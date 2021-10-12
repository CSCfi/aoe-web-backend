import morgan from 'morgan';
import { Request, Response } from 'express';
import winstonLogger from './winston-logger';

export default morgan(':status :method :url :req[accept] HTTP/:http-version :remote-addr :user-agent', {
    skip: (req: Request, res: Response) => res.statusCode < 400,
    stream: {
        write: (message: string) => winstonLogger.http(message.slice(0, -1)) // Remove last character \n to avoid empty lines
    }
});
