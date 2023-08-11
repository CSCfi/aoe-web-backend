import ADMzip from 'adm-zip';
import AWS, { S3 } from 'aws-sdk';
import { ManagedUpload } from 'aws-sdk/lib/s3/managed_upload';
import { ServiceConfigurationOptions } from 'aws-sdk/lib/service';
import { NextFunction, Request, Response } from 'express';
import fs, { WriteStream } from 'fs';
import multer, { DestinationCallback, FileNameCallback } from 'multer';
import { Buffer } from 'node:buffer';
import path from 'path';
import s3Zip from 's3-zip';
import stream from 'stream';
import config from '../configuration';
import { ErrorHandler } from '../helpers/errorHandler';
import { downstreamAndConvertOfficeFileToPDF, isOfficeMimeType, updatePdfKey } from '../helpers/officeToPdfConverter';
import { db } from '../resources/pg-connect';
import { hasAccesstoPublication } from '../services/authService';
import { requestRedirected } from '../services/streamingService';
import { winstonLogger } from '../util/winstonLogger';
import { updateDownloadCounter } from './analyticsQueries';
import { insertEducationalMaterialName } from './apiQueries';

// Interface Express.Multer.File declared globally in multer type definitions.
import File = Express.Multer.File;
import SendData = ManagedUpload.SendData;

// TODO: Ongoing iterative refactoring for all the file handling module functions.

/**
 * AWS S3 cloud storage configuration.
 * @type {{endpoint: string, credentials: {accessKeyId: string, secretAccessKey: string}, region: string}}
 */
const configS3: ServiceConfigurationOptions = {
  credentials: {
    accessKeyId: config.CLOUD_STORAGE_CONFIG.accessKey,
    secretAccessKey: config.CLOUD_STORAGE_CONFIG.accessSecret,
  },
  endpoint: config.CLOUD_STORAGE_CONFIG.apiURL,
  region: config.CLOUD_STORAGE_CONFIG.region,
};
AWS.config.update(configS3);
const s3: S3 = new AWS.S3();

/**
 * Multer disk storage configuration.
 * @type {multer.Multer}
 */
const diskStore = multer({
  storage: multer.diskStorage({
    destination: (req: Request, file: File, callback: DestinationCallback) => {
      callback(undefined, 'uploads/');
    },
    filename: (req: Request, file: File, callback: FileNameCallback) => {
      let extension = file.originalname.substring(file.originalname.lastIndexOf('.'), file.originalname.length);
      let filename = file.originalname.substring(0, file.originalname.lastIndexOf('.'));

      // Regex: match a single character that is not alphanumeric [^a-zA-Z0-9] - all occurences /g.
      filename = filename.replace(/[^a-zA-Z0-9]/g, '');
      callback(undefined, `${filename}-${Date.now()}${extension}`);
    },
  }),
  limits: { fileSize: Number(process.env.FILE_SIZE_LIMIT) },
  preservePath: true,
});

/**
 * Check if files in temporaryattachment table and try to load to allas storage.
 */
export const checkTemporaryAttachmentQueue = async (): Promise<any> => {
  try {
    const ts = Date.now() - 1000 * 60 * 60;
    const query = 'Select * From temporaryattachment where extract(epoch from createdat)*1000 < $1 limit 1000;';
    const data = await db.any(query, [ts]);
    for (const element of data) {
      const metadata = {
        default: element.defaultfile,
        kind: element.kind,
        label: element.label,
        srclang: element.srclang,
      };
      const file = {
        originalname: element.originalfilename,
        path: element.filepath,
        size: element.filesize,
        mimetype: element.mimetype,
        encoding: element.format,
        filename: element.filename,
      };
      await attachmentFileToStorage(file, metadata, element.id, element.attachmentid);
    }
  } catch (error) {
    winstonLogger.error('Error in checkTemporaryAttachmentQueue(): %o', error);
  }
};

/**
 * check if files in temporaryrecord table and try to load to allas storage.
 */
export const checkTemporaryRecordQueue = async (): Promise<any> => {
  try {
    // take hour of
    const ts = Date.now() - 1000 * 60 * 60;
    const query = 'Select * From temporaryrecord where extract(epoch from createdat)*1000 < $1 limit 1000;';
    const data = await db.any(query, [ts]);
    for (const element of data) {
      const file = {
        originalname: element.originalfilename,
        path: element.filepath,
        size: element.filesize,
        mimetype: element.mimetype,
        encoding: element.format,
        filename: element.filename,
      };
      const obj = await fileToStorage(file, element.materialid);
      const path = await downstreamAndConvertOfficeFileToPDF(obj.key);
      const pdfkey = obj.key.substring(0, obj.key.lastIndexOf('.')) + '.pdf';
      const pdfobj: any = await uploadLocalFileToCloudStorage(path, pdfkey, process.env.PDF_BUCKET_NAME);
      await updatePdfKey(pdfobj.Key, obj.recordid);
    }
  } catch (error) {
    winstonLogger.error('Error in checkTemporaryRecordQueue(): %o', error);
  }
};

/**
 * Load file to allas storage.
 * @param {{filename: string, path: string}} file
 * @param {string} materialid
 * @return {Promise<{key: string, recordid: string}>}
 */
export const fileToStorage = async (
  file: { filename: string; path: string },
  materialid: string,
): Promise<{ key: string; recordid: string }> => {
  const obj: any = await uploadLocalFileToCloudStorage(
    './' + file.path,
    file.filename,
    process.env.CLOUD_STORAGE_BUCKET,
  );
  const recordid = await insertDataToRecordTable(file, materialid, obj.Key, obj.Bucket, obj.Location);
  await deleteDataFromTempRecordTable(file.filename, materialid);
  fs.unlink('./' + file.path, (err: any) => {
    if (err) {
      winstonLogger.error('Error in fileToStorage(): %o', err);
    }
  });
  return { key: obj.Key, recordid: recordid };
};

/**
 * Load attachment to allas storage.
 * @param {{filename: string, path: string}} file
 * @param metadata
 * @param {string} materialid
 * @param {string} attachmentId
 * @return {Promise<any>}
 */
export const attachmentFileToStorage = async (
  file: { filename: string; path: string },
  metadata: unknown,
  materialid: string,
  attachmentId: string,
): Promise<any> => {
  const obj: any = await uploadLocalFileToCloudStorage(
    './' + file.path,
    file.filename,
    process.env.CLOUD_STORAGE_BUCKET,
  );
  // await insertDataToAttachmentTable(file, materialid, obj.Key, obj.Bucket, obj.Location, metadata);
  await updateAttachment(obj.Key, obj.Bucket, obj.Location, attachmentId);
  await deleteDataToTempAttachmentTable(file.filename, materialid);
  fs.unlink('./' + file.path, (err: any) => {
    if (err) {
      winstonLogger.error('Error in attachmentFileToStorage(): %o', err);
    }
  });
};

export const insertDataToEducationalMaterialTable = async (req: Request, t: any): Promise<any> => {
  const query = 'INSERT INTO educationalmaterial (Usersusername) VALUES ($1) RETURNING id';
  return await t.one(query, [req.session.passport.user.uid]);
};

export const insertDataToMaterialTable = async (
  t: any,
  eduMaterialId: string,
  location: any,
  languages,
  priority: number,
): Promise<any> => {
  const query = `
    INSERT INTO material (link, educationalmaterialid, materiallanguagekey, priority)
    VALUES ($1, $2, $3, $4)
    RETURNING id
  `;
  return await t.one(query, [location, eduMaterialId, languages, priority]);
};

export const insertDataToAttachmentTable = async (
  files: any,
  materialID: any,
  fileKey: any,
  fileBucket: any,
  location: string,
  metadata: any,
): Promise<string> => {
  const queries = [];
  let query;
  const data = await db
    .tx(async (t: any) => {
      query = `
        UPDATE educationalmaterial SET updatedat = NOW()
        WHERE id = (SELECT educationalmaterialid FROM material WHERE id = $1)
      `;
      queries.push(await db.none(query, [materialID]));
      query = `
        INSERT INTO attachment (filePath, originalfilename, filesize, mimetype, format, fileKey, fileBucket,
          materialid, defaultfile, kind, label, srclang)
        VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12)
        RETURNING id
      `;
      queries.push(
        await db.one(query, [
          location,
          files.originalname,
          files.size,
          files.mimetype,
          files.encoding,
          fileKey,
          fileBucket,
          materialID,
          metadata.default,
          metadata.kind,
          metadata.label,
          metadata.srclang,
        ]),
      );
      return t.batch(queries);
    })
    .catch((err: Error) => {
      throw err;
    });
  return data[1].id;
};

export const updateAttachment = async (
  fileKey: any,
  fileBucket: any,
  location: string,
  attachmentId: string,
): Promise<any> => {
  const queries = [];
  let query;
  await db
    .tx(async (t: any) => {
      query = 'UPDATE attachment SET filePath = $1, fileKey = $2, fileBucket = $3 WHERE id = $4';
      queries.push(await db.none(query, [location, fileKey, fileBucket, attachmentId]));
      return t.batch(queries);
    })
    .catch((err: Error) => {
      throw err;
    });
};

export const insertDataToTempAttachmentTable = async (
  files: any,
  metadata: any,
  attachmentId: string,
): Promise<any> => {
  const query = `
    INSERT INTO temporaryattachment (filename, filepath, originalfilename, filesize, mimetype, format, defaultfile,
      kind, label, srclang, attachmentid)
    VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)
    RETURNING id
  `;
  return await db.any(query, [
    files.filename,
    files.path,
    files.originalname,
    files.size,
    files.mimetype,
    files.encoding,
    metadata.default,
    metadata.kind,
    metadata.label,
    metadata.srclang,
    attachmentId,
  ]);
};

export const insertDataToRecordTable = async (
  files: any,
  materialID: any,
  fileKey: any,
  fileBucket: any,
  location: string,
): Promise<any> => {
  let query;
  try {
    const data = await db.tx(async (t: any) => {
      query = `
        UPDATE educationalmaterial
        SET updatedat = NOW()
        WHERE id = (
          SELECT educationalmaterialid
          FROM material
          WHERE id = $1
        )
      `;
      await t.none(query, [materialID]);
      query = `
        INSERT INTO record (filePath, originalfilename, filesize, mimetype, format, fileKey, fileBucket, materialid)
        VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
        RETURNING id
      `;
      const record = await t.oneOrNone(query, [
        location,
        files.originalname,
        files.size,
        files.mimetype,
        files.encoding,
        fileKey,
        fileBucket,
        materialID,
      ]);
      return { record };
    });
    return data.record.id;
  } catch (err) {
    throw new Error(err);
  }
};

export const insertDataToTempRecordTable = async (t: any, files: any, materialId: any): Promise<any> => {
  const query = `
    INSERT INTO temporaryrecord (filename, filepath, originalfilename, filesize, mimetype, format, materialid)
    VALUES ($1, $2, $3, $4, $5, $6, $7)
    RETURNING id
  `;
  return await t.any(query, [
    files.filename,
    files.path,
    files.originalname,
    files.size,
    files.mimetype,
    files.encoding,
    materialId,
  ]);
};

export const deleteDataFromTempRecordTable = async (filename: any, materialId: any): Promise<any> => {
  const query = 'DELETE FROM temporaryrecord WHERE filename = $1 AND materialid = $2';
  return await db.any(query, [filename, materialId]);
};

export const deleteDataToTempAttachmentTable = async (filename: any, materialId: any): Promise<any> => {
  const query = 'DELETE FROM temporaryattachment WHERE filename = $1 AND id = $2';
  return await db.any(query, [filename, materialId]);
};

/**
 * Stream and combine files from the object storage to a compressed zip file.
 * @param req   Request<any>
 * @param res   Response<any>
 * @param next  NextFunction
 * @param keys  string[] Array of object storage keys
 * @param files string[] Array of file names
 */
export const downloadAndZipFromStorage = async (
  req: Request,
  res: Response,
  next: NextFunction,
  keys: string[],
  files: string[],
): Promise<void> => {
  return new Promise(async (resolve) => {
    try {
      const bucketName = process.env.CLOUD_STORAGE_BUCKET;
      try {
        s3Zip
          .archive({ s3: s3, bucket: bucketName }, '', keys, files)
          .pipe(res)
          .on('finish', async () => {
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
};

/**
 * @param {e.Request} req
 * @param {e.Response} res
 * @param {e.NextFunction} next
 * @return {Promise<any>}
 */
export const downloadFile = async (req: Request, res: Response, next: NextFunction): Promise<any> => {
  try {
    const filename: string = req.params.filename;
    const materialidQuery = 'SELECT materialid FROM record WHERE filekey = $1';
    const materialid = (await db.any(materialidQuery, [filename]))[0];

    if (!materialid) return res.status(404).end();

    const educationalmaterialidQuery = 'SELECT educationalmaterialid FROM versioncomposition WHERE materialid = $1';
    const originalMaterialIdArr: { educationalmaterialid: string }[] = await db.any(educationalmaterialidQuery, [
      materialid.materialid,
    ]);
    let educationalmaterialId: number;
    if (originalMaterialIdArr) {
      educationalmaterialId = parseInt(originalMaterialIdArr[0].educationalmaterialid, 10);

      // Pass educational material ID to the next phase in request chain.
      res.locals.id = educationalmaterialId;
    } else {
      educationalmaterialId = parseInt(materialid.materialid, 10);
    }
    await downloadFileFromStorage(req, res, next);

    // Increase download counter unless the user is the owner of the material.
    if (!req.isAuthenticated() || !(await hasAccesstoPublication(educationalmaterialId, req))) {
      try {
        await updateDownloadCounter(educationalmaterialId.toString());
      } catch (error) {
        winstonLogger.error('Updating download counter failed: ' + error);
      }
    }
    next();
  } catch (err) {
    if (!res.headersSent) {
      next(new ErrorHandler(400, err));
    }
  }
};

/**
 * Get file details from the database before proceeding to the file download from the cloud object storage.
 * In case of video streaming request can be redirected to the streaming service when all criteria are fulfilled.
 * @param {e.Request} req
 * @param {e.Response} res
 * @param {e.NextFunction} next
 * @param {boolean} isZip - Boolean Indicator for the need of decompression.
 * @return {Promise<any>}
 */
export const downloadFileFromStorage = async (
  req: Request,
  res: Response,
  next: NextFunction,
  isZip?: boolean,
): Promise<any> => {
  const fileName: string = (req.params.filename as string) || (req.params.key as string);
  return new Promise(async (resolve) => {
    try {
      const query = `
        SELECT originalfilename, filesize, mimetype
        FROM record
        RIGHT JOIN material AS m ON m.id = materialid
        WHERE m.obsoleted = 0 AND filekey = $1
        UNION
        SELECT originalfilename, filesize, mimetype
        FROM attachment
        WHERE filekey = $1 AND obsoleted = 0
      `;
      const fileDetails: { originalfilename: string; filesize: number; mimetype: string } = await db.oneOrNone(query, [
        fileName,
      ]);
      // { originalfilename: 'oceanwaves1280x720.mp4', filesize: 2000000, mimetype: 'video/mp4' };

      if (!fileDetails) {
        next(new ErrorHandler(404, 'Requested file ' + fileName + ' not found.'));
      } else {
        // Check if Range HTTP header is present and the criteria for streaming service redirect are fulfilled.
        if (req.headers['range'] && (await requestRedirected(fileDetails, fileName))) {
          res.setHeader('Location', config.STREAM_REDIRECT_CRITERIA.redirectUri + fileName);
          res.status(302);
          return resolve(null);
        }
        const params = {
          Bucket: process.env.CLOUD_STORAGE_BUCKET as string,
          Key: (req.params.filename as string) || (req.params.key as string),
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
 * Download an original or compressed (zip) file from the cloud object storage.
 * In case of a download error try to download from the local backup directory.
 * @param {e.Request} req
 * @param {e.Response} res
 * @param {e.NextFunction} next
 * @param {{Bucket: string, Key: string}} s3params
 * @param {string} origFilename - String Original file name without storage ID.
 * @param {boolean} isZip - Boolean Indicator for the need of decompression.
 * @return {Promise<any>}
 */
export const downloadFromStorage = async (
  req: Request,
  res: Response,
  next: NextFunction,
  s3params: { Bucket: string; Key: string },
  origFilename: string,
  isZip?: boolean,
): Promise<any> => {
  const key = s3params.Key;

  return new Promise(async (resolve, reject) => {
    try {
      const fileStream = s3.getObject(s3params).createReadStream();
      if (isZip) {
        // replaced: isZip === true
        const folderpath: string = process.env.HTMLFOLDER + '/' + origFilename;
        const zipStream: WriteStream = fileStream
          .on('error', (error: Error) => {
            winstonLogger.error('Error in zip file download in downloadFromStorage(): ' + error);
            reject();
          })
          .once('end', () => {
            winstonLogger.debug('Download of %s completed in downloadFromStorage()', key);
          })
          .pipe(fs.createWriteStream(folderpath));
        zipStream.once('finish', async () => {
          resolve(await unZipAndExtract(folderpath));
        });
      } else {
        res.attachment(origFilename || key);
        // res.header('Content-Disposition', contentDisposition(origFilename));
        fileStream
          .on('error', (error: Error) => {
            winstonLogger.error('downloadFromStorage() - Error in single file download stream: ' + error);
            reject();
          })
          .once('end', () => {
            winstonLogger.debug('Download of %s completed in downloadFromStorage()', key);
            resolve(null);
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
 * @param req  Request<any>
 * @param res  Response<any>
 * @param next NextFunction
 */
export const downloadMaterialFile = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
  const queryLatestPublished = `
    SELECT MAX(publishedat) AS max
    FROM versioncomposition
    WHERE educationalmaterialid = $1
  `;
  const queryVersionFilesIds = `
    SELECT record.filekey, record.originalfilename
    FROM versioncomposition
    RIGHT JOIN material ON material.id = versioncomposition.materialid
    RIGHT JOIN record ON record.materialid = material.id
    WHERE material.educationalmaterialid = $1 AND obsoleted = 0 AND publishedat = $2
    UNION
    SELECT attachment.filekey, attachment.originalfilename
    FROM attachmentversioncomposition AS v
    INNER JOIN attachment ON v.attachmentid = attachment.id
    WHERE v.versioneducationalmaterialid = $1 AND attachment.obsoleted = 0 AND v.versionpublishedat = $2
  `;
  try {
    const versionFiles: { filekey: string; originalfilename: string }[] = await db.task(async (t: any) => {
      let publishedAt = req.params.publishedat;
      if (!publishedAt) {
        const latestPublished: { max: string } = await t.oneOrNone(queryLatestPublished, req.params.edumaterialid);
        publishedAt = latestPublished.max;
      }
      return await db.any(queryVersionFilesIds, [req.params.edumaterialid, publishedAt]);
    });
    if (versionFiles.length < 1) {
      next(
        new ErrorHandler(
          404,
          'No material found for educationalmaterialid=' +
            req.params.edumaterialid +
            ', publishedat?=' +
            req.params.publishedat,
        ),
      );
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
        } catch (err) {
          winstonLogger.error('Updating download counter failed: %o', err);
        }
      }
    }
  } catch (err) {
    next(
      new ErrorHandler(
        400,
        'File download failed for educationalmaterialid=' +
          req.params.edumaterialid +
          ', publishedat?=' +
          req.params.publishedat,
      ),
    );
  }
};

/**
 * @param {e.Request} req
 * @param {e.Response} res
 * @param {e.NextFunction} next
 * @return {Promise<any>}
 */
export const downloadPreviewFile = async (req: Request, res: Response, next: NextFunction): Promise<any> => {
  try {
    const data = await downloadFileFromStorage(req, res, next);
    if (!data) return res.end();
    return res.status(200).end();
  } catch (err) {
    if (!res.headersSent) {
      next(new ErrorHandler(400, 'Failed to download file'));
    }
  }
};

let uploads = {};
/**
 * API function for file upstream status checks to receive the progress point of the file upload phase.
 * @param {e.Request} req
 * @param {e.Response} res
 * @return {Promise<void>}
 */
export const fileUpstreamStatus = async (req: Request, res: Response): Promise<void> => {
  const fileId = req.headers['x-file-id'] as string;
  const fileName = req.headers['x-file-name'] as string;
  const filePath = `${config.MATERIAL_FILE_UPLOAD.localFolder}/${fileName}`;
  const fileSize = parseInt(req.headers['x-file-size'] as string, 10);

  if (fileName) {
    try {
      const stats = fs.statSync(filePath);

      // Check if the requested file exists.
      if (stats.isFile()) {
        if (fileSize == stats.size) {
          res.send({ uploaded: 'all' });
          return;
        }
        if (!uploads[fileId]) uploads[fileId] = {};
        uploads[fileId]['bytesReceived'] = stats.size;
      }
    } catch (error) {
      winstonLogger.error('File reading failed in fileUpstreamStatus() with %s', filePath);
    }
  }
  let upload = uploads[fileId];
  if (upload) {
    res.send({ uploaded: upload.bytesReceived });
  } else {
    res.send({ uploaded: 0 });
  }
};

/**
 * API function for file upstreaming to the cloud storage through the host server.
 * Interrupted upstream resuming supported based on {@link fileUpstreamStatus}.
 * @param {e.Request} req
 * @param {e.Response} res
 * @return {Promise<void>}
 */
export const fileUpstreamProcess = async (req: Request, res: Response): Promise<void> => {
  res.send({ message: 'success' });
  return;
};

export const insertDataToDisplayName = async (
  t: any,
  educationalmaterialid,
  materialid: string,
  fileDetails: any,
): Promise<any> => {
  const queries = [];
  const query = `
    INSERT INTO materialdisplayname (displayname, language, materialid) (
      SELECT $1, $2, $3
      WHERE $3 IN (
        SELECT id
        FROM material
        WHERE educationalmaterialid = $4)
    ) ON CONFLICT (language, materialid) DO UPDATE SET displayname = $1
  `;
  if (fileDetails.displayName && materialid) {
    if (!fileDetails.displayName.fi || fileDetails.displayName.fi === '') {
      if (!fileDetails.displayName.sv || fileDetails.displayName.sv === '') {
        if (!fileDetails.displayName.en || fileDetails.displayName.en === '') {
          queries.push(await t.none(query, ['', 'fi', materialid, educationalmaterialid]));
        } else {
          queries.push(await t.none(query, [fileDetails.displayName.en, 'fi', materialid, educationalmaterialid]));
        }
      } else {
        queries.push(await t.none(query, [fileDetails.displayName.sv, 'fi', materialid, educationalmaterialid]));
      }
    } else {
      queries.push(await t.none(query, [fileDetails.displayName.fi, 'fi', materialid, educationalmaterialid]));
    }

    if (!fileDetails.displayName.sv || fileDetails.displayName.sv === '') {
      if (!fileDetails.displayName.fi || fileDetails.displayName.fi === '') {
        if (!fileDetails.displayName.en || fileDetails.displayName.en === '') {
          queries.push(await t.none(query, ['', 'sv', materialid, educationalmaterialid]));
        } else {
          queries.push(await t.none(query, [fileDetails.displayName.en, 'sv', materialid, educationalmaterialid]));
        }
      } else {
        queries.push(await t.none(query, [fileDetails.displayName.fi, 'sv', materialid, educationalmaterialid]));
      }
    } else {
      queries.push(await t.none(query, [fileDetails.displayName.sv, 'sv', materialid, educationalmaterialid]));
    }

    if (!fileDetails.displayName.en || fileDetails.displayName.en === '') {
      if (!fileDetails.displayName.fi || fileDetails.displayName.fi === '') {
        if (!fileDetails.displayName.sv || fileDetails.displayName.sv === '') {
          queries.push(await t.none(query, ['', 'en', materialid, educationalmaterialid]));
        } else {
          queries.push(await t.none(query, [fileDetails.displayName.sv, 'en', materialid, educationalmaterialid]));
        }
      } else {
        queries.push(await t.none(query, [fileDetails.displayName.fi, 'en', materialid, educationalmaterialid]));
      }
    } else {
      queries.push(await t.none(query, [fileDetails.displayName.en, 'en', materialid, educationalmaterialid]));
    }
  }
  return queries;
};

/**
 * Downstream an object from the cloud storage.
 * @param {{Bucket: string, Key: string}} params - Bucket name and the object key in the cloud storage.
 * @return {Promise<any>}
 */
export const readStreamFromStorage = async (params: { Bucket: string; Key: string }): Promise<any> => {
  try {
    return s3.getObject(params).createReadStream();
  } catch (err) {
    throw new Error(err);
  }
};

export const unZipAndExtract = async (zipFolder: any): Promise<any> => {
  const searchRecursive = (dir, pattern) => {
    // This is where we store pattern matches of all files inside the directory
    let results = [];

    // Read contents of directory
    fs.readdirSync(dir).forEach((dirInner: string) => {
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
    // Unzip the file to the folder specified in the env variable.
    const filenameParsedNicely = zipFolder.slice(0, -4);
    const zip = new ADMzip(zipFolder);
    zip.extractAllTo(filenameParsedNicely, true);

    // const pathToReturn = zipFolder + '/index.html';
    const results = searchRecursive(filenameParsedNicely, 'index.html');
    if (Array.isArray(results) && results.length) {
      return results[0];
    }
    const resultshtm = searchRecursive(filenameParsedNicely, 'index.htm');
    if (Array.isArray(resultshtm) && resultshtm.length) {
      return resultshtm[0];
    } else {
      return false;
    }
  } catch (err) {
    winstonLogger.error('Error in unzipAndExtract(): %o', err);
    return false;
  }
};

/**
 * Attachment upload to educational material.
 * @param {e.Request} req
 * @param {e.Response} res
 * @param {e.NextFunction} next
 * @return {Promise<any>}
 */
export const uploadAttachmentToMaterial = async (req: Request, res: Response, next: NextFunction): Promise<any> => {
  try {
    const contentType = req.headers['content-type'];
    if (contentType.startsWith('multipart/form-data')) {
      diskStore.single('attachment')(req, res, async (err) => {
        try {
          if (err) {
            winstonLogger.error(err);
            if (err.code === 'LIMIT_FILE_SIZE') {
              next(new ErrorHandler(413, err.message));
            } else {
              next(new ErrorHandler(500, 'Failure in file upload'));
            }
          }
          const file = (<any>req).file;
          if (!file) {
            next(new ErrorHandler(400, 'No file sent'));
          }
          const metadata = JSON.parse(req.body.attachmentDetails);
          let attachmentId;
          let result = [];
          if (typeof file !== 'undefined') {
            attachmentId = await insertDataToAttachmentTable(
              file,
              req.params.materialId,
              undefined,
              undefined,
              undefined,
              metadata,
            );
            result = await insertDataToTempAttachmentTable(file, metadata, attachmentId);
          }
          // return 200 if success and continue sending files to pouta
          res.status(200).json({ id: attachmentId });
          try {
            if (typeof file !== 'undefined') {
              const obj: any = await uploadLocalFileToCloudStorage(
                './' + file.path,
                file.filename,
                process.env.CLOUD_STORAGE_BUCKET,
              );
              await updateAttachment(obj.Key, obj.Bucket, obj.Location, attachmentId);
              await deleteDataToTempAttachmentTable(file.filename, result[0].id);
              fs.unlink('./' + file.path, (err: any) => {
                if (err) {
                  winstonLogger.error(err);
                }
              });
            }
          } catch (error) {
            winstonLogger.error(
              'error while sending files to pouta: ' + error + ' - ' + JSON.stringify((<any>req).file),
            );
          }
        } catch (e) {
          winstonLogger.error(e);
          if (!res.headersSent) {
            next(new ErrorHandler(500, 'Failure in file upload'));
          }
        }
      });
    } else {
      next(new ErrorHandler(400, 'Wrong contentType'));
    }
  } catch (err) {
    winstonLogger.error(err);
    next(new ErrorHandler(500, 'Not found'));
  }
};

/**
 * Upload a file from the local file system to the cloud object storage.
 * @param {Buffer} base64data File binary content Base64 encoded
 * @param {string} filename   Target file name in object storage system
 * @param {string} bucketName Target bucket in object storage system
 * @return {Promise<any>}
 */
export const uploadBase64FileToStorage = (base64data: Buffer, filename: string, bucketName: string): Promise<any> => {
  return new Promise(async (resolve, reject) => {
    try {
      try {
        const params = {
          Bucket: bucketName,
          Key: filename,
          Body: base64data,
        };
        s3.upload(params, (err: any, data: any) => {
          if (err) {
            winstonLogger.error(
              'Reading file from the local file system failed in uploadBase64FileToStorage(): %o',
              err,
            );
            reject(new Error(err));
            return;
          }
          if (data) {
            resolve(data);
          }
        });
      } catch (err) {
        winstonLogger.error(
          'Error in uploading file to the cloud object storage in uploadBase64FileToStorage(): ' + err,
        );
        reject(new Error(err));
      }
    } catch (err) {
      winstonLogger.error('Error in processing file in uploadBase64FileToStorage(): ' + err);
      reject(new Error(err));
    }
  });
};

/**
 * Upload single file and create educational material if empty only educational material is created.
 * @param {e.Request} req
 * @param {e.Response} res
 * @param {e.NextFunction} next
 * @return {Promise<any>}
 */
export const uploadMaterial = async (req: Request, res: Response, next: NextFunction): Promise<any> => {
  try {
    const contentType = req.headers['content-type'];
    if (contentType.startsWith('multipart/form-data')) {
      diskStore.single('file')(req, res, async (err) => {
        try {
          if (err) {
            if (err.code === 'LIMIT_FILE_SIZE') {
              next(new ErrorHandler(413, err.message));
            } else {
              winstonLogger.error(err);
              next(new ErrorHandler(500, 'Error in upload'));
            }
          }
          const file = (<any>req).file;
          const resp: any = {};

          // Send educationalmaterialid if no file send for link material creation.
          if (!file) {
            await db
              .tx(async (t: any) => {
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
                winstonLogger.error(err);
                next(new ErrorHandler(500, 'Error in upload'));
              });
          } else {
            let materialid: string;
            const fileDetails = JSON.parse(req.body.fileDetails);
            const material: any = [];
            db.tx(async (t: any) => {
              const queries = [];
              const emresp = await insertDataToEducationalMaterialTable(req, t);
              queries.push(emresp);
              const id = await insertDataToMaterialTable(t, emresp.id, '', fileDetails.language, fileDetails.priority);
              queries.push(id);
              material.push({ id: id.id, createFrom: file.originalname });
              materialid = id.id;
              let result = await insertDataToDisplayName(t, emresp.id, id.id, fileDetails);
              queries.push(result);
              result = await insertDataToTempRecordTable(t, file, id.id);
              queries.push(result);
              return t.batch(queries);
            })
              .then(async (data: any) => {
                // Return 200 if success and continue sending files to the cloud storage.
                resp.id = data[0].id;
                resp.material = material;
                res.status(200).json(resp);
                try {
                  if (typeof file !== 'undefined') {
                    const obj: any = await uploadLocalFileToCloudStorage(
                      './' + file.path,
                      file.filename,
                      process.env.CLOUD_STORAGE_BUCKET,
                    );
                    const recordid = await insertDataToRecordTable(file, materialid, obj.Key, obj.Bucket, obj.Location);

                    // Convert file to PDF if an office document.
                    try {
                      if (isOfficeMimeType(file.mimetype)) {
                        const path = await downstreamAndConvertOfficeFileToPDF(obj.Key);
                        const pdfkey = obj.Key.substring(0, obj.Key.lastIndexOf('.')) + '.pdf';
                        const pdfobj: any = await uploadLocalFileToCloudStorage(
                          path,
                          pdfkey,
                          process.env.PDF_BUCKET_NAME,
                        );
                        await updatePdfKey(pdfobj.Key, recordid);
                      }
                    } catch (err) {
                      winstonLogger.error(err);
                    }
                    await deleteDataFromTempRecordTable(file.filename, materialid);
                    fs.unlink('./' + file.path, (err: any) => {
                      if (err) {
                        winstonLogger.error(err);
                      }
                    });
                  }
                } catch (err) {
                  winstonLogger.error(err);
                }
              })
              .catch((err: Error) => {
                if (!res.headersSent) {
                  next(new ErrorHandler(500, 'Error in upload: ' + err));
                }
                fs.unlink('./' + file.path, (err: any) => {
                  if (err) {
                    winstonLogger.error('Error in uploadMaterial(): %o', err);
                  }
                });
              });
          }
        } catch (e) {
          if (!res.headersSent) {
            next(new ErrorHandler(500, 'Error in upload: ' + e));
          }
        }
      });
    } else {
      next(new ErrorHandler(400, 'Not found'));
    }
  } catch (err) {
    next(new ErrorHandler(500, 'Error in upload: ' + err));
  }
};

/**
 * Upload a single file to an educational material.
 * @param {e.Request} req
 * @param {e.Response} res
 * @param {e.NextFunction} next
 * @return {Promise<any>}
 */
export const uploadFileToMaterial = async (req: Request, res: Response, next: NextFunction): Promise<any> => {
  try {
    if (req.headers['content-type'].startsWith('multipart/form-data')) {
      diskStore.single('file')(req, res, async (err) => {
        try {
          if (err) {
            winstonLogger.error(err);
            if (err.code === 'LIMIT_FILE_SIZE') {
              next(new ErrorHandler(413, err.message));
            } else {
              next(new ErrorHandler(500, 'Error in upload'));
            }
          }
          const file = (<any>req).file;
          const resp: any = {};
          if (!file) {
            next(new ErrorHandler(400, 'No file sent'));
          } else {
            let materialid: string;
            const fileDetails = JSON.parse(req.body.fileDetails);
            const material: any = [];
            db.tx(async (t: any) => {
              const queries = [];
              const id = await insertDataToMaterialTable(
                t,
                req.params.edumaterialid,
                '',
                fileDetails.language,
                fileDetails.priority,
              );
              queries.push(id);
              material.push({ id: id.id, createFrom: file.originalname });
              materialid = id.id;
              let result = await insertDataToDisplayName(t, req.params.edumaterialid, id.id, fileDetails);
              queries.push(result);
              result = await insertDataToTempRecordTable(t, file, id.id);
              queries.push(result);
              return t.batch(queries);
            })
              .then(async () => {
                resp.id = req.params.edumaterialid;
                resp.material = material;
                res.status(200).json(resp);
                try {
                  if (typeof file !== 'undefined') {
                    const obj: any = await uploadLocalFileToCloudStorage(
                      './' + file.path,
                      file.filename,
                      process.env.CLOUD_STORAGE_BUCKET,
                    );
                    const recordid = await insertDataToRecordTable(file, materialid, obj.Key, obj.Bucket, obj.Location);
                    try {
                      if (isOfficeMimeType(file.mimetype)) {
                        const path = await downstreamAndConvertOfficeFileToPDF(obj.Key);
                        const pdfkey = obj.Key.substring(0, obj.Key.lastIndexOf('.')) + '.pdf';
                        const pdfobj: any = await uploadLocalFileToCloudStorage(
                          path,
                          pdfkey,
                          process.env.PDF_BUCKET_NAME,
                        );
                        await updatePdfKey(pdfobj.Key, recordid);
                      }
                    } catch (e) {
                      winstonLogger.error('ERROR converting office file to pdf: ' + e);
                    }
                    await deleteDataFromTempRecordTable(file.filename, materialid);
                    fs.unlink('./' + file.path, (err: any) => {
                      if (err) {
                        winstonLogger.error(err);
                      }
                    });
                  }
                } catch (ex) {
                  winstonLogger.error(
                    'error while sending file to pouta: ' + ex + ' - ' + JSON.stringify((<any>req).file),
                  );
                }
              })
              .catch((err: Error) => {
                winstonLogger.error(err);
                if (!res.headersSent) {
                  next(new ErrorHandler(500, 'Error in upload'));
                }
                fs.unlink('./' + file.path, (err: any) => {
                  if (err) {
                    winstonLogger.error('Error in uploadFileToMaterial(): %o', err);
                  }
                });
              });
          }
        } catch (err) {
          if (!res.headersSent) {
            next(new ErrorHandler(500, 'Error in upload: ' + err));
          }
        }
      });
    } else {
      next(new ErrorHandler(400, 'Not found'));
    }
  } catch (err) {
    winstonLogger.error(err);
    next(new ErrorHandler(500, 'Error in upload'));
  }
};

/**
 * Upstream a file from the local file system to the cloud storage with a streaming passthrough functionality.
 * @param {string} filePath - Path and file name in local file system.
 * @param {string} fileName - File name used in the cloud storage.
 * @param {string} bucketName - Target bucket in the cloud storage.
 * @return {Promise<ManagedUpload.SendData>}
 */
export const uploadLocalFileToCloudStorage = async (
  filePath: string,
  fileName: string,
  bucketName: string,
): Promise<SendData> => {
  const passThrough = new stream.PassThrough();

  // Read a locally stored file to the streaming passthrough.
  fs.createReadStream(filePath)
    .once('error', (err: Error) => {
      winstonLogger.error('Readstream for a local file failed in uploadLocalFileToCloudStorage(): %s', fileName);
      return Promise.reject(err);
    })
    .pipe(passThrough);

  // Upstream a locally stored file to the cloud storage from the streaming passthrough.
  return await s3
    .upload({ Bucket: bucketName, Key: fileName, Body: passThrough })
    .promise()
    .then((resp: SendData) => {
      winstonLogger.debug('Upstream to the cloud storage completed: %o', resp);
      return resp;
    })
    .catch((err: Error) => {
      winstonLogger.error('Upstream to the cloud storage failed in uploadLocalFileToCloudStorage(): %s', fileName);
      return Promise.reject(err);
    });
};

export default {
  checkTemporaryAttachmentQueue,
  checkTemporaryRecordQueue,
  downloadFile,
  downloadFileFromStorage,
  downloadFromStorage,
  downloadMaterialFile,
  downloadPreviewFile,
  fileUpstreamStatus,
  fileUpstreamProcess,
  insertDataToDisplayName,
  readStreamFromStorage,
  unZipAndExtract,
  uploadAttachmentToMaterial,
  uploadBase64FileToStorage,
  uploadMaterial,
  uploadFileToMaterial,
  uploadLocalFileToCloudStorage,
};
