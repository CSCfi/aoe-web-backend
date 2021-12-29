import { Request, Response, NextFunction } from "express";
import connection from "../resources/pg-connect";
import { winstonLogger } from '../util';

const db = connection.db;

export function checkAuthenticated(req: Request, res: Response, next: NextFunction): void {
    if (req.isAuthenticated()) {
        return next();
    } else {
        // return next();
        res.sendStatus(401);
    }
}

export async function getUserData(req: Request, res: Response): Promise<any> {
    const query = "SELECT termsofusage, email, verifiedemail, newratings, almostexpired, termsupdated, allowtransfer FROM users WHERE username = $1;";
    const data = await db.oneOrNone(query, [req.session.passport.user.uid]);
    res.status(200).json({
        "userdata": req.session.passport.user,
        "email": data.email,
        "termsofusage": data.termsofusage,
        "verifiedEmail": data.verifiedemail,
        "newRatings": data.newratings,
        "almostExpired": data.almostexpired,
        "termsUpdated": data.termsupdated,
        "allowTransfer": data.allowtransfer
    });
//  console.log("The req session in getuserdata: " + JSON.stringify(req.session));
}

export async function hasAccesstoPublication(id: number, req: Request): Promise<any> {
    // Tähän tulee se query, en ihan tiedä miten tää haku menee, mutta vanhan kuvan mukaan näin
    // Mulla ei oo sama possu versio niin saaattaa olla että jotain meni väärin, en pysty testailla lokaalisti
    try {
        if (!req.session.passport) {
            return false;
        }
        const params = {"id": id};
        const query = "SELECT UsersUserName from EducationalMaterial WHERE id = $1";
        const result = await db.oneOrNone(query, params.id);
        if (req.session.passport.user.uid === result) {
            return true;
        } else {
            return false;
        }
    } catch (error) {
        throw new Error('Error in hasAccesstoPublication(): ' + error);
    }
}

export async function InsertUserToDatabase(userinfo: any, acr: string): Promise<any> {
    try {
        winstonLogger.debug("The userinfo in function at authservice: " + userinfo);
        let uid: string;
        if (acr == process.env.SUOMIACR) {
            uid = userinfo["sub"];
        } else if (acr == process.env.HAKAACR) {
            uid = userinfo["eppn"];
        } else if (acr == process.env.MPASSACR) {
            uid = userinfo["mpass_uid"];
        } else {
            throw new Error("Unknown authentication method");
        }
        const query = "SELECT exists (SELECT 1 FROM users WHERE username = $1 LIMIT 1)";
        const data = await db.oneOrNone(query, [uid]);
        if (!data.exists) {
            const query = "insert into users (firstname , lastname, username, preferredlanguage,preferredtargetname,preferredalignmenttype )values ($1,$2,$3,'fi','','');";
            await db.none(query, [userinfo["given_name"], userinfo["family_name"], uid]);
        }
    } catch (e) {
        winstonLogger.error('Error in InsertUserToDatabase(): ' + e);
        return Promise.reject(e);
    }
}

export async function hasAccessToPublicatication(req: Request, res: Response, next: NextFunction): Promise<any> {
    const query = "SELECT usersusername FROM educationalmaterial WHERE id = $1";
    const eduMaterial = await db.oneOrNone(query, [req.params.edumaterialid]);
    if (req.session.passport.user.uid === eduMaterial.usersusername) {
        return next();
    }
    res.sendStatus(401);
}

export async function hasAccessToMaterial(req: Request, res: Response, next: NextFunction): Promise<any> {
    let id = req.params.materialId;
    if (req.params.materialId) {
        id = req.params.materialId;
    } else if (req.params.fileid) {
        id = req.params.fileid;
    }
    const query = "Select usersusername from material inner join educationalmaterial on educationalmaterialid = educationalmaterial.id where material.id = $1";
    const result = await db.oneOrNone(query, [id]);
    winstonLogger.debug(req.session.passport.user.uid);
    winstonLogger.debug(result);
    if (!result) {
        winstonLogger.debug("No result found for id " + id);
        return res.sendStatus(401);
    }
    if (req.session.passport.user.uid === result.usersusername) {
        return next();
    } else {
        res.sendStatus(401);
    }
}

export async function hasAccessToAttachmentFile(req: Request, res: Response, next: NextFunction): Promise<any> {
    const id = req.params.attachmentid;
    const query = "Select usersusername from material inner join educationalmaterial on educationalmaterialid = educationalmaterial.id where material.id = " +
        "(select materialid from attachment where attachment.id =$1);";
    const result = await db.oneOrNone(query, [id]);
    winstonLogger.debug(req.session.passport.user.uid);
    winstonLogger.debug(result);
    if (!result) {
        winstonLogger.debug("No result found for id " + id);
        return res.sendStatus(401);
    }
    if (req.session.passport.user.uid === result.usersusername) {
        return next();
    } else {
        res.sendStatus(401);
    }
}

export async function hasAccessToCollection(req: Request, res: Response, next: NextFunction): Promise<any> {
    const id = req.body.collectionId;
    const result = await hasAccessToCollectionId(id, req.session.passport.user.uid);
    if (!result) {
        winstonLogger.debug("No result found for " + [id, req.session.passport.user.uid]);
        return res.sendStatus(401);
    } else {
        return next();
    }
}

export async function hasAccessToCollectionParams(req: Request, res: Response, next: NextFunction): Promise<any> {
    const id = req.params.collectionid;
    const result = await hasAccessToCollectionId(id, req.session.passport.user.uid);
    if (!result) {
        winstonLogger.debug("No result found for " + [id, req.session.passport.user.uid]);
        return res.sendStatus(401);
    } else {
        return next();
    }
}

export async function hasAccessToCollectionId(id: string, username: string): Promise<any> {
    const query = "Select usersusername from userscollection where collectionid = $1 and usersusername = $2;";
    const result = await db.oneOrNone(query, [id, username]);
    if (!result) {
        winstonLogger.debug("No result found for " + [id, username]);
        return false;
    } else {
        return true;
    }
}

export async function hasAccessToAoe(req: Request, res: Response, next: NextFunction): Promise<any> {
    try {
        if (!req.isAuthenticated()) {
            return res.sendStatus(401);
        }
        const result = await hasAoeAccess(req.session.passport.user.uid);
        if (!result) {
            winstonLogger.error('Unauthorized process request by ', [req.session.passport.user.uid]);
            return res.sendStatus(401);
        } else {
            return next();
        }
    } catch (error) {
        winstonLogger.error('Authorization failed in hasAccessToAoe(): ' + error);
        return res.sendStatus(500);
    }
}

export async function userInfo(req: Request, res: Response): Promise<any> {
    try {
        if (!req.isAuthenticated()) {
            return res.sendStatus(404);
        }
        const result = await hasAoeAccess(req.session.passport.user.uid);
        if (!result) {
            winstonLogger.debug("No Aoe result found for " + [req.session.passport.user.uid]);
            return res.sendStatus(404);
        } else {
            return res.sendStatus(200);
        }
    } catch (e) {
        console.error(e);
        return res.sendStatus(404);
    }
}

export async function hasAoeAccess(username: string): Promise<any> {
    const query = "SELECT username FROM aoeuser WHERE username = $1";
    const result = await db.oneOrNone(query, [username]);
    if (!result) {
        return false;
    } else {
        return true;
    }
}

export function logout(req: Request, res: Response): void {
    req.logout();
    res.status(200).json({"status": "ok"});
}

export default {
    getUserData,
    hasAccesstoPublication,
    checkAuthenticated,
    InsertUserToDatabase,
    hasAccessToPublicatication,
    logout,
    hasAccessToMaterial,
    hasAccessToAttachmentFile,
    hasAccessToCollection,
    hasAccessToCollectionParams,
    userInfo,
};
