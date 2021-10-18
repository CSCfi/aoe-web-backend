import { Router } from 'express';
import metadata from './metadata';

export { default as metadata } from './metadata';

/**
 * API modules and versions available in runtime environment.
 *
 * Modify this module to pick up and drop off API modules.
 *
 * @param router  express.Router
 */
export default (router: Router) => {
    metadata(router);
}
