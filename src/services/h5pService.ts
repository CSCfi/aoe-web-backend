import config from '@/config';
import {
  fs,
  fsImplementations,
  H5PConfig,
  H5PEditor,
  H5PPlayer,
  IContentMetadata,
  ILibraryInstallResult,
  ILibraryName,
  IUser,
  LibraryName,
} from '@lumieducation/h5p-server';
import { directoryDownloadFromStorage } from '@query/fileHandling';
import winstonLogger from '@util/winstonLogger';
import { Request, Response } from 'express';
import fsNode, { promises } from 'node:fs';
import path from 'path';

let h5pConfig: H5PConfig;
let h5pEditor: H5PEditor;
let h5pPlayer: H5PPlayer;

/**
 * Initialize H5P editor and player with a JSON configuration file and static library content.
 * @return {Promise<void>}
 */
export const initializeH5P = async (): Promise<void> => {
  try {
    h5pConfig = new H5PConfig(
      new fsImplementations.JsonStorage(path.resolve(config.MEDIA_FILE_PROCESS.h5pJsonConfiguration)),
    ); // 'dist/services/config/h5p.json'
    await h5pConfig.load();
    h5pEditor = fs(
      h5pConfig,
      path.resolve(config.MEDIA_FILE_PROCESS.h5pPathLibraries),
      path.resolve(config.MEDIA_FILE_PROCESS.h5pPathTemporaryStorage),
      path.resolve(config.MEDIA_FILE_PROCESS.h5pPathContent),
    );
    h5pPlayer = new H5PPlayer(h5pEditor.libraryStorage, h5pEditor.contentStorage, h5pConfig);
  } catch (err) {
    throw err;
  }
};

// Anonymous user applied for unauthenticated client users.
export const user: IUser = {
  email: config.MEDIA_FILE_PROCESS.h5pUserEmail,
  id: 'anonymous',
  name: 'anonymous',
  type: 'local',
};

/**
 * Download and prepare compressed H5P media to run as an application.
 * @param {e.Request} req
 * @param {e.Response} res
 * @return {Promise<any>}
 */
export const downloadAndRenderH5P = async (req: Request, res: Response): Promise<string | any> => {
  const keyS3: string = req.params.keyS3;
  const paramsS3: { Bucket: string; Key: string } = {
    Bucket: config.CLOUD_STORAGE_CONFIG.bucket,
    Key: keyS3,
  };
  const targetPath = `${config.MEDIA_FILE_PROCESS.htmlFolder}/${keyS3}`;
  const options: { onlyInstallLibraries?: boolean } = {
    onlyInstallLibraries: false,
  };
  let page: string | any;
  try {
    await directoryDownloadFromStorage(paramsS3, targetPath);
    const buffer: Buffer = await promises.readFile(targetPath);

    // Install H5P application and needed library dependencies.
    const result: {
      installedLibraries: ILibraryInstallResult[];
      metadata?: IContentMetadata;
      parameters?: any;
    } = await h5pEditor.uploadPackage(buffer, user, options);

    // Update H5P application with the metadata and return a content ID.
    let mainlib: ILibraryName;
    for (const lib of result.metadata.preloadedDependencies) {
      if (lib.machineName == result.metadata.mainLibrary) {
        mainlib = lib;
      }
    }
    const savedContentId: string = await h5pEditor.saveOrUpdateContent(
      undefined,
      result.parameters,
      result.metadata,
      LibraryName.toUberName(mainlib, { useWhitespace: true }),
      user,
    );

    // Delete the downloaded H5P archive file in HTML directory.
    fsNode.unlink(targetPath, (err: unknown): void => {
      if (err) {
        winstonLogger.error('Deleting the H5P archive file failed: %o', err);
      }
    });

    // Render HTML content of the application.
    const htmlH5P: string = await h5pPlayer.render(savedContentId, user, 'en', { ignoreUserPermissions: true });
    res.status(200).send(htmlH5P).end();
  } catch (err: unknown) {
    winstonLogger.error('Processing or rendering H5P failed: %o', err);
    throw err;
  }
};
