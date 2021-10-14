import { Router } from 'express';
import v1 from './routes-v1';
import v2 from './routes-v2';

/**
 * API modules and versions available in runtime environment.
 *
 * Modify this module to pick up and drop off API modules.
 *
 * @param router  express.Router
 * @param version string API version
 */
export default (router: Router, version: string) => {
    if (version === 'v1') {
        v1.material(router);
    } else if (version === 'v2') {
        v2.metadata(router);
    }
}
