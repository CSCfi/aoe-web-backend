import { Router } from 'express';
import { checkAuthenticated, hasAccessToCollectionParams } from '../../services/authService';
import { uploadbase64Image } from '../../queries/thumbnailHandler';

/**
 * API version 1.0 for requesting files and metadata related to stored educational material.
 * This module is a collection of legacy endpoints starting with /collection*.
 * Endpoints ordered by the request URL (1) and method (2).
 *
 * @param router express.Router
 */
export default (router: Router) => {

    // Upload collection thumbnail image to cloud object storage.
    // Case of a collection identified by request parameter name :collectionid in uploadbase64Image().
    router.post('/collection/uploadBase64Image/:collectionid', checkAuthenticated, hasAccessToCollectionParams, uploadbase64Image);

}
