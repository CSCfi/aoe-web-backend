import { Request, Response, NextFunction } from 'express';
import { ErrorHandler } from './../helpers/errorHandler';
import {
  updateEducationalMaterial,
  getUsers,
  changeEducationalMaterialUser,
  getOwnerName,
  getMaterialName,
} from './../queries/materialQueries';
import { deleteDocument } from './../elasticSearch/esQueries';
import { winstonLogger } from '../util/winstonLogger';
/**
 *
 * @param req
 * @param res
 * @param next
 * change educational material to obsoluted
 */
export async function removeEducationalMaterial(req: Request, res: Response, next: NextFunction) {
  try {
    if (!req.params.id) {
      return res.sendStatus(404);
    }
    winstonLogger.debug(
      'removeEducationalMaterial: user ' +
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
 * change user for educationalmaterial
 */
export async function changeMaterialUser(req: Request, res: Response, next: NextFunction) {
  try {
    if (!req.body.materialid || !req.body.userid) {
      return res.sendStatus(404);
    }
    winstonLogger.debug(
      'changeMaterialUser user: ' +
        req.session.passport.user.uid +
        ' changing educational material ' +
        req.body.materialid +
        ' user to ' +
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
