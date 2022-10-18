import { NextFunction, Request, Response, Router } from 'express';
import { checkAuthenticated, hasAccessToPublicatication } from '../../services/authService';
import { downloadFile, downloadPreviewFile } from '../../queries/fileHandling';
import { isAllasEnabled } from '../../services/routeEnablerService';
import { downloadEmThumbnail, uploadbase64Image } from '../../queries/thumbnailHandler';

/**
 * API version 2.0 for requesting files and metadata related to stored educational material.
 * This module is a collection of endpoints starting with /edumaterial/.
 * Endpoints ordered by the request URL (1) and the request method (2).
 *
 * @param router express.Router
 */
export default (router: Router): void => {

    const moduleRoot = '/material';

    // MATERIAL FILE DOWNLOAD FOR LOCAL SAVING:
    // Download the fysical material file by file name (:filename) to save it on a local hard drive.
    router.get(`${moduleRoot}/file/:filename([A-Za-z0-9._-]+[.][A-Za-z0-9]{2,4})/download`, downloadFile);

    // MATERIAL FILE DOWNLOAD FOR EMBEDDED PREVIEW:
    // Fetch a material file by file name (:filename) for the embedded preview (iframe).
    router.get(`${moduleRoot}/file/:filename([A-Za-z0-9._-]+[.][A-Za-z0-9]{2,4})/preview`, downloadPreviewFile);

    // THUMBNAIL FETCH FOR THE WEB VIEW:
    // Fetch a thumbnail picture by file name (:filename) for the educational material web view.
    router.get(`${moduleRoot}/file/:filename([A-Za-z0-9._-]+[.][A-Za-z0-9]{2,4})/thumbnail`, downloadEmThumbnail);

    // THUMBNAIL UPLOAD FOR STORING:
    // Store a new thumbnail picture file for the educational material (:edumaterialid).
    router.post(`${moduleRoot}/edumaterial/:edumaterialid([0-9]{1,6})/thumbnail`,
        isAllasEnabled,
        checkAuthenticated,
        hasAccessToPublicatication,
        uploadbase64Image);

}
