import { Router } from 'express';
import { material } from './routes-v1';

export default (router: Router) => {
    material(router);
}
