import morgan from 'morgan';
import { Request, Response } from 'express';
import winstonLogger from '@util/winstonLogger';

export default morgan(':status :method :url :req[accept] HTTP/:http-version :remote-addr :user-agent', {
  skip: (req: Request, res: Response): boolean => {
    const { path, method }: { path: string; method: string } = req;
    if (/\/userdata$/.test(path) && method === 'GET') {
      return true;
    }
    return res.statusCode < 400;
  },
  stream: {
    write: (message: string) => winstonLogger.http(message.slice(0, -1)), // Remove last character \n to avoid empty lines
  },
});
