import material from './material';
import { Router } from 'express';

export { default as material } from './material';

/**
 * API modules and versions available in runtime environment.
 *
 * Modify this module to pick up and drop off API modules.
 *
 * @param router  express.Router
 */
export default (router: Router) => {
    material(router);
}
