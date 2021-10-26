import { ErrorHandler } from '../helpers/errorHandler';
import { Request, Response, NextFunction } from 'express';
import fh, { downloadFromStorage } from './fileHandling';
import mime from 'mime';
import connection from '../resources/pg-config.module';
import { IDatabase } from 'pg-promise';
import { winstonLogger } from '../util';

// Database connection
const db: IDatabase<any> = connection.db;

/**
 * @param req
 * @param res
 * @param next
 */
export const uploadbase64Image = async (req: Request, res: Response, next: NextFunction): Promise<any> => {
    try {
        const contentType = req.headers['content-type'];
        if (contentType.startsWith('application/json')) {
            const imgdata = req.body.base64image;
            const base64Data = imgdata.replace(/^data:([A-Za-z-+/]+);base64,/, '');
            const matches = req.body.base64image.match(/^data:([A-Za-z-+\/]+);base64,(.+)$/);
            if (matches === undefined) {
                return next(new ErrorHandler(400, 'File not a valid base64 encoded image'));
            }
            const extension = mime.getExtension(matches[1]);
            const fileName = 'thumbnail-' + Date.now() + '.' + extension;
            const buffer: Buffer = Buffer.from(base64Data, 'base64');
            const obj: any = await fh.uploadBase64FileToStorage(buffer, fileName, process.env.THUMBNAIL_BUCKET_NAME);
            if (req.params.edumaterialid) {
                await updateEmThumbnailData(obj.Location, matches[1], req.params.edumaterialid, fileName, obj.Key, obj.Bucket);
            } else {
                await updateCollectionThumbnailData(obj.Location, matches[1], req.params.collectionid, fileName, obj.Key, obj.Bucket);
            }
            return res.status(200).json({"url" : obj.Location});
        } else {
            return res.status(400).json({"error": "application/json expected"});
        }
    } catch (error) {
        next(new ErrorHandler(500, 'uploadbase64Image() - Thumbnail image upload failed: ' + error));
    }
}

/**
 * @param req
 * @param res
 * @param next
 */
export const downloadEmThumbnail = async (req: Request, res: Response, next: NextFunction): Promise<any> => {
    try {
        const key = req.params.id;
        if (!key) {
            return res.status(200).json({});
        }
        await downloadThumbnail(req, res, next, key);
    } catch (error) {
        next(new ErrorHandler(500, 'downloadEmThumbnail() - Downloading the thumbnail image failed: ' + error));
    }
}

/**
 * @param req
 * @param res
 * @param next
 */
export const downloadCollectionThumbnail = async (req: Request, res: Response, next: NextFunction): Promise<any> => {
    try {
        const key = req.params.id;
        if (!key) {
            return res.status(200).json({});
        }
        await downloadThumbnail(req, res, next, key);
    } catch (error) {
        console.error(error);
        next(new ErrorHandler(500, 'downloadCollectionThumbnail() - Downloading the thumbnail image failed: ' + error));
    }
}

/**
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
            Key: key
        };
        await downloadFromStorage(req, res, next, params, key);
    } catch (error) {
        next(new ErrorHandler(500, 'downloadThumbnail() - Error: ' + error));
    }
}

/**
 * @param filepath
 * @param mimetype
 * @param educationalmaterialid
 * @param filename
 * @param fileKey
 * @param fileBucket
 */
async function updateEmThumbnailData(filepath: string, mimetype: string, educationalmaterialid: string, filename: string, fileKey: string, fileBucket: string) {
    winstonLogger.debug('updateEmThumbnailData(): filepath=' + filepath + ', mimetype=' + mimetype +
        ', educationalmaterialid=' + educationalmaterialid + ', filename=' + filename + ', filekey=' + fileKey +
        ', fileBucket=' + fileBucket);
    try {
        let query;
        query = "UPDATE thumbnail SET obsoleted = 1 WHERE educationalmaterialid = $1 AND obsoleted = 0";
        winstonLogger.debug('updateEmThumbnailData() - Query: ' + query);
        await db.none(query, [educationalmaterialid]);
        query =
            "INSERT INTO thumbnail (filepath, mimetype, educationalmaterialid, filename, fileKey, fileBucket) " +
            "VALUES ($1, $2, $3, $4, $5, $6)";
        winstonLogger.debug('updateEmThumbnailData() - Query: ' + query + ' ' + [filepath, mimetype, educationalmaterialid, filename, fileKey, fileBucket]);
        await db.any(query, [filepath, mimetype, educationalmaterialid, filename, fileKey, fileBucket]);
    } catch (error) {
        winstonLogger.error('updateEmThumbnailData(): ' + error);
        throw new Error(error);
    }
}

/**
 * @param filepath
 * @param mimetype
 * @param collectionid
 * @param filename
 * @param fileKey
 * @param fileBucket
 */
async function updateCollectionThumbnailData(filepath: string, mimetype: string, collectionid: string, filename: string, fileKey: string, fileBucket: string) {
    try {
        let query;
        query = "UPDATE collectionthumbnail SET obsoleted = 1 WHERE collectionid = $1 AND obsoleted = 0";
        winstonLogger.debug('updateCollectionThumbnailData() - Query: ' + query);
        await db.none(query, [collectionid]);
        query =
            "INSERT INTO collectionthumbnail (filepath, mimetype, collectionid, filename, fileKey, fileBucket) " +
            "VALUES ($1, $2, $3, $4, $5, $6)";
        winstonLogger.debug('updateCollectionThumbnailData() - Query: ' + query + ' ' +
            [filepath, mimetype, collectionid, filename, fileKey, fileBucket]);
        await db.any(query, [filepath, mimetype, collectionid, filename, fileKey, fileBucket]);
    } catch (error) {
        winstonLogger.error('updateCollectionThumbnailData(): ' + error);
        throw new Error(error);
    }
}

export default {
    uploadbase64Image,
    downloadEmThumbnail,
    downloadCollectionThumbnail
};
