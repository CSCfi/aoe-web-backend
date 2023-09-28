import { NextFunction, Request, Response } from 'express';
import { ValidationError, validationResult } from 'express-validator';

export default async (req: Request, res: Response, next: NextFunction): Promise<any> => {
  const errorFormatter = ({ location, msg, param /*value, nestedErrors*/ }: ValidationError) => {
    return `${location}[${param}]: ${msg}`;
  };
  const result = validationResult(req).formatWith(errorFormatter);
  if (!result.isEmpty()) {
    return res.status(400).json({ errors: result.array() }).end();
  }
  next();
};
