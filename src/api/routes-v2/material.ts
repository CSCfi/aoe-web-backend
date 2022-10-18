import { Router } from 'express';
import { checkAuthenticated, hasAccessToPublicatication } from '../../services/authService';
import { downloadFile, downloadPreviewFile } from '../../queries/fileHandling';
import { isAllasEnabled } from '../../services/routeEnablerService';
import { downloadEmThumbnail, uploadbase64Image } from '../../queries/thumbnailHandler';

/**
 * API version 2.0 for requesting files and metadata related to stored educational material.
 * This module is a collection of endpoints starting with /material/.
 * Endpoints ordered by the request URL (1) and the method (2).
 *
 * @param router express.Router
 */
export default (router: Router) => {

    // MATERIAL FILE DOWNLOAD FOR SAVING:
    // Download the fysical material file by file name (:filename) to save it on a local hard drive.
    router.get('/material/download/:filename', downloadFile);

    // MATERIAL FILE DOWNLOAD FOR EMBEDDED REVIEW:
    // Fetch a material file by file name (:filename) for the embedded view (iframe).
    router.get('/material/preview/:filename', downloadPreviewFile);

    // THUMBNAIL FILE DOWNLOAD FOR WEB VIEW:
    // Fetch a thumbnail picture by file name (:id) for the educational material view.
    router.get('/material/thumbnail/:id', downloadEmThumbnail);

    // THUMBNAIL UPLOAD FOR STORING:
    // Store a new thumbnail picture file for the educational material (:edumaterialid).
    router.post('/material/thumbnail/:edumaterialid([0-9]{1,6})',
        isAllasEnabled,
        checkAuthenticated,
        hasAccessToPublicatication,
        uploadbase64Image);
}
