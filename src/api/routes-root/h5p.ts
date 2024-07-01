import { downloadAndRenderH5P, user } from '@services/h5pService';
import { Router } from 'express';
import { Request, Response } from 'express';

/**
 * Root level Open API for H5P interactive web materials.
 * Sessions and cookies are not created.
 *
 * @param router express.Router
 */
export default (router: Router): void => {
  const moduleRoot = '/h5p';

  router.get(`${moduleRoot}/play/:keyS3`, downloadAndRenderH5P);
  // router.get('/h5p/content/:id/:file(*)', getH5PContent);

  // H5P application state not supported for anonymous users in AOE.
  router.get(`${moduleRoot}/contentUserData/:contentID/state/:stateID`, (req: Request, res: Response): void => {
    res.status(204).end();
  });

  // H5P application state not supported for anonymous users in AOE.
  router.post(`${moduleRoot}/contentUserData/:contentID/state/:stateID`, (req: Request, res: Response): void => {
    res.status(204).end();
  });

  // H5P download link currently not supported in AOE.
  router.get(`${moduleRoot}/download/:contentID`, (req: Request, res: Response): void => {
    res.status(204).end();
  });
};
