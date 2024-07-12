import { Notification, sequelize } from '@domain/aoeModels';
import winstonLogger from '@util/winstonLogger';
import { Request, Response } from 'express';
import { Op, Transaction } from 'sequelize';

/**
 * API function to fetch notifications currently visible in the web portal.
 * @param {e.Request} _req
 * @param {e.Response} res
 * @return {Promise<void>}
 */
export const getScheduledNotifications = async (_req: Request, res: Response): Promise<void> => {
  const now: Date = new Date();
  const t: Transaction = await sequelize.transaction({
    isolationLevel: Transaction.ISOLATION_LEVELS.READ_COMMITTED,
  });
  let notifications: Notification[];
  try {
    notifications = await Notification.findAll({
      where: {
        showSince: {
          [Op.lte]: now,
        },
        [Op.or]: [
          {
            showUntil: {
              [Op.gt]: now,
            },
          },
          {
            showUntil: {
              [Op.eq]: null,
            },
          },
        ],
        disabled: false,
      },
      order: [
        ['type', 'ASC'],
        ['showSince', 'ASC'],
      ],
      attributes: { exclude: ['username'] },
      transaction: t,
    });
    await t.commit();
  } catch (err) {
    winstonLogger.error('Getting the scheduled notifications failed: %o', err);
    await t.rollback();
    throw err;
  }
  res.send(notifications);
};

/**
 * API function to fetch the currently visible or upcoming notifications.
 * @param {e.Request} _req
 * @param {e.Response} res
 * @return {Promise<void>}
 */
export const getScheduledNotificationsAll = async (_req: Request, res: Response): Promise<void> => {
  const now: Date = new Date();
  const t: Transaction = await sequelize.transaction({
    isolationLevel: Transaction.ISOLATION_LEVELS.READ_COMMITTED,
  });
  let notifications: Notification[] = [];
  try {
    notifications = await Notification.findAll({
      where: {
        disabled: false,
        [Op.or]: [
          {
            showSince: {
              [Op.gte]: now,
            },
          },
          {
            showUntil: {
              [Op.gte]: now,
            },
          },
          {
            showUntil: {
              [Op.eq]: null,
            },
          },
        ],
      },
      order: [
        ['type', 'ASC'],
        ['showSince', 'ASC'],
      ],
      attributes: { exclude: ['username'] },
      transaction: t,
    });
    await t.commit();
  } catch (err) {
    winstonLogger.error('Getting the currently active notifications failed: %o', err);
    await t.rollback();
    throw err;
  }
  res.send(notifications);
};

/**
 * API function to schedule a notification visible in the web portal for a specified time period.
 * @param {e.Request} req
 * @param {e.Response} res
 * @return {Promise<void>}
 */
export const setScheduledNotification = async (req: Request, res: Response): Promise<void> => {
  const t: Transaction = await sequelize.transaction({
    isolationLevel: Transaction.ISOLATION_LEVELS.SERIALIZABLE,
  });
  let notification: Notification;
  try {
    notification = await Notification.create(
      {
        text: req.body.text,
        type: req.body.type,
        showSince: req.body.showSince,
        showUntil: req.body.showUntil,
        username: req.session.passport.user.uid,
      },
      {
        transaction: t,
      },
    );
    await t.commit();
  } catch (err) {
    winstonLogger.error('Saving a scheduled notification failed: %o', err);
    await t.rollback();
    throw err;
  }
  const response = notification.toJSON(); // Convert Sequelize instance to a plain object.
  delete response.username;
  res.status(201).json(response);
};

/**
 * API function to set a scheduled notification disabled.
 * @param {e.Request} req
 * @param {e.Response} res
 * @return {Promise<void>}
 */
export const setScheduledNotificationDisabled = async (req: Request, res: Response): Promise<void> => {
  const notificationID: string = req.params.id;
  const t: Transaction = await sequelize.transaction({
    isolationLevel: Transaction.ISOLATION_LEVELS.READ_COMMITTED,
  });
  try {
    const [affectedCount]: [affectedCount: number] = await Notification.update(
      {
        disabled: true,
      },
      {
        where: {
          id: req.params.id,
        },
        transaction: t,
      },
    );
    await t.commit();
    res.send({
      id: notificationID,
      affected: affectedCount,
    });
  } catch (err: unknown) {
    winstonLogger.error('Disabling a scheduled notification failed: %o', err);
    await t.rollback();
    throw err;
  }
};
