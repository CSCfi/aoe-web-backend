import { Router } from 'express';
import fh from './../../queries/fileHandling';

/**
 * API version 1.0 for requesting files related to educational material.
 *
 * @param router express.Router
 */
export default (router: Router) => {

    // Download all files related to an educational material and stream as a single zip file fron the object storage
    router.get('/material/file/:materialid/:publishedat?', fh.downloadMaterialFile);
}
