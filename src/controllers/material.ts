import { Request, Response, NextFunction } from "express";
import { ErrorHandler } from "./../helpers/errorHandler";
import { updateEducationalMaterial, getUsers, changeEducationalMaterialUser } from "./../queries/materialQueries";
import { deleteDocument } from "./../elasticSearch/esQueries";
/**
 *
 * @param req
 * @param res
 * @param next
 * change educational material to obsoluted
 */
export async function removeEducationalMaterial(req: Request , res: Response, next: NextFunction) {
    try {
        if (!req.params.id) {
            return res.sendStatus(404);
        }
        console.log("Strarting removeEducationalMaterial");
        const id = req.params.id;
        await updateEducationalMaterial(id);
        res.status(200).json( {"status" : "success", "statusCode": 200});
        const index = process.env.ES_INDEX;
        await deleteDocument(index, id);
    }
    catch (error) {
        console.error(error);
        next(new ErrorHandler(500, "Issue removing material"));
    }
}
/**
 *
 * @param req
 * @param res
 * @param next
 * get users that can be used in changeMaterialUser
 */
export async function getAoeUsers(req: Request , res: Response, next: NextFunction) {
    try {
        const users = await getUsers();
        res.status(200).json(users);
    }
    catch (error) {
        console.error(error);
        next(new ErrorHandler(500, "Issue getting users"));
    }
}
/**
 *
 * @param req
 * @param res
 * @param next
 * change user for educationalmaterial
 */
export async function changeMaterialUser(req: Request , res: Response, next: NextFunction) {
    try {
        if (!req.body.materialid || !req.body.userid) {
            return res.sendStatus(404);
        }
        const users = await changeEducationalMaterialUser(req.body.materialid, req.body.userid);
        if (!users) {
            return res.sendStatus(404);
        }
        else {
            return res.status(200).json({"status" : "success"});
        }
    }
    catch (error) {
        console.error(error);
        next(new ErrorHandler(500, "Issue changing users"));
    }
}