import { Request, Response, NextFunction } from "express";
import { ErrorHandler } from "./errorHandler";
import { readStreamFromStorage, uploadFileToStorage, downloadFromStorage } from "./../queries/fileHandling";
import { winstonLogger } from '../util';
import rdbms from '../resources/pg-connect';

const contentDisposition = require("content-disposition");
const pgp = rdbms.pgp;
const db = rdbms.db;

const libre = require("libreoffice-convert");
const path = require("path");
const fs = require("fs");
const officeMimeTypes = [
    // .doc
    "application/msword",
    // .dot
    "application/msword",
    // .docx
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    // .dotx
    "application/vnd.openxmlformats-officedocument.wordprocessingml.template",
    // .docm
    "application/vnd.ms-word.document.macroEnabled.12",
    // .dotm
    "application/vnd.ms-word.template.macroEnabled.12",
    // .xls
    "application/vnd.ms-excel",
    // .xlt
    "application/vnd.ms-excel",
    // .xla
    "application/vnd.ms-excel",
    // .xlsx
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
    // .xltx
    "application/vnd.openxmlformats-officedocument.spreadsheetml.template",
    // .xlsm
    "application/vnd.ms-excel.sheet.macroEnabled.12",
    // .xltm
    "application/vnd.ms-excel.template.macroEnabled.12",
    // .xlam
    "application/vnd.ms-excel.addin.macroEnabled.12",
    // .xlsb
    "application/vnd.ms-excel.sheet.binary.macroEnabled.12",

    // .ppt
    "application/vnd.ms-powerpoint",
    // .pot
    "application/vnd.ms-powerpoint",
    // .pps
    "application/vnd.ms-powerpoint",
    // .ppa
    "application/vnd.ms-powerpoint",

    // .pptx
    "application/vnd.openxmlformats-officedocument.presentationml.presentation",
    // .potx
    "application/vnd.openxmlformats-officedocument.presentationml.template",
    // .ppsx
    "application/vnd.openxmlformats-officedocument.presentationml.slideshow",
    // .ppam
    "application/vnd.ms-powerpoint.addin.macroEnabled.12",
    // .pptm
    "application/vnd.ms-powerpoint.presentation.macroEnabled.12",
    // .potm
    "application/vnd.ms-powerpoint.template.macroEnabled.12",
    // .ppsm
    "application/vnd.ms-powerpoint.slideshow.macroEnabled.12",

    // .mdb
    "application/vnd.ms-access",
// openoffice
    "application/rtf",
    "application/vnd.oasis.opendocument.text",
    "application/vnd.oasis.opendocument.spreadsheet",
    "application/vnd.oasis.opendocument.presentation",
    "application/vnd.oasis.opendocument.graphics",
    "application/vnd.oasis.opendocument.chart",
    "application/vnd.oasis.opendocument.formula",
    "application/vnd.oasis.opendocument.image",
    "application/vnd.oasis.opendocument.text-master",
    "application/vnd.oasis.opendocument.text-template",
    "application/vnd.oasis.opendocument.spreadsheet-template",
    "application/vnd.oasis.opendocument.presentation-template",
    "application/vnd.oasis.opendocument.graphics-template",
    "application/vnd.oasis.opendocument.chart-template",
    "application/vnd.oasis.opendocument.formula-template",
    "application/vnd.oasis.opendocument.image-template",
    "application/vnd.oasis.opendocument.text-web"
];
/**
 *
 * @param s
 * check if office mime type
 */
export async function isOfficeMimeType(s: string) {
    if (officeMimeTypes.indexOf(s) >= 0) {
        return true;
    }
    else {
        return false;
    }

}

/**
 *
 * @param req
 * @param res
 * @param next
 * download pdf from allas
 */
export async function downloadPdfFromAllas (req: Request, res: Response, next: NextFunction) {
    try {
        if (!req.params.key) {
            next(new ErrorHandler(400, "key missing"));
        }
        const params = {
            "Bucket" : process.env.PDF_BUCKET_NAME,
            "Key" : req.params.key
        };
        await downloadFromStorage(req, res, next, params, req.params.key);
    }
    catch (error) {
        winstonLogger.error(error);
        next(new ErrorHandler(error.statusCode, "Issue showing pdf"));
    }
}
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
//         const folderpath = process.env.HTMLFOLDER + "/" + req.params.key;
//         const filename = req.params.key.substring(0, req.params.key.lastIndexOf(".")) + ".pdf";
//         winstonLogger.debug("filename: " + filename);
//         const stream = await readStreamFromStorage(params);
//         stream.on("error", function(e) {
//             winstonLogger.error(e);
//             next(new ErrorHandler(e.statusCode, e.message || "Error in download"));
//         });
//         stream.pipe(fs.createWriteStream(folderpath));
//         stream.on("end", async function() {
//             try {
//             winstonLogger.debug("starting officeToPdf");
//             winstonLogger.debug(folderpath);
//             winstonLogger.debug(filename);
//             const path = await officeToPdf(folderpath, filename);
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
 *
 * @param filepath
 * @param filename
 * try to convert file from filepath to pdf
 */
export async function officeToPdf(filepath: string, filename: string) {
    try {
        const extend = "pdf";
        const file = fs.readFileSync(filepath);
        winstonLogger.debug(filepath);
        winstonLogger.debug(filename);
        // const outputPath = path.join(process.env.HTMLFOLDER + filename);
        const outputPath = process.env.HTMLFOLDER + "/" + filename;
        const promise = new Promise<string>((resolve, reject) => {
            libre.convert(file, extend, undefined, (err, done) => {
                if (err) {
                    winstonLogger.error("Error converting file:" + err);
                    return reject(err);
                }
                winstonLogger.debug("officeToPdf write to file: " + outputPath);
                fs.writeFileSync(outputPath, done);
                winstonLogger.debug("officeToPdf writing to file done");
                return resolve(outputPath);
            });
        });
        return promise;
    }
    catch (error) {
        winstonLogger.debug("officeToPdf error");
        throw new Error(error);
    }
}
/**
 * send file to office bucket
 */
export async function officeFilesToAllasAsPdf() {
    try {
        const files = await getOfficeFiles();
        // for (const element of files) {
        for (let index = 0; index < files.length; index++) {
            const element = files[index];
            if (await isOfficeMimeType(element.mimetype) && !element.pdfkey) {
                winstonLogger.debug("Sending pdf to allas: " + element.id);
                try {
                    const path = await allasFileToPdf(element.filekey);
                    winstonLogger.debug("pdf file in path: " + path);
                    winstonLogger.debug("officeFilesToAllasAsPdf START SENDING PDF TO ALLAS");
                    const pdfkey = element.filekey.substring(0, element.filekey.lastIndexOf(".")) + ".pdf";
                    const obj: any = await uploadFileToStorage(path, pdfkey, process.env.PDF_BUCKET_NAME);
                    await updatePdfKey(obj.Key, element.id);
                }
                catch (e) {
                    winstonLogger.error(e);
                }
            }
        }
    }
    catch (error) {
        winstonLogger.error(error);
    }
}
/**
 * get to record table
 */
export async function getOfficeFiles() {
    try {
        return await db.task(async (t: any) => {
            const query = "select id, filepath, mimetype, filekey, filebucket, pdfkey from record order by id;";
            winstonLogger.debug(query, [ ]);
            return await t.any(query);
        });

    }
    catch (error) {
        winstonLogger.error(error);
        throw new Error(error);
    }
}
/**
 *
 * @param key
 * read allas file and convert to pdf
 */
export async function allasFileToPdf(key: string) {
    try {
            return new Promise<string>(async (resolve, reject) => {
            const params = {
                "Bucket" : process.env.BUCKET_NAME,
                "Key" : key
            };
            const folderpath = process.env.HTMLFOLDER + "/" + key;
            const filename = key.substring(0, key.lastIndexOf(".")) + ".pdf";
            winstonLogger.debug("filename: " + filename);
            const stream = await readStreamFromStorage(params);
            stream.on("error", function(e) {
                winstonLogger.error("Error in allasFileToPdf readstream: " + e);
                reject(e);
            });

            const ws = fs.createWriteStream(folderpath);
            stream.pipe(ws);
            ws.on("error", function(e) {
                winstonLogger.error("Error in allasFileToPdf writestream: " + e);
                reject(e);
            });
            ws.on("finish", async function() {
                try {
                    winstonLogger.debug(folderpath);
                    winstonLogger.debug(filename);
                    const path = await officeToPdf(folderpath, filename);
                    winstonLogger.debug("PATH IS: " + path);
                    resolve(path);
                }
                catch (error) {
                    winstonLogger.error("allasFileToPdf error: " + error);
                    reject(error);
                }
            });
        });
    }
    catch (error) {
        winstonLogger.error("allasFileToPdf error");
        throw new Error(error);
    }
}

/**
 *
 * @param key
 * @param id
 * update pdf key column
 */
export async function updatePdfKey(key: string, id: string) {
    try {
        return await db.tx(async (t: any) => {
            const query = "UPDATE record SET pdfkey = $1 where id = $2;";
            winstonLogger.debug(query, [key, id]);
            return await t.any(query, [key, id]);
        });

    }
    catch (error) {
        winstonLogger.error(error);
        throw new Error(error);
    }
}

