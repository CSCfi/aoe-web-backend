import { Request, Response, NextFunction } from "express";
import { ErrorHandler } from "./../helpers/errorHandler";
export interface AoeRouteMessage {
    "enabled": string;
    "message": string;
    "alertType": string;
}

export const allasErrorMessage = "Palvelussamme on tällä hetkellä vikatilanne. Uusien oppimateriaalien tallentaminen on estetty ongelman selvittämisen ajaksi. Korjaamme ongelman mahdollisimman pian. Ajankohtaisimmat tiedot Twitter-kanavallamme @aoe_suomi.";
export const loginErrorMessage = "Palveluun kirjautumisessa on tällä hetkellä ongelmaa. Selvitämme asiaa ja korjaamme sen mahdollisimman pian. Ajankohtaisimmat tiedot Twitter-kanavallamme @aoe_suomi.";

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
        const allas: AoeRouteMessage = {
            "enabled" : process.env.ALLAS_ENABLED,
            "message" : allasErrorMessage,
            "alertType" : "red"
        };
        const login: AoeRouteMessage = {
            "enabled" : process.env.LOGIN_ENABLED,
            "message" : loginErrorMessage,
            "alertType" : "red"
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