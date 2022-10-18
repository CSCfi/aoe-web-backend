import { getEducationalMaterialMetadata } from '../../queries/apiQueries';
import { Router } from 'express';

/**
 * API version 2.0 for requesting metadata related to stored educational materials.
 * This module is a collection of endpoints starting with /metadata/.
 * Endpoints ordered by the request URL (1) and the method (2).
 *
 * @param router express.Router
 */
export default (router: Router): void => {

    // Fetch metadata of an educational material by ID (:edumaterialid).
    router.get('/metadata/:edumaterialid([0-9]{1,6})', getEducationalMaterialMetadata);

    // Fetch metadata of an educational material version by ID (:edumaterialid) and published timestamp (:publishedat).
    router.get('/metadata/:edumaterialid([0-9]{1,6})/version/' +
        ':publishedat([0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}.[0-9]{3}Z)',
        getEducationalMaterialMetadata);

}
