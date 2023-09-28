import { Router } from 'express';
import { elasticSearchQuery } from '../../elasticSearch/esQueries';

/**
 * API version 1.0 for requesting files and metadata related to stored educational material.
 * This module is a collection of legacy endpoints starting with /elasticSearch**.
 * Endpoints ordered by the request URL (1) and method (2).
 *
 * Moved to /search in following API version 2.0
 *
 * @param router express.Router
 */
export default (router: Router): void => {
  router.get('/elasticSearch/search', elasticSearchQuery);
};
