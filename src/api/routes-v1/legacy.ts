import { Router } from 'express';
import ah, { hasAccessToAoe } from '../../services/authService';
import {
    changeMaterialUser,
    getAoeUsers,
    getMaterialNames,
    removeEducationalMaterial
} from '../../controllers/material';
import esCollection from '../../elasticSearch/es';
import es from '../../elasticSearch/esQueries';
import h5p, { getH5PContent } from '../../h5p/h5p';
import db from '../../queries/apiQueries';
import { aoeRoutes, isAllasEnabled } from '../../services/routeEnablerService';
import fh from '../../queries/fileHandling';
import {
    addMetadataExtension,
    getMetadataExtension,
    getUsersMetadataExtension
} from '../../metadataExtension/metadataExtension';
import {
    addCollectionValidationRules, createCollectionValidationRules,
    metadataExtensionValidationRules, ratingValidationRules, removeCollectionValidationRules,
    rulesValidate, updateCollectionValidationRules, validateRatingUser
} from '../../validators/validator';
import oaipmh from '../../queries/oaipmh';
import { downloadPdfFromAllas } from '../../helpers/officeToPdfConverter';
import { downloadCollectionThumbnail, downloadEmThumbnail } from '../../queries/thumbnailHandler';
import { updateUserSettings } from '../../users/userSettings';
import { verifyEmailToken } from '../../services/mailService';
import collection from '../../collection/collection';
import rating from '../../rating/rating';

export default (router: Router) => {

    router.get('/aoeUsers', hasAccessToAoe, getAoeUsers);
    router.post('/changeUser', hasAccessToAoe, changeMaterialUser);
    router.post('/elasticSearch/collection/search', esCollection.getCollectionEsData);

// TODO: To be removed
    router.post('/elasticSearch/search', es.elasticSearchQuery);

    router.get('/h5p/content/:id/:file(*)', getH5PContent);
    router.get('/h5p/play/:contentid', h5p.play);
    router.post('/logout', ah.logout);

// TODO: Unused endpoint?
    router.get('/material', db.getMaterial);

    router.delete('/material/attachment/:attachmentid', ah.checkAuthenticated, ah.hasAccessToAttachmentFile, db.deleteAttachment);
    router.post('/material/attachment/:materialId', isAllasEnabled, ah.checkAuthenticated, ah.hasAccessToMaterial, fh.uploadAttachmentToMaterial);

// Keep the order
    router.post('/material/file/:edumaterialid', isAllasEnabled, ah.checkAuthenticated, ah.hasAccessToPublicatication, fh.uploadFileToMaterial);
    router.post('/material/file', isAllasEnabled, ah.checkAuthenticated, fh.uploadMaterial);

    router.delete('/material/file/:materialId/:fileid', ah.checkAuthenticated, ah.hasAccessToMaterial, db.deleteRecord);

    router.get('/messages/info', aoeRoutes);
    router.get('/metadata/:id', getMetadataExtension);
    router.put('/metadata/:id', metadataExtensionValidationRules(), rulesValidate, ah.checkAuthenticated, addMetadataExtension);
    router.get('/names/:id', hasAccessToAoe, getMaterialNames);
    router.post('/oaipmh/metadata', oaipmh.getMaterialMetaData);
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
    router.post('/collection/addMaterial', ah.checkAuthenticated, ah.hasAccessToCollection, addCollectionValidationRules(), rulesValidate, collection.addEducationalMaterialToCollection);
    router.post('/collection/create', ah.checkAuthenticated, createCollectionValidationRules(), rulesValidate, collection.createCollection);
    router.get('/collection/getCollection/:collectionId', collection.getCollection);
    router.post('/collection/removeMaterial', ah.checkAuthenticated, ah.hasAccessToCollection, removeCollectionValidationRules(), rulesValidate, collection.removeEducationalMaterialFromCollection);
    router.get('/collection/recentCollection', collection.getRecentCollection);
    router.put('/collection/update', ah.checkAuthenticated, ah.hasAccessToCollection, updateCollectionValidationRules(), rulesValidate, collection.updateCollection);
    router.get('/collection/userCollection', ah.checkAuthenticated, collection.getUserCollections);
    router.get('/collection/thumbnail/:id', downloadCollectionThumbnail);

// Rating request endpoints
    router.post('/rating', ah.checkAuthenticated, ratingValidationRules(), rulesValidate, validateRatingUser, rating.addRating);
    router.get('/rating/:materialId', ah.checkAuthenticated, rating.getUserRating);
    router.get('/ratings/:materialId', rating.getRating);

}