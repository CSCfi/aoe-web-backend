import { winstonLogger } from './winstonLogger';
import { NextFunction, Request, Response } from 'express';

export default (req: Request, res: Response, next: NextFunction): void => {
  try {
    winstonLogger.log('digi', '%s %s %o', req.method, req.originalUrl, req.headers);
  } catch (error) {
    winstonLogger.error(`Digivisio logging failed: ${error}`);
  }
  next();
};
