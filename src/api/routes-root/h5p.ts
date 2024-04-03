import { getH5PContent, play } from '@/h5p/h5p';
import { Router } from 'express';

/**
 * Root level Open API for H5P interactive web materials.
 * Sessions and cookies are not created.
 *
 * @param router express.Router
 */
export default (router: Router): void => {
  router.get('/h5p/content/:id/:file(*)', getH5PContent);
  router.get('/h5p/play/:contentid', play);
};
