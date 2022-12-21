import { Request, Response, Router } from 'express';
import { downloadFile, downloadPreviewFile } from '../../queries/fileHandling';
import { runMessageQueueThread } from '../../services/threadService';
import { winstonLogger } from '../../util/winstonLogger';

/**
 * API version 1.0 for requesting files and metadata related to stored educational material.
 * This module is a collection of legacy endpoints starting with /download**.
 * Endpoints ordered by the request URL (1) and method (2).
 *
 * Moved to /material in following API version 2.0
 *
 * @param router express.Router
 */
export default (router: Router): void => {

    // TODO: Add regex validation
    router.get('/download/:filename', downloadPreviewFile);

    // Single file download form the cloud storage to user's workstation.
    router.get('/download/file/:filename', downloadFile,
        (req: Request, res: Response) => {
            if (req.query.interaction === 'load' && res.locals.edumaterialid && req.headers['cookie']) {
                runMessageQueueThread(req, res).then((result) => {
                    if (result) winstonLogger.debug('THREAD: Message queue publishing completed for %o', result);
                });
            }
            res.status(200).end();
        });

}
