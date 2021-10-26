import { Router } from 'express';
import status from './status';

export { default as status } from './status';

/**
 * API root modules available in runtime environment.
 *
 * @param router express.Router
 */
export default (router: Router) => {
    status(router);
}
