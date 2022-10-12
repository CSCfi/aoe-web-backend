import { Request, Response, NextFunction } from "express";
import { sendVerificationEmail } from "./../services/mailService";
import { ErrorHandler } from "./../helpers/errorHandler";
import { winstonLogger } from '../util';
import { db } from '../resources/pg-connect';

export interface UserSettings {
    notifications: {
      newRatings: boolean;
      almostExpired: boolean;
      termsUpdated: boolean;
    };
    email: string;
    allowTransfer: boolean;
}

export async function updateUserSettings(req: Request, res: Response, next: NextFunction) {
  try {
    if (!req.isAuthenticated()) {
      return res.sendStatus(403);
    }
    else if (!req.body) {
      return res.sendStatus(404);
    }
    const settings: UserSettings = req.body;
    await updateNotificationSettings(req.session.passport.user.uid, settings);
    if (settings.email) {
      await updateEmail(req.session.passport.user.uid, settings.email);
      await sendVerificationEmail(req.session.passport.user.uid, settings.email);
    }
    return res.status(200).json({"status": "ok"});
  }
  catch (error) {
    winstonLogger.error(error);
    next(new ErrorHandler(500, "Issue updating user settings"));
  }
}

export async function updateEmail(user: string, email: string) {
  try {
      const query = "update users set email = $1, verifiedemail = false where username = $2;";
      await db.none(query, [email, user]);
  }
  catch (error) {
      throw new Error(error);
  }
}

export async function updateNotificationSettings(user: string, settings: UserSettings) {
  try {
    const query = "update users set newratings = $1, almostexpired = $2, termsupdated = $3, allowtransfer = $4 where username = $5;";
    await db.none(query, [settings.notifications.newRatings, settings.notifications.almostExpired, settings.notifications.termsUpdated, settings.allowTransfer, user]);
  }
  catch (error) {
      throw new Error(error);
  }
}
