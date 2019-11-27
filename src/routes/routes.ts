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

// File handling
 const fh = require("./../queries/fileHandling");
 const handler = require("./../metadataEngine/xlsxHandler");
 const thumbnail = require("./../queries/thumbnailHandler");
 const oajpmh = require("./../queries/oajpmh");
//  const pouta = require("./../queries/pouta");
// post metadata
// post file
// get metadata
// get file
// put metadata
// get omat
// delete file
// delete metadata

//  router.get("/login", passport.authenticate("oidc"), function (req, res) {
//     res.send("hello!!");
// });
//  router.post("/callback", function (req, res) {
//     console.log("In callback", req.user);
//     res.send(200);
// });
// router.post("/authtest", ah.authtest);
router.post("/material/file", fh.uploadMaterial);
router.post("/material/file/:materialId", fh.uploadFileToMaterial);
router.post("/material/link/:materialId", db.addLinkToMaterial);
router.post("/material/attachment/:materialId", fh.uploadAttachmentToMaterial);
router.post("/uploadImage/:id", thumbnail.uploadImage);
router.post("/uploadBase64Image/:id", thumbnail.uploadbase64Image);

// router.get("/logintest", ah.authservice);
router.get("/userdata", ah.getUserData);
router.get("/material", db.getMaterial);
router.get("/material/:id", ah.checkAuthenticated, db.getMaterialData);
router.get("/material/user/:username", db.getUserMaterial);
router.put("/material/:id", db.updateMaterial);
// delete educational material
router.delete("/material/:id", db.deleteMaterial);
// delete link or record from educationalmaterial
router.delete("/material/file/:materialid/:fileid", db.deleteRecord);
// router.post("/material", db.postMaterial);

router.post("/createUser", db.createUser);
router.put("/user/:id", db.updateUser);
router.get("/user/:id", db.getUser);
router.put("/termsOfUsage/:id", db.updateTermsOfUsage);

router.post("/upload", fh.uploadFileToStorage);
router.get("/download/:key", fh.downloadFile);
router.get("/material/file/:materialId", fh.downloadMaterialFile);

router.post("/uploadXlsx" , handler.uploadXlsx);

// oaj-pmh
router.post("/oajpmh/materialMetaData", oajpmh.getMaterialMetaData);
// router.get("/login", ah.authservice);
// router.get("/materialtest", ah.getMaterial);
export = router;