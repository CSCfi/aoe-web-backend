import { Router } from 'express';
import collection from './collection';
import edumaterial from './edumaterial';
import metadata from './metadata';
import process from './process';
import search from './search';

export { default as collection } from './collection';
export { default as edumaterial } from './edumaterial';
export { default as metadata } from './metadata';
export { default as process } from './process';
export { default as search } from './search';

/**
 * API modules and versions available in runtime environment.
 * Modify this module to pick up and drop off API v2.0 modules.
 *
 * @param router express.Router
 */
export default (router: Router): void => {
    collection(router);
    edumaterial(router);
    metadata(router);
    process(router);
    search(router);
}
