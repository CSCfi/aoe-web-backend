import { Router } from 'express';
import { checkAuthenticated, hasAccessToCollectionParams } from '../../services/authService';
import { uploadbase64Image } from '../../queries/thumbnailHandler';

/**
 * API version 2.0 for requesting files and metadata related to stored educational material.
 * This module is a collection of endpoints starting with /collection/.
 * Endpoints ordered by the request URL (1) and the method (2).
 *
 * @param router express.Router
 */
export default (router: Router): void => {

    const requestRoot = '/collection';

    // Upload collection thumbnail image file to the cloud object storage.
    // Case of a collection identified by request parameter name :collectionid in uploadbase64Image().
    router.post(`${requestRoot}/:collectionid([0-9]{1,6})/thumbnail`,
        checkAuthenticated,
        hasAccessToCollectionParams,
        uploadbase64Image);

}
