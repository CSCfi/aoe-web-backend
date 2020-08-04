import { Request, Response, NextFunction } from "express";
import { ErrorHandler } from "./../helpers/errorHandler";
import { collectionQuery, userCollections, insertCollection, deleteEducationalMaterialFromCollection, insertEducationalMaterialToCollection, insertCollectionMetadata } from "./../queries/collectionQueries";
export class Collection {
      public collectionId?: string;
      public name: string;
      public emId?: string[];
      public materials?: Array<CollectionMaterial>;
      public headings: Array<CollectionHeading>;

      public publish?: boolean;
      public description?: string;
      public keywords?: object[];
      public languages?: string[];
      public educationalRoles?: object[];
      public alignmentObjects?: object[];
      public educationalUses?: object[];
      public accessibilityFeatures?: object[];
      public accessibilityHazards?: object[];
      public educationalLevels: object[];
    constructor(data?: Collection) {
      this.collectionId = data.collectionId;
      this.name = data.name;
      this.emId = data.emId;
      this.publish = data.publish;
      this.description = data.description;
      this.keywords = data.keywords;
      this.languages = data.languages;
      this.educationalRoles = data.educationalRoles;
      this.alignmentObjects = data.alignmentObjects;
      this.educationalUses = data.educationalUses;
      this.accessibilityFeatures = data.accessibilityFeatures;
      this.accessibilityHazards = data.accessibilityHazards;
      this.materials = data.materials;
      this.headings = data.headings;
      this.educationalLevels = data.educationalLevels;
    }
}

export class CollectionMaterial {
  public id: string;
  public priority: number;
  constructor(data?: CollectionMaterial) {
    this.id = data.id;
    this.priority = data.priority;
  }
}

export class CollectionHeading {
  public id: string;
  public heading: string;
  public description: string;
  public priority: number;
  constructor(data?: CollectionHeading) {
    this.id = data.id;
    this.heading = data.heading;
    this.description = data.description;
    this.priority = data.priority;
  }
}

export async function createCollection(req: Request , res: Response, next: NextFunction) {
    try {
      const collection = new Collection(req.body);
      console.log(collection);
      const id = await insertCollection(req.session.passport.user.uid, collection);
      res.status(200).json(id);
    }
    catch (error) {
      console.error(error);
      next(new ErrorHandler(500, "Issue creating collection"));
    }
}
export async function addEducationalMaterialToCollection(req: Request , res: Response, next: NextFunction) {
    try {
      const collection = new Collection(req.body);
      await insertEducationalMaterialToCollection(collection);
      res.status(200).json({"status": "ok"});
    }
    catch (error) {
      console.error(error);
      next(new ErrorHandler(500, "Issue adding material to collection"));
    }
}

export async function removeEducationalMaterialFromCollection(req: Request , res: Response, next: NextFunction) {
  try {
    const collection = new Collection(req.body);
    await deleteEducationalMaterialFromCollection(collection);
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
    const collection = new Collection(req.body);
    console.log(collection);
    const data = await insertCollectionMetadata(collection);
    res.status(200).json({"status": "success"});
  }
  catch (error) {
    console.error(error);
    next(new ErrorHandler(500, "Issue updating collection"));
  }
}