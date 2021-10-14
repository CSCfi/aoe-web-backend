import { getEducationalMaterialMetadata } from '../../queries/apiQueries';
import { Router } from 'express';

/**
 * API version 2.0 for requesting files and metadata related to stored educational material.
 * This module is a collection of legacy endpoints starting with /material/.
 * Endpoints ordered by the request URL (1) and method (2).
 *
 * @param router express.Router
 */
export default (router: Router) => {

    // Version 2.0 test endpoint
    router.get('/edumaterial/:edumaterialid([0-9]{1,6})/:publishedat?', getEducationalMaterialMetadata);

}
