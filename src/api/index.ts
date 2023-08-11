import { Router } from 'express';
import root from './routes-root';
import v1 from './routes-v1';
import v2 from './routes-v2';

/**
 * API versions available in runtime environment.
 *
 * Modify this module to pick up and drop off API versions.
 *
 * @param router  express.Router
 */
export default (router: Router): void => {
  root(router);
  v1(router);
  v2(router);
};
