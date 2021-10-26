import { Router } from 'express';
import { isAllasEnabled } from '../../services/routeEnablerService';
import { checkAuthenticated, hasAccessToPublicatication } from '../../services/authService';
import { uploadEmBase64Image, uploadThumbnailImage } from '../../queries/thumbnailHandler';

/**
 * API version 1.0 for requesting files and metadata related to stored educational material.
 * This module is a collection of legacy endpoints starting with /upload*.
 * Endpoints ordered by the request URL (1) and method (2).
 *
 * Moved to /material in API version 2.0
 *
 * @param router express.Router
 */
export default (router: Router) => {

    router.post('/uploadImage/:edumaterialid', isAllasEnabled, checkAuthenticated, hasAccessToPublicatication, uploadThumbnailImage);

    router.post('/uploadBase64Image/:edumaterialid', isAllasEnabled, checkAuthenticated, hasAccessToPublicatication, uploadEmBase64Image);

}
