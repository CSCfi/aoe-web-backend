import config from '../../configuration';
import { Request, Response, Router } from 'express';
import Notification from './dto/notification';

/**
 * API version 2.0 for requesting application processes.
 * This module is a collection of endpoints starting with /process/.
 * Endpoints ordered by the request URL (1) and the request method (2).
 *
 * @param router express.Router
 */
export default (router: Router): void => {

    const moduleRoot = '/process';
    const statsApp = `${config.SERVER_CONFIG_OPTIONS.oaipmhHost}:${config.SERVER_CONFIG_OPTIONS.oaipmhAnalyticsPort}`;

    let notification: Notification = new Notification('');

    // Get currently active service notification.
    router.get(`${moduleRoot}/notification`, (req: Request, res: Response) => {
        if (req.accepts('json')) {
            return res.status(200).json(notification);
        }
        return res.sendStatus(400);
    });

    // Activate a new service notification to inform users about current issues and upcoming events.
    router.post(`${moduleRoot}/notification`, (req: Request, res: Response) => {
        if (req.accepts('json') && req.body.notification) {
            notification.notification = req.body.notification;
            notification.updated = new Date().toISOString();
            return res.status(201).json(notification);
        }
        return res.sendStatus(400);
    });

    /**
     * Endpoints for requesting statistical information from AOE Analytics Sercice.
     * Requests are forwarded to external REST API (aoe-data-anytics) and responses are returned as is.
     */
    // router.post(`${moduleRoot}/statistics`, (req: Request, res: Response) =>
    //     Proxy(`http://${statsApp}/api/statistics`, req, res));
}
