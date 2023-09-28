import { Request, Response, Router } from 'express';
import collection from '../../collection/collection';
import {
  changeMaterialUser,
  getAoeUsers,
  getMaterialNames,
  removeEducationalMaterial,
} from '../../controllers/material';
import { downloadPdfFromAllas } from '../../helpers/officeToPdfConverter';
import {
  addMetadataExtension,
  getMetadataExtension,
  getUsersMetadataExtension,
} from '../../metadataExtension/metadataExtension';
import db from '../../queries/apiQueries';
import fh from '../../queries/fileHandling';
import { getMaterialMetaData } from '../../queries/oaipmh';
import { downloadCollectionThumbnail, downloadEmThumbnail } from '../../queries/thumbnailHandler';
import rating from '../../rating/rating';
import ah, { hasAccessToAoe } from '../../services/authService';
import { verifyEmailToken } from '../../services/mailService';
import { aoeRoutes, isAllasEnabled } from '../../services/routeEnablerService';
import { updateUserSettings } from '../../users/userSettings';
import { requestErrorHandler, requestValidator } from '../../util';
import {
  addCollectionValidationRules,
  createCollectionValidationRules,
  metadataExtensionValidationRules,
  ratingValidationRules,
  removeCollectionValidationRules,
  updateCollectionValidationRules,
  validateRatingUser,
} from '../../util/requestValidator';

export default (router: Router): void => {
  router.get('/aoeUsers', hasAccessToAoe, getAoeUsers);
  router.post('/changeUser', hasAccessToAoe, changeMaterialUser);

  // TODO: Unused endpoint?
  router.get('/material', db.getMaterial);

  router.delete(
    '/material/attachment/:attachmentid',
    ah.checkAuthenticated,
    ah.hasAccessToAttachmentFile,
    db.deleteAttachment,
  );
  router.post(
    '/material/attachment/:materialId',
    isAllasEnabled,
    ah.checkAuthenticated,
    ah.hasAccessToMaterial,
    fh.uploadAttachmentToMaterial,
  );

  // Keep the order
  // Single file upload
  router.post(
    '/material/file/:edumaterialid',
    isAllasEnabled,
    requestValidator.fileUploadRules(),
    requestErrorHandler,
    ah.checkAuthenticated,
    ah.hasAccessToPublicatication,
    fh.uploadFileToMaterial,
  );
  router.post('/material/file', isAllasEnabled, ah.checkAuthenticated, fh.uploadMaterial);

  router.delete('/material/file/:materialId/:fileid', ah.checkAuthenticated, ah.hasAccessToMaterial, db.deleteRecord);

  router.get('/messages/info', aoeRoutes);

  router.get('/metadata/:id', getMetadataExtension);
  router.put(
    '/metadata/:id',
    metadataExtensionValidationRules(),
    requestErrorHandler,
    ah.checkAuthenticated,
    addMetadataExtension,
  );
  router.get('/names/:id', hasAccessToAoe, getMaterialNames);
  router.post('/oaipmh/metadata', getMaterialMetaData);
  router.get('/pdf/content/:key', downloadPdfFromAllas);
  router.get('/recentmaterial', db.getRecentMaterial);

  // TODO: Duplicate functionality with DELETE /material/:edumaterialid - endpoint used by administrator archiving functionality
  router.delete('/removeMaterial/:id', hasAccessToAoe, removeEducationalMaterial);

  router.get('/thumbnail/:id', downloadEmThumbnail);
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
  router.post(
    '/collection/addMaterial',
    ah.checkAuthenticated,
    ah.hasAccessToCollection,
    addCollectionValidationRules(),
    requestErrorHandler,
    collection.addEducationalMaterialToCollection,
  );
  router.post(
    '/collection/create',
    ah.checkAuthenticated,
    createCollectionValidationRules(),
    requestErrorHandler,
    collection.createCollection,
  );
  router.get('/collection/getCollection/:collectionId', collection.getCollection);
  router.post(
    '/collection/removeMaterial',
    ah.checkAuthenticated,
    ah.hasAccessToCollection,
    removeCollectionValidationRules(),
    requestErrorHandler,
    collection.removeEducationalMaterialFromCollection,
  );
  router.get('/collection/recentCollection', collection.getRecentCollection);
  router.put(
    '/collection/update',
    ah.checkAuthenticated,
    ah.hasAccessToCollection,
    updateCollectionValidationRules(),
    requestErrorHandler,
    collection.updateCollection,
  );
  router.get('/collection/userCollection', ah.checkAuthenticated, collection.getUserCollections);
  router.get('/collection/thumbnail/:id', downloadCollectionThumbnail);

  // Rating request endpoints
  router.post(
    '/rating',
    ah.checkAuthenticated,
    ratingValidationRules(),
    requestErrorHandler,
    validateRatingUser,
    rating.addRating,
  );
  router.get('/rating/:materialId', ah.checkAuthenticated, rating.getUserRating);
  router.get('/ratings/:materialId', rating.getRating);
};
