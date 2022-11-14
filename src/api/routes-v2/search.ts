import { Request, Response, Router } from 'express';
import { getCollectionEsData } from '../../elasticSearch/es';
import { runMessageQueueThread } from '../../services/threadService';
import { winstonLogger } from '../../util/winstonLogger';
import { elasticSearchQuery } from '../../elasticSearch/esQueries';

/**
 * API version 2.0 for requesting files and metadata related to stored educational material.
 * This module is a collection of endpoints starting with /search/.
 * Endpoints ordered by the request URL (1) and the request method (2).
 *
 * @param router express.Router
 */
export default (router: Router): void => {

    const moduleRoot = '/search';

    // Search for educational materials with search criteria.
    // Search options are published in the messaging system for further analytical processing.
    router.post(`${moduleRoot}`,
        (req: Request, res: Response) => {
            runMessageQueueThread(req).then((result) =>
                winstonLogger.debug('THREAD: Message queue publishing completed for %o', result));
            return res.status(204).end();
        },
        elasticSearchQuery,
    );

    // Update search index with collection changes.
    router.post(`${moduleRoot}/collection`, getCollectionEsData);

}
