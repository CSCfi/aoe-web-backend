import * as H5P from "h5p-nodejs-library";
import path = require("path");
import { lookup as mimeLookup } from "mime-types";
import { Request, Response, NextFunction } from "express";
import h5pAjaxExpressRouter from "h5p-nodejs-library/build/src/adapters/H5PAjaxRouter/H5PAjaxExpressRouter";
import { readStreamFromStorage } from "./../queries/fileHandling";
import { ErrorHandler } from "./../helpers/errorHandler";
import { resolve } from "bluebird";
// import { H5P } from "h5p-standalone";

console.log("This is H5P: " + H5P);
const config = new H5P.H5PConfig();
// const config = await new H5P.H5PConfig(new H5P.fsImplementations.InMemoryStorage());
console.log("This is config: " + JSON.stringify(config));
config.contentFilesUrl = "/opt/sources/h5p/content";
export const h5pEditor: H5P.H5PEditor = H5P.fs(
    config,
    path.resolve("h5p/libraries"), // the path on the local disc where libraries should be stored
    path.resolve("h5p/temporary-storage"), // the path on the local disc where temporary files (uploads) should be stored
    path.resolve("h5p/content") // the path on the local disc where content is stored
);
export async function play(req: Request, res: Response, next: NextFunction) {
    try {
    const page = await startH5Pplayer(req.params.contentid);
    console.log("RETURNING PAGE ############################################");
    res.send(page);
    console.log("RETURNING 200");
    res.status(200).end();
    // res.status(200).json({});
    }
    catch (error) {
        console.error(error);
        next(new ErrorHandler(500, "Issue playing h5p"));
    }
}

export async function getH5PContent(req: Request, res: Response) {
    try {
        console.log(req.params.id);
        console.log(req.params.file);
        const user = {
            canCreateRestricted: false,
            canInstallRecommended: false,
            canUpdateAndInstallLibraries: false,
            id: req.params.id,
            name: "aoerobot",
            type: "local"
        };
        req.user = user;
        console.log(req.user);
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

export async function ajaxRoute(req: Request, res: Response) {
    const config = new H5P.H5PConfig();
    // const config = await new H5P.H5PConfig(new H5P.fsImplementations.InMemoryStorage());
    console.log("This is config: " + JSON.stringify(config));
    config.contentFilesUrl = "/opt/sources/h5p/content";
    const h5pEditor: H5P.H5PEditor = await H5P.fs(
        config,
        path.resolve("h5p/libraries"), // the path on the local disc where libraries should be stored
        path.resolve("h5p/temporary-storage"), // the path on the local disc where temporary files (uploads) should be stored
        path.resolve("h5p/content") // the path on the local disc where content is stored
    );
    const router =  await h5pAjaxExpressRouter(
        h5pEditor, // an H5P.H5PEditor object
        path.resolve("h5p/core"), // the path to the h5p core files (of the player)
        path.resolve("h5p/editor"), // the path to the h5p core files (of the editor)
        // routeOptions, // the options are optional and can be left out
        // languageOverride // (optional) can be used to override the language used by i18next http middleware
    );
    console.log("Router: " + router);
    res.status(200).json({});
}
export async function startH5Pplayer(contentid: string) {
    return new Promise(async (resolve) => {
    const fs = require("fs");
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
    // let data;
    const stream = await readStreamFromStorage(params);
    stream.pipe(fs.createWriteStream("/opt/sources/htmlfiles/testii.h5p"));
    // stream.on("data", function(chunk) {
    //     data += chunk;
    // });
    let page;
    // return new Promise(async (resolve) {

    stream.on("end", async function() {
        console.log("We finished the zipstream!");
    // const data = await fs.readFileSync("/opt/sources/htmlfiles/oer_harjoitukset.h5p");
    const data = await fs.readFileSync("/opt/sources/htmlfiles/testii.h5p");
    console.log("uploading package #####################################");
    const options = {
        "onlyInstallLibraries": false
    };
    const result = await h5pEditor.uploadPackage(data, user, options);
    console.log(result);
    console.log(JSON.stringify(result));

    const saveresult = await h5pEditor.saveOrUpdateContent(
        undefined,
        result.parameters,
        result.metadata,
        H5P.LibraryName.toUberName(result.metadata.preloadedDependencies[0], {
            useWhitespace: true
        }),
        user
    );
    console.log("mainlaibrary: " +  H5P.LibraryName.toUberName(result.metadata.preloadedDependencies[0]));
    // const saveresult = await h5pEditor.saveOrUpdateContent(contentid, result.parameters, result.metadata, "H5P.Flashcards-1.5", user);
    console.log("saveresult: " + JSON.stringify(saveresult));
    contentid = saveresult;
    console.log("does exist: " + await h5pEditor.contentStorage.contentExists(contentid));
    console.log("This is getParameters: #############################");
    console.log(await h5pEditor.contentStorage.getParameters(contentid));
    console.log("This is getMetadata: #############################");
    console.log(await h5pEditor.contentStorage.getMetadata(contentid, user));
    console.log(h5pEditor.libraryStorage);
    console.log(h5pEditor.contentStorage);
    const h5pPlayer = new H5P.H5PPlayer(
        h5pEditor.libraryStorage,
        h5pEditor.contentStorage,
        config
    );
    const content = result.parameters;
    // const content = {"cards": [{"image": {"path": "images\/image-59a037121bad0.png", "mime": "image\/png", "copyright": {"license": "PD", "source": "https:\/\/www.pexels.com\/photo\/citrus-fruit-close-up-color-eat-531621\/", "author": "Pixabay", "title": "citrus-fruit-close-up-color-eat", "version": "CC0 1.0"}, "width": 889, "height": 594}, "answer": "Lime", "tip": "", "text": "Green, sour fruit...."}, {"answer": "Cherry", "image": {"path": "images\/image-59a0371b56723.png", "mime": "image\/png", "copyright": {"license": "PD", "source": "https:\/\/www.pexels.com\/photo\/fruit-cherries-109274\/", "version": "CC0 1.0", "title": "Red Cherry Fruit", "author": "Lisa Fotios"}, "width": 889, "height": 594}, "tip": "", "text": "Can be both sweet and sour...."}, {"answer": "Strawberry", "image": {"path": "images\/image-59a035ebb555c.png", "mime": "image\/png", "copyright": {"license": "PD", "source": "https:\/\/www.pexels.com\/photo\/food-healthy-red-sweet-59945\/", "version": "CC0 1.0", "author": "Pixabay", "title": "Red and Green Strawberry Fruit"}, "width": 889, "height": 594}, "tip": "", "text": "Sweet red berry...."}, {"answer": "Orange", "image": {"path": "images\/image-59a0375b08a24.png", "mime": "image\/png", "copyright": {"license": "PD", "source": "https:\/\/www.pexels.com\/photo\/orange-lemon-fruit-vitamins-52533\/", "version": "CC0 1.0", "title": "Orange Fruit", "author": "Pixabay"}, "width": 889, "height": 594}, "tip": "", "text": "Sour orange fruit..."}, {"image": {"path": "images\/image-59a038bbd91de.png", "mime": "image\/png", "copyright": {"license": "PD", "title": "Green Apple Photo", "author": "Pixabay", "source": "https:\/\/www.pexels.com\/photo\/apple-green-pallet-pulpwood-green-food-63253\/", "version": "CC0 1.0"}, "width": 889, "height": 594}, "answer": "Apple", "tip": "", "text": "Healthy green or red..."}], "progressText": "Card @card of @total", "next": "Next", "previous": "Previous", "checkAnswerText": "Check", "showSolutionsRequiresInput": true, "defaultAnswerText": "Your answer", "correctAnswerText": "Correct", "incorrectAnswerText": "Incorrect", "showSolutionText": "Correct answer", "results": "Results", "ofCorrect": "@score of @total correct", "showResults": "Show results", "answerShortText": "A:", "retry": "Retry", "caseSensitive": false, "description": "Which fruit is this?"};
    const h5pfile = {"title": "Flashcards", "language": "und", "mainLibrary": "H5P.Flashcards", "embedTypes": ["div"], "license": "U", "preloadedDependencies": [{"machineName": "H5P.Flashcards", "majorVersion": "1", "minorVersion": "5"}, {"machineName": "FontAwesome", "majorVersion": "4", "minorVersion": "5"}, {"machineName": "H5P.FontIcons", "majorVersion": "1", "minorVersion": "0"}, {"machineName": "H5P.JoubelUI", "majorVersion": "1", "minorVersion": "3"}, {"machineName": "H5P.Transition", "majorVersion": "1", "minorVersion": "0"}, {"machineName": "Drop", "majorVersion": "1", "minorVersion": "0"}, {"machineName": "Tether", "majorVersion": "1", "minorVersion": "0"}]};
    page = await h5pPlayer.render(contentid, content);
    console.log("page: " + page);
    resolve(page);
    });
    // console.log("ala page")
    // return page;
}
    catch (error) {
        throw new Error(error);
    }

});
}
