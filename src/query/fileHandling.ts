import config from '@/config';
import {
  EducationalMaterial,
  Material,
  MaterialDisplayName,
  Record,
  sequelize,
  TemporaryRecord,
} from '@/domain/aoeModels';
import { ErrorHandler } from '@/helpers/errorHandler';
import { downstreamAndConvertOfficeFileToPDF, isOfficeMimeType, updatePdfKey } from '@/helpers/officeToPdfConverter';
import { S3Client, S3ClientConfig } from '@aws-sdk/client-s3';
import { db, pgp } from '@resource/postgresClient';
import { hasAccesstoPublication } from '@services/authService';
import { requestRedirected } from '@services/streamingService';
import winstonLogger from '@util/winstonLogger';
import ADMzip from 'adm-zip';
import { EntryData } from 'archiver';
import AWS, { AWSError, S3 } from 'aws-sdk';
import { ManagedUpload } from 'aws-sdk/lib/s3/managed_upload';
import { ServiceConfigurationOptions } from 'aws-sdk/lib/service';
import { NextFunction, Request, Response } from 'express';
import fs, { WriteStream } from 'fs';
import multer, { DiskStorageOptions, Multer, StorageEngine } from 'multer';
import { promisify } from 'node:util';
import path from 'path';
import pdfParser from 'pdf-parse';
import { ColumnSet } from 'pg-promise';
import s3Zip, { ArchiveOptions } from 's3-zip';
import { Error, Transaction } from 'sequelize';
import stream, { PassThrough, Readable } from 'stream';
import { updateDownloadCounter } from './analyticsQueries';
import { insertEducationalMaterialName } from './apiQueries';
import MulterFile = Express.Multer.File;
import SendData = ManagedUpload.SendData;

// AWS and S3 configurations.
const configAWS: ServiceConfigurationOptions = {
  credentials: {
    accessKeyId: process.env.CLOUD_STORAGE_ACCESS_KEY,
    secretAccessKey: process.env.CLOUD_STORAGE_ACCESS_SECRET,
  },
  endpoint: process.env.CLOUD_STORAGE_API,
  region: process.env.CLOUD_STORAGE_REGION,
};
AWS.config.update(configAWS);

// define multer storage
const storage: StorageEngine = multer.diskStorage({
  // notice you are calling the multer.diskStorage() method here, not multer()
  destination: (req: Request, file: any, cb: any) => {
    cb(undefined, `./${config.MEDIA_FILE_PROCESS.localFolder}/`);
  },
  filename: (req: Request, file: any, cb: any) => {
    const ext = file.originalname.substring(file.originalname.lastIndexOf('.'), file.originalname.length);
    let str = file.originalname.substring(0, file.originalname.lastIndexOf('.'));
    str = str.replace(/[^a-zA-Z0-9]/g, '');
    cb(undefined, str + '-' + Date.now() + ext);
  },
} as DiskStorageOptions);

const upload: Multer = multer({
  storage: storage,
  limits: { fileSize: Number(process.env.FILE_SIZE_LIMIT) },
  preservePath: true,
}); // provide the return value from

/**
 * @param {e.Request} req
 * @param {e.Response} res
 * @param {e.NextFunction} next
 * @return {Promise<any>}
 */
export const uploadAttachmentToMaterial = async (req: Request, res: Response, next: NextFunction): Promise<any> => {
  try {
    const contentType: string = req.headers['content-type'];
    if (contentType.startsWith('multipart/form-data')) {
      upload.single('attachment')(req, res, async (err: any): Promise<any> => {
        try {
          if (err) {
            winstonLogger.error('Multer error in uploadAttachmentToMaterial(): %o', err);
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
          // const emresp = await insertDataToEducationalMaterialTable(req);
          const metadata = JSON.parse(req.body.attachmentDetails);
          winstonLogger.debug(metadata);
          let attachmentId;
          let result: any[] = [];
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
              const obj: any = await uploadFileToStorage(
                './' + file.path,
                file.filename,
                process.env.CLOUD_STORAGE_BUCKET,
              );
              // await insertDataToAttachmentTable(file, req.params.materialId, obj.Key, obj.Bucket, obj.Location, metadata);
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
 * @param {e.Request} req
 * @param {e.Response} res
 * @param {e.NextFunction} next
 * @return {Promise<any>}
 */
export const uploadMaterial = async (req: Request, res: Response, next: NextFunction): Promise<any> => {
  try {
    winstonLogger.debug(req.body);
    const contentType = req.headers['content-type'];
    if (contentType.startsWith('multipart/form-data')) {
      upload.single('file')(req, res, async (err: any) => {
        try {
          if (err) {
            winstonLogger.debug(err);
            if (err.code === 'LIMIT_FILE_SIZE') {
              next(new ErrorHandler(413, err.message));
            } else {
              winstonLogger.error(err);
              next(new ErrorHandler(500, 'Error in upload'));
            }
          }
          const file: MulterFile = req.file;
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
                winstonLogger.debug(err);
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
                // return 200 if success and continue sending files to pouta
                resp.id = data[0].id;
                resp.material = material;
                res.status(200).json(resp);
                try {
                  if (typeof file !== 'undefined') {
                    winstonLogger.debug(materialid);
                    const obj: any = await uploadFileToStorage(
                      './' + file.path,
                      file.filename,
                      process.env.CLOUD_STORAGE_BUCKET,
                    );
                    const recordid = await insertDataToRecordTable(file, materialid, obj.Key, obj.Bucket, obj.Location);
                    // convert file to pdf if office document
                    try {
                      if (isOfficeMimeType(file.mimetype)) {
                        winstonLogger.debug('Convert file and send to allas');
                        const path = await downstreamAndConvertOfficeFileToPDF(obj.Key);
                        const pdfkey = obj.Key.substring(0, obj.Key.lastIndexOf('.')) + '.pdf';
                        const pdfobj: any = await uploadFileToStorage(
                          path,
                          pdfkey,
                          config.CLOUD_STORAGE_CONFIG.bucketPDF,
                        );
                        await updatePdfKey(pdfobj.Key, recordid);
                      }
                    } catch (e) {
                      winstonLogger.debug('ERROR converting office file to pdf');
                      winstonLogger.error(e);
                    }
                    await deleteDataFromTempRecordTable(file.filename, materialid);
                    fs.unlink('./' + file.path, (err: any) => {
                      if (err) {
                        winstonLogger.error(err);
                      }
                    });
                  }
                } catch (err) {
                  winstonLogger.debug('error while sending file to pouta: ' + JSON.stringify((<any>req).file));
                  winstonLogger.error(err);
                }
              })
              .catch((err: Error) => {
                if (!res.headersSent) {
                  next(new ErrorHandler(500, 'Error in upload: ' + err));
                }
                fs.unlink('./' + file.path, (err: any) => {
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
 * @param {e.Request} req
 * @param {e.Response} res
 * @return {Promise<{file: Express.Multer.File, fileDetails: Record<string, unknown>}>}
 */
export const uploadFileToLocalDisk = (
  req: Request,
  res: Response,
): Promise<{ file: MulterFile; fileDetails: Record<string, unknown> }> => {
  return new Promise((resolve, reject): void => {
    try {
      upload.single('file')(req, res, (err: any): void => {
        if (err) {
          if (err.code === 'LIMIT_FILE_SIZE') {
            throw new ErrorHandler(413, 'MULTER: ' + err.message);
          } else {
            throw new ErrorHandler(500, 'MULTER: ' + err);
          }
        }
        resolve({
          file: req.file as MulterFile,
          fileDetails: JSON.parse(req.body.fileDetails) as Record<string, unknown>,
        });
      });
    } catch (err) {
      fs.unlink(`./${req.file.path}`, (err) => {
        if (err) winstonLogger.error('File removal after the interrupted upload failed: %o', err);
      });
      reject(err);
      winstonLogger.error('File upload failed: %o', err);
    }
  });
};

export const detectEncyptedPDF = (filePath: string): Promise<boolean> => {
  return new Promise((resolve, reject) => {
    fs.readFile(filePath, (err, data: Buffer) => {
      if (err) {
        reject(err);
        return;
      }
      pdfParser(data)
        .then((info) => {
          const isEncrypted: boolean = info.info.Encrypt !== undefined;
          resolve(isEncrypted);
        })
        .catch((err) => {
          if (err.name === 'PasswordException') {
            resolve(true);
            return;
          } else {
            reject(err);
            return;
          }
        });
    });
  });
};

export const deleteFileFromLocalDiskStorage = (file: MulterFile) => {
  fs.unlink(`./${file.path}`, (err: any): void => {
    if (err) winstonLogger.error('Unlink removal for the uploaded file failed: %o', err);
  });
};

/**
 * Upload a single file to the educational material with a multipart form upload.
 * @param {e.Request} req
 * @param {e.Response} res
 * @param {e.NextFunction} next
 * @return {Promise<void>}
 */
export const uploadFileToMaterial = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
  const { file, fileDetails }: any = await uploadFileToLocalDisk(req, res)
    .then((result: { file: MulterFile; fileDetails: Record<string, unknown> }) => {
      // winstonLogger.debug('FILE UPLOAD COMPLETED');
      return result;
    })
    .catch((err) => {
      winstonLogger.error('Multer upload failed: %o', err);
      throw err;
    });
  // winstonLogger.debug('FILEPATH: %s', file.filename);
  if (!fs.existsSync(`uploads/${file.filename}`)) {
    res.status(500).json({ message: 'aborted' });
    return;
  }
  // Detect and reject encrypted PDFs.
  if (file.mimetype === 'application/pdf') {
    const isEncrypted: boolean = await detectEncyptedPDF(`uploads/${file.filename}`);
    if (isEncrypted) {
      res.status(415).json({ rejected: 'Encrypted PDF files not allowed' }).end();
      deleteFileFromLocalDiskStorage(file);
      return;
    }
  }
  let material: Material;
  let recordID: string;
  let t: Transaction;
  t = await sequelize.transaction({
    isolationLevel: Transaction.ISOLATION_LEVELS.READ_COMMITTED, // SERIALIZABLE,
  });
  try {
    // Save the general information of a new material entry.
    // Create a material in a separate transaction before using the returning material ID to avoid concurrency issues.
    material = await Material.create(
      {
        link: '',
        educationalMaterialId: req.params.edumaterialid,
        obsoleted: 0,
        priority: (fileDetails as any).priority,
        materialLanguageKey: (fileDetails as any).language,
      },
      {
        transaction: t,
      },
    );
    // Save the material display name with language versions.
    await upsertMaterialDisplayName(t, req.params.edumaterialid, material.id, fileDetails);

    recordID = await upsertRecord(t, file, material.id); // await insertDataToRecordTable(file, material.id);
    // Save the file information to the temporary records until the upstreaming is completed.
    // await upsertMaterialFileToTempRecords(t, file, material.id);
    await t.commit();
  } catch (err: any) {
    winstonLogger.error('Transaction for the single file upload failed: %o', err);
    await t.rollback();
    throw new ErrorHandler(500, `Transaction for the single file upload failed: ${err}`);
  }
  // TODO: 202 Accepted response to indicate the incomplete upstreaming.
  res.status(200).json({
    id: req.params.edumaterialid,
    material: [{ id: material.id, createFrom: file.originalname, educationalmaterialid: req.params.edumaterialid }],
  });

  try {
    const fileS3: SendData = await uploadFileToStorage(
      `./${file.path}`,
      file.filename,
      config.CLOUD_STORAGE_CONFIG.bucket,
      material,
    );
    await sequelize.transaction(
      {
        isolationLevel: Transaction.ISOLATION_LEVELS.READ_COMMITTED, // SERIALIZABLE,
      },
      async (t: Transaction): Promise<void> => {
        await upsertRecord(t, file, material.id, fileS3.Key, fileS3.Bucket, fileS3.Location, recordID);
      },
    );
    // Create and save a PDF version from the office file formats, such as Excel, Word and PowerPoint.
    if (isOfficeMimeType(file.mimetype)) {
      const keyPDF: string = fileS3.Key.substring(0, fileS3.Key.lastIndexOf('.')) + '.pdf';
      // Downstream an office file and convert to PDF in the local file system (linked disk storage).
      await downstreamAndConvertOfficeFileToPDF(fileS3.Key).then(async (pathPDF: string): Promise<void> => {
        // Upstream the converted PDF file to the cloud storage (dedicated PDF bucket).
        await uploadFileToStorage(pathPDF, keyPDF, config.CLOUD_STORAGE_CONFIG.bucketPDF).then(
          async (pdfS3: SendData): Promise<void> => {
            // Save the material's PDF key to indicate the availability of a PDF version.
            await updatePdfKey(pdfS3.Key, recordID);
          },
        );
      });
    }
  } catch (err) {
    await Material.update(
      { obsoleted: 1 },
      {
        where: {
          id: material.id,
        },
      },
    );
    winstonLogger.error('Single file upstreaming or conversions failed: %o', err);
    if (!res.headersSent) next(new ErrorHandler(500, `File upstreaming failed: ${err}`));
  } finally {
    // Remove information from incomplete file tasks.
    // await deleteDataFromTempRecordTable(file.filename, material.id);
    deleteFileFromLocalDiskStorage(file);
  }
};

/**
 * Load a file to the cloud storage.
 * TODO: Possible duplicate function
 * @param file
 * @param materialid
 */
export const fileToStorage = async (
  file: MulterFile,
  materialid: string,
): Promise<{ key: string; recordid: string }> => {
  const obj: any = await uploadFileToStorage(`./${file.path}`, file.filename, process.env.CLOUD_STORAGE_BUCKET);
  const recordid = await insertDataToRecordTable(file, materialid, obj.Key, obj.Bucket, obj.Location);
  await deleteDataFromTempRecordTable(file.filename, materialid);
  fs.unlink(`./${file.path}`, (err: any) => {
    if (err) winstonLogger.error(err);
  });
  return { key: obj.Key, recordid: recordid };
};

/**
 *
 * @param file
 * @param metadata
 * @param materialid
 * @param attachmentId
 * load attachment to allas storage
 */
export async function attachmentFileToStorage(
  file: any,
  metadata: any,
  materialid: string,
  attachmentId: string,
): Promise<any> {
  const obj: any = await uploadFileToStorage('./' + file.path, file.filename, process.env.CLOUD_STORAGE_BUCKET);
  // await insertDataToAttachmentTable(file, materialid, obj.Key, obj.Bucket, obj.Location, metadata);
  await updateAttachment(obj.Key, obj.Bucket, obj.Location, attachmentId);
  await deleteDataToTempAttachmentTable(file.filename, materialid);
  fs.unlink('./' + file.path, (err: any) => {
    if (err) {
      winstonLogger.error(err);
    }
  });
}

/**
 * check if files in temporaryrecord table and try to load to allas storage
 */
export const checkTemporaryRecordQueue = async (): Promise<void> => {
  try {
    // Take the last hour off from the current time.
    const ts = Date.now() - 1000 * 60 * 60;
    const query = `
      SELECT * FROM temporaryrecord
      WHERE extract(epoch from createdat) * 1000 < $1
      LIMIT 1000
    `;
    const records = await db.any(query, [ts]);
    for (const record of records) {
      const file: MulterFile = {
        fieldname: null,
        originalname: record.originalfilename,
        encoding: '',
        mimetype: record.mimetype,
        size: record.filesize,
        stream: null,
        destination: null,
        filename: record.filename,
        path: record.filepath,
        buffer: null,
      };
      try {
        const obj = await fileToStorage(file, record.materialid);
        const path = await downstreamAndConvertOfficeFileToPDF(obj.key);
        const pdfkey = obj.key.substring(0, obj.key.lastIndexOf('.')) + '.pdf';
        const pdfobj: any = await uploadFileToStorage(path, pdfkey, config.CLOUD_STORAGE_CONFIG.bucketPDF);
        await updatePdfKey(pdfobj.Key, obj.recordid);
      } catch (error) {
        winstonLogger.error(error);
      }
    }
  } catch (error) {
    winstonLogger.error(error);
  }
};

/**
 * check if files in temporaryattachment table and try to load to allas storage
 */
export async function checkTemporaryAttachmentQueue(): Promise<any> {
  try {
    // take hour of
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
        filename: element.filename,
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

export const insertDataToEducationalMaterialTable = async (req: Request, t: any): Promise<any> => {
  const query = `
    INSERT INTO educationalmaterial (usersusername)
    VALUES ($1)
    RETURNING id
  `;
  return await t.one(query, [req.session.passport.user.uid]);
};

/**
 * Update or insert the file information to the temporary records when the related file processing is still in progress.
 * Attach queries to a transaction provided.
 * @param {Transaction} t
 * @param {Express.Multer.File} file
 * @param {string} materialId
 * @return {Promise<any>}
 */
export const upsertMaterialFileToTempRecords = async (
  t: Transaction,
  file: MulterFile,
  materialId: string,
): Promise<any> => {
  const temporaryRecord = await TemporaryRecord.findOne({
    where: {
      originalFileName: file.originalname,
      materialId,
    },
    transaction: t,
  });
  await TemporaryRecord.upsert(
    {
      id: temporaryRecord && temporaryRecord.id, // NULL for the new entries.
      filePath: file.path || temporaryRecord.filePath,
      originalFileName: file.originalname || temporaryRecord.originalFileName,
      fileSize: file.size || temporaryRecord.fileSize,
      mimeType: file.mimetype || temporaryRecord.mimeType,
      fileName: file.filename || temporaryRecord.fileName,
      materialId: materialId || temporaryRecord.materialId,
    },
    {
      transaction: t,
    },
  );
};

/**
 * LEGACY IMPLEMENTATION.
 * TODO: TO BE REMOVED
 * @param t
 * @param {Express.Multer.File} file
 * @param materialId
 * @return {Promise<any>}
 */
export const insertDataToTempRecordTable = async (t: any, file: MulterFile, materialId: any): Promise<any> => {
  const query = `
    INSERT INTO temporaryrecord (filename, filepath, originalfilename, filesize, mimetype, materialid)
    VALUES ($1, $2, $3, $4, $5, $6)
    RETURNING id
  `;
  return await t.any(query, [file.filename, file.path, file.originalname, file.size, file.mimetype, materialId]);
};

/**
 * Update or insert a material display name with the language versions (if available) and attach to a transaction.
 * A new implementation of the function insertDataToDisplayName() below.
 * @param {Transaction} t
 * @param {string} educationalMaterialId
 * @param {string} materialId
 * @param fileDetails
 * @return {Promise<any>}
 */
export const upsertMaterialDisplayName = async (
  t: Transaction,
  educationalMaterialId: string,
  materialId: string,
  fileDetails: any,
): Promise<void> => {
  const materialDisplayNameEN = await MaterialDisplayName.findOne({
    where: { language: 'en', materialId },
    transaction: t,
  });
  const materialDisplayNameFI = await MaterialDisplayName.findOne({
    where: { language: 'fi', materialId },
    transaction: t,
  });
  const materialDisplayNameSV = await MaterialDisplayName.findOne({
    where: { language: 'sv', materialId },
    transaction: t,
  });
  const missingLang: string = fileDetails.displayName.en || fileDetails.displayName.fi || fileDetails.displayName.sv;
  await MaterialDisplayName.upsert(
    {
      id: materialDisplayNameEN && materialDisplayNameEN.id,
      displayName:
        fileDetails.displayName.en || (materialDisplayNameEN && materialDisplayNameEN.displayName) || missingLang,
      language: 'en',
      materialId: materialId || materialDisplayNameEN.materialId,
    },
    {
      transaction: t,
    },
  );
  await MaterialDisplayName.upsert(
    {
      id: materialDisplayNameFI && materialDisplayNameFI.id,
      displayName:
        fileDetails.displayName.fi || (materialDisplayNameFI && materialDisplayNameFI.displayName) || missingLang,
      language: 'fi',
      materialId: materialId || materialDisplayNameFI.materialId,
    },
    {
      transaction: t,
    },
  );
  await MaterialDisplayName.upsert(
    {
      id: materialDisplayNameSV && materialDisplayNameSV.id,
      displayName:
        fileDetails.displayName.sv || (materialDisplayNameSV && materialDisplayNameSV.displayName) || missingLang,
      language: 'sv',
      materialId: materialId || materialDisplayNameSV.materialId,
    },
    {
      transaction: t,
    },
  );
};

/**
 * LEGACY IMPLEMENTATION.
 * TODO: TO BE REMOVED
 * @param t
 * @param educationalmaterialid
 * @param {string} materialid
 * @param fileDetails
 * @return {Promise<any>}
 */
export async function insertDataToDisplayName(
  t: any,
  educationalmaterialid,
  materialid: string,
  fileDetails: any,
): Promise<any> {
  const queries = [];
  const query =
    'INSERT INTO materialdisplayname (displayname, language, materialid) (SELECT $1,$2,$3 where $3 in (select id from material where educationalmaterialid = $4)) ON CONFLICT (language, materialid) DO UPDATE Set displayname = $1;';
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
}

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

/**
 * @param files
 * @param materialID
 * @param fileKey
 * @param fileBucket
 * @param {string} location
 * @param metadata
 * @return {Promise<any>}
 */
export const insertDataToAttachmentTable = async (
  files: any,
  materialID: any,
  fileKey: any,
  fileBucket: any,
  location: string,
  metadata: any,
): Promise<any> => {
  const queries: any[] = [];
  const data = await db
    .tx(async (t: any): Promise<any> => {
      queries.push(
        await db.none(
          `
          UPDATE educationalmaterial
          SET updatedat = NOW()
          WHERE id = (
            SELECT m.educationalmaterialid FROM material m WHERE m.id = $1
          )
        `,
          [materialID],
        ),
      );
      queries.push(
        await db.one(
          `
          INSERT INTO attachment (filePath, originalfilename, filesize, mimetype, fileKey, fileBucket, materialid, defaultfile, kind, label, srclang)
          VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)
          RETURNING id
        `,
          [
            location,
            files.originalname,
            files.size,
            files.mimetype,
            fileKey,
            fileBucket,
            materialID,
            metadata.default,
            metadata.kind,
            metadata.label,
            metadata.srclang,
          ],
        ),
      );
      return t.batch(queries);
    })
    .catch((err: Error): void => {
      throw err;
    });
  return data[1].id;
};

export async function updateAttachment(
  fileKey: any,
  fileBucket: any,
  location: string,
  attachmentId: string,
): Promise<any> {
  const queries = [];
  let query;
  await db
    .tx(async (t: any) => {
      query = 'UPDATE attachment SET filePath = $1, fileKey = $2, fileBucket = $3 WHERE id = $4';
      winstonLogger.debug(query);
      queries.push(await db.none(query, [location, fileKey, fileBucket, attachmentId]));
      return t.batch(queries);
    })
    .catch((err: Error) => {
      throw err;
    });
}

export async function insertDataToTempAttachmentTable(files: any, metadata: any, attachmentId: string): Promise<any> {
  const query =
    'INSERT INTO temporaryattachment (filename, filepath, originalfilename, filesize, mimetype, ' +
    'defaultfile, kind, label, srclang, attachmentid) ' +
    'VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10) RETURNING id';
  winstonLogger.debug(query);
  return await db.any(query, [
    files.filename,
    files.path,
    files.originalname,
    files.size,
    files.mimetype,
    metadata.default,
    metadata.kind,
    metadata.label,
    metadata.srclang,
    attachmentId,
  ]);
}

/**
 * @param {Transaction} t
 * @param file
 * @param {string} materialID
 * @param {string} cloudKey
 * @param {string} cloudBucket
 * @param {string} cloudURI
 * @param {string} recordID
 * @return {Promise<void>}
 */
export const upsertRecord = async (
  t: Transaction,
  file: MulterFile,
  materialID: string,
  cloudKey?: string,
  cloudBucket?: string,
  cloudURI?: string,
  recordID?: string,
): Promise<string> => {
  const material: Material = await Material.findOne({
    where: { id: materialID },
    transaction: t,
  });
  await EducationalMaterial.update(
    { updatedAt: sequelize.literal('CURRENT_TIMESTAMP') },
    {
      where: {
        id: material.educationalMaterialId,
      },
      transaction: t,
    },
  );
  const [record]: [IRecord, boolean] = await Record.upsert(
    {
      id: recordID,
      filePath: cloudURI,
      originalFileName: file.originalname,
      fileSize: file.size,
      mimeType: file.mimetype,
      materialId: materialID,
      fileKey: cloudKey,
      fileBucket: cloudBucket,
    },
    {
      transaction: t,
    },
  );
  return record.id;
};

/**
 * Transaction to persist the metadata of a new file and update the corresponding educational material.
 * Set the cloud related columns nullable: ALTER TABLE <table> ALTER COLUMN <column> DROP NOT NULL.
 * @param file
 * @param materialID
 * @param cloudKey
 * @param cloudBucket
 * @param {string} cloudURI
 * @param recordID
 * @return {Promise<string | null>}
 */
export const insertDataToRecordTable = async (
  file: MulterFile,
  materialID: string,
  cloudKey?: string,
  cloudBucket?: string,
  cloudURI?: string,
  recordID?: string,
): Promise<string | null> => {
  let query;
  try {
    const { id } = await db.tx(async (t: any) => {
      query = `
        UPDATE educationalmaterial SET updatedat = NOW()
        WHERE id = (
          SELECT educationalmaterialid
          FROM material
          WHERE id = $1
        )
      `;
      await t.none(query, [materialID]);
      let columnSet: ColumnSet = new pgp.helpers.ColumnSet(
        ['filepath', 'originalfilename', 'filesize', 'mimetype', 'materialid', 'filekey', 'filebucket'],
        { table: 'record' },
      );
      const values = {
        filepath: cloudURI,
        originalfilename: file.originalname,
        filesize: file.size,
        mimetype: file.mimetype,
        materialid: materialID,
        filekey: cloudKey,
        filebucket: cloudBucket,
      };
      if (recordID) {
        columnSet = columnSet.extend(['id']);
        values['id'] = recordID;
      }
      query = `
        ${pgp.helpers.insert([values], columnSet)}
        ON CONFLICT (id) DO UPDATE SET
        filepath = EXCLUDED.filepath, filekey = EXCLUDED.filekey, filebucket = EXCLUDED.filebucket
        RETURNING id
      `;
      return await t.oneOrNone(query);
    });
    return id;
  } catch (err) {
    throw err;
  }
};

/**
 * @param filename
 * @param materialId
 * @return {Promise<void>}
 */
export const deleteDataFromTempRecordTable = async (filename: any, materialId: any): Promise<void> => {
  const query = `
    DELETE FROM temporaryrecord
    WHERE filename = $1 AND materialid = $2
  `;
  await db.any(query, [filename, materialId]);
};

export async function deleteDataToTempAttachmentTable(filename: any, materialId: any): Promise<any> {
  const query = 'DELETE FROM temporaryattachment WHERE filename = $1 AND id = $2';
  return await db.any(query, [filename, materialId]);
}

/**
 * Upload a file from the local file system to the cloud object storage.
 * @param {string} filePath
 * @param {string} fileName
 * @param {string} bucketName
 * @param {Material} materialMeta
 * @return {Promise<ManagedUpload.SendData>}
 */
export const uploadFileToStorage = (
  filePath: string,
  fileName: string,
  bucketName: string,
  materialMeta?: Material,
): Promise<SendData> => {
  const config: ServiceConfigurationOptions = {
    credentials: {
      accessKeyId: process.env.CLOUD_STORAGE_ACCESS_KEY,
      secretAccessKey: process.env.CLOUD_STORAGE_ACCESS_SECRET,
    },
    endpoint: process.env.CLOUD_STORAGE_API,
    region: process.env.CLOUD_STORAGE_REGION,
  };
  AWS.config.update(config);
  const s3: S3 = new AWS.S3();
  const passThrough: PassThrough = new stream.PassThrough();
  let putObjectS3: S3.PutObjectRequest = { Bucket: bucketName, Key: fileName, Body: passThrough };
  if (materialMeta) {
    putObjectS3 = {
      ...putObjectS3,
      Metadata: {
        educationalMaterialID: materialMeta.educationalMaterialId,
        materialID: materialMeta.id,
      },
    };
  }
  return new Promise((resolve, reject): void => {
    // Read a locally stored file to the streaming passthrough.
    fs.createReadStream(filePath)
      .once('error', (err: Error): void => {
        winstonLogger.error('Readstream for a local file failed in uploadLocalFileToCloudStorage(): %s', fileName);
        reject(err);
      })
      .pipe(passThrough);
    // Upstream a locally stored file to the cloud storage from the streaming passthrough.
    s3.upload(putObjectS3)
      .promise()
      .then((resp: SendData): void => {
        resolve(resp);
      })
      .catch((err: Error): void => {
        winstonLogger.error('Upstream to the cloud storage failed in uploadLocalFileToCloudStorage(): %s', fileName);
        reject(err);
      });
  });
};

/**
 * Upload a file from the local file system to the cloud object storage.
 *
 * @param base64data Buffer File binary content Base64 encoded
 * @param filename   string Target file name in object storage system
 * @param bucketName string Target bucket in object storage system
 */
export async function uploadBase64FileToStorage(
  base64data: Buffer,
  filename: string,
  bucketName: string,
): Promise<any> {
  return new Promise(async (resolve, reject) => {
    try {
      const config: ServiceConfigurationOptions = {
        credentials: {
          accessKeyId: process.env.CLOUD_STORAGE_ACCESS_KEY,
          secretAccessKey: process.env.CLOUD_STORAGE_ACCESS_SECRET,
        },
        endpoint: process.env.CLOUD_STORAGE_API,
        region: process.env.CLOUD_STORAGE_REGION,
      };
      AWS.config.update(config);
      const s3 = new AWS.S3();
      try {
        const params = {
          Bucket: bucketName,
          Key: filename,
          Body: base64data,
        };
        const startTime: number = Date.now();
        s3.upload(params, (err: any, data: any) => {
          if (err) {
            winstonLogger.error(
              'Reading file from the local file system failed in uploadBase64FileToStorage(): ' + err,
            );
            reject(err);
          }
          if (data) {
            winstonLogger.debug(
              'Uploading file to the cloud object storage completed in ' + (Date.now() - startTime) / 1000 + 's',
            );
            resolve(data);
          }
        });
      } catch (err) {
        winstonLogger.error(
          'Error in uploading file to the cloud object storage in uploadBase64FileToStorage(): ' + err,
        );
        reject(err);
      }
    } catch (err) {
      winstonLogger.error('Error in processing file in uploadBase64FileToStorage(): ' + err);
      reject(err);
    }
  });
}

/**
 *
 * @param req
 * @param res
 * @param next
 */
export const downloadPreviewFile = async (req: Request, res: Response, next: NextFunction): Promise<any> => {
  winstonLogger.debug('HTTP request headers present in downloadPreviewFile(): %o', req.headers);
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

/**
 * @param req
 * @param res
 * @param next
 */
export const downloadFile = async (req: Request, res: Response, next: NextFunction): Promise<any> => {
  try {
    const filename: string = req.params.filename;
    const materialidQuery = 'SELECT materialid FROM record WHERE filekey = $1';
    const materialid = (await db.any(materialidQuery, [filename]))[0];

    if (!materialid) return res.status(404).end();

    const educationalmaterialidQuery = 'SELECT educationalmaterialid FROM versioncomposition WHERE materialid = $1';
    const originalMaterialIdArr: {
      educationalmaterialid: string;
    }[] = await db.any(educationalmaterialidQuery, [materialid.materialid]);

    let educationalmaterialId: number;
    if (originalMaterialIdArr) {
      educationalmaterialId = parseInt(originalMaterialIdArr[0].educationalmaterialid, 10);

      // Pass educational material ID to the next function in request chain.
      res.locals.id = educationalmaterialId;
    } else {
      educationalmaterialId = parseInt(materialid.materialid, 10);
    }

    await downloadFileFromStorage(req, res, next);
    //if (!data) return res.end();

    // Increase download counter unless the user is the owner of the material.
    if (!req.isAuthenticated() || !(await hasAccesstoPublication(educationalmaterialId, req))) {
      try {
        await updateDownloadCounter(educationalmaterialId.toString());
      } catch (error) {
        winstonLogger.error('Updating download counter failed: ' + error);
      }
    }
    next();
    // return res.status(200).end();
  } catch (err) {
    if (!res.headersSent) {
      next(new ErrorHandler(400, err));
    }
  }
};

/**
 * Get file details from the database before proceeding to the file download from the cloud object storage.
 * In case of video streaming request can be redirected to the streaming service when all criteria are fulfilled.
 * TODO: Function chain and related leagcy code should be refactored and simplified in both directions.
 * @param req   express.Request
 * @param res   express.Response
 * @param next  express.NextFunction
 * @param isZip boolean Indicator for the need of decompression
 */
export const downloadFileFromStorage = async (
  req: Request,
  res: Response,
  next: NextFunction,
  isZip?: boolean,
): Promise<any> => {
  const fileName: string = (req.params.filename as string) || (req.params.key as string);
  return new Promise(async (resolve): Promise<void> => {
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
      const fileDetails: {
        originalfilename: string;
        filesize: number;
        mimetype: string;
      } = await db.oneOrNone(query, [fileName]);
      // { originalfilename: 'oceanwaves1280x720.mp4', filesize: 2000000, mimetype: 'video/mp4' };
      if (!fileDetails) {
        next(new ErrorHandler(404, 'Requested file ' + fileName + ' not found.'));
      } else {
        // Check if Range HTTP header is present and the criteria for streaming service redirect are fulfilled.
        if (
          config.STREAM_REDIRECT_CRITERIA.streamEnabled &&
          req.headers['range'] &&
          (await requestRedirected(fileDetails, fileName))
        ) {
          res.setHeader('Location', config.STREAM_REDIRECT_CRITERIA.redirectUri + fileName);
          res.status(302);
          resolve(undefined);
          return;
        }
        const params: { Bucket: string; Key: string } = {
          Bucket: process.env.CLOUD_STORAGE_BUCKET as string,
          Key: (req.params.filename as string) || (req.params.key as string),
        };
        const resp = await downloadFromStorage(req, res, next, params, fileDetails.originalfilename, isZip);
        resolve(resp);
      }
    } catch (err) {
      winstonLogger.error('downloadFileFromStorage(): req.params.filename=%s, isZip=%s', req.params.filename, isZip);
      next(new ErrorHandler(500, 'Downloading a single file failed in downloadFileFromStorage()'));
    }
  });
};

/**
 * Download a single file to a given directory.
 * Wait for download to complete before resolving the promise function.
 * @param {{Bucket: string, Key: string}} paramsS3
 * @param {string} targetPath
 * @return {Promise<void>}
 */
export const directoryDownloadFromStorage = async (
  paramsS3: {
    Bucket: string;
    Key: string;
  },
  targetPath: string,
): Promise<void> => {
  const s3: S3 = new AWS.S3();
  const streamS3: Readable = s3
    .getObject(paramsS3)
    .createReadStream()
    .once('error', (err: AWSError): void => {
      if (err.name === 'NoSuchKey') {
        winstonLogger.debug('S3 requested key [%s] not found.', paramsS3.Key);
        return;
      } else if (err.name === 'TimeoutError') {
        winstonLogger.debug('S3 connection closed by timeout event.');
        return;
      } else {
        throw err;
      }
    });
  const writeStream: WriteStream = fs.createWriteStream(targetPath);
  const pipeline = promisify(stream.pipeline);
  await pipeline(streamS3, writeStream);
};

/**
 * API function to download an original or compressed (zip) file from the cloud object storage.
 * @param req          express.Request
 * @param res          express.Response
 * @param next         express.NextFunction
 * @param paramsS3     GetRequestObject (aws-sdk/clients/s3)
 * @param origFilename string Original file name without storage ID
 * @param isZip        boolean Indicator for the need of decompression
 */
export const downloadFromStorage = (
  req: Request,
  res: Response,
  next: NextFunction,
  paramsS3: { Bucket: string; Key: string },
  origFilename: string,
  isZip?: boolean,
): Promise<any> => {
  const s3: S3 = new AWS.S3();
  const key: string = paramsS3.Key;
  return new Promise(async (resolve, reject): Promise<any> => {
    try {
      const fileStream: Readable = s3.getObject(paramsS3).createReadStream();
      if (isZip) {
        const folderpath = `${process.env.HTML_FOLDER}/${origFilename}`;
        fileStream
          .once('error', (err: AWSError): void => {
            if (err.name === 'NoSuchKey') {
              winstonLogger.debug('Requested file %s not found.', origFilename);
              res.status(404);
              resolve(null);
            } else if (err.name === 'TimeoutError') {
              winstonLogger.debug('Connection closed by timeout event.');
              res.end();
              resolve(null);
            } else {
              winstonLogger.debug('S3 connection failed: %s.', JSON.stringify(err));
              reject(err);
              throw err;
            }
          })
          // Wait for 'finish' event for writable stream.
          .once('finish', async (): Promise<any> => {
            resolve(await unZipAndExtract(folderpath));
          })
          // Write the compressed file to the host directory.
          .pipe(fs.createWriteStream(folderpath));
      } else {
        res.attachment(origFilename || key);
        fileStream
          .once('error', (err: AWSError): void => {
            if (err.name === 'NoSuchKey') {
              winstonLogger.debug('Requested file %s not found.', origFilename);
              res.status(404);
              resolve(null);
            } else if (err.name === 'TimeoutError') {
              winstonLogger.debug('Connection closed by timeout event.');
              res.end();
              resolve(null);
            } else {
              winstonLogger.debug('S3 connection failed: %s.', JSON.stringify(err));
              reject(err);
              throw err;
            }
          })
          // Wait for 'end' event for readable stream.
          .once('end', (): void => {
            resolve(null);
          })
          .pipe(res);
      }
    } catch (err: unknown) {
      reject();
      next(new ErrorHandler(500, `Download of [${origFilename}] failed in downloadFromStorage(): ${err}`));
    }
  });
};

/**
 * Download all files related to an educational material as a bundled ZIP file.
 * @param req  Request<any>
 * @param res  Response<any>
 * @param next NextFunction
 */
export const downloadAllMaterialsCompressed = async (
  req: Request,
  res: Response,
  next: NextFunction,
): Promise<void> => {
  // Queries to resolve files of the latest educational material version requested.
  const queryLatestPublished = `
    SELECT MAX(publishedat) AS max
    FROM versioncomposition
    WHERE educationalmaterialid = $1
  `;
  const queryVersionFilesIds = `
    SELECT r.filekey, r.originalfilename
    FROM versioncomposition vc
    RIGHT JOIN material m ON m.id = vc.materialid
    RIGHT JOIN record r ON r.materialid = m.id
    WHERE m.educationalmaterialid = $1 AND m.obsoleted = 0 AND vc.publishedat = $2
    UNION
    SELECT a.filekey, a.originalfilename
    FROM attachmentversioncomposition avc
    INNER JOIN attachment a ON a.id = avc.attachmentid
    WHERE avc.versioneducationalmaterialid = $1 AND avc.versionpublishedat = $2 AND a.obsoleted = 0
  `;
  const versionFiles: {
    filekey: string;
    originalfilename: string;
  }[] = await db.task(async (t: any): Promise<any[]> => {
    let publishedAt: string = req.params.publishedat;
    if (!publishedAt) {
      const latestPublished: { max: string } = await t.oneOrNone(queryLatestPublished, req.params.edumaterialid);
      publishedAt = latestPublished.max;
    }
    return await db.any(queryVersionFilesIds, [req.params.edumaterialid, publishedAt]);
  });
  const fileKeys: string[] = [];
  const fileNames: EntryData[] = [];
  for (const versionFile of versionFiles) {
    fileKeys.push(versionFile.filekey);
    fileNames.push({
      name: versionFile.originalfilename as string,
    });
  }
  res.header('Content-Disposition', 'attachment; filename=materials.zip');
  // Downstream files from the object storage and zip the bundle.
  await downloadAndZipFromStorage(req, res, next, fileKeys, fileNames).catch((err): void => {
    throw err;
  });
  // Update the download counter.
  const educationalMaterialId: number = parseInt(req.params.edumaterialid, 10);
  if (!req.isAuthenticated() || !(await hasAccesstoPublication(educationalMaterialId, req))) {
    try {
      await updateDownloadCounter(educationalMaterialId.toString());
    } catch (err) {
      winstonLogger.error('Updating download counter failed: %o', err);
    }
  }
};

/**
 * Stream and combine files from the object storage to a compressed zip file.
 *
 * @param req   Request<any>
 * @param res   Response<any>
 * @param next  NextFunction
 * @param keys  string[] Array of object storage keys
 * @param files string[] Array of file names
 */
export const downloadAndZipFromStorage = (
  req: Request,
  res: Response,
  next: NextFunction,
  keys: string[],
  files: EntryData[],
): Promise<void> => {
  return new Promise((resolve, reject): void => {
    const s3: S3Client = new S3Client({
      credentials: {
        accessKeyId: process.env.CLOUD_STORAGE_ACCESS_KEY,
        secretAccessKey: process.env.CLOUD_STORAGE_ACCESS_SECRET,
      },
      endpoint: process.env.CLOUD_STORAGE_API,
      region: process.env.CLOUD_STORAGE_REGION,
    } as S3ClientConfig);
    const bucket = process.env.CLOUD_STORAGE_BUCKET;
    try {
      s3Zip
        .archive(
          { s3, bucket } as ArchiveOptions,
          undefined as string | undefined,
          keys as string[],
          files as EntryData[],
        )
        .pipe(res)
        .on('finish', (): void => {
          resolve();
        })
        .on('error', (err: Error): void => {
          reject(err);
        });
    } catch (err) {
      reject(err);
    }
  });
};

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
    winstonLogger.debug('The folderpath that came to the unZipandExtract function: ' + zipFolder);
    // const filenameParsed = zipFolder.substring(0, zipFolder.lastIndexOf("/"));
    const filenameParsedNicely = zipFolder.slice(0, -4);
    winstonLogger.debug('Hopefully the filename is parsed corectly: ' + filenameParsedNicely);
    // winstonLogger.debug("The filenameParsed: " + filenameParsed);
    winstonLogger.debug('Does the file exist? : ' + fs.existsSync(zipFolder));
    const zip = new ADMzip(zipFolder);
    // Here we remove the ext from the file, eg. python.zip --> python, so that we can name the folder correctly
    // const folderPath = process.env.HTML_FOLDER + "/" + filename;
    // Here we finally extract the zipped file to the folder we just specified.
    // const zipEntries = zip.getEntries();
    // zipEntries.forEach(function (zipEntry) {
    //     winstonLogger.debug(zipEntry.getData().toString("utf8"));
    // });
    zip.extractAllTo(filenameParsedNicely, true);

    const pathToReturn = zipFolder + '/index.html';
    winstonLogger.debug('The pathtoreturn: ' + pathToReturn);
    const results = searchRecursive(filenameParsedNicely, 'index.html');
    if (Array.isArray(results) && results.length) {
      winstonLogger.debug('The results: ' + results);
      return results[0];
    }
    const resultshtm = searchRecursive(filenameParsedNicely, 'index.htm');
    if (Array.isArray(resultshtm) && resultshtm.length) {
      winstonLogger.debug('The resultshtm: ' + resultshtm);
      return resultshtm[0];
    } else {
      winstonLogger.debug('the unzipandextract returns false');
      return false;
    }
  } catch (err) {
    winstonLogger.debug('The error in unzipAndExtract function for HTML zip: ' + err);
    return false;
  }
}

export default {
  uploadMaterial,
  uploadFileToLocalDisk,
  uploadFileToMaterial,
  uploadFileToStorage,
  downloadPreviewFile,
  downloadFile,
  unZipAndExtract,
  downloadFileFromStorage,
  downloadAllMaterialsCompressed,
  checkTemporaryRecordQueue,
  uploadBase64FileToStorage,
  uploadAttachmentToMaterial,
  checkTemporaryAttachmentQueue,
  insertDataToDisplayName,
  upsertMaterialDisplayName,
  upsertMaterialFileToTempRecords,
  downloadFromStorage,
  directoryDownloadFromStorage,
};
