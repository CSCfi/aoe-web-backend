import { Request, Response, NextFunction } from "express";
const connection = require("./../db");
const db = connection.db;

export function checkAuthenticated (req: Request, res: Response, next: NextFunction) {
    if (req.isAuthenticated()) {
        return next();
    }
    else {
        res.sendStatus(401);
    }
}

export async function getUserData(req: Request, res: Response) {
    const query = "SELECT termsofusage, email, verifiedemail, newratings, almostexpired, termsupdated, allowtransfer FROM users WHERE username = $1;";
    const data = await db.oneOrNone(query, [req.session.passport.user.uid]);
    res.status(200).json({"userdata" : req.session.passport.user,
                            "email" : data.email,
                            "termsofusage" : data.termsofusage,
                            "verifiedEmail" : data.verifiedemail,
                            "newRatings" : data.newratings,
                            "almostExpired": data.almostexpired,
                            "termsUpdated": data.termsupdated,
                            "allowTransfer": data.allowtransfer});
//  console.log("The req session in getuserdata: " + JSON.stringify(req.session));
}

export async function hasAccesstoPublication(id: number, req: Request) {
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
        }
        else {
            return false;
        }
    }
    catch (error) {
        console.log(error);
        throw new Error(error);
    }
}

export async function InsertUserToDatabase(userinfo: object, acr: string) {
    try {
        console.log("The userinfo in function at authservice: " + userinfo);
        let uid: string;
        if (acr == process.env.SUOMIACR) {
            uid = userinfo["sub"];
        }
        else if (acr == process.env.HAKAACR) {
            uid = userinfo["eppn"];
        }
        else if (acr == process.env.MPASSACR) {
            uid = userinfo["mpass_uid"];
        }
        else {
            throw new Error("Unknown authentication method");
        }
        const query = "SELECT exists (SELECT 1 FROM users WHERE username = $1 LIMIT 1)";
        const data = await db.oneOrNone(query, [uid]);
        if (!data.exists) {
            const query = "insert into users (firstname , lastname, username, preferredlanguage,preferredtargetname,preferredalignmenttype )values ($1,$2,$3,'fi','','');";
            await db.none(query, [userinfo["given_name"], userinfo["family_name"], uid]);
        }
    }
    catch (e) {
        console.log(e);
        return Promise.reject(e);
    }
}

export async function hasAccessToPublicaticationMW(req: Request, res: Response, next: NextFunction) {
    let id = req.params.id;
    if (req.params.id) {
        id = req.params.id;
    }
    else if (req.params.materialId) {
        id = req.params.materialId;
    }
    else if (req.params.materialid) {
        id = req.params.materialid;
    }
    const query = "SELECT UsersUserName from EducationalMaterial WHERE id = $1";
    const result = await db.oneOrNone(query, [id]);
    console.log(req.session.passport.user.uid);
    console.log(result);
    if (!result) {
        console.log("No result found for id " + id);
        return res.sendStatus(401);
    }
    if (req.session.passport.user.uid === result.usersusername) {
        return next();
    }
    else {
        res.sendStatus(401);
    }
}

export async function hasAccessToMaterial(req: Request, res: Response, next: NextFunction) {
    let id = req.params.materialId;
    if (req.params.materialId) {
        id = req.params.materialId;
    }
    else if (req.params.fileid) {
        id = req.params.fileid;
    }
    const query = "Select usersusername from material inner join educationalmaterial on educationalmaterialid = educationalmaterial.id where material.id = $1";
    const result = await db.oneOrNone(query, [id]);
    console.log(req.session.passport.user.uid);
    console.log(result);
    if (!result) {
        console.log("No result found for id " + id);
        return res.sendStatus(401);
    }
    if (req.session.passport.user.uid === result.usersusername) {
        return next();
    }
    else {
        res.sendStatus(401);
    }
}

export async function hasAccessToAttachmentFile(req: Request, res: Response, next: NextFunction) {
    const id = req.params.attachmentid;
    const query = "Select usersusername from material inner join educationalmaterial on educationalmaterialid = educationalmaterial.id where material.id = " +
                    "(select materialid from attachment where attachment.id =$1);";
    const result = await db.oneOrNone(query, [id]);
    console.log(req.session.passport.user.uid);
    console.log(result);
    if (!result) {
        console.log("No result found for id " + id);
        return res.sendStatus(401);
    }
    if (req.session.passport.user.uid === result.usersusername) {
        return next();
    }
    else {
        res.sendStatus(401);
    }
}

export async function hasAccessToCollection(req: Request, res: Response, next: NextFunction) {
    const id = req.body.collectionId;
    const result = await hasAccessToCollectionId(id, req.session.passport.user.uid);
    if (!result) {
        console.log("No result found for " + [id, req.session.passport.user.uid]);
        return res.sendStatus(401);
    }
    else {
        return next();
    }
}

export async function hasAccessToCollectionParams(req: Request, res: Response, next: NextFunction) {
    const id = req.params.id;
    const result = await hasAccessToCollectionId(id, req.session.passport.user.uid);
    if (!result) {
        console.log("No result found for " + [id, req.session.passport.user.uid]);
        return res.sendStatus(401);
    }
    else {
        return next();
    }
}
export async function hasAccessToCollectionId(id: string, username: string) {
    const query = "Select usersusername from userscollection where collectionid = $1 and usersusername = $2;";
    const result = await db.oneOrNone(query, [id, username]);
    if (!result) {
        console.log("No result found for " + [id, username]);
        return false;
    }
    else {
        return true;
    }
}

export async function hasAccessToAoe(req: Request, res: Response, next: NextFunction) {
    try {
        if (!req.isAuthenticated()) {
            return res.sendStatus(401);
        }
        const result = await hasAoeAccess(req.session.passport.user.uid);
        if (!result) {
            console.log("No Aoe result found for " + [req.session.passport.user.uid]);
            return res.sendStatus(401);
        }
        else {
            return next();
        }
    }
    catch (e) {
        console.error(e);
        return res.sendStatus(500);
    }
}

export async function userInfo(req: Request, res: Response, next: NextFunction) {
    try {
        if (!req.isAuthenticated()) {
            return res.sendStatus(404);
        }
        const result = await hasAoeAccess(req.session.passport.user.uid);
        if (!result) {
            console.log("No Aoe result found for " + [req.session.passport.user.uid]);
            return res.sendStatus(404);
        }
        else {
            return res.sendStatus(200);
        }
    }
    catch (e) {
        console.error(e);
        return res.sendStatus(404);
    }
}

export async function hasAoeAccess(username: string) {
    const query = "Select username from aoeuser where username = $1;";
    const result = await db.oneOrNone(query, [username]);
    if (!result) {
        console.log("No result found for " + [username]);
        return false;
    }
    else {
        return true;
    }
}

export function logout(req: Request, res: Response) {
    req.logout();
    res.redirect("/");
}
// module.exports = {
//     isUser: isUser,
//     getUserData: getUserData,
//     hasAccesstoPublication,
//     checkAuthenticated: checkAuthenticated,
//     InsertUserToDatabase: InsertUserToDatabase,
//     hasAccessToPublicaticationMW: hasAccessToPublicaticationMW,
//     logout: logout,
//     hasAccessToMaterial : hasAccessToMaterial,
//     hasAccessToAttachmentFile : hasAccessToAttachmentFile,
//     hasAccessToCollection,
//     hasAccessToCollectionParams
//     // hasAccess: hasAccess,
// };