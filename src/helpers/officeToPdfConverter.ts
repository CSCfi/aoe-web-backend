import { Request, Response, NextFunction } from "express";
import { ErrorHandler } from "./errorHandler";
import { readStreamFromStorage } from "./../queries/fileHandling";
const contentDisposition = require("content-disposition");

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

export async function isOfficeMimeType(s: string) {
    if (officeMimeTypes.indexOf(s) >= 0) {
        return true;
    }
    else {
        return false;
    }

}

export async function convertOfficeToPdf(req: Request, res: Response, next: NextFunction) {
    try {
        if (!req.params.key) {
            next(new ErrorHandler("400", "key missing"));
        }
        console.log("readstreamfrompouta");
        const params = {
            "Bucket" : process.env.BUCKET_NAME,
            "Key" : req.params.key
        };
        const folderpath = process.env.HTMLFOLDER + "/" + req.params.key;
        const filename = req.params.key.substring(0, req.params.key.lastIndexOf(".")) + ".pdf";
        console.log("filename: " + filename);
        const stream = await readStreamFromStorage(params);
        stream.on("error", function(e) {
            console.error(e);
            next(new ErrorHandler(e.statusCode, e.message || "Error in download"));
        });
        stream.pipe(fs.createWriteStream(folderpath));
        stream.on("end", async function() {
            try {
            console.log("officeToPdf");
            console.log(folderpath);
            console.log(filename);
            const path = await officeToPdf(folderpath, filename, res);
            console.log("starting createReadStream: " + path);
            const readstream = fs.createReadStream(path);
            readstream.on("error", function(e) {
                console.error(e);
                next(new ErrorHandler(e.statusCode, "Error in sending pdf"));
            });
            res.header("Content-Disposition", contentDisposition(filename));
            readstream.pipe(res);
            // res.status(200).json(d);
            // outstream.pipe(res);
            }
            catch (error) {
                console.error(error);
                next(new ErrorHandler(error.statusCode, "Issue showing pdf"));
            }
        });
    }
    catch (error) {
        console.error(error);
        next(new ErrorHandler(error.statusCode, "Issue showing pdf"));
    }
}
export async function officeToPdf(filepath: string, filename: string, res: Response) {
    try {
        console.log("in officeToPdf");
        const extend = "pdf";
        const file = fs.readFileSync(filepath);
        console.log(filepath);
        const outputPath = path.join(process.env.HTMLFOLDER + filename);
        console.log("Strating officeToPdf");
        const promise = new Promise((resolve, reject) => {
            libre.convert(file, extend, undefined, (err, done) => {
                if (err) {
                    console.error("Error converting file:" + err);
                    return reject(err);
                }
                console.log("officeToPdf write to file: " + outputPath);
                fs.writeFileSync(outputPath, done);
                console.log("officeToPdf writing to file done");
                return resolve(outputPath);
            });
        });
        return promise;
    }
    catch (error) {
        console.log("officeToPdf error");
        throw new Error(error);
    }
}