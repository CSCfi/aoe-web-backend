import { Router } from 'express';
import ah from '../../services/authService';

/**
 * Open root level API for the session log out.
 *
 * @param router express.Router
 */
export default (router: Router) => {

    router.post('/logout', ah.logout);

}