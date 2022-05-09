import winstonLogger from './winstonLogger';
import { NextFunction, Request, Response } from 'express';

export default (req: Request, res: Response, next: NextFunction): void => {
    winstonLogger.log('dw', 'HTTP: %s %s [%o]', req.method, req.originalUrl, req.body);
    next();
};