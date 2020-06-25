import { Request, Response, NextFunction } from "express";
import { ErrorHandler } from "./../helpers/errorHandler";
import { collectionQuery, userCollections, insertCollection, deleteEducationalMaterialFromCollection, insertEducationalMaterialToCollection, insertCollectionMetadata } from "./../queries/collectionQueries";
// export class Collection {
//     constructor(public collectionId: string,
//       public name: string,
//       public emId: string[],
//       public publish: boolean,
//       public description: string,
//       public keywords: object[],
//       public languages: string[],
//       public educationalRoles: object[],
//       public alignmentObjects: object[],
//       public accessibilityFeatures: object[],
//       public accessibilityHazards: object[],

//       ) {
//       this.collectionId = collectionId;
//       this.name = name;
//       this.emId = emId;
//       this.publish = publish;
//       this.description = description;
//       this.keywords = keywords;
//       this.educationalRoles = educationalRoles;
//       this.alignmentObjects = alignmentObjects;
//       this.accessibilityFeatures = accessibilityFeatures;
//       this.accessibilityHazards = accessibilityHazards;
//     }
// }

export async function createCollection(req: Request , res: Response, next: NextFunction) {
    try {
      const id = await insertCollection(req.session.passport.user.uid, req.body.name);
      res.status(200).json(id);
    }
    catch (error) {
      console.error(error);
      next(new ErrorHandler(500, "Issue creating collection"));
    }
}
export async function addEducationalMaterialToCollection(req: Request , res: Response, next: NextFunction) {
    try {
      await insertEducationalMaterialToCollection(req.body.collectionId, req.body.emId);
      res.status(200).json({"status": "ok"});
    }
    catch (error) {
      console.error(error);
      next(new ErrorHandler(500, "Issue adding material to collection"));
    }
}

export async function removeEducationalMaterialFromCollection(req: Request , res: Response, next: NextFunction) {
  try {
    await deleteEducationalMaterialFromCollection(req.body.collectionId, req.body.emId);
    res.status(200).json({"status": "ok"});
  }
  catch (error) {
    console.error(error);
    next(new ErrorHandler(500, "Issue removing material from collection"));
  }
}

export async function getUserCollections(req: Request , res: Response, next: NextFunction) {
  try {
    const data = await userCollections(req.session.passport.user.uid);
    res.status(200).json(data);
  }
  catch (error) {
    console.error(error);
    next(new ErrorHandler(500, "Issue getting collection"));
  }
}

export async function getCollection(req: Request , res: Response, next: NextFunction) {
  try {
    let data;
    if (req.isAuthenticated()) {
      data = await collectionQuery(req.params.collectionId, req.session.passport.user.uid);
    }
    else {
      data = await collectionQuery(req.params.collectionId);
    }
    res.status(200).json(data);
  }
  catch (error) {
    console.error(error);
    next(new ErrorHandler(500, "Issue getting collection"));
  }
}

export async function updateCollection(req: Request, res: Response, next: NextFunction) {
  try {
    const data = await insertCollectionMetadata(req.body);
    res.status(200).json({"status": "success"});
  }
  catch (error) {
    console.error(error);
    next(new ErrorHandler(500, "Issue updating collection"));
  }
}