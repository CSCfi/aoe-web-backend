import { Request, Response, NextFunction } from "express";
const connection = require("./../db");
// const db = connection.db;
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

 res.status(200).json(JSON.stringify(req.session.passport.user));
 console.log("The req session in getuserdata: " + JSON.stringify(req.session));
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
    const query = "SELECT UsersUserName from EducationalMaterial WHERE id = ${id}";
    const result = await db.oneOrNone(query, params);
    if (req.session.passport.user.uid === result) {
        return true;
    }
    else {
        return false;
    }
}

async function InsertUserToDatabase(userinfo: object) {
    console.log("The userinfo in function at authservice: " + userinfo);
    const uid = userinfo["uid"];
    const nameparsed = userinfo["given_name"] + " " + userinfo["family_name"];
    const email = userinfo["email"];
    const query = "SELECT * from Users";

    // Tähän tulee se query, en muista miten multiple insertit meni, jos ehdit tehdä tän niin loistavaa
    // Teen sen muuten maanantaina
    // const query = "INSERT ";
    // await db.oneOrNone(query);
    const result = await db.any(query);
    result.forEach( element => {
        if (element.UserName === uid ) {
            console.log("User already exists, proceed without doing anything");
        }
        else {
            const params2 = {"uid": uid, "nameparsed": nameparsed, "email": email};
            // Tää query line jäi vähän vajaaksi, en pysty testailla lokaaalisti ku eri kanta, mutta periaatteessa tossa vaan
            // Tulee se multiple insert ja ylhäällä on parametrit
            const query2 = "INSERT INTO USERS";
            db.insert(query2, params2);
        }

    });




}

module.exports = {
    isUser: isUser,
    getUserData: getUserData,
    hasAccesstoPublication,
    checkAuthenticated: checkAuthenticated,
    InsertUserToDatabase: InsertUserToDatabase
    // hasAccess: hasAccess,
};