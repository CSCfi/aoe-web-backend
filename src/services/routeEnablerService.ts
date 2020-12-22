import { Request, Response, NextFunction } from "express";
import { ErrorHandler } from "./../helpers/errorHandler";
export interface AoeRouteMessage {
    "enabled": string;
    "message": {
        "fi": string;
        "en": string;
        "sv": string;
    };
    "alertType": string;
}
export const alertTypeDanger = "danger";
export const allasErrorMessage = "Palvelussamme on tällä hetkellä vikatilanne. Uusien oppimateriaalien tallentaminen on estetty ongelman selvittämisen ajaksi. Korjaamme ongelman mahdollisimman pian. Ajankohtaisimmat tiedot Twitter-kanavallamme @aoe_suomi.";
export const allasErrorMessageEn = "We currently have an error that affects using the service. Uploading new learning resources has been blocked until the problem is resolved. We will fix the problem as soon as possible. Find the latest information on our Twitter channel @aoe_suomi.";
export const allasErrorMessageSv = "Vi har för närvarande ett fel som påverkar användningen av tjänsten. Publicering av nya lärresurser har blockerats tills problemet har lösts. Vi löser problemet så snart som möjligt. Hitta den senaste informationen på vår Twitter-kanal @aoe_suomi.";
export const loginErrorMessage = "Palveluun kirjautumisessa on tällä hetkellä ongelmaa. Selvitämme asiaa ja korjaamme sen mahdollisimman pian. Ajankohtaisimmat tiedot Twitter-kanavallamme @aoe_suomi.";
export const loginErrorMessageEn = "There is currently an error in signing in to the service. We will fix the problem as soon as possible. Find the latest information on our Twitter channel @aoe_suomi.";
export const loginErrorMessageSv = "Det finns för närvarande ett fel vid inloggning på tjänsten. Vi löser problemet så snart som möjligt. Hitta den senaste informationen på vår Twitter-kanal @aoe_suomi.";
export async function isAllasEnabled(req: Request, res: Response, next: NextFunction) {
    try {
        const allas = Number(process.env.ALLAS_ENABLED);
        console.log(allas);
        if (!allas) {
            console.log("allas disabled");
            const statusCode = 503;
            const message = allasErrorMessage;
            res.status(statusCode).json({
                status: "error",
                statusCode,
                message
            });

        }
        else {
            console.log("allas enabled");
            next();
        }
    }
    catch (e) {
        next(new ErrorHandler(e, "Issue in file sending"));
    }
}

export async function isLoginEnabled(req: Request, res: Response, next: NextFunction) {
    try {
        const login = Number(process.env.LOGIN_ENABLED);
        if (!login) {
            const statusCode = 503;
            const message = loginErrorMessage;
            res.status(statusCode).json({
                status: "error",
                statusCode,
                message
            });

        }
        else {
            next();
        }
    }
    catch (e) {
        next(new ErrorHandler(e, "Issue in login"));
    }
}

export async function aoeRoutes(req: Request, res: Response, next: NextFunction) {
    try {
        const allasMessageObject = {
            "fi": allasErrorMessage,
            "en": allasErrorMessageEn,
            "sv": allasErrorMessageSv
        };
        const loginMessageObject = {
            "fi": loginErrorMessage,
            "en": loginErrorMessageEn,
            "sv": loginErrorMessageSv
        };
        const allas: AoeRouteMessage = {
            "enabled" : process.env.ALLAS_ENABLED,
            "message" : allasMessageObject,
            "alertType" : alertTypeDanger
        };
        const login: AoeRouteMessage = {
            "enabled" : process.env.LOGIN_ENABLED,
            "message" : loginMessageObject,
            "alertType" : alertTypeDanger
        };
        res.status(200).json({
            allas,
            login
        });
    }
    catch (e) {
        next(new ErrorHandler(e, "Issue in messages info"));
    }
}