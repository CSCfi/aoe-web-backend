import { Router } from 'express';
import { checkAuthenticated, hasAccessToCollectionParams } from '../../services/authService';
import { uploadbase64Image } from '../../queries/thumbnailHandler';

/**
 * API version 2.0 for requesting files and metadata related to stored educational material.
 * This module is a collection of endpoints starting with /collection.
 * Endpoints ordered by the request URL (1) and method (2).
 *
 * Replaces /collection* routes in API version 1.0
 *
 * @param router express.Router
 */
export default (router: Router) => {

    // Upload collection thumbnail image file to the cloud object storage.
    // Case of a collection identified by request parameter name :collectionid in uploadbase64Image().
    router.post('/collection/:collectionid([0-9]{1,6})/thumbnail', checkAuthenticated, hasAccessToCollectionParams, uploadbase64Image);

}
