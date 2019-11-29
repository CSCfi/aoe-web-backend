import { Request, Response, NextFunction } from "express";
const connection = require("./../db");
const db = connection.db;

function checkAuthenticated (req: Request, res: Response, next: NextFunction) {
    if (req.isAuthenticated()) {
        return next();
    }
    else {
        res.sendStatus(401);
    }
}

function getUserData(req: Request, res: Response) {

 res.status(200).json(req.session.passport.user);
//  console.log("The req session in getuserdata: " + JSON.stringify(req.session));
}

function isUser(req: Request) {
    // Checking that the user actually exists, for this, the userdata has to be present
    // in the session data
        if (!req.session.userdata.id) {
            return false;
        }
        else if (req.session.userdata.id === db.select("Here we look if ID exist in db, ie. user exists and matches. DO QUERY HERE")) {
            return true;
        }
        else {
            return false;
        }
}

async function hasAccesstoPublication(id: number, req: Request) {
    // Tähän tulee se query, en ihan tiedä miten tää haku menee, mutta vanhan kuvan mukaan näin
    // Mulla ei oo sama possu versio niin saaattaa olla että jotain meni väärin, en pysty testailla lokaalisti
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

async function InsertUserToDatabase(userinfo: object) {
    try {
        console.log("The userinfo in function at authservice: " + userinfo);
        const uid = userinfo["uid"];
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

async function hasAccessToPublicaticationMW(req: Request, res: Response, next: NextFunction) {
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
    if (req.session.passport.user.uid === result.usersusername) {
        return next();
    }
    else {
        res.sendStatus(401);
    }
}

module.exports = {
    isUser: isUser,
    getUserData: getUserData,
    hasAccesstoPublication,
    checkAuthenticated: checkAuthenticated,
    InsertUserToDatabase: InsertUserToDatabase,
    hasAccessToPublicaticationMW: hasAccessToPublicaticationMW
    // hasAccess: hasAccess,
};