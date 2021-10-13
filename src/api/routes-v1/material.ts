import { addLinkToMaterial, setEducationalMaterialObsoleted } from '../../queries/apiQueries';
import { checkAuthenticated, hasAccessToPublicaticationMW } from '../../services/authService';
import { Router } from 'express';
import { downloadMaterialFile } from '../../queries/fileHandling';
import { updateEducationalMaterialMetadata } from '../../controllers/educationalMaterial';

/**
 * API version 1.0 for requesting files related to educational material.
 *
 * @param router express.Router
 */
export default (router: Router) => {

    // Set educational material obsoleted and hide from search results - data remains in the database
    router.delete('/material/:edumaterialid', checkAuthenticated, hasAccessToPublicaticationMW, setEducationalMaterialObsoleted);

    // Create new version of an educational material by updating the metadata, update search index and assign a new PID
    router.put('/material/:edumaterialid', checkAuthenticated, hasAccessToPublicaticationMW, updateEducationalMaterialMetadata);

    // Download all files related to an educational material and stream as a single zip file fron the object storage
    router.get('/material/file/:edumaterialid/:publishedat?', downloadMaterialFile);

    // Save a link type material to an educational material
    router.post('/material/link/:edumaterialid', checkAuthenticated, hasAccessToPublicaticationMW, addLinkToMaterial);

}
