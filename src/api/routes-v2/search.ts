import { Router } from 'express';
import { elasticSearchQuery } from '../../elasticSearch/esQueries';
import { getCollectionEsData } from '../../elasticSearch/es';

/**
 * API version 2.0 for requesting files and metadata related to stored educational material.
 * This module is a collection of endpoints starting with /search/.
 * Endpoints ordered by the request URL (1) and method (2).
 *
 * @param router express.Router
 */
export default (router: Router): void => {

    // Search for educational materials with criteria.
    router.post('/search', elasticSearchQuery);

    // Update search index with collection changes.
    router.post('/search/collection', getCollectionEsData);

}
