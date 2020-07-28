import { Router, Request, Response } from "express";
import { NextFunction } from "connect";
const connection = require("./../db");
// const pgp = connection.pgp;
const db2 = connection.db;
const router: Router = Router();
const passport = require("passport");

// Importing db const from apiQueries.ts
// Importing ah const from authservice.ts
 const db = require("../queries/apiQueries");
 const ah = require("../services/authService");
 const rating = require("../rating/rating");
 const validator = require("../validators/validator");

// File handling
const fh = require("./../queries/fileHandling");
const handler = require("./../metadataEngine/xlsxHandler");
const thumbnail = require("./../queries/thumbnailHandler");
const oaipmh = require("./../queries/oaipmh");
const es = require("./../elasticSearch/esQueries");
const collection = require("../collection/collection");

router.post("/material/file", ah.checkAuthenticated, fh.uploadMaterial);
router.post("/material/file/:materialId", ah.checkAuthenticated, ah.hasAccessToPublicaticationMW, fh.uploadFileToMaterial);
router.post("/material/link/:materialId", ah.checkAuthenticated, ah.hasAccessToPublicaticationMW, db.addLinkToMaterial);
router.post("/material/attachment/:materialId", ah.checkAuthenticated, ah.hasAccessToMaterial, fh.uploadAttachmentToMaterial);
router.post("/uploadImage/:id", ah.checkAuthenticated, ah.hasAccessToPublicaticationMW, thumbnail.uploadImage);
router.post("/uploadBase64Image/:id", ah.checkAuthenticated, ah.hasAccessToPublicaticationMW, thumbnail.uploadbase64Image);
router.get("/thumbnail/:id", thumbnail.downloadThumbnail);

router.get("/download/:key", fh.downloadFile);
router.get("/material/file/:materialId/:publishedat?", fh.downloadMaterialFile);

router.get("/userdata", ah.checkAuthenticated, ah.getUserData);
router.get("/material", db.getMaterial);
router.get("/material/:id/:publishedat?", db.getMaterialData);
router.get("/usermaterial", ah.checkAuthenticated, db.getUserMaterial);
router.get("/recentmaterial", db.getRecentMaterial);
router.put("/material/:id", ah.checkAuthenticated, ah.hasAccessToPublicaticationMW, db.updateMaterial);
// delete educational material
router.delete("/material/:id", ah.checkAuthenticated, ah.hasAccessToPublicaticationMW, db.deleteMaterial);
// delete link or record from educationalmaterial
router.delete("/material/file/:materialid/:fileid", ah.checkAuthenticated, ah.hasAccessToMaterial, db.deleteRecord);
// router.post("/material", db.postMaterial);
// delete attachment
router.delete("/material/attachment/:attachmentid", ah.checkAuthenticated, ah.hasAccessToAttachmentFile, db.deleteAttachment);
// router.post("/createUser", db.createUser);
router.put("/user", ah.checkAuthenticated, db.updateUser);
router.get("/user", ah.checkAuthenticated, db.getUser);
router.put("/termsOfUsage", ah.checkAuthenticated, db.updateTermsOfUsage);

// router.post("/upload", ah.checkAuthenticated, fh.uploadFileToStorage);

router.get("/logout", ah.logout);

// router.post("/uploadXlsx" , handler.uploadXlsx);

// oaj-pmh
router.post("/oaipmh/metadata", oaipmh.getMaterialMetaData);
// router.get("/login", ah.authservice);
// router.get("/materialtest", ah.getMaterial);
router.post("/elasticSearch/search", es.elasticSearchQuery);
router.post("/rating", ah.checkAuthenticated, validator.ratingValidationRules(), validator.rulesValidate, rating.addRating);
router.get("/rating/:materialId", ah.checkAuthenticated, rating.getUserRating);
router.get("/ratings/:materialId", rating.getRating);

router.post("/collection/create", ah.checkAuthenticated, validator.createCollectionValidationRules(), validator.rulesValidate, collection.createCollection);
router.post("/collection/addMaterial", ah.checkAuthenticated, ah.hasAccessToCollection, validator.addCollectionValidationRules(), validator.rulesValidate, collection.addEducationalMaterialToCollection);
router.get("/collection/userCollection", ah.checkAuthenticated, collection.getUserCollections);
router.get("/collection/getCollection/:collectionId", collection.getCollection);
router.post("/collection/removeMaterial", ah.checkAuthenticated, ah.hasAccessToCollection, validator.removeCollectionValidationRules(), validator.rulesValidate, collection.removeEducationalMaterialFromCollection);
router.put("/collection/update", ah.checkAuthenticated, ah.hasAccessToCollection, validator.updateCollectionValidationRules(), validator.rulesValidate, collection.updateCollection);
export = router;