import { Request, Response, NextFunction } from "express";
import { ErrorHandler } from "./../helpers/errorHandler";
import { aoeThumbnailDownloadUrl, getEduMaterialVersionURL } from "./../services/urlService";
import { hasDownloadableFiles } from "./../elasticSearch/esQueries";
import { isOfficeMimeType, officeToPdf } from "./../helpers/officeToPdfConverter";
import { hasAccesstoPublication } from "./../services/authService";
import { updateViewCounter, getPopularity, getPopularityQuery } from "./analyticsQueries";
import { EducationalMaterialMetadata } from "./../controllers/educationalMaterial";
import { winstonLogger } from '../util/winstonLogger';
import { db, pgp } from '../resources/pg-connect';
import * as pgLib from 'pg-promise';

const fh = require("./fileHandling");
const elasticSearch = require("./../elasticSearch/es");

export async function addLinkToMaterial(req: Request, res: Response, next: NextFunction) {
    try {
        db.tx(async (t: any) => {
            const queries: any = [];
            let query;
            query = "insert into material (link, educationalmaterialid, materiallanguagekey, priority) values ($1,$2,$3,$4) returning id, link;";
            const data = await t.one(query, [req.body.link, req.params.edumaterialid, req.body.language, req.body.priority]);
            queries.push(data);
            const displayName = req.body.displayName;
            query = "INSERT INTO materialdisplayname (displayname, language, materialid) (SELECT $1,$2,$3 where $3 in (select id from material where educationalmaterialid = $4)) ON CONFLICT (language, materialid) DO UPDATE Set displayname = $1;";
            if (displayName.fi === null) {
                queries.push(await t.none(query, ["", "fi", data.id, req.params.edumaterialid]));
            } else {
                queries.push(await t.none(query, [displayName.fi, "fi", data.id, req.params.edumaterialid]));
            }
            if (displayName.sv === null) {
                queries.push(await t.none(query, ["", "sv", data.id, req.params.edumaterialid]));
            } else {
                queries.push(await t.none(query, [displayName.sv, "sv", data.id, req.params.edumaterialid]));
            }
            if (displayName.en === null) {
                queries.push(await t.none(query, ["", "en", data.id, req.params.edumaterialid]));
            } else {
                queries.push(await t.none(query, [displayName.en, "en", data.id, req.params.edumaterialid]));
            }
            query = "update educationalmaterial set updatedat = now() where id = $1;";
            queries.push(await db.none(query, [req.params.edumaterialid]));
            return t.batch(queries);
        })
            .then((result: any) => {
                const response = {
                    "id": req.params.edumaterialid,
                    "link": result[0]
                };
                res.status(200).json(response);
            })
            .catch((err: Error) => {
                winstonLogger.error(err);
                next(new ErrorHandler(400, "Issue adding link to material"));
            });
    } catch (err) {
        winstonLogger.error(err);
        next(new ErrorHandler(500, "Issue adding link to material"));
    }
}

export async function getMaterial(req: Request, res: Response, next: NextFunction) {
    try {
        const query = "SELECT * FROM educationalmaterial where obsoleted != 1 order by id desc limit 100;";
        const data = await db.any(query);
        res.status(200).json(data);
    } catch (err) {
        winstonLogger.error(err);
        next(new ErrorHandler(500, "Issue getting materials "));
        // res.status(500).send("getting materials not succeeded");
    }
}

// Create a reusable transaction mode (serializable + read-only + deferrable):
const mode = new pgLib.txMode.TransactionMode({
    tiLevel: pgLib.txMode.isolationLevel.serializable,
    readOnly: true,
    deferrable: true
});

export const getEducationalMaterialMetadata = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    const eduMaterialId: number = parseInt(req.params.edumaterialid as string, 10);
    console.log('ID: ' + eduMaterialId);

    db.tx({mode}, async (t: any) => {
        const queries: any = [];
        let query;
        query =
            "SELECT id, createdat, publishedat, updatedat, archivedat, timerequired, agerangemin, agerangemax, " +
            "licensecode, l.license, obsoleted, originalpublishedat, expires, suitsallearlychildhoodsubjects, " +
            "suitsallpreprimarysubjects, suitsallbasicstudysubjects, suitsalluppersecondarysubjects, " +
            "suitsallvocationaldegrees, suitsallselfmotivatedsubjects, suitsallbranches, " +
            "suitsalluppersecondarysubjectsnew, ratingcontentaverage, ratingvisualaverage, viewcounter, " +
            "downloadcounter " +
            "FROM educationalmaterial AS m " +
            "LEFT JOIN licensecode AS l ON l.code = m.licensecode " +
            "WHERE id = $1 AND obsoleted != '1'";
        let response = await t.any(query, [eduMaterialId]);
        const isPublished = !!(response[0] && response[0].publishedat);
        queries.push(response);

        query = "SELECT * FROM materialname " +
            "WHERE educationalmaterialid = $1";
        response = await t.any(query, [eduMaterialId]);
        queries.push(response);

        query = "SELECT * FROM materialdescription " +
            "WHERE educationalmaterialid = $1";
        response = await t.any(query, [eduMaterialId]);
        queries.push(response);

        query = "SELECT * FROM educationalaudience " +
            "WHERE educationalmaterialid = $1";
        response = await t.any(query, [eduMaterialId]);
        queries.push(response);

        query = "SELECT * FROM learningresourcetype " +
            "WHERE educationalmaterialid = $1";
        response = await t.any(query, [eduMaterialId]);
        queries.push(response);

        query = "SELECT * FROM accessibilityfeature " +
            "WHERE educationalmaterialid = $1";
        response = await t.any(query, [eduMaterialId]);
        queries.push(response);

        query = "SELECT * FROM accessibilityhazard " +
            "WHERE educationalmaterialid = $1";
        response = await t.any(query, [eduMaterialId]);
        queries.push(response);

        query = "SELECT * FROM keyword " +
            "WHERE educationalmaterialid = $1";
        response = await t.any(query, [eduMaterialId]);
        queries.push(response);

        query = "SELECT * FROM educationallevel " +
            "WHERE educationalmaterialid = $1";
        response = await t.any(query, [eduMaterialId]);
        queries.push(response);

        query = "SELECT * FROM educationaluse " +
            "WHERE educationalmaterialid = $1";
        response = await t.any(query, [eduMaterialId]);
        queries.push(response);

        query = "SELECT * FROM publisher " +
            "WHERE educationalmaterialid = $1";
        response = await t.any(query, [eduMaterialId]);
        queries.push(response);

        query = "SELECT * FROM author " +
            "WHERE educationalmaterialid = $1";
        response = await t.any(query, [eduMaterialId]);
        queries.push(response);

        query = "SELECT * FROM isbasedon " +
            "WHERE educationalmaterialid = $1";
        response = await t.map(query, [eduMaterialId], (q: any) => {
            t.any("SELECT * FROM isbasedonauthor " +
                "WHERE isbasedonid = $1", q.id)
                .then((data: any) => {
                    q.author = data;
                });
            return q;
        });
        queries.push(response);
        query = "SELECT * FROM alignmentobject " +
            "WHERE educationalmaterialid = $1";
        response = await t.any(query, [eduMaterialId]);
        queries.push(response);

        // Get all materials from material table if not published else get from version table.
        if (!isPublished) {
            query = "SELECT m.id, m.materiallanguagekey AS language, link, filepath, originalfilename, filesize, " +
                "mimetype, format, filekey, filebucket, pdfkey FROM material AS m " +
                "LEFT JOIN record AS r ON m.id = r.materialid " +
                "WHERE m.educationalmaterialid = $1 AND m.obsoleted = 0";
            response = await t.any(query, [eduMaterialId]);
            winstonLogger.debug(query, [eduMaterialId]);
        } else {
            if (req.params.publishedat) {
                query = "SELECT m.id, m.materiallanguagekey AS language, link, version.priority, filepath, " +
                    "originalfilename, filesize, mimetype, format, filekey, filebucket, version.publishedat, pdfkey " +
                    "FROM (SELECT materialid, publishedat, priority FROM versioncomposition " +
                    "WHERE publishedat = $2) AS version " +
                    "LEFT JOIN material AS m ON m.id = version.materialid " +
                    "LEFT JOIN record AS r ON m.id = r.materialid " +
                    "WHERE m.educationalmaterialid = $1 AND m.obsoleted = 0 " +
                    "ORDER BY priority";
                winstonLogger.debug(query, [eduMaterialId, req.params.publishedat]);
                response = await t.any(query, [eduMaterialId, req.params.publishedat]);
            } else {
                query = "SELECT m.id, m.materiallanguagekey AS language, link, version.priority, filepath, " +
                    "originalfilename, filesize, mimetype, format, filekey, filebucket, version.publishedat, pdfkey " +
                    "FROM (SELECT materialid, publishedat, priority FROM versioncomposition WHERE publishedat = " +
                    "(SELECT MAX(publishedat) FROM versioncomposition WHERE educationalmaterialid = $1)) AS version " +
                    "LEFT JOIN material AS m ON m.id = version.materialid " +
                    "LEFT JOIN record AS r ON m.id = r.materialid " +
                    "WHERE m.educationalmaterialid = $1 AND m.obsoleted = 0 " +
                    "ORDER BY priority";
                response = await t.any(query, [eduMaterialId]);
            }
        }
        queries.push(response);

        query = "SELECT dn.id, dn.displayname, dn.language, dn.materialid FROM material AS m " +
            "RIGHT JOIN materialdisplayname AS dn ON m.id = dn.materialid " +
            "WHERE m.educationalmaterialid = $1 AND m.obsoleted = 0";
        response = await t.any(query, [eduMaterialId]);
        queries.push(response);

        query = "SELECT * FROM educationalaudience " +
            "WHERE educationalmaterialid = $1";
        response = await t.any(query, [eduMaterialId]);
        queries.push(response);

        query = "SELECT * FROM thumbnail " +
            "WHERE educationalmaterialid = $1 AND obsoleted = 0 LIMIT 1";
        response = await t.oneOrNone(query, [eduMaterialId]);
        queries.push(response);
        // get all attachments from attachment table if not published else get from version table
        if (!isPublished) {
            query = "SELECT attachment.id, filepath, originalfilename, filesize, mimetype, format, filekey, filebucket, " +
                "defaultfile, kind, label, srclang, materialid FROM material " +
                "INNER JOIN attachment ON material.id = attachment.materialid " +
                "WHERE material.educationalmaterialid = $1 AND material.obsoleted = 0 AND attachment.obsoleted = 0";
            response = await t.any(query, [eduMaterialId]);
            winstonLogger.debug(query, [eduMaterialId]);
        } else {
            if (req.params.publishedat) {
                // query = "select attachment.id, filepath, originalfilename, filesize, mimetype, format, filekey,
                // filebucket, defaultfile, kind, label, srclang, materialid from material
                // inner join attachment on material.id = attachment.materialid
                // where material.educationalmaterialid = $1 and material.obsoleted = 0 and attachment.obsoleted = 0;";
                query = "SELECT attachment.id, filepath, originalfilename, filesize, mimetype, format, filekey, " +
                    "filebucket, defaultfile, kind, label, srclang, materialid FROM attachmentversioncomposition AS v " +
                    "INNER JOIN attachment ON v.attachmentid = attachment.id " +
                    "WHERE versioneducationalmaterialid = $1 AND attachment.obsoleted = 0 AND versionpublishedat = $2";
                response = await t.any(query, [eduMaterialId, req.params.publishedat]);
                winstonLogger.debug(query, [eduMaterialId, req.params.publishedat]);
            } else {
                query = "SELECT attachment.id, filepath, originalfilename, filesize, mimetype, format, filekey, " +
                    "filebucket, defaultfile, kind, label, srclang, materialid FROM attachmentversioncomposition AS v " +
                    "INNER JOIN attachment ON v.attachmentid = attachment.id " +
                    "WHERE versioneducationalmaterialid = $1 AND attachment.obsoleted = 0 AND versionpublishedat = " +
                    "(SELECT MAX(publishedat) FROM versioncomposition WHERE educationalmaterialid = $1)";
                response = await t.any(query, [eduMaterialId, req.params.publishedat]);
                winstonLogger.debug(query, [eduMaterialId]);
            }
        }
        queries.push(response);
        // const TYPE_TIMESTAMP = 1114;
        // const TYPE_TIMESTAMPTZ = 1184;
        // use raw date in version
        // pgp.pg.types.setTypeParser(TYPE_TIMESTAMP, str => str);
        query = "SELECT DISTINCT publishedat " +
            "FROM versioncomposition " +
            "WHERE educationalmaterialid = $1 " +
            "ORDER BY publishedat DESC";
        winstonLogger.debug(query, [eduMaterialId]);
        response = await t.any(query, [eduMaterialId]);
        queries.push(response);
        // pgp.pg.types.setTypeParser(TYPE_TIMESTAMP, parseDate);
        // const popularity = await t.one(getPopularityQuery, [eduMaterialId]);
        // queries.push(popularity);
        if (req.params.publishedat) {
            query = "SELECT urn " +
                "FROM educationalmaterialversion " +
                "WHERE educationalmaterialid = $1 AND publishedat = $2";
            response = await t.oneOrNone(query, [eduMaterialId, req.params.publishedat]);
            queries.push(response);
        } else {
            query = "SELECT urn " +
                "FROM educationalmaterialversion " +
                "WHERE educationalmaterialid = $1 AND publishedat = " +
                "(SELECT MAX(publishedat) FROM educationalmaterialversion WHERE educationalmaterialid = $1)";
            response = await t.oneOrNone(query, [eduMaterialId]);
            queries.push(response);
        }
        return t.batch(queries);
    })
    .then(async (data: any) => {
        const jsonObj: any = {};
        if (data[0][0] === undefined) {
            return res.status(200).json(jsonObj);
        }
        let owner = false;
        // winstonLogger.debug(owner);
        if (req.session?.passport && req.session?.passport.user && req.session?.passport.user.uid) {
            owner = await isOwner(eduMaterialId.toString(), req.session?.passport.user.uid);
        }
        // winstonLogger.debug(owner);
        // add displayname object to material object
        for (const element of data[14]) {
            const nameobj = {
                "fi": "",
                "sv": "",
                "en": ""
            };
            for (const element2 of data[15]) {
                if (element2.materialid === element.id) {
                    if (element2.language === "fi") {
                        nameobj.fi = element2.displayname;
                    } else if (element2.language === "sv") {
                        nameobj.sv = element2.displayname;
                    } else if (element2.language === "en") {
                        nameobj.en = element2.displayname;
                    }
                }
            }
            element.displayName = nameobj;
        }
        jsonObj.id = data[0][0].id;
        jsonObj.materials = data[14];
        // winstonLogger.debug("The jsonObj before first check: " + JSON.stringify(jsonObj));
        for (const i in jsonObj.materials) {
            let ext = "";
            if (jsonObj.materials[i] && jsonObj.materials[i]["originalfilename"]) {
                ext = jsonObj.materials[i]["originalfilename"].substring(jsonObj.materials[i]["originalfilename"].lastIndexOf("."), jsonObj.materials[i]["originalfilename"].length);
                // if (ext === ".h5p") {
                //     req.params.key = jsonObj.materials[i].filekey;
                //     winstonLogger.debug("h5p file found !!!!!!");
                //     const result = await fh.downloadFileFromStorage(req, res, next, true);
                //     winstonLogger.debug("The result from fh.downloadFile with isZip True value: " + result);
                // }
            }
            if (ext === ".h5p") {
                jsonObj.materials[i]["mimetype"] = "text/html";
                jsonObj.materials[i]["filepath"] = process.env.H5P_PLAYER_URL + jsonObj.materials[i]["filekey"];
            } else if (jsonObj.materials[i] && jsonObj.materials[i]["pdfkey"] && await isOfficeMimeType(jsonObj.materials[i]["mimetype"])) {
                jsonObj.materials[i]["filepath"] = process.env.OFFICE_TO_PDF_URL + jsonObj.materials[i]["pdfkey"];
            } else if (jsonObj.materials[i] && (jsonObj.materials[i]["mimetype"] === "application/zip" || jsonObj.materials[i].mimetype === "text/html" || jsonObj.materials[i]["mimetype"] === "application/x-zip-compressed")) {
                req.params.key = jsonObj.materials[i].filekey;
                winstonLogger.debug("The req.params.key before it is being sent to DownloadFIleFromStorage functiuon: " + req.params.key);
                const result = await fh.downloadFileFromStorage(req, res, next, true);
                winstonLogger.debug("The result from fh.downloadFile with isZip True value: " + result);
                if (result != false && (jsonObj.materials[i]["mimetype"] === "application/zip" || jsonObj.materials[i]["mimetype"] === "application/x-zip-compressed")) {
                    /**
                     * if the unZipAndExtract returns a pathToReturn instead of false, we know its a html file, so then we change the mimetype to text/html
                     * Write db code to replace application/zip with text/html for this specific file
                     * mimetype = text/html + result
                     */
                    jsonObj.materials[i]["mimetype"] = "text/html";
                    jsonObj.materials[i]["filepath"] = process.env.HTML_BASE_URL + result;
                    winstonLogger.debug("The jsonObj: " + JSON.stringify(jsonObj));


                } else if (result != false) {
                    /**
                     * This means the function the returned true, but the mimetype was already text/html so we dont have to change it
                     * Simply return the result to the frontend, which means we have to to the query here and push the response thereafter
                     */
                    jsonObj.materials[i]["filepath"] = result;
                    winstonLogger.debug("The jsonObj: " + JSON.stringify(jsonObj));
                }
            }
        }
        jsonObj.owner = owner;
        jsonObj.name = data[1];
        jsonObj.createdAt = data[0][0].createdat;
        jsonObj.updatedAt = data[0][0].updatedat;
        jsonObj.publishedAt = data[0][0].publishedat;
        jsonObj.archivedAt = data[0][0].archivedat;
        jsonObj.suitsAllEarlyChildhoodSubjects = data[0][0].suitsallearlychildhoodsubjects;
        jsonObj.suitsAllPrePrimarySubjects = data[0][0].suitsallpreprimarysubjects;
        jsonObj.suitsAllBasicStudySubjects = data[0][0].suitsallbasicstudysubjects;
        jsonObj.suitsAllUpperSecondarySubjects = data[0][0].suitsalluppersecondarysubjects;
        jsonObj.suitsAllVocationalDegrees = data[0][0].suitsallvocationaldegrees;
        jsonObj.suitsAllSelfMotivatedSubjects = data[0][0].suitsallselfmotivatedsubjects;
        jsonObj.suitsAllBranches = data[0][0].suitsallbranches;
        jsonObj.suitsAllUpperSecondarySubjectsNew = data[0][0].suitsalluppersecondarysubjectsnew;
        jsonObj.ratingContentAverage = data[0][0].ratingcontentaverage;
        jsonObj.ratingVisualAverage = data[0][0].ratingvisualaverage;
        jsonObj.viewCounter = data[0][0].viewcounter;
        jsonObj.downloadCounter = data[0][0].downloadcounter;
        jsonObj.author = data[11];
        jsonObj.publisher = data[10];
        jsonObj.description = data[2];
        jsonObj.keywords = data[7];
        jsonObj.learningResourceTypes = data[4];
        jsonObj.timeRequired = data[0][0].timerequired;
        const typicalAgeRange: any = {};
        typicalAgeRange.typicalAgeRangeMin = data[0][0].agerangemin;
        typicalAgeRange.typicalAgeRangeMax = data[0][0].agerangemax;
        jsonObj.expires = data[0][0].expires;
        jsonObj.typicalAgeRange = typicalAgeRange;
        jsonObj.educationalAlignment = data[13];
        jsonObj.educationalLevels = data[8];
        jsonObj.educationalUses = data[9];
        // jsonObj.inLanguage = data[13];
        jsonObj.accessibilityFeatures = data[5];
        jsonObj.accessibilityHazards = data[6];
        const license: any = {};
        license.value = data[0][0].license;
        license.key = data[0][0].licensecode;
        jsonObj.license = license;
        jsonObj.isBasedOn = data[12];
        jsonObj.educationalRoles = data[16];
        jsonObj.thumbnail = data[17];
        if (jsonObj.thumbnail) {
            jsonObj.thumbnail.filepath = await aoeThumbnailDownloadUrl(jsonObj.thumbnail.filekey);
        }
        jsonObj.attachments = data[18];
        jsonObj.versions = data[19];
        jsonObj.hasDownloadableFiles = (jsonObj.materials) ? hasDownloadableFiles(jsonObj.materials) : false;
        jsonObj.urn = (data[20]) ? data[20].urn : data[20];
        res.status(200).json(jsonObj);

        if (!req.isAuthenticated() || !(await hasAccesstoPublication(jsonObj.id, req))) {
            updateViewCounter(jsonObj.id).catch((error) => {
                winstonLogger.error(`View counter update failed: ${error}`);
            });
        }
    })
    .catch((error: any) => {
        winstonLogger.error(error);
        next(new ErrorHandler(400, 'Issue getting material data'));
    });
}

export async function getUserMaterial(req: Request, res: Response, next: NextFunction) {
    try {
        db.task(async (t: any) => {
            const params: any = [];
            let query;
            query = "SELECT id, publishedat, expires, viewcounter, downloadcounter FROM educationalmaterial WHERE usersusername = $1 and obsoleted != '1';";
            params.push(req.session.passport.user.uid);
            return t.map(query, params, async (q: any) => {
                query = "select * from materialname where educationalmaterialid = $1;";
                let response = await t.any(query, [q.id]);
                q.name = response;
                query = "select * from materialdescription where educationalmaterialid = $1;";
                response = await t.any(query, [q.id]);
                q.description = response;
                query = "select * from learningresourcetype where educationalmaterialid = $1;";
                response = await t.any(query, [q.id]);
                q.learningResourceTypes = response;
                query = "select * from keyword where educationalmaterialid = $1;";
                response = await t.any(query, [q.id]);
                q.keywords = response;
                query = "select * from author where educationalmaterialid = $1;";
                response = await t.any(query, [q.id]);
                q.authors = response;
                query = "Select filekey as thumbnail from thumbnail where educationalmaterialid = $1 and obsoleted = 0;";
                response = await db.oneOrNone(query, [q.id]);
                if (response) {
                    response.thumbnail = await aoeThumbnailDownloadUrl(response.thumbnail);
                }
                q.thumbnail = response;
                query = "select * from educationallevel where educationalmaterialid = $1;";
                response = await t.any(query, [q.id]);
                q.educationalLevels = response;
                query = "select licensecode as key, license as value from educationalmaterial as m left join licensecode as l on m.licensecode = l.code WHERE m.id = $1;";
                const responseObj = await t.oneOrNone(query, [q.id]);
                q.license = responseObj;
                return q;
            }).then(t.batch)
                .catch((error: any) => {
                    winstonLogger.error(error);
                    return error;
                });
        })
            .then((data: any) => {
                res.status(200).json(data);
            });
    } catch (err) {
        winstonLogger.error(err);
        next(new ErrorHandler(500, "Issue getting users material"));
    }
}

export async function getRecentMaterial(req: Request, res: Response, next: NextFunction) {
    try {
        db.task(async (t: any) => {
            const params: any = [];
            let query;
            query = "SELECT id FROM educationalmaterial WHERE obsoleted = '0' AND publishedat IS NOT NULL AND ( expires IS NULL OR expires > now() )  ORDER BY updatedAt DESC LIMIT 6;";
            return t.map(query, params, async (q: any) => {
                query = "select * from materialname where educationalmaterialid = $1;";
                let response = await t.any(query, [q.id]);
                q.name = response;
                query = "select * from materialdescription where educationalmaterialid = $1;";
                response = await t.any(query, [q.id]);
                q.description = response;
                query = "select * from learningresourcetype where educationalmaterialid = $1;";
                response = await t.any(query, [q.id]);
                q.learningResourceTypes = response;
                query = "select * from keyword where educationalmaterialid = $1;";
                response = await t.any(query, [q.id]);
                q.keywords = response;
                query = "select * from author where educationalmaterialid = $1;";
                response = await t.any(query, [q.id]);
                q.authors = response;
                query = "Select filekey as thumbnail from thumbnail where educationalmaterialid = $1 and obsoleted = 0;";
                response = await db.oneOrNone(query, [q.id]);
                if (response) {
                    response.thumbnail = await aoeThumbnailDownloadUrl(response.thumbnail);
                }
                q.thumbnail = response;
                query = "select * from educationallevel where educationalmaterialid = $1;";
                response = await t.any(query, [q.id]);
                q.educationalLevels = response;
                query = "select licensecode as key, license as value from educationalmaterial as m left join licensecode as l on m.licensecode = l.code WHERE m.id = $1;";
                const responseObj = await t.oneOrNone(query, [q.id]);
                q.license = responseObj;
                return q;
            }).then(t.batch)
                .catch((error: any) => {
                    winstonLogger.error(error);
                    return error;
                });
        })
            .then((data: any) => {
                res.status(200).json(data);
            });
    } catch (err) {
        winstonLogger.error(err);
        next(new ErrorHandler(500, "Issue getting recent materials"));
    }
}

export async function setEducationalMaterialObsoleted(req: Request, res: Response, next: NextFunction) {
    try {
        let query;
        let data;
        await db.tx({mode}, async (t: any) => {
            const queries: any = [];
            query = "update educationalmaterial SET obsoleted = '1' WHERE id = $1;";
            queries.push(await db.none(query, [req.params.edumaterialid]));
            query = "update material SET obsoleted = '1' WHERE educationalmaterialid = $1 returning id;";
            data = await db.any(query, [req.params.edumaterialid]);
            queries.push(data);
            const arr: string[] = [];
            for (let i = 1; i <= data.length; i++) {
                arr.push("('" + data[i - 1].id + "')");
            }
            if (arr.length > 0) {
                query = "update attachment SET obsoleted = '1' WHERE materialid in (" + arr.join(",") + " );";
                queries.push(await db.none(query));
            }
            query = "update educationalmaterial set updatedat = now() where id = $1";
            queries.push(await db.none(query, [req.params.edumaterialid]));
            return t.batch(queries);
        });
        res.status(204).send();
        elasticSearch.updateEsDocument()
            .catch((err: Error) => {
                winstonLogger.error(err);
            });
    } catch (err) {
        next(new ErrorHandler(500, "Issue deleting material"));
    }
}

export async function deleteRecord(req: Request, res: Response, next: NextFunction) {
    try {
        let query;
        let data;
        await db.tx({mode}, async (t: any) => {
            const queries: any = [];
            query = "update material SET obsoleted = '1' WHERE id = $1 returning educationalmaterialid;";
            data = await db.one(query, [req.params.fileid]);
            queries.push(data);
            query = "update attachment SET obsoleted = '1' WHERE materialid = $1;";
            queries.push(await db.none(query, [req.params.fileid]));
            query = "update educationalmaterial set updatedat = now() where id = $1";
            queries.push(await db.none(query, [data.educationalmaterialid]));
            return t.batch(queries);
        });
        res.status(200).json({"status": "deleted"});
        elasticSearch.updateEsDocument()
            .catch((err: Error) => {
                winstonLogger.error(err);
            });
    } catch (err) {
        next(new ErrorHandler(500, "Issue deleting record: " + err));
    }
}

export async function deleteAttachment(req: Request, res: Response, next: NextFunction) {
    try {
        let query;
        let data;
        await db.tx({mode}, async (t: any) => {
            const queries: any = [];
            query = "update attachment SET obsoleted = '1' WHERE id = $1;";
            data = await db.any(query, [req.params.attachmentid]);
            queries.push(data);
            query = "update educationalmaterial set updatedat = now() where id = "
                + "(select educationalmaterialid from material where id = (select materialid from attachment where id = $1));";
            winstonLogger.debug('Query in deleteAttachment(): ' + query);
            queries.push(await db.none(query, [req.params.attachmentid]));
            return t.batch(queries);
        });
        res.status(200).json({"status": "deleted"});
        elasticSearch.updateEsDocument()
            .catch((err: Error) => {
                winstonLogger.error("Es update error: " + err);
            });
    } catch (err) {
        next(new ErrorHandler(500, "Issue deleting attachment" + err));
        // res.sendStatus(500);
    }
}

export async function setLanguage(obj: any) {
    try {
        if (obj) {
            if (!obj.fi || obj.fi === "") {
                if (!obj.sv || obj.sv === "") {
                    if (!obj.en || obj.en === "") {
                        obj.fi = "";
                    } else {
                        obj.fi = obj.en;
                    }
                } else {
                    obj.fi = obj.sv;
                }
            }
            if (!obj.sv || obj.sv === "") {
                if (!obj.fi || obj.fi === "") {
                    if (!obj.en || obj.en === "") {
                        obj.sv = "";
                    } else {
                        obj.sv = obj.en;
                    }
                } else {
                    obj.sv = obj.fi;
                }
            }
            if (!obj.en || obj.en === "") {
                if (!obj.fi || obj.fi === "") {
                    if (!obj.sv || obj.sv === "") {
                        obj.en = "";
                    } else {
                        obj.en = obj.sv;
                    }
                } else {
                    obj.en = obj.fi;
                }
            }
        }
    } catch (err) {
        throw new Error('Error in setLanguage(): ' + err);
    }
}

export async function insertDataToDescription(t: any, educationalmaterialid: string, description: any) {
    const queries = [];
    // const query = "INSERT INTO materialdisplayname (displayname, language, materialid) (SELECT $1,$2,$3 where $3 in (select id from material where educationalmaterialid = $4)) ON CONFLICT (language, materialid) DO UPDATE Set displayname = $1;";
    const query = "INSERT INTO materialdescription (description, language, educationalmaterialid) VALUES ($1,$2,$3) ON CONFLICT (language,educationalmaterialid) DO " +
        "UPDATE SET description = $1;";
    winstonLogger.debug('Query in insertDataToDescription(): ' + query);
    if (description && educationalmaterialid) {
        if (!description.fi || description.fi === "") {
            if (!description.sv || description.sv === "") {
                if (!description.en || description.en === "") {
                    queries.push(await t.any(query, ["", "fi", educationalmaterialid]));
                } else {
                    queries.push(await t.any(query, [description.en, "fi", educationalmaterialid]));
                }
            } else {
                queries.push(await t.any(query, [description.sv, "fi", educationalmaterialid]));
            }
        } else {
            queries.push(await t.any(query, [description.fi, "fi", educationalmaterialid]));
        }

        if (!description.sv || description.sv === "") {
            if (!description.fi || description.fi === "") {
                if (!description.en || description.en === "") {
                    queries.push(await t.any(query, ["", "sv", educationalmaterialid]));
                } else {
                    queries.push(await t.any(query, [description.en, "sv", educationalmaterialid]));
                }
            } else {
                queries.push(await t.any(query, [description.fi, "sv", educationalmaterialid]));
            }
        } else {
            queries.push(await t.any(query, [description.sv, "sv", educationalmaterialid]));
        }

        if (!description.en || description.en === "") {
            if (!description.fi || description.fi === "") {
                if (!description.sv || description.sv === "") {
                    queries.push(await t.any(query, ["", "en", educationalmaterialid]));
                } else {
                    queries.push(await t.any(query, [description.sv, "en", educationalmaterialid]));
                }
            } else {
                queries.push(await t.any(query, [description.fi, "en", educationalmaterialid]));
            }
        } else {
            queries.push(await t.any(query, [description.en, "en", educationalmaterialid]));
        }
    }
    return queries;
}

export interface NameObject {
    "en": string;
    "sv": string;
    "fi": string;
}

export async function insertEducationalMaterialName(materialname: NameObject, id: string, t: any) {
    const query = "INSERT INTO materialname (materialname, language, slug, educationalmaterialid) " +
        "VALUES ($1, $2, $3, $4) " +
        "ON CONFLICT (language,educationalmaterialid) DO " +
        "UPDATE SET materialname = $1, slug = $3";
    const queries = [];
    await setLanguage(materialname);
    winstonLogger.debug('Query in insertEducationalMaterialName(): ' + query);
    if (materialname.fi === null) {
        queries.push(await t.any(query, ["", "fi", "", id]));
    } else {
        queries.push(await t.any(query, [materialname.fi, "fi", "", id]));
    }
    if (materialname.sv === null) {
        queries.push(await t.any(query, ["", "sv", "", id]));
    } else {
        queries.push(await t.any(query, [materialname.sv, "sv", "", id]));
    }
    if (materialname.en === null) {
        queries.push(await t.any(query, ["", "en", "", id]));
    } else {
        queries.push(await t.any(query, [materialname.en, "en", "", id]));
    }
    return queries;
}

export async function updateMaterial(metadata: EducationalMaterialMetadata, emid: string) {
    return await db.tx(async (t: any) => {
        let query;
        const queries: any = [];
        // let params = req.params;
        const materialname = metadata.name;
        const nameparams = [];
        let response;
        winstonLogger.debug('Update metadata in updateMaterial(): ' + JSON.stringify(metadata));
        // let arr = metadata.name;
        if (materialname == undefined) {
            // query = "DELETE FROM materialname where educationalmaterialid = $1;";
            // response  = await t.any(query, [req.params.id]);
            // queries.push(response);
        } else {
            queries.push(await insertEducationalMaterialName(materialname, emid, t));
        }

        // material
        const dnow = Date.now() / 1000.0;
        query = "UPDATE educationalmaterial SET (expires,UpdatedAt,timeRequired,agerangeMin,agerangeMax,licensecode,suitsAllEarlyChildhoodSubjects,suitsAllPrePrimarySubjects,suitsAllBasicStudySubjects,suitsAllUpperSecondarySubjects,suitsAllVocationalDegrees,suitsAllSelfMotivatedSubjects,suitsAllBranches ,suitsAllUpperSecondarySubjectsNew) = ($1,to_timestamp($2),$3,$4,$5,$7,$8,$9,$10,$11,$12,$13,$14,$15) where id=$6;";
        winstonLogger.debug('Query in updateMaterial(): ' + query, [metadata.expires, dnow, metadata.timeRequired, ((!metadata.typicalAgeRange) ? undefined : metadata.typicalAgeRange.typicalAgeRangeMin), ((!metadata.typicalAgeRange) ? undefined : metadata.typicalAgeRange.typicalAgeRangeMax), emid, metadata.license]);
        queries.push(await t.any(query, [metadata.expires, dnow, ((metadata.timeRequired == undefined) ? "" : metadata.timeRequired), ((!metadata.typicalAgeRange) ? undefined : metadata.typicalAgeRange.typicalAgeRangeMin), ((!metadata.typicalAgeRange) ? undefined : metadata.typicalAgeRange.typicalAgeRangeMax), emid, metadata.license, metadata.suitsAllEarlyChildhoodSubjects, metadata.suitsAllPrePrimarySubjects, metadata.suitsAllBasicStudySubjects, metadata.suitsAllUpperSecondarySubjects, metadata.suitsAllVocationalDegrees, metadata.suitsAllSelfMotivatedSubjects, metadata.suitsAllBranches, metadata.suitsAllUpperSecondarySubjectsNew]));
// description
        const description = metadata.description;
        if (description == undefined) {
            // if not found do nothing
        } else {
            queries.push(await insertDataToDescription(t, emid, description));
        }
        // educationalRoles
        const audienceparams = [];
        const audienceArr = metadata.educationalRoles;
        if (audienceArr == undefined || audienceArr.length < 1) {
            query = "DELETE FROM educationalaudience where educationalmaterialid = $1;";
            response = await t.any(query, [emid]);
            queries.push(response);
        } else {
            for (let i = 1; i <= audienceArr.length; i++) {
                audienceparams.push("('" + audienceArr[i - 1].value + "')");
            }
            query = "select id from (select * from educationalaudience where educationalmaterialid = $1) as i left join" +
                "(select t.role from ( values " + audienceparams.join(",") + " ) as t(role)) as a on i.educationalrole = a.role where a.role is null;";
            response = await t.any(query, [emid]);
            queries.push(response);
            for (const element of response) {
                query = "DELETE FROM educationalaudience where id = " + element.id + ";";
                winstonLogger.debug('Query in updateMaterial(): ' + query);
                queries.push(await t.any(query));
            }
            for (const element of audienceArr) {
                query = "INSERT INTO educationalaudience (educationalrole, educationalmaterialid, educationalrolekey) VALUES ($1,$2,$3) ON CONFLICT (educationalrolekey,educationalmaterialid) DO " +
                    "UPDATE SET educationalrole = $1;";
                winstonLogger.debug('Query in updateMaterial(): ' + query);
                queries.push(await t.any(query, [element.value, emid, element.key]));
            }
        }
        // educationalUse
        const educationalUseParams = [];
        const educationalUseArr = metadata.educationalUses;
        if (educationalUseArr == undefined || educationalUseArr.length < 1) {
            query = "DELETE FROM educationaluse where educationalmaterialid = $1;";
            response = await t.any(query, [emid]);
            queries.push(response);
        } else {
            for (let i = 1; i <= educationalUseArr.length; i++) {
                educationalUseParams.push("('" + educationalUseArr[i - 1].key + "')");
            }
            query = "select id from (select * from educationaluse where educationalmaterialid = $1) as i left join" +
                "(select t.educationalusekey from ( values " + educationalUseParams.join(",") + " ) as t(educationalusekey)) as a on i.educationalusekey = a.educationalusekey where a.educationalusekey is null;";
            response = await t.any(query, [emid]);
            queries.push(response);
            winstonLogger.debug(response);
            for (const element of response) {
                query = "DELETE FROM educationaluse where id = " + element.id + ";";
                winstonLogger.debug(query);
                queries.push(await t.any(query));
            }
            for (const element of educationalUseArr) {
                query = "INSERT INTO educationaluse (value, educationalmaterialid, educationalusekey) VALUES ($1,$2,$3) ON CONFLICT (educationalusekey,educationalmaterialid) DO UPDATE SET value = $1;";
                winstonLogger.debug(query);
                queries.push(await t.any(query, [element.value, emid, element.key]));
            }
        }
        // learningResourceType
        const learningResourceTypeParams = [];
        const learningResourceTypeArr = metadata.learningResourceTypes;
        if (learningResourceTypeArr == undefined || learningResourceTypeArr.length < 1) {
            query = "DELETE FROM learningresourcetype where educationalmaterialid = $1;";
            response = await t.any(query, [emid]);
            queries.push(response);
        } else {
            for (let i = 1; i <= learningResourceTypeArr.length; i++) {
                learningResourceTypeParams.push("('" + learningResourceTypeArr[i - 1].key + "')");
            }
            query = "select id from (select * from learningresourcetype where educationalmaterialid = $1) as i left join" +
                "(select t.learningresourcetypekey from ( values " + learningResourceTypeParams.join(",") + " ) as t(learningresourcetypekey)) as a on i.learningresourcetypekey = a.learningresourcetypekey where a.learningresourcetypekey is null;";
            response = await t.any(query, [emid]);
            queries.push(response);
            winstonLogger.debug(response);
            for (const element of response) {
                query = "DELETE FROM learningresourcetype where id = " + element.id + ";";
                winstonLogger.debug(query);
                queries.push(await t.any(query));
            }
            for (const element of learningResourceTypeArr) {
                query = "INSERT INTO learningresourcetype (value, educationalmaterialid, learningresourcetypekey) VALUES ($1,$2,$3) ON CONFLICT (learningresourcetypekey,educationalmaterialid) DO UPDATE SET value = $1;";
                winstonLogger.debug(query);
                queries.push(await t.any(query, [element.value, emid, element.key]));
            }
        }

        // keywords
        let params = [];
        let arr = metadata.keywords;
        if (arr == undefined || arr.length < 1) {
            query = "DELETE FROM keyword where educationalmaterialid = $1;";
            response = await t.any(query, [emid]);
            queries.push(response);
        } else {
            for (let i = 1; i <= arr.length; i++) {
                params.push("('" + arr[i - 1].key + "')");
            }
            query = "select id from (select * from keyword where educationalmaterialid = $1) as i left join" +
                "(select t.keywordkey from ( values " + params.join(",") + " ) as t(keywordkey)) as a on i.keywordkey = a.keywordkey where a.keywordkey is null;";
            response = await t.any(query, [emid]);
            queries.push(response);
            for (const element of response) {
                query = "DELETE FROM keyword where id = " + element.id + ";";
                winstonLogger.debug(query);
                queries.push(await t.any(query));
            }
            for (const element of arr) {
                query = "INSERT INTO keyword (value, educationalmaterialid, keywordkey) VALUES ($1,$2,$3) ON CONFLICT (keywordkey, educationalmaterialid) DO UPDATE SET value = $1;";
                winstonLogger.debug(query, [element.value, emid, element.key]);
                queries.push(await t.any(query, [element.value, emid, element.key]));
            }
        }
        // publisher
        params = [];
        arr = metadata.publisher;
        winstonLogger.debug(arr);
        if (arr == undefined || arr.length < 1) {
            query = "DELETE FROM publisher where educationalmaterialid = $1;";
            winstonLogger.debug(query, [emid]);
            response = await t.any(query, [emid]);
            queries.push(response);
        } else {
            for (let i = 1; i <= arr.length; i++) {
                params.push("('" + arr[i - 1].key + "')");
            }
            query = "select id from (select * from publisher where educationalmaterialid = $1) as i left join" +
                "(select t.publisherkey from ( values " + params.join(",") + " ) as t(publisherkey)) as a on i.publisherkey = a.publisherkey where a.publisherkey is null;";
            winstonLogger.debug(query);
            response = await t.any(query, [emid]);
            queries.push(response);
            for (const element of response) {
                query = "DELETE FROM publisher where id = " + element.id + ";";
                winstonLogger.debug(query);
                queries.push(await t.any(query));
            }
            for (const element of arr) {
                query = "INSERT INTO publisher (name, educationalmaterialid, publisherkey) VALUES ($1,$2,$3) ON CONFLICT (publisherkey, educationalmaterialid) DO UPDATE SET name = $1";
                winstonLogger.debug(query);
                queries.push(await t.any(query, [element.value, emid, element.key]));
            }
        }
        // isBasedOn
        params = [];
        let isBasedonArr = [];
        if (metadata.isBasedOn) {
            isBasedonArr = metadata.isBasedOn.externals;
        }
        if (isBasedonArr == undefined || isBasedonArr.length < 1) {
            query = "DELETE FROM isbasedonauthor where isbasedonid IN (SELECT id from isbasedon where educationalmaterialid = $1);";
            response = await t.any(query, [emid]);
            query = "DELETE FROM isbasedon where educationalmaterialid = $1;";
            response = await t.any(query, [emid]);
            queries.push(response);
        } else {
            query = "DELETE FROM isbasedonauthor where isbasedonid IN (SELECT id from isbasedon where educationalmaterialid = $1);";
            response = await t.any(query, [emid]);
            query = "SELECT * from isbasedon where educationalmaterialid = $1;";
            response = await t.any(query, [emid]);
            queries.push(response);
            for (const element of response) {
                let toBeDeleted = true;
                for (let i = 0; isBasedonArr.length > i; i += 1) {
                    if (element.name === isBasedonArr[i].materialname) {
                        toBeDeleted = false;
                    }
                }
                if (toBeDeleted) {
                    query = "DELETE FROM isbasedon where id = " + element.id + ";";
                    winstonLogger.debug(query);
                    queries.push(await t.any(query));
                }
            }
            for (const element of isBasedonArr) {
                query = "INSERT INTO isbasedon (materialname, url, educationalmaterialid) VALUES ($1,$2,$3) ON CONFLICT (materialname, educationalmaterialid) DO UPDATE SET url = $2 returning id;";
                winstonLogger.debug(query, [element.name, element.url, emid]);
                const resp = await t.one(query, [element.name, element.url, emid]);
                queries.push(resp);
                for (const author of element.author) {
                    query = "INSERT INTO isbasedonauthor (authorname, isbasedonid) VALUES ($1,$2);";
                    winstonLogger.debug(query, [author, resp.id]);
                    queries.push(t.none(query, [author, resp.id]));
                }
            }
        }
        // alignmentObjects
        const alignmentObjectArr = metadata.alignmentObjects;

        if (alignmentObjectArr == undefined) {
            query = "DELETE FROM alignmentobject where educationalmaterialid = $1;";
            response = await t.any(query, [emid]);
            queries.push(response);
        } else if (alignmentObjectArr.length === 0) {
            query = "DELETE FROM alignmentobject where educationalmaterialid = $1;";
            response = await t.any(query, [emid]);
            queries.push(response);
        } else {
            query = "SELECT * from alignmentobject where educationalmaterialid = $1;";
            response = await t.any(query, [emid]);
            queries.push(response);
            for (const element of response) {
                let toBeDeleted = true;
                for (let i = 0; alignmentObjectArr.length > i; i += 1) {
                    if (element.alignmenttype === alignmentObjectArr[i].alignmentType && element.objectkey === alignmentObjectArr[i].key && element.source === alignmentObjectArr[i].source) {
                        toBeDeleted = false;
                    }
                }
                if (toBeDeleted) {
                    query = "DELETE FROM alignmentobject where id = " + element.id + ";";
                    winstonLogger.debug(query);
                    queries.push(await t.any(query));
                }
            }
            const cs = new pgp.helpers.ColumnSet(["alignmenttype", "targetname", "source", "educationalmaterialid", "objectkey", "educationalframework", "targeturl"], {table: "alignmentobject"});
            // data input values:
            // winstonLogger.debug(arr);
            const values: any = [];
            // const updateValues: Array<object> = [];
            // for ( let i = 0; i < arr.length; i += 1) {
            //     alignmentObjectArr[i].educationalmaterialid = emid;
            // }
            alignmentObjectArr.forEach(async (element: any) => {
                winstonLogger.debug(element.educationalFramework);
                const obj = {
                    alignmenttype: element.alignmentType,
                    targetname: element.targetName,
                    source: element.source,
                    educationalmaterialid: emid,
                    objectkey: element.key,
                    educationalframework: ((element.educationalFramework == undefined) ? "" : element.educationalFramework),
                    targeturl: element.targetUrl
                };
                values.push(obj);
                // updateValues.push({educationalframework : ((element.educationalFramework == undefined) ? "" : element.educationalFramework)});
            });
            winstonLogger.debug(values);
            query = pgp.helpers.insert(values, cs) + " ON CONFLICT ON CONSTRAINT constraint_alignmentobject DO UPDATE Set educationalframework = excluded.educationalframework";
            winstonLogger.debug(query);
            queries.push(await t.any(query));
        }
        // Author
        params = [];
        const authorArr = metadata.authors;
        query = "DELETE FROM author where educationalmaterialid = $1;";
        response = await t.any(query, [emid]);
        queries.push(response);

        for (const element of authorArr) {
            query = "INSERT INTO author (authorname, organization, educationalmaterialid, organizationkey) VALUES ($1,$2,$3,$4);";
            winstonLogger.debug(query, [element.author, element.organization, emid]);
            queries.push(await t.any(query, [((element.author == undefined) ? "" : element.author), ((element.organization == undefined) ? "" : element.organization.value), emid, ((element.organization == undefined) ? "" : element.organization.key)]));
        }

        // File details
        params = [];
        const fileDetailArr = metadata.fileDetails;
        if (fileDetailArr == undefined) {
            // query = "DELETE FROM materialdisplayname where materialid = $1;";
            // winstonLogger.debug(query, [emid]);
            // response  = await t.any(query, [emid]);
            // queries.push(response);
        } else {
            for (const element of fileDetailArr) {
                const dnresult = await fh.insertDataToDisplayName(t, emid, element.id, element);
                queries.push(dnresult);
                query = "UPDATE material SET materiallanguagekey = $1 WHERE id = $2 AND educationalmaterialid = $3";
                winstonLogger.debug("update material name: " + query, [element.language, element.id, emid]);
                queries.push(await t.any(query, [element.language, element.id, emid]));
                if (element.link) {
                    query = "UPDATE material SET link = $1 WHERE id = $2 AND educationalmaterialid = $3";
                    winstonLogger.debug("update link: " + query, [element.link, element.id, emid]);
                    queries.push(await t.any(query, [element.link, element.id, emid]));
                }
            }
        }
        // Accessibility features
        params = [];
        arr = metadata.accessibilityFeatures;
        if (arr == undefined || arr.length < 1) {
            query = "DELETE FROM accessibilityfeature where educationalmaterialid = $1;";
            response = await t.any(query, [emid]);
            queries.push(response);
        } else {
            for (let i = 1; i <= arr.length; i++) {
                params.push("('" + arr[i - 1].key + "')");
            }
            query = "select id from (select * from accessibilityfeature where educationalmaterialid = $1) as i left join" +
                "(select t.accessibilityfeaturekey from ( values " + params.join(",") + " ) as t(accessibilityfeaturekey)) as a on i.accessibilityfeaturekey = a.accessibilityfeaturekey where a.accessibilityfeaturekey is null;";
            winstonLogger.debug(query);
            response = await t.any(query, [emid]);
            winstonLogger.debug(response);
            queries.push(response);
            for (const element of response) {
                if (element.dnid !== null) {
                    query = "DELETE FROM accessibilityfeature where id = " + element.id + ";";
                    winstonLogger.debug(query);
                    queries.push(await t.any(query));
                }
            }
            for (const element of arr) {
                query = "INSERT INTO accessibilityfeature (accessibilityfeaturekey, value, educationalmaterialid) VALUES ($1,$2,$3) ON CONFLICT (accessibilityfeaturekey, educationalmaterialid) DO NOTHING;";
                // query = "INSERT INTO materialdisplayname (displayname, language, materialid, slug) VALUES ($1,$2,$3,$4) ON CONFLICT (language, materialid) DO UPDATE Set displayname = $1, slug = $4;";
                winstonLogger.debug(query, [element.key, element.value, emid]);
                queries.push(await t.any(query, [element.key, element.value, emid]));
            }
        }
// accessibilityHazards
        winstonLogger.debug("inserting accessibilityHazards");
        params = [];
        arr = metadata.accessibilityHazards;
        if (arr == undefined || arr.length < 1) {
            query = "DELETE FROM accessibilityhazard where educationalmaterialid = $1;";
            response = await t.any(query, [emid]);
            queries.push(response);
        } else {
            for (let i = 1; i <= arr.length; i++) {
                params.push("('" + arr[i - 1].key + "')");
            }
            query = "select id from (select * from accessibilityhazard where educationalmaterialid = $1) as i left join" +
                "(select t.accessibilityhazardkey from ( values " + params.join(",") + " ) as t(accessibilityhazardkey)) as a on i.accessibilityhazardkey = a.accessibilityhazardkey where a.accessibilityhazardkey is null;";
            winstonLogger.debug(query);
            response = await t.any(query, [emid]);
            winstonLogger.debug(response);
            queries.push(response);
            for (const element of response) {
                if (element.dnid !== null) {
                    query = "DELETE FROM accessibilityhazard where id = " + element.id + ";";
                    winstonLogger.debug(query);
                    queries.push(await t.any(query));
                }
            }
            for (const element of arr) {
                query = "INSERT INTO accessibilityhazard (accessibilityhazardkey, value, educationalmaterialid) VALUES ($1,$2,$3) ON CONFLICT (accessibilityhazardkey, educationalmaterialid) DO NOTHING;";
                // query = "INSERT INTO materialdisplayname (displayname, language, materialid, slug) VALUES ($1,$2,$3,$4) ON CONFLICT (language, materialid) DO UPDATE Set displayname = $1, slug = $4;";
                winstonLogger.debug(query, [element.key, element.value, emid]);
                queries.push(await t.any(query, [element.key, element.value, emid]));
            }
        }
// educationalLevels
        winstonLogger.debug("inserting educationalLevels");
        params = [];
        arr = metadata.educationalLevels;
        if (arr == undefined || arr.length < 1) {
            query = "DELETE FROM educationallevel where educationalmaterialid = $1;";
            response = await t.any(query, [emid]);
            queries.push(response);
        } else {
            for (let i = 1; i <= arr.length; i++) {
                params.push("('" + arr[i - 1].key + "')");
            }
            query = "select id from (select * from educationallevel where educationalmaterialid = $1) as i left join" +
                "(select t.educationallevelkey from ( values " + params.join(",") + " ) as t(educationallevelkey)) as a on i.educationallevelkey = a.educationallevelkey where a.educationallevelkey is null;";
            winstonLogger.debug(query);
            response = await t.any(query, [emid]);
            winstonLogger.debug(response);
            queries.push(response);
            for (const element of response) {
                if (element.dnid !== null) {
                    query = "DELETE FROM educationallevel where id = " + element.id + ";";
                    winstonLogger.debug(query);
                    queries.push(await t.any(query));
                }
            }
            for (const element of arr) {
                query = "INSERT INTO educationallevel (educationallevelkey, value, educationalmaterialid) VALUES ($1,$2,$3) ON CONFLICT (educationallevelkey, educationalmaterialid) DO NOTHING;";
                // query = "INSERT INTO materialdisplayname (displayname, language, materialid, slug) VALUES ($1,$2,$3,$4) ON CONFLICT (language, materialid) DO UPDATE Set displayname = $1, slug = $4;";
                winstonLogger.debug(query, [element.key, element.value, emid]);
                queries.push(await t.any(query, [element.key, element.value, emid]));
            }
        }

        winstonLogger.debug("update attachmentDetails");
        const attachmentDetailArr = metadata.attachmentDetails;
        if (attachmentDetailArr) {
            for (const element of attachmentDetailArr) {
                query = "update attachment set kind = $1, defaultfile = $2, label = $3, srclang = $4 where (id = $5 " +
                    "and (select educationalmaterialid from material where id = (select materialid from attachment where id = $5)) = $6);";
                winstonLogger.debug(query, [element.kind, element.default, element.label, element.lang, element.id, emid]);
                queries.push(await t.none(query, [element.kind, element.default, element.label, element.lang, element.id, emid]));
            }
        }
        let publishedat;
        if (metadata.isVersioned) {
            winstonLogger.debug("versioned true");
            const arr = metadata.materials;
            if (metadata.materials) {
                query = "UPDATE educationalmaterial SET publishedat = now() WHERE id = $1 AND publishedat IS NULL;";
                queries.push(await t.none(query, [emid]));
                // insert new version
                query = "INSERT INTO educationalmaterialversion (educationalmaterialid, publishedat) values ($1, now()::timestamp(3)) returning publishedat;";
                // queries.push(await t.one(query, [emid]));
                publishedat = await t.one(query, [emid]);
                // queries.push(publishedat);
                for (const element of arr) {
                    // query = "INSERT INTO versioncomposition (educationalmaterialid, materialid, publishedat, priority) VALUES ($1,$2,now(),$3);";
                    query = "INSERT INTO versioncomposition (educationalmaterialid, materialid, publishedat, priority) select $1,$2,now()::timestamp(3),$3 where exists (select * from material where id = $2 and educationalmaterialid = $1);";
                    winstonLogger.debug(query, [emid, element.materialId, element.priority]);
                    queries.push(await t.none(query, [emid, element.materialId, element.priority]));
                    // add attachments
                    if (element.attachments) {
                        for (const att of element.attachments) {
                            query = "INSERT INTO attachmentversioncomposition (versioneducationalmaterialid, versionmaterialid, versionpublishedat, attachmentid) select $1,$2,now()::timestamp(3),$3 where exists (select * from attachment where id = $3 and materialid = $2);";
                            winstonLogger.debug(query, [emid, element.materialId, att]);
                            queries.push(await t.none(query, [emid, element.materialId, att]));
                        }
                    }
                }
            }
        } else {
            const materialArr = metadata.materials;
            if (materialArr) {
                for (const element of materialArr) {
                    query = "UPDATE versioncomposition SET priority = $3 WHERE educationalmaterialid = $1 and materialid = $2 and publishedat = (select max(publishedat) from versioncomposition where educationalmaterialid = $1);";
                    winstonLogger.debug(query, [emid, element.materialId, element.priority]);
                    queries.push(await t.none(query, [emid, element.materialId, element.priority]));
                }
            }
        }
        return [t.batch(queries), publishedat];
    })
        .then(async (data: any) => {
            return data;
        })
        .catch((err: Error) => {
            winstonLogger.error(err);
            throw(err);
            // next(new ErrorHandler(400, "Issue updating material"));
        });
}

export const updateEduMaterialVersionURN = async (id: string, publishedat: string, urn: string): Promise<void> => {
    try {
        const query = "UPDATE educationalmaterialversion " +
            "SET urn = $3 " +
            "WHERE educationalmaterialid = $1 AND publishedat = $2";
        await db.none(query, [id, publishedat, urn]);
    } catch (error) {
        winstonLogger.error('Update for educational material version failed in updateEduMaterialVersionURN(): ' + error);
        throw new Error(error);
    }
}

export async function createUser(req: Request, res: Response, next: NextFunction) {
    try {
        const query = "INSERT INTO users (firstname, lastname, username, preferredlanguage, preferredtargetname," +
            "preferredalignmenttype) VALUES ($1, $2, $3, 'fi', '', '') RETURNING username";
        winstonLogger.debug(req.body);
        if (req.body.username === undefined) {
            next(new ErrorHandler(500, "Username cannot be undefined"));
        }
        const data = await db.any(query, [req.body.firstname, req.body.lastname, req.body.username]);
        res.status(200).json(data);
    } catch (err) {
        winstonLogger.error(err);
        next(new ErrorHandler(500, "Issue creating user"));
    }
}

export async function updateUser(req: Request, res: Response, next: NextFunction) {
    try {
        const query = "UPDATE users SET (firstname, lastname, preferredlanguage, preferredtargetname, " +
            "preferredalignmenttype) = ($1, $2, $3, $4, $5) " +
            "WHERE username = $6";
        winstonLogger.debug(query);
        const data = await db.any(query, [req.body.firstname, req.body.lastname, req.body.preferredlanguage,
            req.body.preferredtargetname, req.body.preferredalignmenttype, req.session.passport.user.uid]);
        res.status(200).json("user updated");
    } catch (err) {
        winstonLogger.error(err);
        next(new ErrorHandler(500, "Issue updating user"));
    }
}

export async function updateTermsOfUsage(req: Request, res: Response, next: NextFunction) {
    try {
        const query = "UPDATE users SET termsofusage = '1' WHERE username = $1";
        winstonLogger.debug(query);
        const data = await db.any(query, [req.session.passport.user.uid]);
        res.status(200).json("terms of usage updated");
    } catch (err) {
        winstonLogger.error(err);
        next(new ErrorHandler(500, "Update failed"));
    }
}

export async function getUser(req: Request, res: Response, next: NextFunction) {
    try {
        const query = "SELECT * FROM users WHERE username = $1";
        winstonLogger.debug(query);
        const data = await db.any(query, [req.session.passport.user.uid]);
        res.status(200).json(data);
    } catch (err) {
        winstonLogger.error(err);
        next(new ErrorHandler(500, "Issue processing get user request"));
    }
}

export async function insertEducationalMaterial(obj: any, func: any) {
    await db.any("BEGIN");
    try {
        const response = await insertIntoEducationalMaterial(obj.educationalmaterial[0]);
        const materialid = response[0].id;
        let mkey = "MaterialName";
        for (const num in obj[mkey]) {
            await insertIntoMaterialName(obj[mkey][num], materialid);
        }
        mkey = "Description";
        for (const num in obj[mkey]) {
            await insertIntoMaterialDescription(obj[mkey][num], materialid);
        }
        mkey = "EducationalAudience";
        for (const num in obj[mkey]) {
            await insertIntoEducationalAudience(obj[mkey][num], materialid);
        }
        mkey = "LearningResourceType";
        for (const num in obj[mkey]) {
            await insertIntoLearningResourceType(obj[mkey][num], materialid);
        }
        mkey = "AccessibilityFeature";
        for (const num in obj[mkey]) {
            await insertIntoAccessibilityFeature(obj[mkey][num], materialid);
        }
        mkey = "AccessibilityHazard";
        for (const num in obj[mkey]) {
            await insertIntoAccessibilityHazard(obj[mkey][num], materialid);
        }
        mkey = "KeyWord";
        for (const num in obj[mkey]) {
            await insertIntoKeyWord(obj[mkey][num], materialid);
        }
        mkey = "EducationalLevel";
        for (const num in obj[mkey]) {
            await insertIntoEducationalLevel(obj[mkey][num], materialid);
        }
        mkey = "EducationalUse";
        for (const num in obj[mkey]) {
            await insertIntoEducationalUse(obj[mkey][num], materialid);
        }
        mkey = "Publisher";
        for (const num in obj[mkey]) {
            await insertIntoPublisher(obj[mkey][num], materialid);
        }
        mkey = "InLanguage";
        for (const num in obj[mkey]) {
            await insertIntoInLanguage(obj[mkey][num], materialid);
        }
        mkey = "AlignmentObject";
        for (const num in obj[mkey]) {
            await insertIntoAlignmentObject(obj[mkey][num], materialid);
        }
        mkey = "Material";
        for (const num in obj[mkey]) {
            await insertIntoMaterial(obj[mkey][num], materialid);
        }
        mkey = "Author";
        for (const num in obj[mkey]) {
            await insertIntoAuthor(obj[mkey][num], materialid);
        }
        await db.any("COMMIT");
        func(undefined, "Success");
    } catch (err) {
        await db.any("ROLLBACK");
        winstonLogger.debug(err);
        func(err);
    }
}

export async function insertIntoEducationalMaterial(obj: any) {
    const materialData = {
        technicalname: obj.technicalname,
        createdat: obj.createdat,
        // author : obj.author,
        // organization : obj.organization,
        publishedat: obj.publishedat,
        updatedat: obj.updatedat,
        archivedat: obj.archivedat,
        timerequired: obj.timerequired,
        agerangemin: obj.agerangemin,
        agerangemax: obj.agerangemax,
        // usersid : obj.usersid,
        usersusername: obj.username,
        licensecode: obj.licensecode,
        originalpublishedat: obj.originalpublishedat
    };
    const query = pgp.helpers.insert(materialData, undefined, "educationalmaterial") + "RETURNING id";
    winstonLogger.debug(query);
    const data = await db.any(query);
    return data;
}

export async function insertIntoMaterialName(obj: any, materialid: any) {
    const data = {
        materialname: obj.MaterialName,
        language: obj.Language,
        slug: obj.Slug,
        educationalmaterialid: materialid
    };
    const query = pgp.helpers.insert(data, undefined, "materialname") + "RETURNING id";
    winstonLogger.debug(query);
    await db.any(query);
}

export async function insertIntoMaterialDescription(obj: any, materialid: any) {
    const data = {
        description: obj.Description,
        language: obj.Language,
        educationalmaterialid: materialid
    };
    const query = pgp.helpers.insert(data, undefined, "materialdescription") + "RETURNING id";
    winstonLogger.debug(query);
    await db.any(query);
}

export async function insertIntoEducationalAudience(obj: any, materialid: any) {
    const data = {
        educationalrole: obj.EducationalRole,
        educationalmaterialid: materialid
    };
    const query = pgp.helpers.insert(data, undefined, "educationalaudience") + "RETURNING id";
    winstonLogger.debug(query);
    await db.any(query);
}

export async function insertIntoLearningResourceType(obj: any, materialid: any) {
    const data = {
        value: obj.value,
        educationalmaterialid: materialid
    };
    const query = pgp.helpers.insert(data, undefined, "learningresourcetype") + "RETURNING id";
    winstonLogger.debug(query);
    await db.any(query);
}

export async function insertIntoAuthor(obj: any, materialid: any) {
    const data = {
        authorname: obj.authorname,
        organization: obj.organization,
        educationalmaterialid: materialid
    };
    const query = pgp.helpers.insert(data, undefined, "author") + "RETURNING id";
    await db.any(query);
}

export async function insertIntoAccessibilityFeature(obj: any, materialid: any) {
    const data = {
        value: obj.value,
        educationalmaterialid: materialid
    };
    const query = pgp.helpers.insert(data, undefined, "accessibilityfeature") + "RETURNING id";
    winstonLogger.debug(query);
    await db.any(query);
}

export async function insertIntoAccessibilityHazard(obj: any, materialid: any) {
    const data = {
        value: obj.value,
        educationalmaterialid: materialid
    };
    const query = pgp.helpers.insert(data, undefined, "accessibilityhazard") + "RETURNING id";
    winstonLogger.debug(query);
    await db.any(query);
}

export async function insertIntoKeyWord(obj: any, materialid: any) {
    const data = {
        value: obj.value,
        keyurl: "",
        educationalmaterialid: materialid
    };
    const query = pgp.helpers.insert(data, undefined, "keyword") + "RETURNING id";
    winstonLogger.debug(query);
    await db.any(query);
}

export async function insertIntoEducationalLevel(obj: any, materialid: any) {
    const data = {
        value: obj.value,
        educationalmaterialid: materialid
    };
    const query = pgp.helpers.insert(data, undefined, "educationallevel") + "RETURNING id";
    winstonLogger.debug(query);
    await db.any(query);
}

export async function insertIntoEducationalUse(obj: any, materialid: any) {
    const data = {
        value: obj.value,
        educationalmaterialid: materialid
    };
    const query = pgp.helpers.insert(data, undefined, "educationaluse") + "RETURNING id";
    winstonLogger.debug(query);
    await db.any(query);
}

export async function insertIntoPublisher(obj: any, materialid: any) {
    const data = {
        name: obj.name,
        educationalmaterialid: materialid
    };
    const query = pgp.helpers.insert(data, undefined, "publisher") + "RETURNING id";
    winstonLogger.debug(query);
    await db.any(query);
}

export async function insertIntoInLanguage(obj: any, materialid: any) {
    const data = {
        inlanguage: obj.name,
        url: "",
        educationalmaterialid: materialid
    };
    const query = pgp.helpers.insert(data, undefined, "inlanguage") + "RETURNING id";
    winstonLogger.debug(query);
    await db.any(query);
}

export async function insertIntoAlignmentObject(obj: any, materialid: any) {
    const data = {
        alignmenttype: obj.alignmenttype,
        targetname: obj.targetname,
        source: obj.source,
        educationalmaterialid: materialid
    };
    const query = pgp.helpers.insert(data, undefined, "alignmentobject") + "RETURNING id";
    winstonLogger.debug(query);
    await db.any(query);
}

export async function insertIntoMaterial(obj: any, materialid: any) {
    const data = {
        // materialname : obj.materialname,
        link: obj.link,
        priority: obj.priority,
        educationalmaterialid: materialid
    };
    const query = pgp.helpers.insert(data, undefined, "material") + "RETURNING id";
    winstonLogger.debug(query);
    await db.any(query);
}

function createSlug(str: string) {
    str = str.replace(/[ä]/g, "a");
    str = str.replace(/[ö]/g, "o");
    str = str.replace(/[å]/g, "a");
    str = str.replace(/[^a-zA-Z0-9]/g, "");
    return str;
}

export async function isOwner(educationalmaterialid: string, username: string) {
    if (educationalmaterialid && username) {
        const query = "SELECT UsersUserName from EducationalMaterial WHERE id = $1";
        winstonLogger.debug(query);
        const result = await db.oneOrNone(query, educationalmaterialid);
        winstonLogger.debug(result);
        if (!result) {
            winstonLogger.debug("isOwner: No result found for id " + educationalmaterialid);
            return false;
        } else if (username === result.usersusername) {
            return true;
        } else {
            return false;
        }
    }
}

export default {
    addLinkToMaterial,
    getMaterial,
    getEducationalMaterialMetadata,
    getUserMaterial,
    getRecentMaterial,
    setEducationalMaterialObsoleted,
    deleteRecord,
    deleteAttachment,
    setLanguage,
    insertDataToDescription,
    insertEducationalMaterialName,
    updateMaterial,
    insertUrn: updateEduMaterialVersionURN,
    createUser,
    updateUser,
    updateTermsOfUsage,
    getUser,
    insertEducationalMaterial,
    insertIntoEducationalMaterial,
    insertIntoMaterialName,
    insertIntoMaterialDescription,
    insertIntoEducationalAudience,
    insertIntoLearningResourceType,
    insertIntoAuthor,
    insertIntoAccessibilityFeature,
    insertIntoAccessibilityHazard,
    insertIntoKeyWord,
    insertIntoEducationalLevel,
    insertIntoEducationalUse,
    insertIntoPublisher,
    insertIntoInLanguage,
    insertIntoAlignmentObject,
    insertIntoMaterial,
    isOwner
}
