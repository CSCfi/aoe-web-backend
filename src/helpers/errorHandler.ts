import { winstonLogger } from '../util';
import { Response } from 'express';

export class ErrorHandler extends Error {
    statusCode: number;

    constructor(statusCode: number, message: string) {
        super();
        this.statusCode = statusCode;
        this.message = message;
    }
}

export const genericErrorMessage = 'Palvelussamme on tällä hetkellä vikatilanne. Selvitämme ongelmaa ja korjaamme sen mahdollisimman pian. Ajankohtaisimmat tiedot Twitter-kanavallamme @aoe_suomi.';
export const genericErrorMessageEn = 'We currently have an error that affects using the service. We will fix the problem as soon as possible. Find the latest information on our Twitter channel @aoe_suomi.';
export const genericErrorMessageSv = 'Vi har för närvarande ett fel som påverkar användningen av tjänsten. Vi löser problemet så snart som möjligt. Hitta den senaste informationen på vår Twitter-kanal @aoe_suomi.';

export const handleError = (err, res: Response) => {
    let { statusCode } = err;
    let { message } = err;
    winstonLogger.error('Request default error handler: ' + message);
    // send generic error message
    message = {
        "fi": genericErrorMessage,
        "en": genericErrorMessageEn,
        "sv": genericErrorMessageSv
    };
    if (!statusCode) {
        statusCode = 500;
    }
    res.status(statusCode).json({
        status: 'error',
        statusCode,
        message
    });
};
