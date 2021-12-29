import { Router } from 'express';
import collection from './collection';
import material from './material';
import upload from './upload';
import download from './download';

export { default as collection } from './collection';
export { default as download } from './download';
export { default as material } from './material';
export { default as upload } from './upload';

/**
 * API modules and versions available in runtime environment.
 * Modify this module to pick up and drop off API v1.0 modules.
 *
 * @param router express.Router
 */
export default (router: Router) => {
    collection(router);
    download(router);
    material(router);
    upload(router);
}
