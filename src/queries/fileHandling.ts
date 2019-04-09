import { Request, Response, NextFunction } from "express";
const AWS = require("aws-sdk");
const globalLog = require("global-request-logger");
globalLog.initialize();

const fs = require("fs");
const path = require("path");

// File upload dependencies
const multer  = require("multer");
const upload = multer({ dest: "temp/"});

// Database connection
const connection = require("./../db");
const db = connection.db;

const publicationFolder = "publications";
const savedFileName = "file.blob";

async function uploadMaterial(req: Request, res: Response) {
    try {
        const contentType = req.headers["content-type"];

        if (contentType.startsWith("multipart/form-data")) {
            upload.array("myFiles", 12)(req , res, async function() {
                try {
                    console.log("here");
                    const files = (<any>req).files;
                    let result = await insertDataToEducationalMaterialTable(req);
                    result = await insertDataToMaterialTable(files, result[0].id);
                    console.log(result);
                    await insertDataToRecordTable(files, result);
                    console.log(files);
                    res.status(200).send("Files uploaded: " + files.length);
                } catch (e) {
                    console.log(e);
                    return res.status(500).send("Failure in file upload");
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
            upload.array("myFiles", 12)(req , res, async function() {
                try {
                    const files = (<any>req).files;
                    let result;
                    result = await insertDataToMaterialTable(files, req.params.id);
                    console.log(result);
                    await insertDataToRecordTable(files, result);
                    console.log(files);
                    res.status(200).send("Files uploaded: " + files.length);
                } catch (e) {
                    console.log(e);
                    return res.status(500).send("Failure in file upload");
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

async function insertDataToEducationalMaterialTable(req: Request) {
    const query = "insert into educationalmaterial (materialName,slug,CreatedAt,PublishedAt,UpdatedAt,Description,TechnicalName,author,organization,publisher,timeRequired,agerangeMin,agerangeMax,UsersId,LicenseCode) values ('" + req.body.materialname + "','slugi kolmas',to_date('1900-01-01', 'YYYY-MM-DD'),to_date('1900-01-01', 'YYYY-MM-DD'),to_date('1900-01-01', 'YYYY-MM-DD'),'kuvaus','tekninen nimi','tekijä','CSC',123,'300','1','12','" + req.body.usersid + "','koodi') returning id;";
    const data = await db.any(query);
    return data;
}

async function insertDataToMaterialTable(files: any, materialID: String) {
    let query;
    const str = Object.keys(files).map(function(k) {return "('" + files[k].originalname + "','" + files[k].path + "','" + materialID + "')"; }).join(",");
    query = "insert into material (materialname, link, educationalmaterialid) values " + str + " returning id;";
    console.log(query);
    const data = await db.any(query);
    return data;
}

async function insertDataToRecordTable(files: any, materialID: any) {
    let query;
    const str = Object.keys(files).map(function(k) {return "('" + files[k].path +
     "','" + files[k].originalname +
     "','" + files[k].size +
     "','" + files[k].mimetype +
     "','" + files[k].encoding +
      "','" + materialID[k].id + "')"; }).join(",");
    query = "insert into record (filePath, originalfilename, filesize, mimetype, format, materialid) values " + str + " returning id;";
    console.log(query);
    const data = await db.any(query);
}

  async function uploadFileToStorage(req: Request, res: Response) {
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
        const params2 = {
            Bucket: process.env.BUCKET_NAME,
            MaxKeys: 2
        };
        s3.listObjects(params2, function(err: any, data: any) {
            if (err) console.log(err, err.stack); // an error occurred
            else     console.log(data);           // successful response
        });
        const filePath = "./temp/0b66fed4e0fafdbd1298107681b305d4";
        const bucketName = process.env.BUCKET_NAME;
        const key = "testfile2";
        // const uploadFile = (filePath, bucketName, key) => {
        fs.readFile(filePath, (err: any, data: any) => {
            if (err) console.error(err);
            const base64data = new Buffer(data, "binary2");
            const params = {
                Bucket: bucketName,
                Key: key,
                Body: base64data
            };
            s3.upload(params, (err: any, data: any) => {
                if (err) {
                    console.error(`Upload Error ${err}`);
                    res.status(500).send("error during upload");
                }

                if (data) {
                    console.log("Upload Completed");
                    console.log(data);
                    res.status(200).send("success");
                }
            });
        });
    }
    catch (err) {
        console.log(err);
        res.status(500).send("error");
    }
  }

module.exports = {
    uploadMaterial: uploadMaterial,
    uploadFileToMaterial : uploadFileToMaterial,
    uploadFileToStorage : uploadFileToStorage
};