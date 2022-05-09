import winstonLogger from './winstonLogger';
import { NextFunction, Request, Response } from 'express';

export default (req: Request, res: Response, next: NextFunction): void => {
    winstonLogger.log('dw', 'HTTP: %s', JSON.stringify(req));
    next();
};