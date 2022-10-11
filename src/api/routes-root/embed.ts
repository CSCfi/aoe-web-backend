import { Router } from 'express';
import { downloadFile } from '../../queries/fileHandling';
import { getEducationalMaterialMetadata } from '../../queries/apiQueries';

/**
 * Open root level API for embedded materials.
 * Sessions and cookies not created.
 *
 * @param router express.Router
 */
export default (router: Router) => {

    // Get all metadata of an educational material.
    // Version specified optionally with publishing date (:publishedat).
    // :publishedat format 'YYYY-MM-DDTHH:mm:ss.SSSZ' (ISODate) - regex path validation in API v2.0.
    // :edumaterialid defined as a number between 1 to 6 digits to prevent similar endpoints collision.
    router.get('/embed/material/:edumaterialid([0-9]{1,6})/:publishedat?', getEducationalMaterialMetadata);

    // Download single file by file name.
    router.get('/embed/download/:filename', downloadFile);

}