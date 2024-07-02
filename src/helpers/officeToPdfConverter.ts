import config from '@/config';
import { downloadFromStorage, uploadFileToStorage } from '@query/fileHandling';
import { s3 } from '@resource/awsClient';
import { db } from '@resource/postgresClient';
import winstonLogger from '@util/winstonLogger';
import { NextFunction, Request, Response } from 'express';
import fs, { WriteStream } from 'fs';
import fsPromise from 'fs/promises';
import libre from 'libreoffice-convert';
import stream from 'stream';
import { ErrorHandler } from './errorHandler';

const officeMimeTypes = [
  // .doc
  'application/msword',
  // .dot
  'application/msword',
  // .docx
  'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
  // .dotx
  'application/vnd.openxmlformats-officedocument.wordprocessingml.template',
  // .docm
  'application/vnd.ms-word.document.macroEnabled.12',
  // .dotm
  'application/vnd.ms-word.template.macroEnabled.12',
  // .xls
  'application/vnd.ms-excel',
  // .xlt
  'application/vnd.ms-excel',
  // .xla
  'application/vnd.ms-excel',
  // .xlsx
  'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
  // .xltx
  'application/vnd.openxmlformats-officedocument.spreadsheetml.template',
  // .xlsm
  'application/vnd.ms-excel.sheet.macroEnabled.12',
  // .xltm
  'application/vnd.ms-excel.template.macroEnabled.12',
  // .xlam
  'application/vnd.ms-excel.addin.macroEnabled.12',
  // .xlsb
  'application/vnd.ms-excel.sheet.binary.macroEnabled.12',
  // .ppt
  'application/vnd.ms-powerpoint',
  // .pot
  'application/vnd.ms-powerpoint',
  // .pps
  'application/vnd.ms-powerpoint',
  // .ppa
  'application/vnd.ms-powerpoint',
  // .pptx
  'application/vnd.openxmlformats-officedocument.presentationml.presentation',
  // .potx
  'application/vnd.openxmlformats-officedocument.presentationml.template',
  // .ppsx
  'application/vnd.openxmlformats-officedocument.presentationml.slideshow',
  // .ppam
  'application/vnd.ms-powerpoint.addin.macroEnabled.12',
  // .pptm
  'application/vnd.ms-powerpoint.presentation.macroEnabled.12',
  // .potm
  'application/vnd.ms-powerpoint.template.macroEnabled.12',
  // .ppsm
  'application/vnd.ms-powerpoint.slideshow.macroEnabled.12',
  // .mdb
  'application/vnd.ms-access',
  // openoffice
  'application/rtf',
  'application/vnd.oasis.opendocument.text',
  'application/vnd.oasis.opendocument.spreadsheet',
  'application/vnd.oasis.opendocument.presentation',
  'application/vnd.oasis.opendocument.graphics',
  'application/vnd.oasis.opendocument.chart',
  'application/vnd.oasis.opendocument.formula',
  'application/vnd.oasis.opendocument.image',
  'application/vnd.oasis.opendocument.text-master',
  'application/vnd.oasis.opendocument.text-template',
  'application/vnd.oasis.opendocument.spreadsheet-template',
  'application/vnd.oasis.opendocument.presentation-template',
  'application/vnd.oasis.opendocument.graphics-template',
  'application/vnd.oasis.opendocument.chart-template',
  'application/vnd.oasis.opendocument.formula-template',
  'application/vnd.oasis.opendocument.image-template',
  'application/vnd.oasis.opendocument.text-web',
];

/**
 * Check if a file mimetype is an office format.
 * @param {string} s
 * @return {boolean}
 */
export const isOfficeMimeType = (s: string): boolean => {
  return officeMimeTypes.indexOf(s) >= 0;
};

/**
 * @param {e.Request} req
 * @param {e.Response} res
 * @param {e.NextFunction} next
 * @return {Promise<void>}
 */
export const downloadPdfFromAllas = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
  try {
    if (!req.params.key) {
      next(new ErrorHandler(400, 'key missing'));
    }
    const params = {
      Bucket: config.CLOUD_STORAGE_CONFIG.bucketPDF,
      Key: req.params.key,
    };
    await downloadFromStorage(req, res, next, params, req.params.key);
  } catch (error) {
    winstonLogger.error(error);
    next(new ErrorHandler(error.statusCode, 'Issue showing pdf'));
  }
};

// export async function convertOfficeToPdf(req: Request, res: Response, next: NextFunction) {
//     try {
//         if (!req.params.key) {
//             next(new ErrorHandler("400", "key missing"));
//         }
//         winstonLogger.debug("readstreamfrompouta");
//         const params = {
//             "Bucket" : process.env.BUCKET_NAME,
//             "Key" : req.params.key
//         };
//         const folderpath = process.env.HTML_FOLDER + "/" + req.params.key;
//         const filename = req.params.key.substring(0, req.params.key.lastIndexOf(".")) + ".pdf";
//         winstonLogger.debug("filename: " + filename);
//         const stream = await directoryDownloadFromStorage(params);
//         stream.on("error", function(e) {
//             winstonLogger.error(e);
//             next(new ErrorHandler(e.statusCode, e.message || "Error in download"));
//         });
//         stream.pipe(fs.createWriteStream(folderpath));
//         stream.on("end", async function() {
//             try {
//             winstonLogger.debug("starting convertOfficeFileToPDF");
//             winstonLogger.debug(folderpath);
//             winstonLogger.debug(filename);
//             const path = await convertOfficeFileToPDF(folderpath, filename);
//             winstonLogger.debug("starting createReadStream: " + path);
//             const readstream = fs.createReadStream(path);
//             readstream.on("error", function(e) {
//                 winstonLogger.error(e);
//                 next(new ErrorHandler(e.statusCode, "Error in sending pdf"));
//             });
//             res.header("Content-Disposition", contentDisposition(filename));
//             readstream.pipe(res);
//             // res.status(200).json(d);
//             // outstream.pipe(res);
//             }
//             catch (error) {
//                 winstonLogger.error(error);
//                 next(new ErrorHandler(error.statusCode, "Issue showing pdf"));
//             }
//         });
//     }
//     catch (error) {
//         winstonLogger.error(error);
//         next(new ErrorHandler(error.statusCode, "Issue showing pdf"));
//     }
// }

/**
 * Convert an office format file to PDF format.
 * @param {string} filepath File path of the original office format file.
 * @param {string} filename File name of the original office file.
 * @return {Promise<string>} File path of the converted PDF.
 */
export const convertOfficeFileToPDF = (filepath: string, filename: string): Promise<string> => {
  const extension = 'pdf';
  const outputPath = `${config.MEDIA_FILE_PROCESS.htmlFolder}/${filename}`;

  return new Promise((resolve, reject) => {
    try {
      const file = fs.readFileSync(filepath);
      libre.convert(file, extension, undefined, async (err: Error, data: Buffer) => {
        if (err) {
          winstonLogger.error('Converting an office file to PDF failed in convertOfficeFileToPDF()');
          return reject(err);
        }
        await fsPromise.writeFile(outputPath, data);
        return resolve(outputPath);
      });
    } catch (err) {
      winstonLogger.error('Error in convertOfficeFileToPDF(): %o', err);
      return reject(err);
    }
  });
};

/**
 * Scheduled process to collect the office file materials without a PDF conversion,
 * create the missing PDF conversions and upstream them to the cloud object storage.
 * {@link src/util/aoeScheduler.ts}
 * @return {Promise<void>}
 */
export const scheduledConvertAndUpstreamOfficeFilesToCloudStorage = async (): Promise<void> => {
  try {
    // Fetch the office files without a PDF conversion.
    const files = await getFilesWithoutPDF();

    for (let index = 0; index < files.length; index++) {
      const file = files[index];

      if (isOfficeMimeType(file.mimetype)) {
        const pdfKey: string = file.filekey.substring(0, file.filekey.lastIndexOf('.')) + '.pdf';
        downstreamAndConvertOfficeFileToPDF(file.filekey).then((path: string) => {
          uploadFileToStorage(path, pdfKey, config.CLOUD_STORAGE_CONFIG.bucketPDF).then((obj: any) => {
            void updatePdfKey(obj.Key, file.id);
          });
        });
      }
    }
  } catch (err) {
    throw new Error(err);
  }
};

export const getFilesWithoutPDF = async (): Promise<any> => {
  try {
    return await db.task(async (t: any) => {
      const query = `
        SELECT id, filepath, mimetype, filekey, filebucket, pdfkey
        FROM record
        WHERE filekey IS NOT NULL AND pdfkey IS NULL
        ORDER BY id
      `;
      return await t.any(query);
    });
  } catch (err: unknown) {
    winstonLogger.error('Fetching files without PDFs failed: %o', err);
    throw err;
  }
};

/**
 * Downstream a stored office file from the cloud storage and convert it to PDF format.
 * @param {string} key - File name in the cloud storage.
 * @return {Promise<string>} File path of the converted PDF.
 */
export const downstreamAndConvertOfficeFileToPDF = (key: string): Promise<string> => {
  return new Promise<string>((resolve, reject) => {
    const folderpath = `${config.MEDIA_FILE_PROCESS.htmlFolder}/${key}`;
    const filename: string = key.substring(0, key.lastIndexOf('.')) + '.pdf';
    const stream: stream = s3
      .getObject({
        Bucket: config.CLOUD_STORAGE_CONFIG.bucket,
        Key: key,
      })
      .createReadStream();
    const ws: WriteStream = fs
      .createWriteStream(folderpath)
      .on('close', async (): Promise<void> => {
        try {
          const path: string = await convertOfficeFileToPDF(folderpath, filename);
          return resolve(path);
        } catch (e) {
          winstonLogger.error('Error catch when trying to convertOfficeFileToPDF()');
          return reject(e);
        }
      })
      .on('error', (err: Error): void => {
        reject(err);
      });
    stream
      .on('error', (err): void => {
        reject(err);
        winstonLogger.error('Error in downstreamAndConvertOfficeFileToPDF(): %o', err);
      })
      .pipe(ws);
  });
};

/**
 * @param {string} key
 * @param {string} id
 * @return {Promise<any>}
 */
export const updatePdfKey = async (key: string, id: string): Promise<void> => {
  await db.tx(async (t: any): Promise<void> => {
    const query = `
      UPDATE record SET pdfkey = $1
      WHERE id = $2
    `;
    await t.none(query, [key, id]);
  });
};
