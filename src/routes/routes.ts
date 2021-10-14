import api from './../api'
import { hasAccessToAoe } from '../services/authService';
import { Router } from 'express';
import { getH5PContent } from '../h5p/h5p';
import { downloadPdfFromAllas } from '../helpers/officeToPdfConverter';
import { verifyEmailToken } from '../services/mailService';
import {
    removeEducationalMaterial,
    getAoeUsers,
    changeMaterialUser,
    getMaterialNames
} from '../controllers/material';
import {
    addMetadataExtension,
    getMetadataExtension,
    getUsersMetadataExtension
} from '../metadataExtension/metadataExtension';
import { isAllasEnabled, aoeRoutes } from '../services/routeEnablerService';
import { updateUserSettings } from '../users/userSettings';
import {
    ratingValidationRules,
    createCollectionValidationRules,
    addCollectionValidationRules,
    removeCollectionValidationRules,
    metadataExtensionValidationRules,
    updateCollectionValidationRules,
    rulesValidate,
    validateRatingUser
} from '../validators/validator';

const router: Router = Router();

// TODO: Convert to import statements
const db = require('../queries/apiQueries');
const ah = require('../services/authService');
const collection = require('../collection/collection');
const esCollection = require('./../elasticSearch/es');
const es = require('./../elasticSearch/esQueries');
const h5p = require('./../h5p/h5p');
const fh = require('./../queries/fileHandling');
const oaipmh = require('./../queries/oaipmh');
const rating = require('../rating/rating');
const thumbnail = require('./../queries/thumbnailHandler');

/**
 * Legacy API routes and connected middlewares.
 * Sorted by request URL for the later modularization, refactoring and renaming.
 */
router.get('/aoeUsers', hasAccessToAoe, getAoeUsers);
router.post('/changeUser', hasAccessToAoe, changeMaterialUser);
router.get('/download/:key', fh.downloadFile);
router.post('/elasticSearch/collection/search', esCollection.getCollectionEsData);
router.post('/elasticSearch/search', es.elasticSearchQuery);
router.get('/h5p/content/:id/:file(*)', getH5PContent);
router.get('/h5p/play/:contentid', h5p.play);
router.post('/logout', ah.logout);

// TODO: Unused endpoint?
router.get('/material', db.getMaterial);

router.delete('/material/attachment/:attachmentid', ah.checkAuthenticated, ah.hasAccessToAttachmentFile, db.deleteAttachment);
router.post('/material/attachment/:materialId', isAllasEnabled, ah.checkAuthenticated, ah.hasAccessToMaterial, fh.uploadAttachmentToMaterial);
router.post('/material/file', isAllasEnabled, ah.checkAuthenticated, fh.uploadMaterial);
router.post('/material/file/:edumaterialid', isAllasEnabled, ah.checkAuthenticated, ah.hasAccessToPublicaticationMW, fh.uploadFileToMaterial);
router.delete('/material/file/:materialid/:fileid', ah.checkAuthenticated, ah.hasAccessToMaterial, db.deleteRecord);

router.get('/messages/info', aoeRoutes);
router.get('/metadata/:id', getMetadataExtension);
router.put('/metadata/:id', metadataExtensionValidationRules(), rulesValidate, ah.checkAuthenticated, addMetadataExtension);
router.get('/names/:id', hasAccessToAoe, getMaterialNames);
router.post('/oaipmh/metadata', oaipmh.getMaterialMetaData);
router.get('/pdf/content/:key', downloadPdfFromAllas);
router.get('/recentmaterial', db.getRecentMaterial);

// TODO: Duplicate functionality with DELETE /material/:edumaterialid - endpoint used by administrator archiving functionality
router.delete('/removeMaterial/:id', hasAccessToAoe, removeEducationalMaterial);

router.post('/uploadImage/:edumaterialid', isAllasEnabled, ah.checkAuthenticated, ah.hasAccessToPublicaticationMW, thumbnail.uploadImage);
router.post('/uploadBase64Image/:edumaterialid', isAllasEnabled, ah.checkAuthenticated, ah.hasAccessToPublicaticationMW, thumbnail.uploadEmBase64Image);
router.get('/thumbnail/:id', thumbnail.downloadEmThumbnail);
router.put('/updateSettings', ah.checkAuthenticated, updateUserSettings);
router.get('/user', ah.checkAuthenticated, db.getUser);
router.put('/user', ah.checkAuthenticated, db.updateUser);
router.get('/userdata', ah.checkAuthenticated, ah.getUserData);
router.post('/userinfo', ah.userInfo);
router.get('/usermaterial', ah.checkAuthenticated, db.getUserMaterial);
router.get('/usersMetadata/:id', ah.checkAuthenticated, getUsersMetadataExtension);
router.put('/termsOfUsage', ah.checkAuthenticated, db.updateTermsOfUsage);
router.get('/verify', verifyEmailToken);

// Collection request endpoints
router.post('/collection/addMaterial', ah.checkAuthenticated, ah.hasAccessToCollection, addCollectionValidationRules(), rulesValidate, collection.addEducationalMaterialToCollection);
router.post('/collection/create', ah.checkAuthenticated, createCollectionValidationRules(), rulesValidate, collection.createCollection);
router.get('/collection/getCollection/:collectionId', collection.getCollection);
router.post('/collection/removeMaterial', ah.checkAuthenticated, ah.hasAccessToCollection, removeCollectionValidationRules(), rulesValidate, collection.removeEducationalMaterialFromCollection);
router.get('/collection/recentCollection', collection.getRecentCollection);
router.put('/collection/update', ah.checkAuthenticated, ah.hasAccessToCollection, updateCollectionValidationRules(), rulesValidate, collection.updateCollection);
router.post('/collection/uploadBase64Image/:id', ah.checkAuthenticated, ah.hasAccessToCollectionParams, thumbnail.uploadCollectionBase64Image);
router.get('/collection/userCollection', ah.checkAuthenticated, collection.getUserCollections);
router.get('/collection/thumbnail/:id', thumbnail.downloadCollectionThumbnail);

// Rating request endpoints
router.post('/rating', ah.checkAuthenticated, ratingValidationRules(), rulesValidate, validateRatingUser, rating.addRating);
router.get('/rating/:materialId', ah.checkAuthenticated, rating.getUserRating);
router.get('/ratings/:materialId', rating.getRating);

export = router;
