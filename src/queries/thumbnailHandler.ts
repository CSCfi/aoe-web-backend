import { ErrorHandler } from '../helpers/errorHandler';
import { Request, Response, NextFunction } from 'express';
import fh, { downloadFromStorage, uploadFileToStorage } from './fileHandling';
import multer, { DiskStorageOptions, Multer, StorageEngine } from 'multer';
import connection from '../resources/pg-config.module';
import { IDatabase } from 'pg-promise';
import { winstonLogger } from '../util';

const fs = require("fs");
const mime = require("mime");

// Database connection
const db: IDatabase<any> = connection.db;

const diskStorageOptions: DiskStorageOptions = {
    destination: (req: Request, file: any, cb: any) => {
        cb(undefined, process.env.THUMBNAIL_END_POINT);
    },
    filename: (req: Request, file: any, cb: any) => {
        const ext: string = file.originalname.substring(file.originalname.lastIndexOf('.'), file.originalname.length);
        cb(undefined, 'thumbnail-' + Date.now() + ext);
    }
};
const engine: StorageEngine = multer.diskStorage(diskStorageOptions);
const upload: Multer = multer({'storage': engine, 'limits': {'fileSize': Number(process.env.THUMBNAIL_FILE_SIZE_LIMIT)}});

export const uploadThumbnailImage = async (req: Request, res: Response): Promise<any> => {
    try {
        const contentType = req.headers['content-type'];
        if (contentType.startsWith('multipart/form-data')) {
            await upload.single('image')(req, res, async (err: any) => {
                try {
                    if (err) {
                        if (err.code === 'LIMIT_FILE_SIZE') {
                            winstonLogger.error('Thumbnail upload failed for large file size in uploadThumbnailImage(): ' + err);
                            return res.status(413).send(err.message); // 413 Payload Too Large
                        } else {
                            winstonLogger.error('Thumbnail upload failed in uploadThumbnailImage(): ' + err);
                            return res.status(500).send('Thumbnail upload failed');
                        }
                    }
                    const file = (<any>req).file;
                    if (file === undefined) {
                        winstonLogger.error('Thumbnail upload failed for missing file in uploadThumbnailImage()');
                        return res.status(400).send('Thumbnail upload failed for missing file');
                    }
                    try {
                        const obj: any = await uploadFileToStorage((file.path), file.filename, process.env.THUMBNAIL_BUCKET_NAME);
                        let query;
                        query = "UPDATE thumbnail SET obsoleted = 1 WHERE educationalmaterialid = $1 AND obsoleted = 0";
                        console.log(query);
                        await db.none(query, [req.params.edumaterialid]);
                        query = "INSERT INTO thumbnail " +
                            "(filepath, mimetype, educationalmaterialid, filename, fileKey, fileBucket) " +
                            "VALUES ($1, $2, $3, $4, $5, $6)";
                        console.log(query, [obj.Location, file.mimetype, req.params.edumaterialid, file.filename, obj.Key, obj.Bucket]);
                        await db.any(query, [obj.Location, file.mimetype, req.params.edumaterialid, file.filename, obj.Key, obj.Bucket]);
                    } catch (err) {
                        console.log(err);
                        return res.status(500).send("upload failed");
                    }
                    res.status(200).json({"status" : "Image upload done"});
                    fs.unlink(file.path, (err: any) => {
                        if (err) {
                            console.error(err);
                        }
                    });
                } catch (err) {
                    console.log(err);
                    return res.status(500).send("upload failed");
                }
            });
        } else {
            res.status(500).json({"error" : "upload failed"});
        }
    } catch (err) {
        console.log(err);
        return res.status(500).send("error");
    }
}

export async function uploadCollectionBase64Image(req: Request, res: Response, next: NextFunction) {
    try {
        const obj: any = uploadbase64Image(req, res, false);
        return res.status(200).json({"url" : obj.Location});
    }
    catch (error) {
        console.error(error);
        next(new ErrorHandler(500, "Issue uploading thumbnail"));
    }
}

export async function uploadEmBase64Image(req: Request, res: Response, next: NextFunction): Promise<any> {
    try {
        const obj: any = uploadbase64Image(req, res, true);
        return res.status(200).json({"url" : obj.Location});
    }
    catch (error) {
        console.error(error);
        next(new ErrorHandler(500, "Issue uploading thumbnail"));
    }
}

export async function uploadbase64Image(req: Request, res: Response, isEm: boolean) {
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
            const obj: any = await fh.uploadBase64FileToStorage(buff.toString(), fileName, process.env.THUMBNAIL_BUCKET_NAME);
            // let query;
            // query = "update thumbnail set obsoleted = 1 where educationalmaterialid = $1 and obsoleted = 0;";
            // console.log(query);
            // await db.none(query, [req.params.id]);
            // query = "INSERT INTO thumbnail (filepath, mimetype, educationalmaterialid, filename, fileKey, fileBucket) VALUES ($1,$2,$3,$4,$5,$6);";
            // console.log(query, [obj.Location, matches[1], req.params.id, fileName, obj.Key, obj.Bucket]);
            // await db.any(query, [obj.Location, matches[1], req.params.id, fileName, obj.Key, obj.Bucket]);
            if (isEm) {
                await updateEmThumbnailData(obj.Location, matches[1], req.params.edumaterialid, fileName, obj.Key, obj.Bucket);
            } else {
                await updateCollectionThumbnailData(obj.Location, matches[1], req.params.edumaterialid, fileName, obj.Key, obj.Bucket);
            }
            return obj;
        } else {
            return res.status(400).json({"error": "application/json expected"});
        }
    } catch (error) {
        console.log(error);
        throw new Error(error);
    }
}

export async function downloadEmThumbnail(req: Request, res: Response, next: NextFunction) {
    try {
        // const id = req.params.id;
        // const key = await getThumbnailKey(id);
        const key = req.params.id;
        if (!key) {
            return res.status(200).json({});
        }
        await downloadThumbnail(req, res, next, key);
    }
    catch (error) {
        console.error(error);
        next(new ErrorHandler(500, "Issue downloading thumbnail"));
    }
}

export async function downloadCollectionThumbnail(req: Request, res: Response, next: NextFunction) {
    try {
        // const id = req.params.id;
        // const key = await getColectionThumbnailKey(id);
        const key = req.params.id;
        if (!key) {
            return res.status(200).json({});
        }
        downloadThumbnail(req, res, next, key);
    }
    catch (error) {
        console.error(error);
        next(new ErrorHandler(500, "Issue downloading thumbnail"));
    }
}
/**
 * Download thumbnail from Pouta
 *
 * @param req
 * @param res
 * @param next
 * @param key
 */
async function downloadThumbnail(req: Request, res: Response, next: NextFunction, key: string) {
    try {
        if (!key) {
            return res.status(200).json({});
        }
        const params = {
            Bucket: process.env.THUMBNAIL_BUCKET_NAME,
            Key: key};
        await downloadFromStorage(req, res, next, params, key);
      }
      catch (error) {
        console.error(error);
        next(new ErrorHandler(500, "Issue downloading thumbnail"));
      }
}

/**
 *
 * @param id
 * get thumbnail pouta key based on educationalmaterial id
 */
async function getThumbnailKey(id: string) {
    try {
        const query = "select filekey from thumbnail where educationalmaterialid = $1 and obsoleted = 0 limit 1;";
        return await db.oneOrNone(query, [id]);
    }
    catch (error) {
        console.log(error);
        throw new Error(error);
    }
}

async function getColectionThumbnailKey(id: string) {
    try {
        const query = "select filekey from collectionthumbnail where collectionid = $1 and obsoleted = 0 limit 1;";
        return await db.oneOrNone(query, [id]);
    }
    catch (error) {
        console.log(error);
        throw new Error(error);
    }
}

async function updateEmThumbnailData(filepath: string, mimetype: string, educationalmaterialid: string, filename: string, fileKey: string, fileBucket: string) {
    winstonLogger.debug('updateEmThumbnailData(): filepath=' + filepath + ', mimetype=' + mimetype +
        ', educationalmaterialid=' + educationalmaterialid + ', filename=' + filename + ', filekey=' + fileKey +
        ', fileBucket=' + fileBucket);
    try {
        let query;
        query = "UPDATE thumbnail SET obsoleted = 1 WHERE educationalmaterialid = $1 AND obsoleted = 0";
        winstonLogger.debug(query);
        await db.none(query, [educationalmaterialid]);
        query = "INSERT INTO thumbnail (filepath, mimetype, educationalmaterialid, filename, fileKey, fileBucket) " +
            "VALUES ($1, $2, $3, $4, $5, $6)";
        winstonLogger.debug(query, [filepath, mimetype, educationalmaterialid, filename, fileKey, fileBucket]);
        await db.any(query, [filepath, mimetype, educationalmaterialid, filename, fileKey, fileBucket]);
    }
    catch (error) {
        winstonLogger.error('updateEmThumbnailData(): ' + error);
        throw new Error(error);
    }
}

async function updateCollectionThumbnailData(filepath: string, mimetype: string, collectionid: string, filename: string, fileKey: string, fileBucket: string) {
    try {
        let query;
        query = "update collectionthumbnail set obsoleted = 1 where collectionid = $1 and obsoleted = 0;";
        console.log(query);
        await db.none(query, [collectionid]);
        query = "INSERT INTO collectionthumbnail (filepath, mimetype, collectionid, filename, fileKey, fileBucket) VALUES ($1,$2,$3,$4,$5,$6);";
        console.log(query, [filepath, mimetype, collectionid, filename, fileKey, fileBucket]);
        await db.any(query, [filepath, mimetype, collectionid, filename, fileKey, fileBucket]);
    }
    catch (error) {
        console.log(error);
        throw new Error(error);
    }
}

export default {
    uploadImage: uploadThumbnailImage,
    uploadbase64Image,
    uploadEmBase64Image,
    uploadCollectionBase64Image,
    downloadEmThumbnail,
    downloadCollectionThumbnail
};
