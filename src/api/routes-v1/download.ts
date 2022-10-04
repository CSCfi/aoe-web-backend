import { Router } from 'express';
import { downloadFile } from '../../queries/fileHandling';

/**
 * API version 1.0 for requesting files and metadata related to stored educational material.
 * This module is a collection of legacy endpoints starting with /download**.
 * Endpoints ordered by the request URL (1) and method (2).
 *
 * Moved to /material in following API version 2.0
 *
 * @param router express.Router
 */
export default (router: Router) => {

    // TODO: Add regex validation
    router.get('/download/:filename', downloadFile);

}
