import * as H5P from 'h5p-nodejs-library';
import path = require('path');
import { lookup as mimeLookup } from 'mime-types';
import { Request, Response, NextFunction } from 'express';
import { readStreamFromStorage } from '../queries/fileHandling';
import { ErrorHandler } from '../helpers/errorHandler';
import fs from 'fs';
import { ContentId, IUser } from "h5p-nodejs-library";
import { IContentMetadata, ILibraryInstallResult } from "h5p-nodejs-library/build/src/types";
import { winstonLogger } from '../util';

const config = new H5P.H5PConfig();

config.baseUrl = process.env.H5P_BASE_URL || '/h5p';

export const h5pEditor: H5P.H5PEditor = H5P.fs(
    config,
    process.env.H5P_LIBRARY_PATH || path.resolve('h5p/libraries'), // the path on the local disc where libraries should be stored
    process.env.H5P_TEMPORARY_STORAGE_PATH || path.resolve('h5p/temporary-storage'), // the path on the local disc where temporary files (uploads) should be stored
    process.env.H5P_CONTENT_PATH || path.resolve('h5p/content'), // the path on the local disc where content is stored
);

/**
 * Play H5P material.
 *
 * @param req
 * @param res
 * @param next
 */
export const play = async (req: Request, res: Response, next: NextFunction): Promise<any> => {
    try {
        const page = await startH5Pplayer(req.params.contentid);
        res.send(page);
        res.status(200).end();
    } catch (error) {
        winstonLogger.error(error);
        next(new ErrorHandler(error.statusCode, 'Issue playing h5p'));
    }
};

export async function getH5PContent(req: Request, res: Response): Promise<any> {
    try {
        const user = {
            canCreateRestricted: true,
            canInstallRecommended: true,
            canUpdateAndInstallLibraries: true,
            id: req.params.id,
            name: 'robot',
            type: 'local'
        };
        req.user = user;
        const stats = await h5pEditor.contentStorage.getFileStats(
            req.params.id,
            req.params.file,
            user
        );
        const contentLength = stats.size;
        const readStream = await h5pEditor.getContentFileStream(
            req.params.id,
            req.params.file,
            user
        );
        const contentType = mimeLookup(req.params.file) || 'application/octet-stream';
        if (contentLength) {
            res.writeHead(200, {
                'Content-Type': contentType,
                'Content-Length': contentLength,
                'Accept-Ranges': 'bytes',
            });
        } else {
            res.type(contentType);
        }
        readStream.on('error', (error: Error) => {
            winstonLogger.error('Reading the H5P file failed: %o', error);
            res.status(404).end();
        });
        readStream.pipe(res);
    } catch (error) {
        winstonLogger.error('Reading the H5P file failed: %o', error);
        res.status(404);
    }
}

/**
 * start h5p player return main page.
 *
 * @param contentid
 */
export const startH5Pplayer = async (contentid: string): Promise<any> => {
    return new Promise(async (resolve, reject) => {
        try {
            // const user: IUser = {
            //     canCreateRestricted: true,
            //     canInstallRecommended: true,
            //     canUpdateAndInstallLibraries: true,
            //     id: contentid,
            //     name: "robot",
            //     type: "local"
            // };
            const params: { Bucket: string; Key: string } = {
                "Bucket": process.env.BUCKET_NAME as string,
                "Key": contentid as string
            };
            const stream = await readStreamFromStorage(params);
            const filepath = process.env.HTMLFOLDER + "/" + contentid;
            let page;

            // Error event handler for streaming
            stream.on('error', async (error) => {
                winstonLogger.error('Issue getting readstream from Allas. Try from backup data: %o' + error);
                try {
                    const path = process.env.BACK_UP_PATH + contentid;
                    page = await renderH5Ppage(contentid, path);
                    resolve(page);
                } catch (error) {
                    winstonLogger.error('Issue reading file from backup: ' + error);
                    reject(error);
                }
            });

            stream.pipe(fs.createWriteStream(filepath));
            stream.on('end', async function () {
                try {
                    // winstonLogger.debug("We finished the zipstream!");
                    // const data = await fs.readFileSync(filepath);
                    // winstonLogger.debug("uploading h5p package #####################################");
                    // const options = {
                    //     "onlyInstallLibraries": false
                    // };
                    // const result = await h5pEditor.uploadPackage(data, user, options);
                    // winstonLogger.debug("saving h5p package");
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
                    // winstonLogger.debug("rendering h5p page: " + contentid);
                    // // page = await h5pPlayer.render(contentid, content);
                    // page = await h5pPlayer.render(contentid);
                    page = await renderH5Ppage(contentid, filepath);
                    resolve(page);
                } catch (error) {
                    reject(error);
                }
            });
        } catch (error) {
            reject(error);
        }
    });
};

/**
 * Save, extract and render H5P content from H5p file to a given file path.
 *
 * @param contentId H5P file name passed as a content ID - not used to identify the H5P content.
 * @param filepath  Directory path for saving the H5P file.
 */
export const renderH5Ppage = async (contentId: string, filepath: string): Promise<string | any> => {

    // H5P configurations
    const user: IUser = {
        canCreateRestricted: true,
        canInstallRecommended: true,
        canUpdateAndInstallLibraries: true,
        id: contentId,
        name: 'robot',
        type: 'local',
    };
    const options: { onlyInstallLibraries?: boolean } = {
        onlyInstallLibraries: false
    };

    try {
        const buffer: Buffer = await fs.readFileSync(filepath);

        // Uploading returns a JSON content of H5P application.
        const result: {
            installedLibraries: ILibraryInstallResult[];
            metadata?: IContentMetadata;
            parameters?: any;
        } = await h5pEditor.uploadPackage(buffer, user, options);

        let mainlib;
        for (const lib of result.metadata.preloadedDependencies) {
            if (lib.machineName == result.metadata.mainLibrary) {
                mainlib = lib;
            }
        }

        // Saving generates a numeric ID for the H5P content.
        const cid: ContentId = await h5pEditor.saveOrUpdateContent(
            undefined, // contentId is undefined when saving a new H5P content
            result.parameters,
            result.metadata,
            H5P.LibraryName.toUberName(mainlib, { useWhitespace: true }),
            user,
        );

        const h5pPlayer: H5P.H5PPlayer = new H5P.H5PPlayer(h5pEditor.libraryStorage, h5pEditor.contentStorage, config);
        // const content = result.parameters;
        // page = await h5pPlayer.render(contentid, content);

        winstonLogger.debug('Rendering H5P content ID: %s', cid);
        return await h5pPlayer.render(cid);
    } catch (error) {
        throw new Error(error);
    }
};

export default {
    play,
    getH5PContent,
    startH5Pplayer,
    renderH5Ppage
};
