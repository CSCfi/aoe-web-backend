import {
  addLinkToMaterial,
  getEducationalMaterialMetadata,
  setEducationalMaterialObsoleted,
} from '../../queries/apiQueries';
import { checkAuthenticated, hasAccessToPublicatication } from '../../services/authService';
import { NextFunction, Request, Response, Router } from 'express';
import { downloadMaterialFile } from '../../queries/fileHandling';
import { updateEducationalMaterialMetadata } from '../../controllers/educationalMaterial';
import { runMessageQueueThread } from '../../services/threadService';
import { winstonLogger } from '../../util/winstonLogger';

/**
 * API version 1.0 for requesting files and metadata related to stored educational material.
 * This module is a collection of legacy endpoints starting with /material/.
 * Endpoints ordered by the request URL (1) and method (2).
 *
 * @param router express.Router
 */
export default (router: Router): void => {
  // Set educational material obsoleted (archived) and hide it from the search results - data remains in the database.
  router.delete(
    '/material/:edumaterialid',
    checkAuthenticated,
    hasAccessToPublicatication,
    setEducationalMaterialObsoleted,
  );

  // Create new version of an educational material by updating the metadata, update search index and assign a new PID.
  router.put(
    '/material/:edumaterialid',
    checkAuthenticated,
    hasAccessToPublicatication,
    updateEducationalMaterialMetadata,
  );

  // Get all metadata of an educational material.
  // Version specified optionally with publishing date (:publishedat).
  // :publishedat format 'YYYY-MM-DDTHH:mm:ss.SSSZ' (ISODate) - regex path validation in API v2.0.
  // :edumaterialid defined as a number between 1 to 6 digits to prevent similar endpoints collision.
  router.get(
    '/material/:edumaterialid([0-9]{1,6})/:publishedat?',
    (req: Request, res: Response, next: NextFunction) => {
      getEducationalMaterialMetadata(req, res, next, false).catch(() => {
        winstonLogger.error('Metadata request failed for a single file download.');
      });
    },
    (req: Request, res: Response) => {
      if (['view', 'edit'].includes(req.query.interaction as string)) {
        runMessageQueueThread(req, res).then((result) => {
          if (result) winstonLogger.debug('THREAD: Message queue publishing completed for %o', result);
        });
      }
      res.end();
    },
  );

  // Download all files related to an educational material and stream as a single zip file from the cloud object storage.
  // :publishedat format: 'YYYY-MM-DDTHH:mm:ss.SSSZ' (ISODate) - regex path validation in API v2.0.
  // :edumaterialid defined as a number between 1 to 6 digits to prevent similar endpoints collision.
  router.get('/material/file/:edumaterialid([0-9]{1,6})/:publishedat?', downloadMaterialFile);

  // Save a link type material to an educational material.
  router.post('/material/link/:edumaterialid', checkAuthenticated, hasAccessToPublicatication, addLinkToMaterial);
};
