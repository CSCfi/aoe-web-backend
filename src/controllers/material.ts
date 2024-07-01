import { ErrorHandler } from '@/helpers/errorHandler';
import {
  changeEducationalMaterialUser,
  getMaterialName,
  getOwnerName,
  getUsers,
  updateEducationalMaterial,
} from '@query/materialQueries';
import { deleteDocument } from '@search/esQueries';
import winstonLogger from '@util/winstonLogger';
import { NextFunction, Request, Response } from 'express';

/**
 * @param req
 * @param res
 * @param next
 * Change educational material to obsoluted
 */
export async function removeEducationalMaterial(req: Request, res: Response, next: NextFunction) {
  try {
    if (!req.params.id) {
      return res.sendStatus(404);
    }
    winstonLogger.debug(
      'removeEducationalMaterial: userH5P ' +
        req.session.passport.user.uid +
        ' deleting educational material ' +
        req.params.id,
    );
    const id = req.params.id;
    await updateEducationalMaterial(id);
    res.status(200).json({ status: 'success', statusCode: 200 });
    const index = process.env.ES_INDEX;
    await deleteDocument(index, id);
  } catch (error) {
    next(new ErrorHandler(500, 'Issue removing material' + error));
  }
}

/**
 *
 * @param req
 * @param res
 * @param next
 * get users that can be used in changeMaterialUser
 */
export async function getAoeUsers(req: Request, res: Response, next: NextFunction) {
  try {
    const users = await getUsers();
    res.status(200).json({ users: users });
  } catch (error) {
    winstonLogger.error(error);
    next(new ErrorHandler(500, 'Issue getting users'));
  }
}

/**
 *
 * @param req
 * @param res
 * @param next
 * change userH5P for educationalmaterial
 */
export async function changeMaterialUser(req: Request, res: Response, next: NextFunction) {
  try {
    if (!req.body.materialid || !req.body.userid) {
      return res.sendStatus(404);
    }
    winstonLogger.debug(
      'changeMaterialUser userH5P: ' +
        req.session.passport.user.uid +
        ' changing educational material ' +
        req.body.materialid +
        ' userH5P to ' +
        req.body.materialid,
    );
    const users = await changeEducationalMaterialUser(req.body.materialid, req.body.userid);
    if (!users) {
      return res.sendStatus(404);
    } else {
      return res.status(200).json({ status: 'success' });
    }
  } catch (error) {
    winstonLogger.error(error);
    next(new ErrorHandler(500, 'Issue changing users'));
  }
}

export async function getMaterialNames(req: Request, res: Response, next: NextFunction) {
  try {
    if (!req.params.id) {
      return res.sendStatus(404);
    }
    const name = await getMaterialName(req.params.id);
    const owner = await getOwnerName(req.params.id);
    if (!owner) {
      return res.sendStatus(404);
    } else {
      return res.status(200).json({ name, owner });
    }
  } catch (error) {
    winstonLogger.error(error);
    next(new ErrorHandler(500, 'Issue changing users'));
  }
}
