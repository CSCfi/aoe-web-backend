import { hasAccessToAOE } from '@services/authService';
import {
  getScheduledNotifications,
  getScheduledNotificationsAll,
  setScheduledNotification,
  setScheduledNotificationDisabled,
} from '@services/notificationService';
import requestErrorHandler from '@util/requestErrorHandler';
import { validateNotification } from '@util/requestValidator';
import { NextFunction, Request, Response, Router } from 'express';

/**
 * API version 2.0 for requesting application system processes.
 * This module is a collection of endpoints starting with /api/v2/process/.
 * @param router express.Router
 */
export default (router: Router): void => {
  const moduleRoot = '/process';

  // Get currently active notifications.
  router.get(
    `${moduleRoot}/notifications`,
    (req: Request, res: Response, next: NextFunction): void => {
      if (!req.accepts('json')) {
        res.sendStatus(400).end();
        return;
      }
      next();
    },
    (req: Request, res: Response, next: NextFunction): void => {
      getScheduledNotifications(req, res).catch((err: unknown): void => {
        next(err);
      });
    },
  );

  // Get currently active and upcoming notifications.
  router.get(
    `${moduleRoot}/notifications/all`,
    hasAccessToAOE,
    (req: Request, res: Response, next: NextFunction): void => {
      if (!req.accepts('json')) {
        res.sendStatus(400).end();
        return;
      }
      next();
    },
    (req: Request, res: Response, next: NextFunction): void => {
      getScheduledNotificationsAll(req, res).catch((err: unknown): void => {
        next(err);
      });
    },
  );

  // Save a new scheduled notification.
  router.post(
    `${moduleRoot}/notifications`,
    hasAccessToAOE,
    (req: Request, res: Response, next: NextFunction): void => {
      if (!req.is('application/json')) {
        res.sendStatus(400).end();
        return;
      }
      next();
    },
    validateNotification(),
    requestErrorHandler,
    (req: Request, res: Response, next: NextFunction): void => {
      setScheduledNotification(req, res).catch((err: unknown): void => {
        next(err);
      });
    },
  );

  // Update a notification to disabled.
  router.patch(
    `${moduleRoot}/notifications/:id`,
    hasAccessToAOE,
    (req: Request, res: Response, next: NextFunction): void => {
      setScheduledNotificationDisabled(req, res).catch((err: unknown): void => {
        next(err);
      });
    },
  );
};
