import { Request, Response, NextFunction } from "express";
import { ErrorHandler } from "./../helpers/errorHandler";
import { updateMaterial, insertUrn } from "./../queries/apiQueries";
import { updateEsDocument } from "./../elasticSearch/es";
import { aoeMaterialVersionUrl } from "./../services/urlService";
import { getPid } from "./../pid/pidService";
import { EnumStringMember } from "@babel/types";

export interface EducationalMaterialMetadata {
    name: {
        fi: string;
        sv: string;
        en: string;
    };
    keywords: Array<{
        key: string;
        value: string;
    }>;
    authors: Array<{
        organization: AuthorsOrganization;
        author: string;
    }>;
    learningResourceTypes: Array<{
        key: string;
        value: string;
    }>;
    educationalRoles: Array<{
        key: string;
        value: string;
    }>;
    educationalUses: Array<{
        key: string;
        value: string;
    }>;
    description: {
        fi: string;
        sv: string;
        en: string;
    };
    educationalLevels: Array<{
        key: string;
        value: string;
    }>;
    alignmentObjects: Array<{
        key: string;
        source: string;
        alignmentType: string;
        targetName: string;
    }>;
    suitsAllEarlyChildhoodSubjects: boolean;
    suitsAllPrePrimarySubjects: boolean;
    suitsAllBasicStudySubjects: boolean;
    suitsAllUpperSecondarySubjects: boolean;
    suitsAllUpperSecondarySubjectsNew: boolean;
    suitsAllVocationalDegrees: boolean;
    suitsAllSelfMotivatedSubjects: boolean;
    suitsAllBranches: boolean;
    accessibilityFeatures: Array<{
        key: string;
        value: string;
    }>;
    accessibilityHazards: Array<{
        key: string;
        value: string;
    }>;
    typicalAgeRange: {
        typicalAgeRangeMin: string;
        typicalAgeRangeMax: string;
    };
    timeRequired: string;
    publisher: Array<{
        key: string;
        value: string;
    }>;
    expires: string;
    prerequisites: Array<{
        key: string;
        source: string;
        alignmentType: string;
        targetName: string;
    }>;
    license: string;
    isBasedOn: {
        externals: Array<{
            author: string[];
            url: string;
            name: string;
        }>;
    };
    isVersioned: boolean;
    materials: Array<{
        materialId: string;
        priority: number;
        attachments: Array<string>;
    }>;
    fileDetails: Array<{
        id: string;
        displayName: {
            fi: string;
            sv: string;
            en: string;
        };
        language: {
            key: string;
            value: string;
        };
        link: string;
    }>;
    attachmentDetails: Array<{
        kind: string;
        default: boolean;
        label: string;
        lang: string;
        id: string;
    }>;

}

interface AuthorsOrganization {
    key: string;
    value: string;
}
export async function updateEducationalMaterialMetadata(req: Request , res: Response , next: NextFunction) {
    try {
        const metadata: EducationalMaterialMetadata = req.body;
        const emid: string = req.params.id;
        if (!metadata || !emid) {
            console.log("updateEducationalMaterialMetadata data or params missing");
            return res.status(401).json({"status": "invalid data"});
        }
        const data = await updateMaterial(metadata, emid);
        console.log(data);
        res.status(200).json({"status": "data updated"});
        try {
            updateEsDocument();
        }
        catch (error) {
            console.log("Es update error do something");
            console.error(error);
        }
        try {
            if (Number(process.env.PID_SERVICE_ENABLED) === 1 && data[1] && data[1].publishedat) {
                // try to get pid if new version
                try {
                console.log("GET NEW PID");
                const aoeurl = await aoeMaterialVersionUrl(req.params.id, data[1].publishedat);
                const pidurn = await getPid(aoeurl);
                await insertUrn(req.params.id, data[1].publishedat, pidurn);
                }
                catch (error) {
                    console.log("Cannot get Pid from " + req.params.id, data[1].publishedat);
                    console.error(error);
                }
            }
            else {
                console.log("PID SERVICE DISABLED OR NO DATA");
                console.log(process.env.PID_SERVICE_ENABLED);
                console.log(data[1]);
            }
        }
        catch (error) {
            console.log("ISSUE GETTING PID");
            console.error(error);
        }
    }
    catch (error) {
        console.error(error);
        next(new ErrorHandler(400, "Issue updating material"));
    }
}