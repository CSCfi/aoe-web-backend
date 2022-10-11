import { Router } from 'express';
import embed from './embed';
import status from './status';

export { default as embed } from './embed';
export { default as status } from './status';

/**
 * API root modules available in runtime environment.
 *
 * @param router express.Router
 */
export default (router: Router) => {
    embed(router);
    status(router);
}
