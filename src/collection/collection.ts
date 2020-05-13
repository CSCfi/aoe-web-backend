import { Request, Response, NextFunction } from "express";
const { check, validationResult } = require("express-validator");
import { insertCollection, insertEducationalMaterialToCollection } from "./../queries/collectionQueries";
export class Collection {
    constructor(public collectionId: string, public emArray: string[]) {}
}

export async function createCollection(req: Request , res: Response) {
    try {
      const id = await insertCollection(req.session.passport.user.uid);
      res.status(200).json(id);
    }
    catch (error) {
      console.error(error);
      res.status(500).json({"error": "something went wrong"});
    }
}
export async function addEducationalMaterialToCollection(req: Request , res: Response) {
    try {
        console.log("test");
      await insertEducationalMaterialToCollection(req.body.collectionId, req.body.emId);
      res.status(200).json({"status": "ok"});
    }
    catch (error) {
      console.error(error);
      res.status(500).json({"error": "something went wrong"});
    }
}