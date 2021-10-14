import { Router } from 'express';
import v1 from './routes-v1';
import v2 from './routes-v2';

/**
 * API modules and versions available in runtime environment.
 *
 * Modify this module to pick up and drop off API modules.
 *
 * @param router express.Router
 */
export default (router: Router) => {
    v1.material(router);
    v2.edumaterial(router);
}
