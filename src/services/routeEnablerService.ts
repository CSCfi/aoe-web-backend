import { Request, Response, NextFunction } from "express";
import { ErrorHandler } from "./../helpers/errorHandler";
export async function isAllasEnabled(req: Request, res: Response, next: NextFunction) {
    try {
        const allas = Number(process.env.ALLAS_ENABLED);
        console.log(allas);
        if (!allas) {
            console.log("allas disabled");
            const statusCode = 503;
            const message = "Allas service unavailable";
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
            const message = "Login service unavailable";
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