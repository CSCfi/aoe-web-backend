import { Request, Response, NextFunction } from "express";
import { ErrorHandler } from "./../helpers/errorHandler";
import { updateEducationalMaterial, getUsers, changeEducationalMaterialUser } from "./../queries/materialQueries";

export async function removeEducationalMaterial(req: Request , res: Response, next: NextFunction) {
    try {
        if (!req.params.id) {
            return res.sendStatus(404);
        }
        console.log("Strarting updateEducationalMaterial");
        const id = req.params.id;
        await updateEducationalMaterial(id);
        res.status(200).json(
            {"status" : "success",
            "statusCode": 200});
    }
    catch (error) {
        console.error(error);
        next(new ErrorHandler(500, "Issue removing material"));
    }
}

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