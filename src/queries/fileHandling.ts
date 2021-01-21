import { Request, Response, NextFunction } from "express";
import { ErrorHandler } from "./../helpers/errorHandler";
import { insertEducationalMaterialName } from "./apiQueries";
import { updateDownloadCounter } from "./analyticsQueries";
import { hasAccesstoPublication } from "./../services/authService";
import { isOfficeMimeType, allasFileToPdf, updatePdfKey } from "./../helpers/officeToPdfConverter";
import { ReadStream } from "fs";
const AWS = require("aws-sdk");
const s3Zip = require("s3-zip");
const globalLog = require("global-request-logger");
globalLog.initialize();
const ADMzip = require("adm-zip");

const fs = require("fs");
const path = require("path");
const contentDisposition = require("content-disposition");

// File upload dependencies
const multer  = require("multer");


const storage = multer.diskStorage({ // notice you are calling the multer.diskStorage() method here, not multer()
    destination: function(req: Request, file: any, cb: any) {
        cb(undefined, "uploads/");
    },
    filename: function(req: Request, file: any, cb: any) {
        const ext = file.originalname.substring(file.originalname.lastIndexOf("."), file.originalname.length);
        let str = file.originalname.substring(0, file.originalname.lastIndexOf("."));
        str = str.replace(/[^a-zA-Z0-9]/g, "");
        cb(undefined, str + "-" + Date.now() + ext);
    }
});
const upload = multer({"storage": storage
                    , "limits": {"fileSize": Number(process.env.FILE_SIZE_LIMIT)}
                    , "preservePath" : true
                    }); // provide the return value from
// Database connection
const connection = require("./../db");
const db = connection.db;

export async function uploadAttachmentToMaterial(req: Request, res: Response, next: NextFunction) {
    try {
        console.log(req.body);
        const contentType = req.headers["content-type"];
        if (contentType.startsWith("multipart/form-data")) {
        upload.single("attachment")(req , res, async function(err: any) {
            try {
                if (err) {
                    console.log(err);
                    if (err.code === "LIMIT_FILE_SIZE") {
                        next(new ErrorHandler(413, err.message));
                    }
                    else {
                        console.error(err);
                        next(new ErrorHandler(500, "Failure in file upload"));
                    }
                }
                const file = (<any>req).file;
                console.log("fil: " + file);
                if (!file) {
                    next(new ErrorHandler(400, "No file sent"));
                }
                console.log("req.params.id: " + req.params.materialId);
                // const emresp = await insertDataToEducationalMaterialTable(req);
                const metadata = JSON.parse(req.body.attachmentDetails);
                console.log(metadata);
                const material = [];
                const materialid = [];
                let attachmentId;
                let result = [];
                if (typeof file !== "undefined") {
                    attachmentId = await insertDataToAttachmentTable(file, req.params.materialId, undefined, undefined, undefined, metadata);
                    console.log(JSON.stringify(attachmentId));
                    result = await insertDataToTempAttachmentTable(file, metadata, attachmentId);
                        console.log("result: " + JSON.stringify(result[0]));
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
                            console.error(err);
                            }
                        });
                    }
                }
                catch (ex) {
                    console.log(ex);
                    console.log("error while sending files to pouta: " + JSON.stringify((<any>req).file));
                }
            } catch (e) {
                console.error(e);
                if ( ! res.headersSent) {
                    next(new ErrorHandler(500, "Failure in file upload"));
                }
            }
        }
        );
    }
    else {
        next(new ErrorHandler(400, "Wrong contentType"));
    }
}
catch (err) {
    console.error(err);
    next(new ErrorHandler(500, "Not found"));
}
}

export async function uploadMaterial(req: Request, res: Response, next: NextFunction) {
    try {
        console.log(req.body);
        const contentType = req.headers["content-type"];
        if (contentType.startsWith("multipart/form-data")) {
            upload.single("file")(req , res, async function(err: any) {
                try {
                    if (err) {
                        console.log(err);
                        if (err.code === "LIMIT_FILE_SIZE") {
                            next(new ErrorHandler(413, err.message));
                        }
                        else {
                            console.trace(err);
                            next(new ErrorHandler(500, "Error in upload"));
                        }
                    }
                    const file = (<any>req).file;
                    const resp: any = {};
// send educationalmaterialid if no file send for link material creation.
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
                            console.log(err);
                            next(new ErrorHandler(500, "Error in upload"));
                        });
                    }
                    else {
                        let materialid: String;
                        const fileDetails = JSON.parse(req.body.fileDetails);
                        const material: any = [];
                        db.tx(async (t: any) => {
                            const queries = [];
                            const emresp = await insertDataToEducationalMaterialTable(req, t);
                            queries.push(emresp);
                            const id = await insertDataToMaterialTable(t, emresp.id, "", fileDetails.language, fileDetails.priority);
                            queries.push(id);
                            material.push({"id" : id.id, "createFrom" : file.originalname});
                            materialid = id.id;
                            let result = await insertDataToDisplayName(t, emresp.id, id.id, fileDetails);
                            queries.push(result);
                            result = await insertDataToTempRecordTable(t, file, id.id);
                            queries.push(result);
                            return t.batch(queries);
                        })
                        .then( async (data: any) => {
                            // return 200 if success and continue sending files to pouta
                            resp.id = data[0].id;
                            resp.material = material;
                            res.status(200).json(resp);
                            try {
                                if (typeof file !== "undefined") {
                                    console.log(materialid);
                                    const obj: any = await uploadFileToStorage(("./" + file.path), file.filename, process.env.BUCKET_NAME);
                                    const recordid = await insertDataToRecordTable(file, materialid, obj.Key, obj.Bucket, obj.Location);
                                    // convert file to pdf if office document
                                    try {
                                        if (isOfficeMimeType(file.mimetype)) {
                                            console.log("Convert file and send to allas");
                                            const path = await allasFileToPdf(obj.Key);
                                            const pdfkey = obj.Key.substring(0, obj.Key.lastIndexOf(".")) + ".pdf";
                                            const pdfobj: any = await uploadFileToStorage(path, pdfkey, process.env.PDF_BUCKET_NAME);
                                            await updatePdfKey(pdfobj.Key, recordid);
                                        }
                                    }
                                    catch (e) {
                                        console.log("ERROR converting office file to pdf");
                                        console.error(e);
                                    }
                                    await deleteDataFromTempRecordTable(file.filename, materialid);
                                    fs.unlink("./" + file.path, (err: any) => {
                                        if (err) {
                                        console.error(err);
                                        }
                                    });
                                }
                            }
                            catch (ex) {
                                console.log(ex);
                                console.log("error while sending file to pouta: " + JSON.stringify((<any>req).file));
                            }

                    }
                    )
                    .catch((err: Error) => {
                        console.log(err);
                        if ( ! res.headersSent) {
                            next(new ErrorHandler(500, "Error in upload"));
                        }
                        fs.unlink("./" + file.path, (err: any) => {
                            if (err) {
                            console.error(err);
                            }
                            else {
                                console.log("file removed");
                            }
                        });
                    });
                    }

                } catch (e) {
                    console.log(e);
                    if ( ! res.headersSent) {
                        next(new ErrorHandler(500, "Error in upload"));
                    }
                }
            }
            );
        }
        else {
            next(new ErrorHandler(400, "Not found"));
        }
    }
    catch (err) {
        console.log(err);
        next(new ErrorHandler(500, "Error in upload"));
    }
}

export async function uploadFileToMaterial(req: Request, res: Response, next: NextFunction) {
    try {
        const contentType = req.headers["content-type"];
        if (contentType.startsWith("multipart/form-data")) {
            console.log("uploadFileToMaterial starting");
            upload.single("file")(req , res, async function(err: any) {
                try {
                    if (err) {
                        console.error(err);
                        if (err.code === "LIMIT_FILE_SIZE") {
                            next(new ErrorHandler(413, err.message));
                        }
                        else {
                            console.trace(err);
                            next(new ErrorHandler(500, "Error in upload"));
                        }
                    }
                    const file = (<any>req).file;
                    const resp: any = {};
                    if (!file) {
                        next(new ErrorHandler(400, "No file sent"));
                    }
                    else {
                        console.log("uploadFileToMaterial details to database for: " + file.originalname);
                        let materialid: String;
                        const fileDetails = JSON.parse(req.body.fileDetails);
                        const material: any = [];
                        db.tx(async (t: any) => {
                            const queries = [];
                            const id = await insertDataToMaterialTable(t, req.params.materialId, "", fileDetails.language, fileDetails.priority);
                            queries.push(id);
                            material.push({"id" : id.id, "createFrom" : file.originalname});
                            materialid = id.id;
                            let result = await insertDataToDisplayName(t, req.params.materialId, id.id, fileDetails);
                            queries.push(result);
                            result = await insertDataToTempRecordTable(t, file, id.id);
                            queries.push(result);
                            return t.batch(queries);
                        })
                        .then( async (data: any) => {
                            // return 200 if success and continue sending files to pouta
                            console.log("uploadFileToMaterial sending to Pouta: " + file.filename);
                            resp.id = req.params.materialId;
                            resp.material = material;
                            res.status(200).json(resp);
                            try {
                                if (typeof file !== "undefined") {
                                    console.log(materialid);
                                    const obj: any = await uploadFileToStorage(("./" + file.path), file.filename, process.env.BUCKET_NAME);
                                    const recordid = await insertDataToRecordTable(file, materialid, obj.Key, obj.Bucket, obj.Location);
                                    try {
                                        if (isOfficeMimeType(file.mimetype)) {
                                            console.log("Convert file and send to allas");
                                            const path = await allasFileToPdf(obj.Key);
                                            const pdfkey = obj.Key.substring(0, obj.Key.lastIndexOf(".")) + ".pdf";
                                            const pdfobj: any = await uploadFileToStorage(path, pdfkey, process.env.PDF_BUCKET_NAME);
                                            await updatePdfKey(pdfobj.Key, recordid);
                                        }
                                    }
                                    catch (e) {
                                        console.log("ERROR converting office file to pdf");
                                        console.error(e);
                                    }
                                    await deleteDataFromTempRecordTable(file.filename, materialid);
                                    fs.unlink("./" + file.path, (err: any) => {
                                        if (err) {
                                        console.error(err);
                                        }
                                    });
                                }
                            }
                            catch (ex) {
                                console.log(ex);
                                console.log("error while sending file to pouta: " + JSON.stringify((<any>req).file));
                            }

                    }
                    )
                    .catch((err: Error) => {
                        console.log(err);
                        if ( ! res.headersSent) {
                            next(new ErrorHandler(500, "Error in upload"));
                        }
                        fs.unlink("./" + file.path, (err: any) => {
                            if (err) {
                            console.error(err);
                            }
                            else {
                                console.log("file removed");
                            }
                        });
                    });
                    }
                } catch (e) {
                    console.log(e);
                    if ( ! res.headersSent) {
                        next(new ErrorHandler(500, "Error in upload"));
                    }
                }
            }
            );
        }
        else {
            next(new ErrorHandler(400, "Not found"));
        }
    }
    catch (err) {
        console.error(err);
        next(new ErrorHandler(500, "Error in upload"));
    }
}

export async function fileToStorage(file: any, materialid: String): Promise<{key: string, recordid: string}> {
    const obj: any = await uploadFileToStorage(("./" + file.path), file.filename, process.env.BUCKET_NAME);
    const recordid = await insertDataToRecordTable(file, materialid, obj.Key, obj.Bucket, obj.Location);
    await deleteDataFromTempRecordTable(file.filename, materialid);
    fs.unlink("./" + file.path, (err: any) => {
        if (err) {
        console.error(err);
        }
    });
    return { key : obj.Key, recordid: recordid };
}

export async function attachmentFileToStorage(file: any, metadata: any, materialid: string, attachmentId: string) {
    const obj: any = await uploadFileToStorage(("./" + file.path), file.filename, process.env.BUCKET_NAME);
    // await insertDataToAttachmentTable(file, materialid, obj.Key, obj.Bucket, obj.Location, metadata);
    await updateAttachment(obj.Key, obj.Bucket, obj.Location, attachmentId);
    await deleteDataToTempAttachmentTable(file.filename, materialid);
    fs.unlink("./" + file.path, (err: any) => {
        if (err) {
        console.error(err);
        }
    });
}

export async function checkTemporaryRecordQueue() {
    try {
        // take hour of
        const ts = Date.now() - 1000 * 60 * 60;
        console.log("checkTemporaryRecordQueue");
        const query = "Select * From temporaryrecord where extract(epoch from createdat)*1000 < $1 limit 1000;";
        const data = await db.any(query, [ts]);
        for (const element of data) {
            const file = {
                "originalname" : element.originalfilename,
                "path" : element.filepath,
                "size" : element.filesize,
                "mimetype" : element.mimetype,
                "encoding" : element.format,
                "filename" : element.filename
            };
            try {
                const obj = await fileToStorage(file, element.materialid);
                const path = await allasFileToPdf(obj.key);
                const pdfkey = obj.key.substring(0, obj.key.lastIndexOf(".")) + ".pdf";
                const pdfobj: any = await uploadFileToStorage(path, pdfkey, process.env.PDF_BUCKET_NAME);
                await updatePdfKey(pdfobj.Key, obj.recordid);
            }
            catch (error) {
                console.log(error);
            }
        }
    }
    catch (error) {
        console.log(error);
    }
}

export async function checkTemporaryAttachmentQueue() {
    try {
        // take hour of
        const ts = Date.now() - 1000 * 60 * 60;
        console.log("checkTemporaryAttachmentQueue");
        const query = "Select * From temporaryattachment where extract(epoch from createdat)*1000 < $1 limit 1000;";
        const data = await db.any(query, [ts]);
        for (const element of data) {
            const metadata = {
                "default" : element.defaultfile,
                "kind" : element.kind,
                "label" :  element.label,
                "srclang" : element.srclang
            };
            const file = {
                "originalname" : element.originalfilename,
                "path" : element.filepath,
                "size" : element.filesize,
                "mimetype" : element.mimetype,
                "encoding" : element.format,
                "filename" : element.filename
            };
            try {
                await attachmentFileToStorage(file, metadata, element.id, element.attachmentid);
            }
            catch (error) {
                console.log(error);
            }
        }
    }
    catch (error) {
        console.log(error);
    }
}

export async function insertDataToEducationalMaterialTable(req: Request, t: any) {
    const query = "insert into educationalmaterial (Usersusername)" +
                    " values ($1) returning id;";
    const data = await t.one(query, [req.session.passport.user.uid]);
    console.log(data.id);
    return data;
}



export async function insertDataToDisplayName(t: any, educationalmaterialid: String, materialid: String, fileDetails: any) {
    const queries = [];
    const query = "INSERT INTO materialdisplayname (displayname, language, materialid) (SELECT $1,$2,$3 where $3 in (select id from material where educationalmaterialid = $4)) ON CONFLICT (language, materialid) DO UPDATE Set displayname = $1;";
    if (fileDetails.displayName && materialid) {
        if (!fileDetails.displayName.fi || fileDetails.displayName.fi === "") {
            if (!fileDetails.displayName.sv || fileDetails.displayName.sv === "") {
                if (!fileDetails.displayName.en || fileDetails.displayName.en === "") {
                    queries.push(await t.none(query, ["", "fi", materialid, educationalmaterialid]));
                }
                else {
                    queries.push(await t.none(query, [fileDetails.displayName.en, "fi", materialid, educationalmaterialid]));
                }
            }
            else {
                queries.push(await t.none(query, [fileDetails.displayName.sv, "fi", materialid, educationalmaterialid]));
            }
        }
        else {
            queries.push(await t.none(query, [fileDetails.displayName.fi, "fi", materialid, educationalmaterialid]));
        }

        if (!fileDetails.displayName.sv || fileDetails.displayName.sv === "") {
            if (!fileDetails.displayName.fi || fileDetails.displayName.fi === "") {
                if (!fileDetails.displayName.en || fileDetails.displayName.en === "") {
                    queries.push(await t.none(query, ["", "sv", materialid, educationalmaterialid]));
                }
                else {
                    queries.push(await t.none(query, [fileDetails.displayName.en, "sv", materialid, educationalmaterialid]));
                }
            }
            else {
                queries.push(await t.none(query, [fileDetails.displayName.fi, "sv", materialid, educationalmaterialid]));
            }
        }
        else {
            queries.push(await t.none(query, [fileDetails.displayName.sv, "sv", materialid, educationalmaterialid]));
        }

        if (!fileDetails.displayName.en || fileDetails.displayName.en === "") {
            if (!fileDetails.displayName.fi || fileDetails.displayName.fi === "") {
                if (!fileDetails.displayName.sv || fileDetails.displayName.sv === "") {
                    queries.push(await t.none(query, ["", "en", materialid, educationalmaterialid]));
                }
                else {
                    queries.push(await t.none(query, [fileDetails.displayName.sv, "en", materialid, educationalmaterialid]));
                }
            }
            else {
                queries.push(await t.none(query, [fileDetails.displayName.fi, "en", materialid, educationalmaterialid]));
            }
        }
        else {
            queries.push(await t.none(query, [fileDetails.displayName.en, "en", materialid, educationalmaterialid]));
        }
    }
    return queries;
}

export async function insertDataToMaterialTable(t: any, materialID: String, location: any, language: String, priority: number) {
    let query;
    // const str = Object.keys(files).map(function(k) {return "('" + files[k].originalname + "','" + location + "','" + materialID + "')"; }).join(",");
    // const str = "('" + files.originalname + "','" + location + "','" + materialID + "')";
    query = "insert into material (link, educationalmaterialid, materiallanguagekey, priority) values ($1,$2,$3,$4) returning id;";
    console.log(query);
    const data = await t.one(query, [location, materialID, language, priority]);
    return data;
}

export async function insertDataToAttachmentTable(files: any, materialID: any, fileKey: any, fileBucket: any, location: String, metadata: any) {
    const queries = [];
    let query;
    const data = await db.tx(async (t: any) => {
        query = "update educationalmaterial set updatedat = now() where id = (select educationalmaterialid from material where id = $1);";
        queries.push(await db.none(query, [materialID]));
        query = "insert into attachment (filePath, originalfilename, filesize, mimetype, format, fileKey, fileBucket, materialid, defaultfile, kind, label, srclang) values ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12) returning id;";
        console.log(query);
        queries.push(await db.one(query, [location, files.originalname, files.size, files.mimetype, files.encoding, fileKey, fileBucket, materialID, metadata.default, metadata.kind, metadata.label, metadata.srclang]));
        return t.batch(queries);
    }
    ).catch((err: Error) => {
        throw err;
    });
    return data[1].id;
}

export async function updateAttachment(fileKey: any, fileBucket: any, location: string, attachmentId: string) {
    const queries = [];
    let query;
    await db.tx(async (t: any) => {
        query = "update attachment set filePath = $1, fileKey = $2, fileBucket = $3 where id = $4;";
        console.log(query);
        queries.push(await db.none(query, [location, fileKey, fileBucket, attachmentId]));
        return t.batch(queries);
    }
    ).catch((err: Error) => {
        throw err;
    });
}

export async function insertDataToTempAttachmentTable(files: any, metadata: any, attachmentId: string) {
    let query;
    query = "insert into temporaryattachment (filename, filepath, originalfilename, filesize, mimetype, format, defaultfile, kind, label, srclang, attachmentid) values ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11) returning id;";
    console.log(query);
    const data = await db.any(query, [files.filename, files.path, files.originalname, files.size, files.mimetype, files.encoding, metadata.default, metadata.kind, metadata.label, metadata.srclang, attachmentId]);
    return data;
}

export async function insertDataToRecordTable(files: any, materialID: any, fileKey: any, fileBucket: any, location: String) {
    let query;
    try {
    const data = await db.tx(async (t: any) => {
        query = "update educationalmaterial set updatedat = now() where id = (select educationalmaterialid from material where id = $1);";
        // queries.push(await db.none(query, [materialID]));
        await t.none(query, [materialID]);
        query = "insert into record (filePath, originalfilename, filesize, mimetype, format, fileKey, fileBucket, materialid) values ($1,$2,$3,$4,$5,$6,$7,$8) returning id;";
        console.log(query);
        const record = await t.oneOrNone(query, [location, files.originalname, files.size, files.mimetype, files.encoding, fileKey, fileBucket, materialID]);
        return {record};
    });
    return data.record.id;
    }
    catch (err) {
        throw new Error(err);
    }
}

export async function insertDataToTempRecordTable(t: any, files: any, materialId: any) {
    let query;
    query = "insert into temporaryrecord (filename, filepath, originalfilename, filesize, mimetype, format, materialid) values ($1,$2,$3,$4,$5,$6,$7) returning id;";
    console.log(query);
    const data = await t.any(query, [files.filename, files.path, files.originalname, files.size, files.mimetype, files.encoding, materialId]);
    return data;
}

export async function deleteDataFromTempRecordTable(filename: any, materialId: any) {
    let query;
    query = "delete from temporaryrecord where filename = $1 and materialid = $2;";
    console.log(query);
    const data = await db.any(query, [filename, materialId]);
    return data;
}

export async function deleteDataToTempAttachmentTable(filename: any, materialId: any) {
    let query;
    query = "delete from temporaryattachment where filename = $1 and id = $2;";
    console.log(query, [filename, materialId]);
    const data = await db.any(query, [filename, materialId]);
    return data;
}


export async function uploadFileToStorage(filePath: String, filename: String, bucketName: String) {
    return new Promise(async (resolve, reject) => {
        try {
            const util = require("util");
            const config = {
                accessKeyId: process.env.USER_KEY,
                secretAccessKey: process.env.USER_SECRET,
                endpoint: process.env.POUTA_END_POINT,
                region: process.env.REGION
                };
            AWS.config.update(config);
            const s3 = new AWS.S3();
            // const bucketName = process.env.BUCKET_NAME;
            const key = filename;
            fs.readFile(filePath, async (err: any, data: any) => {
                if (err) {
                    console.error(err);
                    return reject(new Error(err));
                }
            try {
                const params = {
                    Bucket: bucketName,
                    Key: key,
                    Body: data
                };
                const time = Date.now();
                s3.upload(params, (err: any, data: any) => {
                    if (err) {
                        console.error(`Upload Error ${err}`);
                        reject(new Error(err));
                    }

                    if (data) {
                        console.log((Date.now() - time) / 1000);
                        console.log("Upload Completed");
                        console.log(data);
                        resolve(data);
                    }
                });
            }
            catch (err) {
                console.log(err);
                reject(new Error(err));
            }

            });
        }
        catch (err) {
            console.log(err);
            reject(new Error(err));
        }
    });
}

export async function uploadBase64FileToStorage(base64data: String, filename: String, bucketName: String) {
    return new Promise(async (resolve, reject) => {
        try {
            const config = {
                accessKeyId: process.env.USER_KEY,
                secretAccessKey: process.env.USER_SECRET,
                endpoint: process.env.POUTA_END_POINT,
                region: process.env.REGION
                };
            AWS.config.update(config);
            const s3 = new AWS.S3();
            const key = filename;
            try {
                const params = {
                    Bucket: bucketName,
                    Key: key,
                    Body: base64data
                };
                const time = Date.now();
                s3.upload(params, (err: any, data: any) => {
                    if (err) {
                        console.error(`Upload Error ${err}`);
                        reject(new Error(err));
                    }

                    if (data) {
                        console.log((Date.now() - time) / 1000);
                        console.log("Upload Completed");
                        console.log(data);
                        resolve(data);
                    }
                });
            }
            catch (err) {
                console.log(err);
                reject(new Error(err));
            }
        }
        catch (err) {
            console.log(err);
            reject(new Error(err));
        }
    });
}


export async function downloadFile(req: Request, res: Response, next: NextFunction) {
    try {
        const data = await downloadFileFromStorage(req, res, next);
        console.log("The data in DownloadFile function: " + data);
        res.status(200).send(data);
    }
    catch (err) {
        console.error(err);
        if (!res.headersSent) {
            next(new ErrorHandler(400, "Failed to download file"));
        }
    }
}

export async function downloadFileFromStorage(req: Request, res: Response, next: NextFunction, isZip?: any) {
    console.log("The isZip value in downloadFileFromStorage: " + isZip);
    console.log("The req.params in downloadFileFromStorage: " + req.params);
    console.log("The req.params.key in downloadFileFromStorage: " + req.params.key);
    return new Promise(async (resolve) => {
        try {
            const query = "select originalfilename from record right join material as m on m.id = materialid where m.obsoleted = 0 and filekey = $1" +
                        "union " +
                        "select originalfilename from attachment where filekey = $1 and obsoleted = 0;";
            console.log("The query from downloadFileFromStorage: " + query, [req.params.key]);
            const response = await db.oneOrNone(query, [req.params.key]);
            console.log("The response from query in downloadFileFromStorage function: " + response);
            if (!response) {
                console.log("No material found from database");
                next(new ErrorHandler(400, "Failed to download file"));
            }
            else {
                const params = {Bucket: process.env.BUCKET_NAME,
                    Key: req.params.key
                };
                const resp = await downloadFromStorage(req, res, next, params, response.originalfilename, isZip);
                console.log("This is response: " + resp);
                resolve(resp);
            }

        }
        catch (err) {
            console.error("The error in downloadFileFromStorage function (upper try catch) : " + err);
            next(new ErrorHandler(500, "Error in download"));
        }
    });
}
/**
 *
 * @param req
 * @param res
 * @param next
 * @param params
 * @param filename
 * @param isZip
 * function to download file from Pouta
 */
export async function readStreamFromStorage(params: {Bucket: string; Key: string; }) {
    try {
        const config = {
            accessKeyId: process.env.USER_KEY,
            secretAccessKey: process.env.USER_SECRET,
            endpoint: process.env.POUTA_END_POINT,
            region: process.env.REGION
        };
        AWS.config.update(config);
        const s3 = new AWS.S3();
        console.log("Returning stream");
        return s3.getObject(params).createReadStream();
    }
    catch (error) {
        console.log("throw readStreamFromStorage error");
        throw new Error(error);
    }
}
export async function downloadFromStorage(req: Request, res: Response, next: NextFunction, params: {Bucket: string; Key: string; }, filename: string, isZip?: any) {
    return new Promise(async (resolve) => {
        try {
    const config = {
        accessKeyId: process.env.USER_KEY,
        secretAccessKey: process.env.USER_SECRET,
        endpoint: process.env.POUTA_END_POINT,
        region: process.env.REGION
        };
    AWS.config.update(config);
    const s3 = new AWS.S3();
    const key = params.Key;
    try {
        const fileStream = s3.getObject(params).createReadStream();
        if (isZip === true) {
            console.log("We came to the if-statement in downloadFileFromStorage!");
            const folderpath = process.env.HTMLFOLDER + "/" + filename;
            const zipStream = fileStream.on("error", function(e) {
                console.error(e);
                console.log("TRY BACK UP DATA HERE FOR ZIP");
                const path = process.env.BACK_UP_PATH + key;
                const backupfs = fs.createReadStream(path);
                const backupws = backupfs.on("error", function(e) {
                    console.error("Error in createReadStream " + path);
                    console.error(e);
                    next(new ErrorHandler(e.statusCode, e.message || "Error in download"));
                }).pipe(fs.createWriteStream(folderpath)).on("error", function(e) {
                    console.error("Error in createWriteStream " + folderpath);
                    console.error(e);
                    next(new ErrorHandler(e.statusCode, e.message || "Error in download"));
                });
                backupws.on("finish", async function() {
                    console.log("We finished the backupfs!");
                    resolve(await unZipAndExtract(folderpath));
                });
            }).pipe(fs.createWriteStream(folderpath));
            zipStream.on("finish", async function() {
                console.log("We finished the zipstream!");
                 resolve(await unZipAndExtract(folderpath));
            });
        }
        else {
            res.attachment(key);
            res.header("Content-Disposition", contentDisposition(filename));
            console.log("The response.originalfilename is: " + filename);
            fileStream.on("error", function(e) {
                console.error(e);
                console.log("TRY BACK UP DATA HERE");
                // const backupfs = await readStreamFromBackup(key);
                let path = process.env.BACK_UP_PATH + key;
                // if thumbnail bucket try thumbnail back up
                if (params.Bucket == process.env.THUMBNAIL_BUCKET_NAME) {
                    path = process.env.THUMBNAIL_BACK_UP_PATH + key;
                }
                const backupfs = fs.createReadStream(path);
                backupfs.on("error", function(e) {
                    console.error(e);
                    next(new ErrorHandler(e.statusCode, e.message || "Error in download"));
                }).pipe(res).on("error", function(e) {
                    console.error(e);
                    next(new ErrorHandler(e.statusCode, e.message || "Error in download"));
                });

            })
            .pipe(res).on("error", function(e) {
                console.error(e);
                next(new ErrorHandler(e.statusCode, e.message || "Error in download"));
            });
        }

    }
    catch (err) {
        console.error("The error in downloadFileFromStorage function (nested try) : " + err);
        next(new ErrorHandler(500, "Error in download"));
    }
}
catch (err) {
    console.error("The error in downloadFileFromStorage function (upper try catch) : " + err);
    next(new ErrorHandler(500, "Error in download"));
}
});
}

export async function downloadMaterialFile(req: Request, res: Response, next: NextFunction) {
    try {
        console.log("downloadMaterialFile");
        const response = await db.task(async (t: any) => {
            let publishedat = req.params.publishedat;
            if (!publishedat) {
                const q = "select max(publishedat) from versioncomposition where educationalmaterialid = $1;";
                console.log(q, req.params.materialId);
                const res = await t.oneOrNone(q, req.params.materialId);
                publishedat = res.max;
            }
            const query = "select record.filekey, record.originalfilename from versioncomposition right join material on material.id = versioncomposition.materialid right join record on record.materialid = material.id where material.educationalmaterialid = $1 and obsoleted = 0 and publishedat = $2" +
            " union " +
            "select attachment.filekey, attachment.originalfilename from attachmentversioncomposition as v inner join attachment on v.attachmentid = attachment.id where v.versioneducationalmaterialid = $1 and attachment.obsoleted = 0 and v.versionpublishedat = $2;";
            console.log(query, [req.params.materialId, publishedat]);
            return await db.any(query, [req.params.materialId, publishedat]);
        });
        if (response.length < 1) {
            console.log("No material found");
            next(new ErrorHandler(404, "No material found"));
        }
        else {
            const keys = [];
            const archiveFiles = [];
            for (const element of response) {
                keys.push(element.filekey);
                archiveFiles.push(element.originalfilename);
            }
            console.log(keys, req.params.materialId);
            // res.set("content-type", "application/zip");
            res.header("Content-Disposition", "attachment; filename=materials.zip");
            await downloadAndZipFromStorage(req, res, next, keys, archiveFiles);
            // update downloadcounter here
            const idnumber = parseInt(req.params.materialId);
            console.log("Starting update downloadcounter");
            if (!req.isAuthenticated() || !(await hasAccesstoPublication(idnumber, req))) {
                console.log("update downloadcounter");
                try {
                    updateDownloadCounter(req.params.materialId);
                }
                catch (error) {
                    console.error("update downloadcounter failed: " + error);
                }
            }
        }
    }
    catch (err) {
        console.error(err);
        next(new ErrorHandler(400, "Failed to download file"));
    }
}

export async function downloadAndZipFromStorage(req: Request, res: Response, next: NextFunction, keys: any, archiveFiles: any) {
    return new Promise(async resolve => {
        try {
            const config = {
                accessKeyId: process.env.USER_KEY,
                secretAccessKey: process.env.USER_SECRET,
                endpoint: process.env.POUTA_END_POINT,
                region: process.env.REGION
                };
            AWS.config.update(config);
            const s3 = new AWS.S3();
            const bucketName = process.env.BUCKET_NAME;
            console.log("Starting s3Zip zipstream!");
            try {
                s3Zip
                .archive({ s3: s3, bucket: bucketName }, "", keys, archiveFiles)
                .pipe(res).on("finish", async function() {
                    console.log("We finished the s3Zip zipstream!");
                    resolve();
                    }
                )
                .on("error", function(e) {
                    console.error(e);
                    next(new ErrorHandler(e.statusCode, e.message || "Error in download"));
                });
            }
            catch (err) {
                console.error(err);
                next(new ErrorHandler(500, "Failed to download file from storage"));
            }
        }
        catch (err) {
            console.error(err);
            next(new ErrorHandler(500, "Failed to download file"));
        }
    });


}
 export async function unZipAndExtract(zipFolder: any) {
    const searchRecursive = function(dir, pattern) {
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
    console.log("The folderpath that came to the unZipandExtract function: " + zipFolder);
    // const filenameParsed = zipFolder.substring(0, zipFolder.lastIndexOf("/"));
    const filenameParsedNicely = zipFolder.slice(0, -4);
    console.log("Hopefully the filename is parsed corectly: " + filenameParsedNicely);
    // console.log("The filenameParsed: " + filenameParsed);
    console.log("Does the file exist? : " + fs.existsSync(zipFolder));
    const zip = new ADMzip(zipFolder);
    // Here we remove the ext from the file, eg. python.zip --> python, so that we can name the folder correctly
    // const folderPath = process.env.HTMLFOLDER + "/" + filename;
    // Here we finally extract the zipped file to the folder we just specified.
    // const zipEntries = zip.getEntries();
    // zipEntries.forEach(function (zipEntry) {
    //     console.log(zipEntry.getData().toString("utf8"));
    // });
    zip.extractAllTo(filenameParsedNicely, true);

    const pathToReturn = zipFolder + "/index.html";
    console.log("The pathtoreturn: " + pathToReturn);
    const results = await searchRecursive(filenameParsedNicely, "index.html");
    if (Array.isArray(results) && results.length) {
        console.log("The results: " + results);
        return results[0];
    }
    const resultshtm = await searchRecursive(filenameParsedNicely, "index.htm");
    if (Array.isArray(resultshtm) && resultshtm.length) {
        console.log("The resultshtm: " + resultshtm);
        return resultshtm[0];
    }
    else {
        console.log("the unzipandextract returns false");
        return false;
    }
}
catch (err) {
    console.log("The error in unzipAndExtract function for HTML zip: " + err);
    return false;
}
}


module.exports = {
    uploadMaterial: uploadMaterial,
    uploadFileToMaterial : uploadFileToMaterial,
    uploadFileToStorage : uploadFileToStorage,
    downloadFile : downloadFile,
    unZipAndExtract: unZipAndExtract,
    downloadFileFromStorage : downloadFileFromStorage,
    downloadMaterialFile : downloadMaterialFile,
    checkTemporaryRecordQueue : checkTemporaryRecordQueue,
    uploadBase64FileToStorage : uploadBase64FileToStorage,
    uploadAttachmentToMaterial : uploadAttachmentToMaterial,
    checkTemporaryAttachmentQueue : checkTemporaryAttachmentQueue,
    insertDataToDisplayName : insertDataToDisplayName,
    downloadFromStorage : downloadFromStorage,
    readStreamFromStorage
};