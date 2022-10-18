import { Router } from 'express';
import { checkAuthenticated, hasAccessToPublicatication } from '../../services/authService';
import { downloadFile, downloadPreviewFile } from '../../queries/fileHandling';
import { isAllasEnabled } from '../../services/routeEnablerService';
import { downloadEmThumbnail, uploadbase64Image } from '../../queries/thumbnailHandler';

/**
 * API version 2.0 for requesting files and metadata related to stored educational material.
 * This module is a collection of endpoints starting with /edumaterial/.
 * Endpoints ordered by the request URL (1) and the method (2).
 *
 * @param router express.Router
 */
export default (router: Router): void => {

    const requestRoot = '/edumaterial';

    // MATERIAL FILE DOWNLOAD FOR SAVING:
    // Download the fysical material file by file name (:filename) to save it on a local hard drive.
    router.get(`${requestRoot}/files/:filename/download`, downloadFile);

    // MATERIAL FILE DOWNLOAD FOR EMBEDDED PREVIEW:
    // Fetch a material file by file name (:filename) for the embedded preview (iframe).
    router.get(`${requestRoot}/files/:filename/preview`, downloadPreviewFile);

    // THUMBNAIL FILE LOAD FOR WEB VIEW:
    // Fetch a thumbnail picture by file name (:id) for the educational material view.
    router.get(`${requestRoot}/thumbnail/:id`, downloadEmThumbnail);

    // THUMBNAIL UPLOAD FOR STORING:
    // Store a new thumbnail picture file for the educational material (:edumaterialid).
    router.post(`${requestRoot}/thumbnail/:edumaterialid([0-9]{1,6})`,
        isAllasEnabled,
        checkAuthenticated,
        hasAccessToPublicatication,
        uploadbase64Image);

}
