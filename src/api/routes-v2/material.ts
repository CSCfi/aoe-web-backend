import { Router } from 'express';
import { isAllasEnabled } from '../../services/routeEnablerService';
import { checkAuthenticated, hasAccessToPublicatication } from '../../services/authService';
import { uploadbase64Image } from '../../queries/thumbnailHandler';

/**
 * API version 2.0 for requesting files and metadata related to stored educational material.
 * This module is a collection of endpoints starting with /material.
 * Endpoints ordered by the request URL (1) and method (2).
 *
 * Replaces /upload** routes in API version 1.0
 *
 * @param router express.Router
 */
export default (router: Router) => {

    router.post('/material/:edumaterialid/thumbnail', isAllasEnabled, checkAuthenticated, hasAccessToPublicatication, uploadbase64Image);

}
