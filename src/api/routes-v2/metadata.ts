import { getEducationalMaterialMetadata } from '../../queries/apiQueries';
import { Router } from 'express';

/**
 * API version 2.0 for requesting files and metadata related to stored educational materials.
 * This module is a collection of legacy endpoints starting with /maetadata/.
 * Endpoints ordered by the request URL (1) and method (2).
 *
 * @param router express.Router
 */
export default (router: Router) => {

    // Version 2.0 test endpoints
    router.get('/metadata/:edumaterialid([0-9]{1,6})', getEducationalMaterialMetadata);
    router.get('/metadata/:edumaterialid([0-9]{1,6})/version/:publishedat(\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}Z)', getEducationalMaterialMetadata);

}
