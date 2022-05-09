import { Router } from 'express';
import { checkAuthenticated, hasAccessToPublicatication } from '../../services/authService';
import { downloadFile } from '../../queries/fileHandling';
import { isAllasEnabled } from '../../services/routeEnablerService';
import { uploadbase64Image } from '../../queries/thumbnailHandler';
import digivisioLogger from '../../util/digivisioLogger';

/**
 * API version 2.0 for requesting files and metadata related to stored educational material.
 * This module is a collection of endpoints starting with /material.
 * Endpoints ordered by the request URL (1) and method (2).
 *
 * Replaces following root routes in previous API version 1.0:
 * /download**
 * /upload**
 *
 * @param router express.Router
 */
export default (router: Router) => {

    router.post('/material/:edumaterialid([0-9]{1,6})/thumbnail', isAllasEnabled, checkAuthenticated, hasAccessToPublicatication, uploadbase64Image);

    // TODO: Add regex validation
    router.get('/material/download/:filename', digivisioLogger, downloadFile);

}
