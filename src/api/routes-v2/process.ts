import { Request, Response, Router } from 'express';
import Notification from './dto/notification';

/**
 * API version 2.0 for requesting application processes.
 * This module is a collection of endpoints starting with /process/.
 * Endpoints ordered by the request URL (1) and method (2).
 *
 * @param router express.Router
 */
export default (router: Router): void => {

    let notification: Notification = new Notification('');

    // Get a notification
    router.get('/process/notification', (req: Request, res: Response) => {
        if (req.accepts('json')) {
            return res.status(200).json(notification);
        }
        return res.sendStatus(400);
    });

    // Save a notification
    router.post('/process/notification', (req: Request, res: Response) => {
        if (req.accepts('json') && req.body.notification) {
            notification.notification = req.body.notification;
            notification.updated = new Date().toISOString();
            return res.status(201).json(notification);
        }
        return res.sendStatus(400);
    });
}
