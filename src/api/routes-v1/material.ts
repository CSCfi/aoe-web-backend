import { addLinkToMaterial, getEducationalMaterialMetadata, setEducationalMaterialObsoleted } from '../../queries/apiQueries';
import { checkAuthenticated, hasAccessToPublicaticationMW } from '../../services/authService';
import { Router } from 'express';
import { downloadMaterialFile } from '../../queries/fileHandling';
import { updateEducationalMaterialMetadata } from '../../controllers/educationalMaterial';

/**
 * API version 1.0 for requesting files related to educational material.
 *
 * Endpoints ordered by the request URL and method.
 *
 * @param router express.Router
 */
export default (router: Router) => {

    // Set educational material obsoleted (archived) and hide it from the search results - data remains in the database.
    router.delete('/material/:edumaterialid', checkAuthenticated, hasAccessToPublicaticationMW, setEducationalMaterialObsoleted);

    // Create new version of an educational material by updating the metadata, update search index and assign a new PID.
    router.put('/material/:edumaterialid', checkAuthenticated, hasAccessToPublicaticationMW, updateEducationalMaterialMetadata);

    // Get all metadata of an educational material - version specified optionally with publishing date (:publishedat).
    // Variable :edumaterialid defined as a number between 1 to 6 digits to prevent similar endpoints collision.
    router.get('/material/:edumaterialid([0-9]{1,6})/:publishedat?', getEducationalMaterialMetadata);

    // Download all files related to an educational material and stream as a single zip file fron the object storage.
    // Variable :edumaterialid defined as a number between 1 to 6 digits to prevent similar endpoints collision.
    router.get('/material/file/:edumaterialid([0-9]{1,6})/:publishedat?', downloadMaterialFile);

    // Save a link type material to an educational material.
    router.post('/material/link/:edumaterialid', checkAuthenticated, hasAccessToPublicaticationMW, addLinkToMaterial);

}
