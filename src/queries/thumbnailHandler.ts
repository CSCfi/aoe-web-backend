import { Request, Response, NextFunction } from "express";
const fs = require("fs");
const multer  = require("multer");
const fh = require("./fileHandling");
const mime = require("mime");

const storage = multer.diskStorage({ // notice you are calling the multer.diskStorage() method here, not multer()
    destination: function(req: Request, file: any, cb: any) {
        console.log(process.env.THUMBNAIL_END_POINT);
        cb(undefined, process.env.THUMBNAIL_END_POINT);
    },
    filename: function(req: Request, file: any, cb: any) {
        const ext = file.originalname.substring(file.originalname.lastIndexOf("."), file.originalname.length);
        // let str = file.originalname.substring(0, file.originalname.lastIndexOf("."));
        // str = str.replace(/[^a-zA-Z0-9]/g, "");
        cb(undefined, "thumbnail" + "-" + Date.now() + ext);
    }
});

const upload = multer({"storage": storage
                    , "limits": {"fileSize": Number(process.env.THUMBNAIL_FILE_SIZE_LIMIT)}}); // provide the return value from
// Database connection
const connection = require("./../db");
const db = connection.db;

async function uploadImage(req: Request, res: Response) {
    try {
        const contentType = req.headers["content-type"];
        if (contentType.startsWith("multipart/form-data")) {
            await upload.single("image")(req , res, await async function(err: any) {
                try {
                    if (err) {
                        if (err.code === "LIMIT_FILE_SIZE") {
                            console.log(err);
                            return res.status(413).send(err.message);
                        }
                        else {
                            console.trace(err);
                            return res.status(500).send("Failure in file upload");
                        }
                    }
                    const file = (<any>req).file;
                    console.log(file);
                    if (file == undefined) {
                        return res.status(400).send("No file sent");
                    }
                    try {
                        const obj: any = await fh.uploadFileToStorage((file.path), file.filename, process.env.THUMBNAIL_BUCKET_NAME);
                        let query;
                        query = "update thumbnail set obsoleted = 1 where educationalmaterialid = $1 and obsoleted = 0;";
                        console.log(query);
                        await db.none(query, [req.params.id]);
                        query = "INSERT INTO thumbnail (filepath, mimetype, educationalmaterialid, filename, fileKey, fileBucket) VALUES ($1,$2,$3,$4,$5,$6);";
                        console.log(query, [obj.Location, file.mimetype, req.params.id, file.filename, obj.Key, obj.Bucket]);
                        await db.any(query, [obj.Location, file.mimetype, req.params.id, file.filename, obj.Key, obj.Bucket]);
                    }
                    catch (err) {
                        console.log(err);
                        return res.status(500).send("upload failed");
                    }
                    res.status(200).json({"status" : "Image upload done"});
                    fs.unlink(file.path, (err: any) => {
                        if (err) {
                        console.error(err);
                        }
                    });
                }
                catch (err) {
                    console.log(err);
                    return res.status(500).send("upload failed");
                }
            });
        }
        else {
            res.status(500).json({"error" : "upload failed"});
        }
    }
    catch (err) {
        console.log(err);
        return res.status(500).send("error");
    }
}

async function uploadbase64Image(req: Request, res: Response) {
    try {
        const contentType = req.headers["content-type"];
        if (contentType.startsWith("application/json")) {
            const imgdata = req.body.base64image;
            const base64Data = imgdata.replace(/^data:([A-Za-z-+/]+);base64,/, "");
            const matches = req.body.base64image.match(/^data:([A-Za-z-+\/]+);base64,(.+)$/);
            if (matches == undefined) {
                return res.status(400).json({"expecting" : "data:image/png;base64,..."});
            }
            const extension = mime.getExtension(matches[1]);
            const fileName = "thumbnail" + Date.now() + "." + extension;
            const buff = Buffer.from(base64Data, "base64");
            const obj: any = await fh.uploadBase64FileToStorage(buff, fileName, process.env.THUMBNAIL_BUCKET_NAME);
            let query;
            query = "update thumbnail set obsoleted = 1 where educationalmaterialid = $1 and obsoleted = 0;";
            console.log(query);
            await db.none(query, [req.params.id]);
            query = "INSERT INTO thumbnail (filepath, mimetype, educationalmaterialid, filename, fileKey, fileBucket) VALUES ($1,$2,$3,$4,$5,$6);";
            console.log(query, [obj.Location, matches[1], req.params.id, fileName, obj.Key, obj.Bucket]);
            await db.any(query, [obj.Location, matches[1], req.params.id, fileName, obj.Key, obj.Bucket]);
            return res.status(200).json({"url" : obj.Location});
        }
        else {
            return res.status(400).json({"error": "application/json expected"});
        }

    }
    catch (e) {
        console.log(e);
        return res.status(500).json({"error": "upload failed"});
    }
}

module.exports = {
    uploadImage : uploadImage,
    uploadbase64Image : uploadbase64Image
};