import winstonLogger from './winstonLogger';
import { NextFunction, Request, Response } from 'express';

export default (req: Request, res: Response, next: NextFunction): void => {
    try {
        winstonLogger.log('dw', 'HTTP: %s %s' + req.method, req.originalUrl);
    } catch (error) {
        winstonLogger.error(`DW logging failed: ${error}`);
    }
    next();
};