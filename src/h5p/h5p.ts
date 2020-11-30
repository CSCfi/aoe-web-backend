import * as H5P from "h5p-nodejs-library";
import path = require("path");
import { lookup as mimeLookup } from "mime-types";
import { Request, Response, NextFunction } from "express";
import h5pAjaxExpressRouter from "h5p-nodejs-library/build/src/adapters/H5PAjaxRouter/H5PAjaxExpressRouter";
import { readStreamFromStorage } from "./../queries/fileHandling";
import { ErrorHandler } from "./../helpers/errorHandler";
import { resolve, reject } from "bluebird";
// import { H5P } from "h5p-standalone";
const fs = require("fs");

console.log("This is H5P: " + H5P);
const config = new H5P.H5PConfig();
// const config = await new H5P.H5PConfig(new H5P.fsImplementations.InMemoryStorage());
config.baseUrl = process.env.H5P_BASE_URL || "/h5p";
console.log("This is config: " + JSON.stringify(config));
// config.contentFilesUrl = "/opt/sources/h5p/content";
export const h5pEditor: H5P.H5PEditor = H5P.fs(
    config,
    process.env.H5P_LIBRARY_PATH || path.resolve("h5p/libraries"), // the path on the local disc where libraries should be stored
    process.env.H5P_TEMPORARY_STORAGE_PATH || path.resolve("h5p/temporary-storage"), // the path on the local disc where temporary files (uploads) should be stored
    process.env.H5P_CONTENT_PATH || path.resolve("h5p/content") // the path on the local disc where content is stored
);
export async function play(req: Request, res: Response, next: NextFunction) {
    try {
        console.log("Starting startH5Pplayer");
        const page = await startH5Pplayer(req.params.contentid);
        console.log("RETURNING PAGE ############################################");
        res.send(page);
        console.log("RETURNING 200");
        res.status(200).end();
    }
    catch (error) {
        console.error(error);
        next(new ErrorHandler(error.statusCode, "Issue playing h5p"));
    }
}

export async function getH5PContent(req: Request, res: Response) {
    try {
        console.log(req.params.id);
        console.log(req.params.file);
        const user = {
            canCreateRestricted: true,
            canInstallRecommended: true,
            canUpdateAndInstallLibraries: true,
            id: req.params.id,
            name: "aoerobot",
            type: "local"
        };
        req.user = user;
        const stats = await h5pEditor.contentStorage.getFileStats(
            req.params.id,
            req.params.file,
            user
        );
        const contentLength = stats.size;
        const readStream = await h5pEditor.getContentFileStream(req.params.id,
            req.params.file,
            user);
        const contentType = mimeLookup(req.params.file) || "application/octet-stream";
        if (contentLength) {
            res.writeHead(200, {
                "Content-Type": contentType,
                "Content-Length": contentLength,
                "Accept-Ranges": "bytes"
            });
        } else {
            res.type(contentType);
        }
        readStream.on("error", (err) => {
            res.status(404).end();
        });
        readStream.pipe(res);
    }
    catch (error) {
        console.log(error);
        res.status(404);
    }
}

export async function startH5Pplayer(contentid: string) {
    return new Promise(async (resolve, reject) => {
    try {
    const user = {
        canCreateRestricted: true,
        canInstallRecommended: true,
        canUpdateAndInstallLibraries: true,
        id: contentid,
        name: "aoe robot",
        type: "local"
    };
    const params = {
        "Bucket" : process.env.BUCKET_NAME,
        "Key" : contentid
    };
    const stream = await readStreamFromStorage(params);
    const filepath = process.env.HTMLFOLDER + "/" + contentid;
    let page;
    stream.on("error", async (e) => {
        console.log("Issue getting readstream from Allas. Try from backup data");
        console.error(e);
        try {
            const path = process.env.BACK_UP_PATH + contentid;
            page = await renderH5Ppage(contentid, path);
            resolve(page);
        }
        catch (e) {
            console.log("Issue reading file from backup");
            console.error(e);
            reject(e);
        }
    });
    stream.pipe(fs.createWriteStream(filepath));
    stream.on("end", async function() {
        try {
            // console.log("We finished the zipstream!");
            // const data = await fs.readFileSync(filepath);
            // console.log("uploading h5p package #####################################");
            // const options = {
            //     "onlyInstallLibraries": false
            // };
            // const result = await h5pEditor.uploadPackage(data, user, options);
            // console.log("saving h5p package");
            // let mainlib;
            // for (const lib of result.metadata.preloadedDependencies) {
            //     if (lib.machineName == result.metadata.mainLibrary) {
            //         mainlib = lib;
            //     }
            // }

            // const saveresult = await h5pEditor.saveOrUpdateContent(
            //     undefined,
            //     result.parameters,
            //     result.metadata,
            //     H5P.LibraryName.toUberName(mainlib, {useWhitespace: true}),
            //     user
            // );
            // contentid = saveresult;
            // const h5pPlayer = new H5P.H5PPlayer(
            //     h5pEditor.libraryStorage,
            //     h5pEditor.contentStorage,
            //     config
            // );
            // // const content = result.parameters;
            // console.log("rendering h5p page: " + contentid);
            // // page = await h5pPlayer.render(contentid, content);
            // page = await h5pPlayer.render(contentid);
            page = await renderH5Ppage(contentid, filepath);
            resolve(page);
        }
        catch (error) {
            reject(error);
        }
    });
}
    catch (error) {
        reject(error);
    }

});
}
/**
 *
 * @param contentid
 * @param filepath
 * renders H5P page from H5p file in filepath
 */
export async function renderH5Ppage(contentid: string, filepath: string) {
    try {
        const user = {
            canCreateRestricted: true,
            canInstallRecommended: true,
            canUpdateAndInstallLibraries: true,
            id: contentid,
            name: "aoe robot",
            type: "local"
        };
        console.log("We finished the zipstream!");
        const data = await fs.readFileSync(filepath);
        console.log("uploading h5p package #####################################");
        const options = {
            "onlyInstallLibraries": false
        };
        const result = await h5pEditor.uploadPackage(data, user, options);
        console.log("saving h5p package");
        let mainlib;
        for (const lib of result.metadata.preloadedDependencies) {
            if (lib.machineName == result.metadata.mainLibrary) {
                mainlib = lib;
            }
        }
        const saveresult = await h5pEditor.saveOrUpdateContent(
            undefined,
            result.parameters,
            result.metadata,
            H5P.LibraryName.toUberName(mainlib, {useWhitespace: true}),
            user
        );
        contentid = saveresult;
        const h5pPlayer = new H5P.H5PPlayer(
            h5pEditor.libraryStorage,
            h5pEditor.contentStorage,
            config
        );
        // const content = result.parameters;
        console.log("rendering h5p page: " + contentid);
        // page = await h5pPlayer.render(contentid, content);
        const page = await h5pPlayer.render(contentid);
        return page;
    }
    catch (error) {
        throw new Error(error);
    }
}
