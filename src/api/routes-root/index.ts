import { Router } from 'express';
import embed from './embed';
import h5p from './h5p';
import status from './status';

export { default as embed } from './embed';
export { default as h5p } from './h5p';
export { default as status } from './status';

/**
 * API root modules available in runtime environment.
 *
 * @param router express.Router
 */
export default (router: Router): void => {
  embed(router);
  h5p(router);
  status(router);
};
