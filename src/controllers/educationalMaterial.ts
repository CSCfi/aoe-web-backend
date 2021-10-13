import { Request, Response, NextFunction } from "express";
import { ErrorHandler } from "./../helpers/errorHandler";
import { updateMaterial, insertUrn } from "./../queries/apiQueries";
import { updateEsDocument } from "./../elasticSearch/es";
import { aoeMaterialVersionUrl } from "./../services/urlService";
import { getPid } from "./../pid/pidService";
import { EnumStringMember } from "@babel/types";
import { winstonLogger } from '../util';

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
/**
 *
 * @param req
 * @param res
 * @param next
 * update educational material metadata
 */
export async function updateEducationalMaterialMetadata(req: Request, res: Response, next: NextFunction): Promise<void> {
    winstonLogger.debug('updateEducationalMaterialMetadata(): edumaterialid=' + req.params.edumaterialid +
        ', metadata=' + req.body);

    try {
        const metadata: EducationalMaterialMetadata = req.body;
        const emid: string = req.params.edumaterialid;
        if (!metadata || !emid) {
            return next(new ErrorHandler(400, 'Metadata update for the educational material ' +
                'failed: edumaterialid=' + emid + ', metadata=' + metadata));
        }
        const eduMaterial = await updateMaterial(metadata, emid);

        // 200 OK response to the client and continue to search index and PID update
        res.status(200).json(eduMaterial);

        // TODO: Refactoring break point

        try {
            await updateEsDocument();
        } catch (error) {
            console.log("Es update error do something");
            console.error(error);
        }
        try {
            if (Number(process.env.PID_SERVICE_ENABLED) === 1 && eduMaterial[1] && eduMaterial[1].publishedat) {
                // try to get pid if new version
                try {
                    console.log("GET NEW PID");
                    const aoeurl = await aoeMaterialVersionUrl(emid, eduMaterial[1].publishedat);
                    const pidurn = await getPid(aoeurl);
                    await insertUrn(emid, eduMaterial[1].publishedat, pidurn);
                } catch (error) {
                    console.log("Cannot get Pid from " + emid, eduMaterial[1].publishedat);
                    console.error(error);
                }
            } else {
                console.log("PID SERVICE DISABLED OR NO DATA");
                console.log(process.env.PID_SERVICE_ENABLED);
                console.log(eduMaterial[1]);
            }
        } catch (error) {
            console.log("ISSUE GETTING PID");
            console.error(error);
        }
    } catch (error) {
        console.error(error);
        next(new ErrorHandler(400, "Issue updating material"));
    }
}
