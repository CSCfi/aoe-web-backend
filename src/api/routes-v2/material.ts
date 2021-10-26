import { Router } from 'express';
import { isAllasEnabled } from '../../services/routeEnablerService';
import { checkAuthenticated, hasAccessToPublicatication } from '../../services/authService';
import { uploadEmBase64Image, uploadThumbnailImage } from '../../queries/thumbnailHandler';

/**
 * API version 2.0 for requesting files and metadata related to stored educational material.
 * This module is a collection of endpoints starting with /material.
 * Endpoints ordered by the request URL (1) and method (2).
 *
 * Makes /upload* routes deprecated in API version 1.0
 *
 * @param router express.Router
 */
export default (router: Router) => {

    // Upload single thumbnail image of an educational material to the local file system and cloud object storage
    router.post('/material/:edumaterialid/thumbnail', isAllasEnabled, checkAuthenticated, hasAccessToPublicatication, uploadThumbnailImage);

    router.post('/material/:edumaterialid/base64', isAllasEnabled, checkAuthenticated, hasAccessToPublicatication, uploadEmBase64Image);

}
