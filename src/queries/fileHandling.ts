import { Request, Response, NextFunction } from "express";
const AWS = require("aws-sdk");
const s3Zip = require("s3-zip");
const globalLog = require("global-request-logger");
globalLog.initialize();

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

async function uploadAttachmentToMaterial(req: Request, res: Response) {
    try {
        console.log(req.body);
        const contentType = req.headers["content-type"];
        if (contentType.startsWith("multipart/form-data")) {
        upload.single("attachment")(req , res, async function(err: any) {
            try {
                if (err) {
                    console.log(err);
                    if (err.code === "LIMIT_FILE_SIZE") return res.status(413).send(err.message);
                    else {
                        console.trace(err);
                        return res.status(500).send("Failure in file upload");
                    }
                }
                const file = (<any>req).file;
                console.log("fil: " + file);
                if (!file) {
                    return res.status(400).send("No file sent");
                }
                console.log("req.params.id: " + req.params.materialId);
                // const emresp = await insertDataToEducationalMaterialTable(req);
                const metadata = JSON.parse(req.body.attachmentDetails);
                console.log(metadata);
                const material = [];
                const materialid = [];
                let result = [];
                if (typeof file !== "undefined") {
                        result = await insertDataToTempAttachmentTable(file, req.params.materialId, metadata);
                        console.log("result: " + JSON.stringify(result[0]));
                    }
                // return 200 if success and continue sending files to pouta
                const resp: any = {};
                res.status(200).json({"status" : "ok"});
                try {
                    if (typeof file !== "undefined") {
                        const obj: any = await uploadFileToStorage(("./" + file.path), file.filename, process.env.BUCKET_NAME);
                        await insertDataToAttachmentTable(file, req.params.materialId, obj.Key, obj.Bucket, obj.Location, metadata);
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
                    console.log("error while sending files to pouta: " + JSON.stringify((<any>req).files));
                }
            } catch (e) {
                console.log(e);
                if ( ! res.headersSent) {
                    return res.status(500).send("Failure in file upload");
                }
            }
        }
        );
    }
    else {
        res.status(400).send("Not found");
    }
}
catch (err) {
    console.log(err);
    res.status(500).send("error");
}
}

async function uploadMaterial(req: Request, res: Response) {
    try {
        console.log(req.body);
        const contentType = req.headers["content-type"];
        if (contentType.startsWith("multipart/form-data")) {
            upload.single("file")(req , res, async function(err: any) {
                try {
                    if (err) {
                        console.log(err);
                        if (err.code === "LIMIT_FILE_SIZE") return res.status(413).send(err.message);
                        else {
                            console.trace(err);
                            return res.status(500).send("Failure in file upload");
                        }
                    }
                    const file = (<any>req).file;
                    const resp: any = {};
// send educationalmaterialid if no file send for link material creation.
                    if (!file) {
                        await db.tx(async (t: any) => {
                            return await insertDataToEducationalMaterialTable(req, t);
                        })
                        .then((data: any) => {
                            resp.id = data.id;
                            return res.status(200).json(resp);
                        })
                        .catch((err: Error) => {
                            console.log(err);
                            return res.status(500).json({"Error" : "Failure in file upload"});
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
                            const id = await insertDataToMaterialTable(t, emresp.id, "", fileDetails.language);
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
                                    await insertDataToRecordTable(file, materialid, obj.Key, obj.Bucket, obj.Location);
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
                            res.status(500).send("Failure in file upload");
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
                        return res.status(500).send("Failure in file upload");
                    }
                }
            }
            );
        }
        else {
            res.status(400).send("Not found");
        }
    }
    catch (err) {
        console.log(err);
        res.status(500).send("error");
    }
}

async function uploadFileToMaterial(req: Request, res: Response) {
    try {
        const contentType = req.headers["content-type"];
        if (contentType.startsWith("multipart/form-data")) {
            upload.single("file")(req , res, async function(err: any) {
                try {
                    if (err) {
                        console.log(err);
                        if (err.code === "LIMIT_FILE_SIZE") return res.status(413).send(err.message);
                        else {
                            console.trace(err);
                            return res.status(500).send("Failure in file upload");
                        }
                    }
                    const file = (<any>req).file;
                    const resp: any = {};
                    if (!file) {
                        return res.status(400).send("No file sent");
                    }
                    else {
                        let materialid: String;
                        const fileDetails = JSON.parse(req.body.fileDetails);
                        const material: any = [];
                        db.tx(async (t: any) => {
                            const queries = [];
                            const id = await insertDataToMaterialTable(t, req.params.materialId, "", fileDetails.language);
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
                            resp.id = req.params.materialId;
                            resp.material = material;
                            res.status(200).json(resp);
                            try {
                                if (typeof file !== "undefined") {
                                    console.log(materialid);
                                    const obj: any = await uploadFileToStorage(("./" + file.path), file.filename, process.env.BUCKET_NAME);
                                    await insertDataToRecordTable(file, materialid, obj.Key, obj.Bucket, obj.Location);
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
                            res.status(500).send("Failure in file upload");
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
                        return res.status(500).send("Failure in file upload");
                    }
                }
            }
            );
        }
        else {
            res.status(400).send("Not found");
        }
    }
    catch (err) {
        console.log(err);
        res.status(500).send("error");
    }
}

async function fileToStorage(file: any, materialid: String) {
    const obj: any = await uploadFileToStorage(("./" + file.path), file.filename, process.env.BUCKET_NAME);
    await insertDataToRecordTable(file, materialid, obj.Key, obj.Bucket, obj.Location);
    await deleteDataFromTempRecordTable(file.filename, materialid);
    fs.unlink("./" + file.path, (err: any) => {
        if (err) {
        console.error(err);
        }
    });
}

async function attachmentFileToStorage(file: any, metadata: any, materialid: string) {
    const obj: any = await uploadFileToStorage(("./" + file.path), file.filename, process.env.BUCKET_NAME);
    await insertDataToAttachmentTable(file, materialid, obj.Key, obj.Bucket, obj.Location, metadata);
    await deleteDataToTempAttachmentTable(file.filename, materialid);
    fs.unlink("./" + file.path, (err: any) => {
        if (err) {
        console.error(err);
        }
    });
}

async function checkTemporaryRecordQueue() {
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
                await fileToStorage(file, element.materialid);
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

async function checkTemporaryAttachmentQueue() {
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
                await attachmentFileToStorage(file, metadata, element.id);
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

async function insertDataToEducationalMaterialTable(req: Request, t: any) {
    const query = "insert into educationalmaterial (Usersusername)" +
                    " values ($1) returning id;";
    const data = await t.one(query, [req.session.passport.user.uid]);
    console.log(data.id);
    return data;
}

async function insertDataToDisplayName(t: any, educationalmaterialid: String, materialid: String, fileDetails: any) {
    const queries = [];
    const query = "INSERT INTO materialdisplayname (displayname, language, materialid) (SELECT $1,$2,$3 where $3 in (select id from material where educationalmaterialid = $4)) ON CONFLICT (language, materialid) DO UPDATE Set displayname = $1;";
    if (fileDetails.fi === null) {
        queries.push(await t.none(query, ["", "fi", materialid, educationalmaterialid]));
    }
    else {
        queries.push(await t.none(query, [fileDetails.displayName.fi, "fi", materialid, educationalmaterialid]));
    }
    if (fileDetails.sv === null) {
        queries.push(await t.none(query, ["", "sv", materialid, educationalmaterialid]));
    }
    else {
        queries.push(await t.none(query, [fileDetails.displayName.sv, "sv", materialid, educationalmaterialid]));
    }
    if (fileDetails.en === null) {
        queries.push(await t.none(query, ["", "en", materialid, educationalmaterialid]));
    }
    else {
        queries.push(await t.none(query, [fileDetails.displayName.en, "en", materialid, educationalmaterialid]));
    }
    return queries;
}

async function insertDataToMaterialTable(t: any, materialID: String, location: any, language: String) {
    let query;
    // const str = Object.keys(files).map(function(k) {return "('" + files[k].originalname + "','" + location + "','" + materialID + "')"; }).join(",");
    // const str = "('" + files.originalname + "','" + location + "','" + materialID + "')";
    query = "insert into material (link, educationalmaterialid, materiallanguagekey) values ($1,$2,$3) returning id;";
    console.log(query);
    const data = await t.one(query, [location, materialID, language]);
    return data;
}

async function insertDataToAttachmentTable(files: any, materialID: any, fileKey: any, fileBucket: any, location: String, metadata: any) {
    let query;
    query = "insert into attachment (filePath, originalfilename, filesize, mimetype, format, fileKey, fileBucket, materialid, defaultfile, kind, label, srclang) values ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12) returning id;";
    console.log(query);
    const data = await db.one(query, [location, files.originalname, files.size, files.mimetype, files.encoding, fileKey, fileBucket, materialID, metadata.default, metadata.kind, metadata.label, metadata.srclang]);
    return data;
}

async function insertDataToTempAttachmentTable(files: any, materialId: any, metadata: any) {
    let query;
    query = "insert into temporaryattachment (filename, filepath, originalfilename, filesize, mimetype, format, materialid, defaultfile, kind, label, srclang) values ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11) returning id;";
    console.log(query);
    const data = await db.any(query, [files.filename, files.path, files.originalname, files.size, files.mimetype, files.encoding, materialId, metadata.default, metadata.kind, metadata.label, metadata.srclang]);
    return data;
}

async function insertDataToRecordTable(files: any, materialID: any, fileKey: any, fileBucket: any, location: String) {
    let query;
    query = "insert into record (filePath, originalfilename, filesize, mimetype, format, fileKey, fileBucket, materialid) values ($1,$2,$3,$4,$5,$6,$7,$8) returning id;";
    console.log(query);
    const data = await db.any(query, [location, files.originalname, files.size, files.mimetype, files.encoding, fileKey, fileBucket, materialID]);
}

async function insertDataToTempRecordTable(t: any, files: any, materialId: any) {
    let query;
    query = "insert into temporaryrecord (filename, filepath, originalfilename, filesize, mimetype, format, materialid) values ($1,$2,$3,$4,$5,$6,$7) returning id;";
    console.log(query);
    const data = await t.any(query, [files.filename, files.path, files.originalname, files.size, files.mimetype, files.encoding, materialId]);
    return data;
}

async function deleteDataFromTempRecordTable(filename: any, materialId: any) {
    let query;
    query = "delete from temporaryrecord where filename = $1 and materialid = $2;";
    console.log(query);
    const data = await db.any(query, [filename, materialId]);
    return data;
}

async function deleteDataToTempAttachmentTable(filename: any, materialId: any) {
    let query;
    query = "delete from temporaryattachment where filename = $1 and id = $2;";
    console.log(query, [filename, materialId]);
    const data = await db.any(query, [filename, materialId]);
    return data;
}


async function uploadFileToStorage(filePath: String, filename: String, bucketName: String) {
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

async function uploadBase64FileToStorage(base64data: String, filename: String, bucketName: String) {
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

async function downloadFile(req: Request, res: Response) {
    try {
        const data = await downloadFileFromStorage(req, res);
        res.status(200).send(data);
    }
    catch (err) {
        res.status(400).send("Failed to download file");
    }
}

async function downloadFileFromStorage(req: Request, res: Response) {
    return new Promise(async resolve => {
        try {
            const query = "select originalfilename from record where filekey = $1;";
            console.log(query);
            const response = await db.oneOrNone(query, [req.params.key]);
            console.log(response);
            const config = {
                accessKeyId: process.env.USER_KEY,
                secretAccessKey: process.env.USER_SECRET,
                endpoint: process.env.POUTA_END_POINT,
                region: process.env.REGION
                };
            AWS.config.update(config);
            const s3 = new AWS.S3();
            const bucketName = process.env.BUCKET_NAME;
            // const filename = req.body.key;
            const key = req.params.key;
            try {
                const params = {
                    Bucket: bucketName,
                    Key: key
                };
                res.attachment(key);
                res.header("Content-Disposition", contentDisposition(response.originalfilename));
                const fileStream = s3.getObject(params).createReadStream();
                fileStream.pipe(res);
            }
            catch (err) {
                console.log(err);
                res.status(500).send(err);
            }
        }
        catch (err) {
            console.log(err);
            res.status(500).send("error");
        }
    });
}

async function downloadMaterialFile(req: Request, res: Response) {
    try {
        const query = "select record.filekey, record.originalfilename from material right join record on record.materialid = material.id where educationalmaterialid = $1;";
        console.log(query);
        const response = await db.any(query, [req.params.materialId]);
        const keys = [];
        const archiveFiles = [];
        for (const element of response) {
            keys.push(element.filekey);
            archiveFiles.push(element.originalfilename);
        }
        console.log(keys, req.params.materialId);
        const data = await downloadAndZipFromStorage(req, res, keys, archiveFiles);
        res.status(200).send(data);
    }
    catch (err) {
        res.status(400).send("Failed to download file");
    }
}

async function downloadAndZipFromStorage(req: Request, res: Response, keys: any, archiveFiles: any) {
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
            try {
                s3Zip
                .archive({ s3: s3, bucket: bucketName }, "", keys, archiveFiles)
                .pipe(res);
            }
            catch (err) {
                res.status(500).send(err);
            }
        }
        catch (err) {
            console.log(err);
            res.status(500).send("error");
        }
    });
}

module.exports = {
    uploadMaterial: uploadMaterial,
    uploadFileToMaterial : uploadFileToMaterial,
    uploadFileToStorage : uploadFileToStorage,
    downloadFile : downloadFile,
    downloadFileFromStorage : downloadFileFromStorage,
    downloadMaterialFile : downloadMaterialFile,
    checkTemporaryRecordQueue : checkTemporaryRecordQueue,
    uploadBase64FileToStorage : uploadBase64FileToStorage,
    uploadAttachmentToMaterial : uploadAttachmentToMaterial,
    checkTemporaryAttachmentQueue : checkTemporaryAttachmentQueue
};