import { Router } from 'express';
import { getH5PContent, play } from '../../h5p/h5p';

/**
 * Open root level API for H5P interactive web materials.
 * Sessions and cookies not created.
 *
 * @param router express.Router
 */
export default (router: Router) => {

    router.get('/h5p/content/:id/:file(*)', getH5PContent);
    router.get('/h5p/play/:contentid', play);

}