import { Router } from 'express';
import ah from '../../services/authService';

/**
 * Open root level API for H5P interactive web materials.
 * Sessions and cookies not created.
 *
 * @param router express.Router
 */
export default (router: Router) => {

    router.post('/logout', ah.logout);

}