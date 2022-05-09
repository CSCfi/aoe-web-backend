import { Router } from 'express';
import { elasticSearchQuery } from '../../elasticSearch/esQueries';
import digivisioLogger from '../../util/digivisioLogger';

/**
 * API version 2.0 for requesting files and metadata related to stored educational material.
 * This module is a collection of endpoints starting with /search.
 * Endpoints ordered by the request URL (1) and method (2).
 *
 * Replaces following root routes in previous API version 1.0:
 * /elasticSearch**
 *
 * @param router express.Router
 */
export default (router: Router) => {

    // Search for educational materials with criteria provided in the request body.
    router.post('/search', digivisioLogger, elasticSearchQuery);

}