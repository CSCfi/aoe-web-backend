import ADMzip from 'adm-zip';
import AWS, { S3 } from 'aws-sdk';
import { ServiceConfigurationOptions } from 'aws-sdk/lib/service';
import { Request, Response, NextFunction } from 'express';
import fs, { WriteStream } from 'fs';

import multer from 'multer';
import path from 'path';
import s3Zip from 's3-zip';

import { updateDownloadCounter } from './analyticsQueries';
import { insertEducationalMaterialName } from './apiQueries';
import { hasAccesstoPublication } from '../services/authService';
import env from '../configuration/environments';
import { ErrorHandler } from '../helpers/errorHandler';
import { isOfficeMimeType, allasFileToPdf, updatePdfKey } from '../helpers/officeToPdfConverter';
import connection from '../resources/pg-connect';
import { requestRedirected } from '../services/streaming-service';
import { winstonLogger } from '../util';

// TODO: Remove legacy dependencies
// import { ReadStream } from "fs";
// const AWS = require("aws-sdk");
// const s3Zip = require("s3-zip");
// const globalLog = require("global-request-logger");
// globalLog.initialize();
// const ADMzip = require("adm-zip");
// const fs = require("fs");
// const path = require("path");
// const contentDisposition = require("content-disposition");
// const multer = require("multer");

// define multer storage
const storage = multer.diskStorage({ // notice you are calling the multer.diskStorage() method here, not multer()
    destination: function (req: Request, file: any, cb: any) {
        cb(undefined, "uploads/");
    },
    filename: function (req: Request, file: any, cb: any) {
        const ext = file.originalname.substring(file.originalname.lastIndexOf("."), file.originalname.length);
        let str = file.originalname.substring(0, file.originalname.lastIndexOf("."));
        str = str.replace(/[^a-zA-Z0-9]/g, "");
        cb(undefined, str + "-" + Date.now() + ext);
    }
});
const upload = multer({
    "storage": storage,
    "limits": {"fileSize": Number(process.env.FILE_SIZE_LIMIT)},
    "preservePath": true
}); // provide the return value from
// Database connection
const db = connection.db;

/**
 *
 * @param req
 * @param res
 * @param next
 * attachment upload to educational material req.params.materialId
 */
export async function uploadAttachmentToMaterial(req: Request, res: Response, next: NextFunction): Promise<any> {
    try {
        winstonLogger.debug(req.body);
        const contentType = req.headers["content-type"];
        if (contentType.startsWith("multipart/form-data")) {
            upload.single("attachment")(req, res, async function (err: any) {
                    try {
                        if (err) {
                            winstonLogger.error(err);
                            if (err.code === "LIMIT_FILE_SIZE") {
                                next(new ErrorHandler(413, err.message));
                            } else {
                                winstonLogger.error(err);
                                next(new ErrorHandler(500, "Failure in file upload"));
                            }
                        }
                        const file = (<any>req).file;
                        winstonLogger.debug("fil: " + file);
                        if (!file) {
                            next(new ErrorHandler(400, "No file sent"));
                        }
                        winstonLogger.debug("req.params.id: " + req.params.materialId);
                        // const emresp = await insertDataToEducationalMaterialTable(req);
                        const metadata = JSON.parse(req.body.attachmentDetails);
                        winstonLogger.debug(metadata);
                        const material = [];
                        const materialid = [];
                        let attachmentId;
                        let result = [];
                        if (typeof file !== "undefined") {
                            attachmentId = await insertDataToAttachmentTable(file, req.params.materialId, undefined, undefined, undefined, metadata);
                            winstonLogger.debug(JSON.stringify(attachmentId));
                            result = await insertDataToTempAttachmentTable(file, metadata, attachmentId);
                            winstonLogger.debug("result: " + JSON.stringify(result[0]));
                        }
                        // return 200 if success and continue sending files to pouta
                        const resp: any = {};
                        res.status(200).json({"id": attachmentId});
                        try {
                            if (typeof file !== "undefined") {
                                const obj: any = await uploadFileToStorage(("./" + file.path), file.filename, process.env.BUCKET_NAME);
                                // await insertDataToAttachmentTable(file, req.params.materialId, obj.Key, obj.Bucket, obj.Location, metadata);
                                await updateAttachment(obj.Key, obj.Bucket, obj.Location, attachmentId);
                                await deleteDataToTempAttachmentTable(file.filename, result[0].id);
                                fs.unlink("./" + file.path, (err: any) => {
                                    if (err) {
                                        winstonLogger.error(err);
                                    }
                                });
                            }
                        } catch (error) {
                            winstonLogger.error('error while sending files to pouta: ' + error + ' - ' +
                                JSON.stringify((<any>req).file));
                        }
                    } catch (e) {
                        winstonLogger.error(e);
                        if (!res.headersSent) {
                            next(new ErrorHandler(500, "Failure in file upload"));
                        }
                    }
                }
            );
        } else {
            next(new ErrorHandler(400, "Wrong contentType"));
        }
    } catch (err) {
        winstonLogger.error(err);
        next(new ErrorHandler(500, "Not found"));
    }
}

/**
 *
 * @param req
 * @param res
 * @param next
 * upload single file and create educational material if empty only educational material is created
 */
export async function uploadMaterial(req: Request, res: Response, next: NextFunction): Promise<any> {
    try {
        winstonLogger.debug(req.body);
        const contentType = req.headers["content-type"];
        if (contentType.startsWith("multipart/form-data")) {
            upload.single("file")(req, res, async function (err: any) {
                    try {
                        if (err) {
                            winstonLogger.debug(err);
                            if (err.code === "LIMIT_FILE_SIZE") {
                                next(new ErrorHandler(413, err.message));
                            } else {
                                winstonLogger.error(err);
                                next(new ErrorHandler(500, "Error in upload"));
                            }
                        }
                        const file = (<any>req).file;
                        const resp: any = {};

                        // Send educationalmaterialid if no file send for link material creation.
                        if (!file) {
                            await db.tx(async (t: any) => {
                                const id = await insertDataToEducationalMaterialTable(req, t);
                                if (req.body.name) {
                                    await insertEducationalMaterialName(JSON.parse(req.body.name), id.id, t);
                                }
                                return id;
                            })
                                .then((data: any) => {
                                    resp.id = data.id;
                                    return res.status(200).json(resp);
                                })
                                .catch((err: Error) => {
                                    winstonLogger.debug(err);
                                    next(new ErrorHandler(500, "Error in upload"));
                                });
                        } else {
                            let materialid: string;
                            const fileDetails = JSON.parse(req.body.fileDetails);
                            const material: any = [];
                            db.tx(async (t: any) => {
                                const queries = [];
                                const emresp = await insertDataToEducationalMaterialTable(req, t);
                                queries.push(emresp);
                                const id = await insertDataToMaterialTable(t, emresp.id, "", fileDetails.language, fileDetails.priority);
                                queries.push(id);
                                material.push({"id": id.id, "createFrom": file.originalname});
                                materialid = id.id;
                                let result = await insertDataToDisplayName(t, emresp.id, id.id, fileDetails);
                                queries.push(result);
                                result = await insertDataToTempRecordTable(t, file, id.id);
                                queries.push(result);
                                return t.batch(queries);
                            })
                                .then(async (data: any) => {
                                        // return 200 if success and continue sending files to pouta
                                        resp.id = data[0].id;
                                        resp.material = material;
                                        res.status(200).json(resp);
                                        try {
                                            if (typeof file !== "undefined") {
                                                winstonLogger.debug(materialid);
                                                const obj: any = await uploadFileToStorage(("./" + file.path), file.filename, process.env.BUCKET_NAME);
                                                const recordid = await insertDataToRecordTable(file, materialid, obj.Key, obj.Bucket, obj.Location);
                                                // convert file to pdf if office document
                                                try {
                                                    if (isOfficeMimeType(file.mimetype)) {
                                                        winstonLogger.debug("Convert file and send to allas");
                                                        const path = await allasFileToPdf(obj.Key);
                                                        const pdfkey = obj.Key.substring(0, obj.Key.lastIndexOf(".")) + ".pdf";
                                                        const pdfobj: any = await uploadFileToStorage(path, pdfkey, process.env.PDF_BUCKET_NAME);
                                                        await updatePdfKey(pdfobj.Key, recordid);
                                                    }
                                                } catch (e) {
                                                    winstonLogger.debug("ERROR converting office file to pdf");
                                                    winstonLogger.error(e);
                                                }
                                                await deleteDataFromTempRecordTable(file.filename, materialid);
                                                fs.unlink("./" + file.path, (err: any) => {
                                                    if (err) {
                                                        winstonLogger.error(err);
                                                    }
                                                });
                                            }
                                        } catch (ex) {
                                            winstonLogger.debug(ex);
                                            winstonLogger.debug("error while sending file to pouta: " + JSON.stringify((<any>req).file));
                                        }

                                    }
                                )
                                .catch((err: Error) => {
                                    if (!res.headersSent) {
                                        next(new ErrorHandler(500, "Error in upload: " + err));
                                    }
                                    fs.unlink("./" + file.path, (err: any) => {
                                        if (err) {
                                            winstonLogger.debug('Error in uploadMaterial(): ' + err);
                                        } else {
                                            winstonLogger.debug('file removed');
                                        }
                                    });
                                });
                        }

                    } catch (e) {
                        if (!res.headersSent) {
                            next(new ErrorHandler(500, "Error in upload: " + e));
                        }
                    }
                }
            );
        } else {
            next(new ErrorHandler(400, "Not found"));
        }
    } catch (err) {
        next(new ErrorHandler(500, "Error in upload: " + err));
    }
}

/**
 *
 * @param req
 * @param res
 * @param next
 * upload single file to educational material req.params.materialId
 */
export async function uploadFileToMaterial(req: Request, res: Response, next: NextFunction): Promise<any> {
    try {
        const contentType = req.headers["content-type"];
        if (contentType.startsWith("multipart/form-data")) {
            upload.single("file")(req, res, async function (err: any) {
                    try {
                        if (err) {
                            winstonLogger.error(err);
                            if (err.code === "LIMIT_FILE_SIZE") {
                                next(new ErrorHandler(413, err.message));
                            } else {
                                winstonLogger.error(err);
                                next(new ErrorHandler(500, "Error in upload"));
                            }
                        }
                        const file = (<any>req).file;
                        const resp: any = {};
                        if (!file) {
                            next(new ErrorHandler(400, "No file sent"));
                        } else {
                            winstonLogger.debug("uploadFileToMaterial details to database for: " + file.originalname);
                            let materialid: string;
                            const fileDetails = JSON.parse(req.body.fileDetails);
                            const material: any = [];
                            db.tx(async (t: any) => {
                                const queries = [];
                                const id = await insertDataToMaterialTable(t, req.params.edumaterialid, "", fileDetails.language, fileDetails.priority);
                                queries.push(id);
                                material.push({"id": id.id, "createFrom": file.originalname});
                                materialid = id.id;
                                let result = await insertDataToDisplayName(t, req.params.edumaterialid, id.id, fileDetails);
                                queries.push(result);
                                result = await insertDataToTempRecordTable(t, file, id.id);
                                queries.push(result);
                                return t.batch(queries);
                            })
                                .then(async (data: any) => {
                                        // return 200 if success and continue sending files to pouta
                                        winstonLogger.debug("uploadFileToMaterial sending to Pouta: " + file.filename);
                                        resp.id = req.params.edumaterialid;
                                        resp.material = material;
                                        res.status(200).json(resp);
                                        try {
                                            if (typeof file !== "undefined") {
                                                winstonLogger.debug(materialid);
                                                const obj: any = await uploadFileToStorage(("./" + file.path), file.filename, process.env.BUCKET_NAME);
                                                const recordid = await insertDataToRecordTable(file, materialid, obj.Key, obj.Bucket, obj.Location);
                                                try {
                                                    if (await isOfficeMimeType(file.mimetype)) {
                                                        const path = await allasFileToPdf(obj.Key);
                                                        const pdfkey = obj.Key.substring(0, obj.Key.lastIndexOf(".")) + ".pdf";
                                                        const pdfobj: any = await uploadFileToStorage(path, pdfkey, process.env.PDF_BUCKET_NAME);
                                                        await updatePdfKey(pdfobj.Key, recordid);
                                                    }
                                                } catch (e) {
                                                    winstonLogger.error("ERROR converting office file to pdf: " + e);
                                                }
                                                await deleteDataFromTempRecordTable(file.filename, materialid);
                                                fs.unlink("./" + file.path, (err: any) => {
                                                    if (err) {
                                                        winstonLogger.error(err);
                                                    }
                                                });
                                            }
                                        } catch (ex) {
                                            winstonLogger.error("error while sending file to pouta: " + ex + ' - ' + JSON.stringify((<any>req).file));
                                        }

                                    }
                                ).catch((err: Error) => {
                                    winstonLogger.error(err);
                                    if (!res.headersSent) {
                                        next(new ErrorHandler(500, "Error in upload"));
                                    }
                                    fs.unlink("./" + file.path, (err: any) => {
                                        if (err) {
                                            winstonLogger.error('Error in uploadFileToMaterial(): ' + err);
                                        } else {
                                            winstonLogger.debug("file removed");
                                        }
                                    });
                                });
                        }
                    } catch (e) {
                        if (!res.headersSent) {
                            next(new ErrorHandler(500, "Error in upload: " + e));
                        }
                    }
                }
            );
        } else {
            next(new ErrorHandler(400, "Not found"));
        }
    } catch (err) {
        winstonLogger.error(err);
        next(new ErrorHandler(500, "Error in upload"));
    }
}

/**
 *
 * @param file
 * @param materialid
 * load file to allas storage
 */
export async function fileToStorage(file: any, materialid: string): Promise<{ key: string, recordid: string }> {
    const obj: any = await uploadFileToStorage(("./" + file.path), file.filename, process.env.BUCKET_NAME);
    const recordid = await insertDataToRecordTable(file, materialid, obj.Key, obj.Bucket, obj.Location);
    await deleteDataFromTempRecordTable(file.filename, materialid);
    fs.unlink("./" + file.path, (err: any) => {
        if (err) {
            winstonLogger.error(err);
        }
    });
    return {key: obj.Key, recordid: recordid};
}

/**
 *
 * @param file
 * @param metadata
 * @param materialid
 * @param attachmentId
 * load attachment to allas storage
 */
export async function attachmentFileToStorage(file: any, metadata: any, materialid: string, attachmentId: string): Promise<any> {
    const obj: any = await uploadFileToStorage(("./" + file.path), file.filename, process.env.BUCKET_NAME);
    // await insertDataToAttachmentTable(file, materialid, obj.Key, obj.Bucket, obj.Location, metadata);
    await updateAttachment(obj.Key, obj.Bucket, obj.Location, attachmentId);
    await deleteDataToTempAttachmentTable(file.filename, materialid);
    fs.unlink("./" + file.path, (err: any) => {
        if (err) {
            winstonLogger.error(err);
        }
    });
}

/**
 * check if files in temporaryrecord table and try to load to allas storage
 */
export async function checkTemporaryRecordQueue(): Promise<any> {
    try {
        // take hour of
        const ts = Date.now() - 1000 * 60 * 60;
        const query = "Select * From temporaryrecord where extract(epoch from createdat)*1000 < $1 limit 1000;";
        const data = await db.any(query, [ts]);
        for (const element of data) {
            const file = {
                "originalname": element.originalfilename,
                "path": element.filepath,
                "size": element.filesize,
                "mimetype": element.mimetype,
                "encoding": element.format,
                "filename": element.filename
            };
            try {
                const obj = await fileToStorage(file, element.materialid);
                const path = await allasFileToPdf(obj.key);
                const pdfkey = obj.key.substring(0, obj.key.lastIndexOf(".")) + ".pdf";
                const pdfobj: any = await uploadFileToStorage(path, pdfkey, process.env.PDF_BUCKET_NAME);
                await updatePdfKey(pdfobj.Key, obj.recordid);
            } catch (error) {
                winstonLogger.error(error);
            }
        }
    } catch (error) {
        winstonLogger.error(error);
    }
}

/**
 * check if files in temporaryattachment table and try to load to allas storage
 */
export async function checkTemporaryAttachmentQueue(): Promise<any> {
    try {
        // take hour of
        const ts = Date.now() - 1000 * 60 * 60;
        const query = "Select * From temporaryattachment where extract(epoch from createdat)*1000 < $1 limit 1000;";
        const data = await db.any(query, [ts]);
        for (const element of data) {
            const metadata = {
                "default": element.defaultfile,
                "kind": element.kind,
                "label": element.label,
                "srclang": element.srclang
            };
            const file = {
                "originalname": element.originalfilename,
                "path": element.filepath,
                "size": element.filesize,
                "mimetype": element.mimetype,
                "encoding": element.format,
                "filename": element.filename
            };
            try {
                await attachmentFileToStorage(file, metadata, element.id, element.attachmentid);
            } catch (error) {
                winstonLogger.error('Error in checkTemporaryAttachmentQueue(): ' + error);
            }
        }
    } catch (error) {
        winstonLogger.error('Error in checkTemporaryAttachmentQueue(): ' + error);
    }
}

export async function insertDataToEducationalMaterialTable(req: Request, t: any): Promise<any> {
    const query = "insert into educationalmaterial (Usersusername)" +
        " values ($1) returning id;";
    const data = await t.one(query, [req.session.passport.user.uid]);
    winstonLogger.debug(data.id);
    return data;
}


export async function insertDataToDisplayName(t: any, educationalmaterialid, materialid: string, fileDetails: any): Promise<any> {
    const queries = [];
    const query = "INSERT INTO materialdisplayname (displayname, language, materialid) (SELECT $1,$2,$3 where $3 in (select id from material where educationalmaterialid = $4)) ON CONFLICT (language, materialid) DO UPDATE Set displayname = $1;";
    if (fileDetails.displayName && materialid) {
        if (!fileDetails.displayName.fi || fileDetails.displayName.fi === "") {
            if (!fileDetails.displayName.sv || fileDetails.displayName.sv === "") {
                if (!fileDetails.displayName.en || fileDetails.displayName.en === "") {
                    queries.push(await t.none(query, ["", "fi", materialid, educationalmaterialid]));
                } else {
                    queries.push(await t.none(query, [fileDetails.displayName.en, "fi", materialid, educationalmaterialid]));
                }
            } else {
                queries.push(await t.none(query, [fileDetails.displayName.sv, "fi", materialid, educationalmaterialid]));
            }
        } else {
            queries.push(await t.none(query, [fileDetails.displayName.fi, "fi", materialid, educationalmaterialid]));
        }

        if (!fileDetails.displayName.sv || fileDetails.displayName.sv === "") {
            if (!fileDetails.displayName.fi || fileDetails.displayName.fi === "") {
                if (!fileDetails.displayName.en || fileDetails.displayName.en === "") {
                    queries.push(await t.none(query, ["", "sv", materialid, educationalmaterialid]));
                } else {
                    queries.push(await t.none(query, [fileDetails.displayName.en, "sv", materialid, educationalmaterialid]));
                }
            } else {
                queries.push(await t.none(query, [fileDetails.displayName.fi, "sv", materialid, educationalmaterialid]));
            }
        } else {
            queries.push(await t.none(query, [fileDetails.displayName.sv, "sv", materialid, educationalmaterialid]));
        }

        if (!fileDetails.displayName.en || fileDetails.displayName.en === "") {
            if (!fileDetails.displayName.fi || fileDetails.displayName.fi === "") {
                if (!fileDetails.displayName.sv || fileDetails.displayName.sv === "") {
                    queries.push(await t.none(query, ["", "en", materialid, educationalmaterialid]));
                } else {
                    queries.push(await t.none(query, [fileDetails.displayName.sv, "en", materialid, educationalmaterialid]));
                }
            } else {
                queries.push(await t.none(query, [fileDetails.displayName.fi, "en", materialid, educationalmaterialid]));
            }
        } else {
            queries.push(await t.none(query, [fileDetails.displayName.en, "en", materialid, educationalmaterialid]));
        }
    }
    return queries;
}

export async function insertDataToMaterialTable(t: any, eduMaterialId: string, location: any, languages, priority: number): Promise<any> {
    const query = "INSERT INTO material (link, educationalmaterialid, materiallanguagekey, priority) VALUES ($1, $2, $3, $4) RETURNING id";
    // const str = Object.keys(files).map(function(k) {return "('" + files[k].originalname + "','" + location + "','" + materialID + "')"; }).join(",");
    // const str = "('" + files.originalname + "','" + location + "','" + materialID + "')";
    winstonLogger.debug('insertDataToMaterialTable(): query=' + query);
    return await t.one(query, [location, eduMaterialId, languages, priority]);
}

export async function insertDataToAttachmentTable(files: any, materialID: any, fileKey: any, fileBucket: any, location: string, metadata: any): Promise<any> {
    const queries = [];
    let query;
    const data = await db.tx(async (t: any) => {
            query = "UPDATE educationalmaterial SET updatedat = NOW() " +
                "WHERE id = (SELECT educationalmaterialid FROM material WHERE id = $1)";
            queries.push(await db.none(query, [materialID]));
            query = "INSERT INTO attachment (filePath, originalfilename, filesize, mimetype, format, fileKey, " +
                "fileBucket, materialid, defaultfile, kind, label, srclang) " +
                "VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12) RETURNING id";
            winstonLogger.debug(query);
            queries.push(await db.one(query, [location, files.originalname, files.size, files.mimetype,
                files.encoding, fileKey, fileBucket, materialID, metadata.default, metadata.kind, metadata.label,
                metadata.srclang]));
            return t.batch(queries);
        }
    ).catch((err: Error) => {
        throw err;
    });
    return data[1].id;
}

export async function updateAttachment(fileKey: any, fileBucket: any, location: string, attachmentId: string): Promise<any> {
    const queries = [];
    let query;
    await db.tx(async (t: any) => {
            query = "UPDATE attachment SET filePath = $1, fileKey = $2, fileBucket = $3 WHERE id = $4";
            winstonLogger.debug(query);
            queries.push(await db.none(query, [location, fileKey, fileBucket, attachmentId]));
            return t.batch(queries);
        }
    ).catch((err: Error) => {
        throw err;
    });
}

export async function insertDataToTempAttachmentTable(files: any, metadata: any, attachmentId: string): Promise<any> {
    const query = "INSERT INTO temporaryattachment (filename, filepath, originalfilename, filesize, mimetype, format, " +
        "defaultfile, kind, label, srclang, attachmentid) " +
        "VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11) RETURNING id";
    winstonLogger.debug(query);
    const data = await db.any(query, [files.filename, files.path, files.originalname, files.size,
        files.mimetype, files.encoding, metadata.default, metadata.kind, metadata.label, metadata.srclang, attachmentId]);
    return data;
}

export async function insertDataToRecordTable(files: any, materialID: any, fileKey: any, fileBucket: any, location: string): Promise<any> {
    let query;
    try {
        const data = await db.tx(async (t: any) => {
            query = "UPDATE educationalmaterial SET updatedat = NOW() " +
                "WHERE id = (SELECT educationalmaterialid FROM material WHERE id = $1)";
            // queries.push(await db.none(query, [materialID]));
            await t.none(query, [materialID]);
            query = "INSERT INTO record (filePath, originalfilename, filesize, mimetype, format, fileKey, fileBucket, " +
                "materialid) VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING id";
            winstonLogger.debug(query);
            const record = await t.oneOrNone(query, [location, files.originalname, files.size, files.mimetype,
                files.encoding, fileKey, fileBucket, materialID]);
            return {record};
        });
        return data.record.id;
    } catch (err) {
        throw new Error(err);
    }
}

export async function insertDataToTempRecordTable(t: any, files: any, materialId: any): Promise<any> {
    const query = "INSERT INTO temporaryrecord (filename, filepath, originalfilename, filesize, mimetype, format, " +
        "materialid) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING id";
    winstonLogger.debug(query);
    const data = await t.any(query, [files.filename, files.path, files.originalname, files.size, files.mimetype,
        files.encoding, materialId]);
    return data;
}

export async function deleteDataFromTempRecordTable(filename: any, materialId: any): Promise<any> {
    const query = "DELETE FROM temporaryrecord WHERE filename = $1 AND materialid = $2";
    winstonLogger.debug(query);
    return await db.any(query, [filename, materialId]);
}

export async function deleteDataToTempAttachmentTable(filename: any, materialId: any): Promise<any> {
    const query = "DELETE FROM temporaryattachment WHERE filename = $1 AND id = $2";
    winstonLogger.debug(query, [filename, materialId]);
    return await db.any(query, [filename, materialId]);
}

/**
 * Upload a file from the local file system to the cloud object storage.
 *
 * @param filePath   string Path and file name in local file system
 * @param filename   string Target file name in object storage system
 * @param bucketName string Target bucket in object storage system
 */
export const uploadFileToStorage = async (filePath: string, filename: string, bucketName: string): Promise<any> => {
    return new Promise(async (resolve, reject) => {
        try {
            const config: ServiceConfigurationOptions = {
                accessKeyId: process.env.USER_KEY,
                secretAccessKey: process.env.USER_SECRET,
                endpoint: process.env.POUTA_END_POINT,
                region: process.env.REGION
            };
            AWS.config.update(config);
            const s3: S3 = new AWS.S3();
            fs.readFile(filePath, async (err: any, data: any) => {
                if (err) {
                    winstonLogger.error('Reading file from the local file system failed in uploadFileToStorage(): ' + err);
                    return reject(new Error(err));
                }
                try {
                    const params = {
                        Bucket: bucketName,
                        Key: filename,
                        Body: data
                    };
                    const startTime: number = Date.now();
                    s3.upload(params, (err: any, data: any) => {
                        if (err) {
                            winstonLogger.error('Uploading file to the cloud object storage failed in uploadFileToStorage(): ' + err);
                            reject(new Error(err));
                        }
                        if (data) {
                            winstonLogger.debug('Uploading file to the cloud object storage completed in ' + ((Date.now() - startTime) / 1000) + 's');
                            resolve(data);
                        }
                    });
                } catch (err) {
                    winstonLogger.error('Error in uploading file to the cloud object storage in uploadFileToStorage(): ' + err);
                    reject(new Error(err));
                }
            });
        } catch (err) {
            winstonLogger.error('Error in processing file in uploadFileToStorage(): ' + err);
            reject(new Error(err));
        }
    });
};

/**
 * Upload a file from the local file system to the cloud object storage.
 *
 * @param base64data Buffer File binary content Base64 encoded
 * @param filename   string Target file name in object storage system
 * @param bucketName string Target bucket in object storage system
 */
export async function uploadBase64FileToStorage(base64data: Buffer, filename: string, bucketName: string): Promise<any> {
    return new Promise(async (resolve, reject) => {
        try {
            const config: ServiceConfigurationOptions = {
                accessKeyId: process.env.USER_KEY,
                secretAccessKey: process.env.USER_SECRET,
                endpoint: process.env.POUTA_END_POINT,
                region: process.env.REGION
            };
            AWS.config.update(config);
            const s3 = new AWS.S3();
            try {
                const params = {
                    Bucket: bucketName,
                    Key: filename,
                    Body: base64data
                };
                const startTime: number = Date.now();
                s3.upload(params, (err: any, data: any) => {
                    if (err) {
                        winstonLogger.error('Reading file from the local file system failed in uploadBase64FileToStorage(): ' + err);
                        reject(new Error(err));
                    }
                    if (data) {
                        winstonLogger.debug('Uploading file to the cloud object storage completed in ' + ((Date.now() - startTime) / 1000) + 's');
                        resolve(data);
                    }
                });
            } catch (err) {
                winstonLogger.error('Error in uploading file to the cloud object storage in uploadBase64FileToStorage(): ' + err);
                reject(new Error(err));
            }
        } catch (err) {
            winstonLogger.error('Error in processing file in uploadBase64FileToStorage(): ' + err);
            reject(new Error(err));
        }
    });
}

/**
 *
 * @param req
 * @param res
 * @param next
 */
export async function downloadFile(req: Request, res: Response, next: NextFunction): Promise<any> {
    try {
        const data = await downloadFileFromStorage(req, res, next);
        if (!data) return res.end();
        res.status(200).send(data);
    } catch (err) {
        if (!res.headersSent) {
            next(new ErrorHandler(400, "Failed to download file"));
        }
    }
}

/**
 * Get file details from the database before proceeding to the file download from the cloud object storage.
 * TODO: Function chain and related leagcy code should be refactored and simplified.
 *
 * @param req   express.Request
 * @param res   express.Response
 * @param next  express.NextFunction
 * @param isZip boolean Indicator for the need of decompression
 */
export const downloadFileFromStorage = async (req: Request, res: Response, next: NextFunction, isZip?: boolean): Promise<any> => {
    winstonLogger.debug('downloadFileFromStorage(): req.params.filename=' + req.params.filename + ', isZip=' + isZip);

    // TODO: Remove req.params.key refrence from apiQueries.ts:286 (and below :774 and :801)
    const fileName: string = req.params.filename as string || req.params.key as string;
    return new Promise(async (resolve) => {
        try {
            const query =
                "SELECT originalfilename, filesize, mimetype FROM record " +
                "RIGHT JOIN material AS m ON m.id = materialid " +
                "WHERE m.obsoleted = 0 AND filekey = $1 " +
                "UNION " +
                "SELECT originalfilename, filesize, mimetype FROM attachment " +
                "WHERE filekey = $1 AND obsoleted = 0";

            const fileDetails: { originalfilename: string, filesize: number, mimetype: string } =
                await db.oneOrNone(query, [fileName]);
                // { originalfilename: 'oceanwaves1280x720.mp4', filesize: 2000000, mimetype: 'video/mp4' };

            if (!fileDetails) {
                next(new ErrorHandler(404, 'Requested file ' + fileName + ' not found'));
            } else {
                // Check if the criteria for streaming service redirect are fulfilled
                // src/services/streaming-service: requestRedirected()
                if (await requestRedirected(fileDetails)) {
                    res.status(302).set({
                        'Location': env.STREAM_REDIRECT_CRITERIA.redirectUri + req.params.filename
                    });
                    return resolve();
                }
                const params = {
                    Bucket: process.env.BUCKET_NAME as string,
                    Key: req.params.filename as string || req.params.key as string
                };
                const resp = await downloadFromStorage(req, res, next, params, fileDetails.originalfilename, isZip);
                resolve(resp);
            }
        } catch (err) {
            next(new ErrorHandler(500, 'Downloading a single file failed in downloadFileFromStorage()'));
        }
    });
};

/**
 *
 * @param params
 * readstream from allas. params object: bucket name and allas filekey
 */
export async function readStreamFromStorage(params: { Bucket: string; Key: string; }): Promise<any> {
    try {
        const config = {
            accessKeyId: process.env.USER_KEY,
            secretAccessKey: process.env.USER_SECRET,
            endpoint: process.env.POUTA_END_POINT,
            region: process.env.REGION
        };
        AWS.config.update(config);
        const s3 = new AWS.S3();
        winstonLogger.debug("Returning stream");
        return s3.getObject(params).createReadStream();
    } catch (error) {
        winstonLogger.debug("throw readStreamFromStorage error");
        throw new Error(error);
    }
}

/**
 * Download an original or compressed (zip) file from the cloud object storage.
 * In case of a download error try to download from the local backup directory.
 * TODO: Refactoring in progress for the function chain and related legacy code.
 *
 * @param req          express.Request
 * @param res          express.Response
 * @param next         express.NextFunction
 * @param s3params     GetRequestObject (aws-sdk/clients/s3)
 * @param origFilename string Original file name without storage ID
 * @param isZip        boolean Indicator for the need of decompression
 */
export const downloadFromStorage = async (req: Request,
                                          res: Response,
                                          next: NextFunction,
                                          s3params: { Bucket: string, Key: string },
                                          origFilename: string,
                                          isZip?: boolean): Promise<any> => {
    winstonLogger.debug('s3params.Bucket=' + s3params.Bucket + ', s3params.Key=' + s3params.Key + ', origFilename=' +
        origFilename + ', isZip=' + isZip);

    // TODO: Move to global variables
    const configAWS: ServiceConfigurationOptions = {
        accessKeyId: process.env.USER_KEY,
        secretAccessKey: process.env.USER_SECRET,
        endpoint: process.env.POUTA_END_POINT,
        region: process.env.REGION
    };
    AWS.config.update(configAWS);
    const s3: S3 = new AWS.S3();
    const key = s3params.Key;

    return new Promise(async (resolve, reject) => {
        try {
            const fileStream = s3.getObject(s3params).createReadStream();
            if (isZip) { // replaced: isZip === true
                const folderpath: string = process.env.HTMLFOLDER + '/' + origFilename;
                const zipStream: WriteStream = fileStream
                    .on('error', (error: Error) => {
                        winstonLogger.error('Error in zip file download in downloadFromStorage(): ' + error);
                        reject();
                        // const path: string = process.env.BACK_UP_PATH + key;
                        // const backupfs: ReadStream = fs.createReadStream(path);
                        // const backupws: WriteStream = backupfs
                        //     .on('error', (error: Error) => {
                        //         next(new ErrorHandler(500, 'downloadFromStorage() - Error in ' +
                        //             'backup file stream: ' + error));
                        //     })
                        //     .pipe(fs.createWriteStream(folderpath));
                        // backupws.once('finish', async () => {
                        //     resolve(await unZipAndExtract(folderpath));
                        // });
                    })
                    .once('end', () => {
                        winstonLogger.error('Download of %s completed in downloadFromStorage()', key);
                    })
                    .pipe(fs.createWriteStream(folderpath));
                zipStream.once('finish', async () => {
                    resolve(await unZipAndExtract(folderpath));
                });
            } else {
                res.attachment(key);
                // res.header('Content-Disposition', contentDisposition(origFilename));
                fileStream
                    .on('error', (error: Error) => {
                        winstonLogger.error('downloadFromStorage() - Error in single file download stream: ' +
                            error);
                        reject();
                        // const backupfs = await readStreamFromBackup(key);
                        // let path = process.env.BACK_UP_PATH + key;
                        // if (s3params.Bucket == process.env.THUMBNAIL_BUCKET_NAME) { // In case of a thumbnail
                        //     path = process.env.THUMBNAIL_BACK_UP_PATH + key;
                        // }
                        // const backupfs = fs.createReadStream(path);
                        // backupfs
                        //     .on('error', (error: Error) => {
                        //         next(new ErrorHandler(500, 'downloadFromStorage() - Error in ' +
                        //             'backup file stream: ' + error));
                        //     })
                        //     .pipe(res);
                    })
                    .once('end', () => {
                        winstonLogger.debug('Download of %s completed in downloadFromStorage()', key);
                        resolve();
                    })
                    .pipe(res);
            }
        } catch (error) {
            next(new ErrorHandler(500, 'Error in downloadFromStorage():' + error));
        }
    });
};

/**
 * Download all files related to an educational material as a bundled zip file.
 *
 * @param req  Request<any>
 * @param res  Response<any>
 * @param next NextFunction
 */
export async function downloadMaterialFile(req: Request, res: Response, next: NextFunction): Promise<void> {
    winstonLogger.debug('downloadMaterialFile(): edumaterialid=' + req.params.edumaterialid + ', publishedat?=' + req.params.publishedat);

    // Queries to resolve files of the latest educational material requested
    const queryLatestPublished = "SELECT MAX(publishedat) AS max FROM versioncomposition WHERE educationalmaterialid = $1";
    const queryVersionFilesIds =
        "SELECT record.filekey, record.originalfilename " +
        "FROM versioncomposition " +
        "RIGHT JOIN material ON material.id = versioncomposition.materialid " +
        "RIGHT JOIN record ON record.materialid = material.id " +
        "WHERE material.educationalmaterialid = $1 AND obsoleted = 0 AND publishedat = $2 " +
        "UNION " +
        "SELECT attachment.filekey, attachment.originalfilename " +
        "FROM attachmentversioncomposition AS v " +
        "INNER JOIN attachment ON v.attachmentid = attachment.id " +
        "WHERE v.versioneducationalmaterialid = $1 AND attachment.obsoleted = 0 AND v.versionpublishedat = $2";

    try {
        const versionFiles: { filekey: string, originalfilename: string }[] = await db.task(async (t: any) => {
            let publishedAt = req.params.publishedat;
            if (!publishedAt) {
                const latestPublished: { max: string } = await t.oneOrNone(queryLatestPublished, req.params.edumaterialid);
                publishedAt = latestPublished.max;
            }
            return await db.any(queryVersionFilesIds, [req.params.edumaterialid, publishedAt]);
        });
        if (versionFiles.length < 1) {
            next(new ErrorHandler(404, 'No material found for educationalmaterialid=' +
                req.params.edumaterialid + ', publishedat?=' + req.params.publishedat));
        } else {
            const fileKeys: string[] = [];
            const fileNames: string[] = [];
            for (const file of versionFiles) {
                fileKeys.push(file.filekey);
                fileNames.push(file.originalfilename);
            }
            // res.header('Content-Type', 'application/zip');
            res.header('Content-Disposition', 'attachment; filename=materials.zip');

            // Download files from the object storage and zip the bundle, send the zipped file as a response
            await downloadAndZipFromStorage(req, res, next, fileKeys, fileNames);

            // Try to update download counter
            const educationalMaterialId: number = parseInt(req.params.edumaterialid, 10);
            if (!req.isAuthenticated() || !(await hasAccesstoPublication(educationalMaterialId, req))) {
                try {
                    await updateDownloadCounter(educationalMaterialId.toString());
                } catch (error) {
                    winstonLogger.error('Updating download counter failed: ' + error);
                }
            }
        }
    } catch (error) {
        next(new ErrorHandler(400, 'File download failed for educationalmaterialid=' +
            req.params.edumaterialid + ', publishedat?=' + req.params.publishedat));
    }
}

/**
 * Stream and combine files from the object storage to a compressed zip file.
 *
 * @param req   Request<any>
 * @param res   Response<any>
 * @param next  NextFunction
 * @param keys  string[] Array of object storage keys
 * @param files string[] Array of file names
 */
export async function downloadAndZipFromStorage(req: Request, res: Response, next: NextFunction, keys: string[], files: string[]): Promise<void> {
    return new Promise(async resolve => {
        try {
            // ServiceConfigurationOptions (fields: endpoint, lib: aws-sdk/lib/service) extends
            // ConfigurationOptions (fields: all others, lib: aws-sdk)
            const config: ServiceConfigurationOptions = {
                accessKeyId: process.env.USER_KEY,
                secretAccessKey: process.env.USER_SECRET,
                endpoint: process.env.POUTA_END_POINT,
                region: process.env.REGION
            };
            AWS.config.update(config);
            const s3 = new AWS.S3();
            const bucketName = process.env.BUCKET_NAME;
            winstonLogger.debug('Starting s3Zip stream');
            try {
                s3Zip
                    .archive({s3: s3, bucket: bucketName}, '', keys, files)
                    .pipe(res)
                    .on('finish', async () => {
                        winstonLogger.debug('Completed the s3Zip stream');
                        resolve();
                    })
                    .on('error', (e) => {
                        next(new ErrorHandler(500, e.message || 'Error in download'));
                    });
            } catch (err) {
                next(new ErrorHandler(500, 'Failed to download file from storage'));
            }
        } catch (err) {
            next(new ErrorHandler(500, 'Failed to download file'));
        }
    });
}

export async function unZipAndExtract(zipFolder: any): Promise<any> {
    const searchRecursive = function (dir, pattern) {
        // This is where we store pattern matches of all files inside the directory
        let results = [];

        // Read contents of directory
        fs.readdirSync(dir).forEach(function (dirInner) {
            // Obtain absolute path
            dirInner = path.resolve(dir, dirInner);

            // Get stats to determine if path is a directory or a file
            const stat = fs.statSync(dirInner);

            // If path is a directory, scan it and combine results
            if (stat.isDirectory()) {
                results = results.concat(searchRecursive(dirInner, pattern));
            }

            // If path is a file and ends with pattern then push it onto results
            if (stat.isFile() && dirInner.endsWith(pattern)) {
                results.push(dirInner);
            }
        });
        return results;
    };

    try {

        // We unzip the file that is received to the function
        // We unzip the file to the folder specified in the env variables, + filename
        winstonLogger.debug("The folderpath that came to the unZipandExtract function: " + zipFolder);
        // const filenameParsed = zipFolder.substring(0, zipFolder.lastIndexOf("/"));
        const filenameParsedNicely = zipFolder.slice(0, -4);
        winstonLogger.debug("Hopefully the filename is parsed corectly: " + filenameParsedNicely);
        // winstonLogger.debug("The filenameParsed: " + filenameParsed);
        winstonLogger.debug("Does the file exist? : " + fs.existsSync(zipFolder));
        const zip = new ADMzip(zipFolder);
        // Here we remove the ext from the file, eg. python.zip --> python, so that we can name the folder correctly
        // const folderPath = process.env.HTMLFOLDER + "/" + filename;
        // Here we finally extract the zipped file to the folder we just specified.
        // const zipEntries = zip.getEntries();
        // zipEntries.forEach(function (zipEntry) {
        //     winstonLogger.debug(zipEntry.getData().toString("utf8"));
        // });
        zip.extractAllTo(filenameParsedNicely, true);

        const pathToReturn = zipFolder + "/index.html";
        winstonLogger.debug("The pathtoreturn: " + pathToReturn);
        const results = await searchRecursive(filenameParsedNicely, "index.html");
        if (Array.isArray(results) && results.length) {
            winstonLogger.debug("The results: " + results);
            return results[0];
        }
        const resultshtm = await searchRecursive(filenameParsedNicely, "index.htm");
        if (Array.isArray(resultshtm) && resultshtm.length) {
            winstonLogger.debug("The resultshtm: " + resultshtm);
            return resultshtm[0];
        } else {
            winstonLogger.debug("the unzipandextract returns false");
            return false;
        }
    } catch (err) {
        winstonLogger.debug("The error in unzipAndExtract function for HTML zip: " + err);
        return false;
    }
}

export default {
    uploadMaterial,
    uploadFileToMaterial,
    uploadFileToStorage,
    downloadFile,
    unZipAndExtract,
    downloadFileFromStorage,
    downloadMaterialFile,
    checkTemporaryRecordQueue,
    uploadBase64FileToStorage,
    uploadAttachmentToMaterial,
    checkTemporaryAttachmentQueue,
    insertDataToDisplayName,
    downloadFromStorage,
    readStreamFromStorage
};
