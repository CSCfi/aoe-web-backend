import { NextFunction, Request, Response } from 'express';
import { ErrorHandler } from '@/helpers/errorHandler';
import { db } from '@resource/postgresClient';
import winstonLogger from '@util/winstonLogger';

export const checkAuthenticated = (req: Request, res: Response, next: NextFunction): void => {
  if (req.isAuthenticated()) return next();
  res.sendStatus(401).end();
};

export const getUserData = async (req: Request, res: Response): Promise<any> => {
  const query = `
    SELECT termsofusage, email, verifiedemail, newratings, almostexpired, termsupdated, allowtransfer
    FROM users
    WHERE username = $1
  `;
  const userInfo = await db.oneOrNone(query, [req.session.passport.user.uid]);
  res.setHeader('Cache-Control', 'private, max-age=0');
  res.status(200).json({
    userdata: req.session.passport.user,
    email: userInfo.email,
    termsofusage: userInfo.termsofusage,
    verifiedEmail: userInfo.verifiedemail,
    newRatings: userInfo.newratings,
    almostExpired: userInfo.almostexpired,
    termsUpdated: userInfo.termsupdated,
    allowTransfer: userInfo.allowtransfer,
  });
};

export const hasAccesstoPublication = async (id: number, req: Request): Promise<any> => {
  if (!req.session.passport) return false;
  try {
    const params = { id: id };
    const query = `
      SELECT usersusername
      FROM educationalmaterial
      WHERE id = $1
    `;
    const result = await db.oneOrNone(query, params.id);
    return req.session.passport.user.uid === result;
  } catch (err) {
    throw new Error(`Checking user\'s ownership failed: ${err}`);
  }
};

/**
 * Save a new authenticated user to service users.
 * TODO: Add a return value to verify the user registration.
 * @param {Record<string, unknown>} userinfo
 * @return {Promise<void>}
 */
export const insertUserToDatabase = async (userinfo: Record<string, unknown>): Promise<void> => {
  try {
    const uid: string = userinfo['uid'] as string;
    const query = `
      SELECT EXISTS (
        SELECT 1
        FROM users
        WHERE username = $1
      )
    `;
    const result = await db.oneOrNone(query, [uid]);
    if (!result.exists) {
      const query = `
        INSERT INTO users
          (firstname, lastname, username, preferredlanguage, preferredtargetname, preferredalignmenttype)
        VALUES ($1, $2, $3, 'fi', '', '')
      `;
      await db.none(query, [userinfo['given_name'], userinfo['family_name'], uid]);
    }
  } catch (err) {
    winstonLogger.error('Saving a new user failed: %o', err);
    winstonLogger.debug('USER: %o', userinfo);
    throw new Error(err);
  }
};

export async function hasAccessToPublicatication(req: Request, res: Response, next: NextFunction): Promise<any> {
  const query = 'SELECT usersusername FROM educationalmaterial WHERE id = $1';
  const eduMaterial = await db.oneOrNone(query, [req.params.edumaterialid]);
  if (req.session.passport.user.uid === eduMaterial.usersusername) {
    return next();
  }
  res.sendStatus(401);
}

export const hasAccessToMaterial = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
  const materialid = req.params.materialid || req.params.materialId;
  const query = `
    SELECT em.usersusername
    FROM educationalmaterial em
    JOIN material m ON m.educationalmaterialid = em.id
    WHERE m.id = $1
  `;
  const resp = await db.oneOrNone(query, [materialid]);
  if (req.session.passport.user.uid === resp.usersusername) {
    next();
    return;
  }
  res.sendStatus(401).end();
};

export const hasAccessToAttachmentFile = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
  const id = req.params.attachmentid;
  const query = `
    SELECT em.usersusername
    FROM educationalmaterial em
    INNER JOIN material m ON m.educationalmaterialid = em.id
    WHERE m.id = (
      SELECT a.materialid
      FROM attachment a
      WHERE a.id = $1
    )
  `;
  const result = await db.oneOrNone(query, [id]);
  if (!result.usersusername) {
    res.sendStatus(401).end();
    return;
  }
  if (req.session.passport.user.uid === result.usersusername) {
    next();
    return;
  }
  res.sendStatus(401).end();
  return;
};

export const hasAccessToCollection = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
  const id = req.body.collectionId;
  const result = await hasAccessToCollectionID(id, req.session.passport.user.uid);
  if (!result) {
    res.sendStatus(401).end();
    return;
  }
  next();
  return;
};

export const hasAccessToCollectionParams = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
  const id = req.params.collectionid;
  const hasAccess: boolean = await hasAccessToCollectionID(id, req.session.passport.user.uid);
  if (!hasAccess) {
    res.sendStatus(401).end();
    return;
  }
  next();
  return;
};

export const hasAccessToCollectionID = async (id: string, username: string): Promise<boolean> => {
  const query = `
    SELECT uc.usersusername
    FROM userscollection uc
    WHERE uc.collectionid = $1 AND uc.usersusername = $2
  `;
  return !!(await db.oneOrNone(query, [id, username]));
};

export const hasAccessToAOE = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
  try {
    if (!req.isAuthenticated()) {
      res.sendStatus(401).end();
      return;
    }
    const result: boolean = await hasAoeAccess(req.session.passport.user.uid);
    if (!result) {
      res.sendStatus(401).end();
      return;
    }
    next();
    return;
  } catch (err) {
    throw new ErrorHandler(500, `Checking user's access rights failed: ${err}`);
  }
};

export const userInfo = async (req: Request, res: Response): Promise<void> => {
  try {
    if (!req.isAuthenticated()) {
      res.sendStatus(404).end();
      return;
    }
    const hasAccess: boolean = await hasAoeAccess(req.session.passport.user.uid);
    if (!hasAccess) {
      res.sendStatus(404).end();
      return;
    }
    res.sendStatus(200);
    return;
  } catch (err) {
    throw new ErrorHandler(500, `Checking user's access rights failed: ${err}`);
  }
};

export const hasAoeAccess = async (username: string): Promise<boolean> => {
  const query = `
    SELECT au.username
    FROM aoeuser au
    WHERE au.username = $1
  `;
  return !!(await db.oneOrNone(query, [username]));
};

export default {
  getUserData,
  // hasAccesstoPublication,
  checkAuthenticated,
  insertUserToDatabase,
  hasAccessToPublicatication,
  // logout,
  hasAccessToMaterial,
  hasAccessToAttachmentFile,
  hasAccessToCollection,
  // hasAccessToCollectionParams,
  userInfo,
};
