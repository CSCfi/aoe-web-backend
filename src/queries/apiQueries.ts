import { Request, Response, NextFunction } from "express";



const connection = require("./../db");
const pgp = connection.pgp;
const db = connection.db;
const elasticSearch = require("./../elasticSearch/es");
// const dbHelpers = require("./../databaseHelpers");


async function addLinkToMaterial(req: Request , res: Response , next: NextFunction) {
    try {
        db.tx(async (t: any) => {
            const queries: any = [];
            let query;
            query = "insert into material (link, educationalmaterialid, materiallanguagekey, priority) values ($1,$2,$3,$4) returning id, link;";
            const data = await t.one(query, [req.body.link, req.params.materialId, req.body.language, req.body.priority]);
            queries.push(data);
            const displayName = req.body.displayName;
            query = "INSERT INTO materialdisplayname (displayname, language, materialid) (SELECT $1,$2,$3 where $3 in (select id from material where educationalmaterialid = $4)) ON CONFLICT (language, materialid) DO UPDATE Set displayname = $1;";
            if (displayName.fi === null) {
                queries.push(await t.none(query, ["", "fi", data.id, req.params.materialId]));
            }
            else {
                queries.push(await t.none(query, [displayName.fi, "fi", data.id, req.params.materialId]));
            }
            if (displayName.sv === null) {
                queries.push(await t.none(query, ["", "sv", data.id, req.params.materialId]));
            }
            else {
                queries.push(await t.none(query, [displayName.sv, "sv", data.id, req.params.materialId]));
            }
            if (displayName.en === null) {
                queries.push(await t.none(query, ["", "en", data.id, req.params.materialId]));
            }
            else {
                queries.push(await t.none(query, [displayName.en, "en", data.id, req.params.materialId]));
            }
            query = "update educationalmaterial set updatedat = now() where id = $1;";
            queries.push(await db.none(query, [req.params.materialId]));
            return t.batch(queries);
        })
        .then((result: any) => {
            const response = {
                "id": req.params.materialId,
                "link" : result[0]
            };
            res.status(200).json(response);
        })
        .catch((err: Error) => {
            console.log(err);
            res.status(400).send("error in updating");
        });
    }
    catch (err ) {
        console.log(err);
        res.status(400).send("error in updating");
    }
}


async function getMaterial(req: Request , res: Response , next: NextFunction) {
    try {
        let query;
        // let params = { };

        query = "SELECT * FROM educationalmaterial where obeleted != 1 order by id desc limit 100;";
        const data = await db.any(query);
        res.status(200).json(data);
    }
    catch (err ) {
        console.log(err);
        res.status(500).send("getting materials not succeeded");
    }
}

const TransactionMode = pgp.txMode.TransactionMode;
const isolationLevel = pgp.txMode.isolationLevel;

// Create a reusable transaction mode (serializable + read-only + deferrable):
const mode = new TransactionMode({
    tiLevel: isolationLevel.serializable,
    readOnly: true,
    deferrable: true
});

async function getMaterialData(req: Request , res: Response , next: NextFunction) {

    db.tx({mode}, async (t: any) => {
        const queries: any = [];
        let query;
        query = "SELECT * FROM educationalmaterial WHERE id = $1 and obsoleted != '1';";
        let response = await t.any(query, [req.params.id]);
        queries.push(response);

        query = "select * from materialname where educationalmaterialid = $1;";
        response = await t.any(query, [req.params.id]);
        queries.push(response);

        query = "select * from materialdescription where educationalmaterialid = $1;";
        response = await t.any(query, [req.params.id]);
        queries.push(response);

        query = "select * from educationalaudience where educationalmaterialid = $1;";
        response = await t.any(query, [req.params.id]);
        queries.push(response);

        query = "select * from learningresourcetype where educationalmaterialid = $1;";
        response = await t.any(query, [req.params.id]);
        queries.push(response);

        query = "select * from accessibilityfeature where educationalmaterialid = $1;";
        response = await t.any(query, [req.params.id]);
        queries.push(response);

        query = "select * from accessibilityhazard where educationalmaterialid = $1;";
        response = await t.any(query, [req.params.id]);
        queries.push(response);

        query = "select * from keyword where educationalmaterialid = $1;";
        response = await t.any(query, [req.params.id]);
        queries.push(response);

        query = "select * from educationallevel where educationalmaterialid = $1;";
        response = await t.any(query, [req.params.id]);
        queries.push(response);

        query = "select * from educationaluse where educationalmaterialid = $1;";
        response = await t.any(query, [req.params.id]);
        queries.push(response);

        query = "select * from publisher where educationalmaterialid = $1;";
        response = await t.any(query, [req.params.id]);
        queries.push(response);

        query = "select * from author where educationalmaterialid = $1;";
        response = await t.any(query, [req.params.id]);
        queries.push(response);

        query = "select * from isbasedon where educationalmaterialid = $1;";
        response = await t.map(query, [req.params.id], (q: any) => {
            t.any("select * from isbasedonauthor where isbasedonid = $1;", q.id)
            .then((data: any) => {
                q.author = data;
            });
        return q;
        });
        queries.push(response);

        query = "select * from inlanguage where educationalmaterialid = $1;";
        response = await t.any(query, [req.params.id]);
        queries.push(response);

        query = "select * from alignmentobject where educationalmaterialid = $1;";
        response = await t.any(query, [req.params.id]);
        queries.push(response);

        query = "select m.id, m.materiallanguagekey as language, link, priority, filepath, originalfilename, filesize, mimetype, format, filekey, filebucket from material m left join record r on m.id = r.materialid where m.educationalmaterialid = $1 and m.obsoleted = 0 order by priority;";
        response = await t.any(query, [req.params.id]);
        queries.push(response);

        query = "SELECT users.id, users.firstname, users.lastname FROM educationalmaterial INNER JOIN users ON educationalmaterial.usersusername = users.username WHERE educationalmaterial.id = $1 and educationalmaterial.obsoleted != '1';";
        response = await t.any(query, [req.params.id]);
        queries.push(response);

        query = "SELECT dn.id, dn.displayname, dn.language, dn.materialid FROM material m right join materialdisplayname dn on m.id = dn.materialid where m.educationalmaterialid = $1 and m.obsoleted != '1';";
        response = await t.any(query, [req.params.id]);
        queries.push(response);

        query = "select * from educationalaudience where educationalmaterialid = $1;";
        response = await t.any(query, [req.params.id]);
        queries.push(response);

        query = "select * from thumbnail where educationalmaterialid = $1 and obsoleted = 0 limit 1;";
        response = await t.oneOrNone(query, [req.params.id]);
        queries.push(response);

        query = "select attachment.id, filepath, originalfilename, filesize, mimetype, format, filekey, filebucket, defaultfile, kind, label, srclang, materialid from material inner join attachment on material.id = attachment.materialid where material.educationalmaterialid = $1 and material.obsoleted = 0 and attachment.obsoleted = 0;";
        response = await t.any(query, [req.params.id]);
        console.log(query, [req.params.id]);
        queries.push(response);

        return t.batch(queries);
    })
    .then((data: any) => {
        const jsonObj: any = {};
        if (data[0][0] === undefined) {
            return res.status(200).json(jsonObj);
        }
        // add displayname object to material object
        for (const element of data[15]) {
            const nameobj = {"fi" : "",
                            "sv" : "",
                            "en" : ""};
            for (const element2 of data[17]) {
                if (element2.materialid === element.id) {
                    if (element2.language === "fi") {
                        nameobj.fi = element2.displayname;
                    }
                    else if (element2.language === "sv") {
                        nameobj.sv = element2.displayname;
                    }
                    else if (element2.language === "en") {
                        nameobj.en = element2.displayname;
                    }
                }
            }
            element.displayName = nameobj;
        }
        jsonObj.id = data[0][0].id;
        jsonObj.materials = data[15];
        jsonObj.owner = data[16];
        jsonObj.name = data[1];
        jsonObj.createdAt = data[0][0].createdat;
        jsonObj.updatedAt = data[0][0].updatedat;
        jsonObj.publishedAt = data[0][0].publishedat;
        jsonObj.archivedAt = data[0][0].archivedat;
        jsonObj.suitsAllEarlyChildhoodSubjects = data[0][0].suitsallearlychildhoodsubjects;
        jsonObj.suitsAllPrePrimarySubjects = data[0][0].suitsallpreprimarysubjects;
        jsonObj.suitsAllBasicStudySubjects = data[0][0].suitsallbasicstudysubjects;
        jsonObj.suitsAllUpperSecondarySubjects = data[0][0].suitsalluppersecondarysubjects;
        jsonObj.suitsAllVocationalDegrees = data[0][0].suitsallvocationaldegrees;
        jsonObj.suitsAllSelfMotivatedSubjects = data[0][0].suitsallselfmotivatedsubjects;
        jsonObj.suitsAllBranches = data[0][0].suitsallbranches;
        jsonObj.author = data[11];
        jsonObj.publisher = data[10];
        jsonObj.description = data[2];
        jsonObj.keywords = data[7];
        jsonObj.learningResourceTypes = data[4];
        jsonObj.timeRequired = data[0][0].timerequired;
        const typicalAgeRange: any = {};
        typicalAgeRange.typicalAgeRangeMin = data[0][0].agerangemin;
        typicalAgeRange.typicalAgeRangeMax = data[0][0].agerangemax;
        jsonObj.expires = data[0][0].expires;
        jsonObj.typicalAgeRange = typicalAgeRange;
        jsonObj.educationalAlignment = data[14];
        jsonObj.educationalLevels = data[8];
        jsonObj.educationalUses = data[9];
        jsonObj.inLanguage = data[13];
        jsonObj.accessibilityFeatures = data[5];
        jsonObj.accessibilityHazards = data[6];
        jsonObj.license = data[0][0].licensecode;
        jsonObj.isBasedOn = data[12];
        // jsonObj.materialDisplayName = data[17];
        jsonObj.educationalRoles = data[18];
        jsonObj.thumbnail = data[19];
        jsonObj.attachments = data[20];
        res.status(200).json(jsonObj);
    })
    .catch((error: any) => {
        console.log(error);
        res.sendStatus(400);
    });
}

async function getUserMaterial(req: Request , res: Response , next: NextFunction) {
    try {
        db.task(async (t: any) => {
            const params: any = [];
            let query;
            query = "SELECT id, licensecode as license FROM educationalmaterial WHERE usersusername = $1 and obsoleted != '1' limit 1000;";
            params.push(req.session.passport.user.uid);
            return t.map(query, params, async (q: any) => {
                query = "select * from materialname where educationalmaterialid = $1;";
                let response = await t.any(query, [q.id]);
                q.name = response;
                query = "select * from materialdescription where educationalmaterialid = $1;";
                response = await t.any(query, [q.id]);
                q.description = response;
                query = "select * from learningresourcetype where educationalmaterialid = $1;";
                response = await t.any(query, [q.id]);
                q.learningResourceTypes = response;
                query = "select * from keyword where educationalmaterialid = $1;";
                response = await t.any(query, [q.id]);
                q.keywords = response;
                query = "select * from author where educationalmaterialid = $1;";
                response = await t.any(query, [q.id]);
                q.authors = response;
                query = "Select filepath as thumbnail from thumbnail where educationalmaterialid = $1 and obsoleted = 0;";
                response = await db.oneOrNone(query, [q.id]);
                q.thumbnail = response;
                query = "select * from educationallevel where educationalmaterialid = $1;";
                response = await t.any(query, [q.id]);
                q.educationalLevels = response;
                return q;
            }).then(t.batch)
            .catch((error: any) => {
                console.log(error);
                return error;
            }) ;
        })
        .then((data: any) => {
        res.status(200).json(data);
        });
    }
    catch (err ) {
        console.log(err);
        res.sendStatus(500);
    }
}

async function getRecentMaterial(req: Request , res: Response , next: NextFunction) {
    try {
        db.task(async (t: any) => {
            const params: any = [];
            let query;
            query = "SELECT id, licensecode as license FROM educationalmaterial WHERE obsoleted != '1' AND publishedat IS NOT NULL ORDER BY educationalmaterial.updatedAt DESC LIMIT 6;";
            return t.map(query, params, async (q: any) => {
                query = "select * from materialname where educationalmaterialid = $1;";
                let response = await t.any(query, [q.id]);
                q.name = response;
                query = "select * from materialdescription where educationalmaterialid = $1;";
                response = await t.any(query, [q.id]);
                q.description = response;
                query = "select * from learningresourcetype where educationalmaterialid = $1;";
                response = await t.any(query, [q.id]);
                q.learningResourceTypes = response;
                query = "select * from keyword where educationalmaterialid = $1;";
                response = await t.any(query, [q.id]);
                q.keywords = response;
                query = "select * from author where educationalmaterialid = $1;";
                response = await t.any(query, [q.id]);
                q.authors = response;
                query = "Select filepath as thumbnail from thumbnail where educationalmaterialid = $1 and obsoleted = 0;";
                response = await db.oneOrNone(query, [q.id]);
                q.thumbnail = response;
                query = "select * from educationallevel where educationalmaterialid = $1;";
                response = await t.any(query, [q.id]);
                q.educationalLevels = response;
                return q;
            }).then(t.batch)
            .catch((error: any) => {
                console.log(error);
                return error;
            }) ;
        })
        .then((data: any) => {
        res.status(200).json(data);
        });
    }
    catch (err ) {
        console.log(err);
        res.sendStatus(500);
    }
}

async function deleteMaterial(req: Request , res: Response , next: NextFunction) {
    try {
        let query;
        let data;
        await db.tx({mode}, async (t: any) => {
            const queries: any = [];
            query = "update educationalmaterial SET obsoleted = '1' WHERE id = $1;";
            queries.push(await db.none(query, [req.params.id]));
            query = "update material SET obsoleted = '1' WHERE educationalmaterialid = $1 returning id;";
            data = await db.any(query, [req.params.id]);
            queries.push(data);
            const arr: string[] = [];
            for (let i = 1; i <= data.length; i++) {
                arr.push("('" + data[i - 1].id + "')");
            }
            if (arr.length > 0) {
                query = "update attachment SET obsoleted = '1' WHERE materialid in (" + arr.join(",") + " );";
                queries.push(await db.none(query));
            }
            query = "update educationalmaterial set updatedat = now() where id = $1";
            queries.push(await db.none(query, [req.params.id]));
            return t.batch(queries);
        });
        res.status(200).json({"status" : "deleted"});
        elasticSearch.updateEsDocument()
        .catch ((err: Error) => {
            console.log("Es update error");
            console.log(err);
        });
    }
    catch (err ) {
        console.log(err);
        res.sendStatus(500);
    }
}

async function deleteRecord(req: Request , res: Response , next: NextFunction) {
    try {
        let query;
        let data;
        await db.tx({mode}, async (t: any) => {
            const queries: any = [];
            query = "update material SET obsoleted = '1' WHERE id = $1 returning educationalmaterialid;";
            data = await db.one(query, [req.params.fileid]);
            queries.push(data);
            query = "update attachment SET obsoleted = '1' WHERE materialid = $1;";
            queries.push(await db.none(query, [req.params.fileid]));
            query = "update educationalmaterial set updatedat = now() where id = $1";
            queries.push(await db.none(query, [data.educationalmaterialid]));
            return t.batch(queries);
        });
        res.status(200).json({"status" : "deleted"});
        elasticSearch.updateEsDocument()
        .catch ((err: Error) => {
            console.log("Es update error");
            console.log(err);
        });
    }
    catch (err ) {
        console.log(err);
        res.sendStatus(500);
    }
}

async function deleteAttachment(req: Request , res: Response , next: NextFunction) {
    try {
        let query;
        let data;
        await db.tx({mode}, async (t: any) => {
            const queries: any = [];
            query = "update attachment SET obsoleted = '1' WHERE id = $1;";
            data = await db.any(query, [req.params.attachmentid]);
            queries.push(data);
            query = "update educationalmaterial set updatedat = now() where id = "
            + "(select educationalmaterialid from material where id = (select materialid from attachment where id = $1));";
            console.log(query);
            queries.push(await db.none(query, [req.params.attachmentid]));
            return t.batch(queries);
        });
        res.status(200).json({"status" : "deleted"});
        elasticSearch.updateEsDocument()
        .catch ((err: Error) => {
            console.log("Es update error");
            console.log(err);
        });
    }
    catch (err ) {
        console.log(err);
        res.sendStatus(500);
    }
}
// async function postMaterial(req: Request , res: Response , next: NextFunction) {
//     try {
//         let query;
//         const params = req.params;

//         query = "insert into educationalmaterial (materialName,slug,CreatedAt,PublishedAt,UpdatedAt,TechnicalName,timeRequired,agerangeMin,agerangeMax,UsersId) values ('matskun nimi 3','slugi',to_date('1900-01-01', 'YYYY-MM-DD'),to_date('1900-01-01', 'YYYY-MM-DD'),to_date('1900-01-01', 'YYYY-MM-DD'),'" + req.query.materialName + "','tekninen nimi','300','1','12','" + req.query.usersid + "') RETURNING id;";
//         const data = await db.any(query);
//         res.status(200).json(data);
//     }
//     catch (err ) {
//         console.log(err);
//         res.sendStatus(500);
//     }
// }

async function updateMaterial(req: Request , res: Response , next: NextFunction) {
    db.tx(async (t: any) => {
        let query;
        const queries: any = [];
        // let params = req.params;
        const materialname = req.body.name;
        const nameparams = [];
        let response;
        console.log("updateMaterial request body:");
        console.log(JSON.stringify(req.body));
        let arr = req.body.name;
        console.log("inserting material name");
        if (arr == undefined) {
            // query = "DELETE FROM materialname where educationalmaterialid = $1;";
            // response  = await t.any(query, [req.params.id]);
            // queries.push(response);
        }
        else {
            query = "INSERT INTO materialname (materialname, language, slug, educationalmaterialid) VALUES ($1,$2,$3,$4) ON CONFLICT (language,educationalmaterialid) DO " +
                    "UPDATE SET materialname = $1 , slug = $3;";
            console.log(query);
            if (materialname.fi === null) {
                queries.push(await t.any(query, ["", "fi", "", req.params.id]));
            }
            else {
                queries.push(await t.any(query, [materialname.fi, "fi", "", req.params.id]));
            }
            if (materialname.sv === null) {
                queries.push(await t.any(query, ["", "sv", "", req.params.id]));
            }
            else {
                queries.push(await t.any(query, [materialname.sv, "sv", "", req.params.id]));
            }
            if (materialname.en === null) {
                queries.push(await t.any(query, ["", "en", "", req.params.id]));
            }
            else {
                queries.push(await t.any(query, [materialname.en, "en", "", req.params.id]));
            }
        }

        // material
        console.log("inserting educationalmaterial");
        const dnow = Date.now() / 1000.0;
        query = "UPDATE educationalmaterial SET (expires,UpdatedAt,timeRequired,agerangeMin,agerangeMax,licensecode,suitsAllEarlyChildhoodSubjects,suitsAllPrePrimarySubjects,suitsAllBasicStudySubjects,suitsAllUpperSecondarySubjects,suitsAllVocationalDegrees,suitsAllSelfMotivatedSubjects,suitsAllBranches ,publishedat) = ($1,to_timestamp($2),$3,$4,$5,$7,$8,$9,$10,$11,$12,$13,$14,$15) where id=$6;";
        console.log(query, [req.body.expires, dnow, req.body.timeRequired, req.body.typicalAgeRange.typicalAgeRangeMin, req.body.typicalAgeRange.typicalAgeRangeMax, req.params.id, req.body.license]);
        queries.push(await t.any(query, [((req.body.expires == undefined) ? "9999-01-01T00:00:00+00:00" : req.body.expires), dnow, ((req.body.timeRequired == undefined) ? "" : req.body.timeRequired), ((req.body.typicalAgeRange.typicalAgeRangeMin == undefined) ? -1 : req.body.typicalAgeRange.typicalAgeRangeMin), ((req.body.typicalAgeRange.typicalAgeRangeMax == undefined) ? -1 : req.body.typicalAgeRange.typicalAgeRangeMax), req.params.id, req.body.license, req.body.suitsAllEarlyChildhoodSubjects, req.body.suitsAllPrePrimarySubjects, req.body.suitsAllBasicStudySubjects, req.body.suitsAllUpperSecondarySubjects, req.body.suitsAllVocationalDegrees, req.body.suitsAllSelfMotivatedSubjects, req.body.suitsAllBranches, ((req.body.publishedAt == undefined) ? "now()" : req.body.publishedAt)]));
// description
        console.log("inserting description");
        const description = req.body.description;
        if (description == undefined) {
        // if not found do nothing
        }
        else {
            query = "INSERT INTO materialdescription (description, language, educationalmaterialid) VALUES ($1,$2,$3) ON CONFLICT (language,educationalmaterialid) DO " +
                    "UPDATE SET description = $1;";
            console.log(query);
            if (description.fi === null) {
                queries.push(await t.any(query, ["", "fi", req.params.id]));
            }
            else {
                queries.push(await t.any(query, [description.fi, "fi", req.params.id]));
            }
            if (description.sv === null) {
                queries.push(await t.any(query, ["", "sv", req.params.id]));
            }
            else {
                queries.push(await t.any(query, [description.sv, "sv", req.params.id]));
            }
            if (description.en === null) {
                queries.push(await t.any(query, ["", "en", req.params.id]));
            }
            else {
                queries.push(await t.any(query, [description.en, "en", req.params.id]));
            }
        }
// educationalRoles
        console.log("inserting educationalRoles");
        const audienceparams = [];
        const audienceArr = req.body.educationalRoles;
        if (audienceArr == undefined) {
            query = "DELETE FROM learningresourcetype where educationalmaterialid = $1;";
            response  = await t.any(query, [req.params.id]);
            queries.push(response);
        }
        else {
            for (let i = 1; i <= audienceArr.length; i++) {
                audienceparams.push("('" + audienceArr[i - 1].value + "')");
            }
            query = "select id from (select * from educationalaudience where educationalmaterialid = $1) as i left join" +
            "(select t.role from ( values " + audienceparams.join(",") + " ) as t(role)) as a on i.educationalrole = a.role where a.role is null;";
            response  = await t.any(query, [req.params.id]);
            queries.push(response);
            for (const element of response) {
                query = "DELETE FROM educationalaudience where id = " + element.id + ";";
                console.log(query);
                queries.push(await t.any(query));
            }
            for (const element of audienceArr) {
                query = "INSERT INTO educationalaudience (educationalrole, educationalmaterialid, educationalrolekey) VALUES ($1,$2,$3) ON CONFLICT (educationalrolekey,educationalmaterialid) DO " +
                        "UPDATE SET educationalrole = $1;";
                console.log(query);
                queries.push(await t.any(query, [element.value, req.params.id, element.key]));
            }
        }
        // educationalUse
        console.log("inserting educationalUse");
        const educationalUseParams = [];
        const educationalUseArr = req.body.educationalUses;
        if (educationalUseArr == undefined) {
            query = "DELETE FROM learningresourcetype where educationalmaterialid = $1;";
            response  = await t.any(query, [req.params.id]);
            queries.push(response);
        }
        else {
            for (let i = 1; i <= educationalUseArr.length; i++) {
                educationalUseParams.push("('" + educationalUseArr[i - 1].key + "')");
            }
            query = "select id from (select * from educationaluse where educationalmaterialid = $1) as i left join" +
            "(select t.educationalusekey from ( values " + educationalUseParams.join(",") + " ) as t(educationalusekey)) as a on i.educationalusekey = a.educationalusekey where a.educationalusekey is null;";
            response  = await t.any(query, [req.params.id]);
            queries.push(response);
            console.log(response);
            for (const element of response) {
                query = "DELETE FROM educationaluse where id = " + element.id + ";";
                console.log(query);
                queries.push(await t.any(query));
            }
            for (const element of educationalUseArr) {
                query = "INSERT INTO educationaluse (value, educationalmaterialid, educationalusekey) VALUES ($1,$2,$3) ON CONFLICT (educationalusekey,educationalmaterialid) DO UPDATE SET value = $1;";
                console.log(query);
                queries.push(await t.any(query, [element.value, req.params.id, element.key]));
            }
        }
        // learningResourceType
        console.log("inserting learningResourceType");
        const learningResourceTypeParams = [];
        const learningResourceTypeArr = req.body.learningResourceTypes;
        if (learningResourceTypeArr == undefined) {
            query = "DELETE FROM learningresourcetype where educationalmaterialid = $1;";
            response  = await t.any(query, [req.params.id]);
            queries.push(response);
        }
        else {
            for (let i = 1; i <= learningResourceTypeArr.length; i++) {
                learningResourceTypeParams.push("('" + learningResourceTypeArr[i - 1].key + "')");
            }
            query = "select id from (select * from learningresourcetype where educationalmaterialid = $1) as i left join" +
            "(select t.learningresourcetypekey from ( values " + learningResourceTypeParams.join(",") + " ) as t(learningresourcetypekey)) as a on i.learningresourcetypekey = a.learningresourcetypekey where a.learningresourcetypekey is null;";
            response  = await t.any(query, [req.params.id]);
            queries.push(response);
            console.log(response);
            for (const element of response) {
                query = "DELETE FROM learningresourcetype where id = " + element.id + ";";
                console.log(query);
                queries.push(await t.any(query));
            }
            for (const element of learningResourceTypeArr) {
                query = "INSERT INTO learningresourcetype (value, educationalmaterialid, learningresourcetypekey) VALUES ($1,$2,$3) ON CONFLICT (learningresourcetypekey,educationalmaterialid) DO UPDATE SET value = $1;";
                console.log(query);
                queries.push(await t.any(query, [element.value, req.params.id, element.key]));
            }
        }
        // inLanguage
        // console.log("inserting inLanguage");
        // const inLanguageParams = [];
        // const inLanguageArr = req.body.inLanguage;
        // if (inLanguageArr == undefined) {
        //     query = "DELETE FROM inlanguage where educationalmaterialid = $1;";
        //     response  = await t.any(query, [req.params.id]);
        //     queries.push(response);
        // }
        // else {
        //     for (let i = 1; i <= inLanguageArr.length; i++) {
        //         inLanguageParams.push("('" + inLanguageArr[i - 1].value + "')");
        //     }
        //     query = "select id from (select * from inlanguage where educationalmaterialid = $1) as i left join" +
        //     "(select t.inlanguage from ( values " + inLanguageParams.join(",") + " ) as t(inlanguage)) as a on i.inlanguage = a.inlanguage where a.inlanguage is null;";
        //     response  = await t.any(query, [req.params.id]);
        //     queries.push(response);
        //     for (const element of response) {
        //         query = "DELETE FROM inlanguage where id = " + element.id + ";";
        //         console.log(query);
        //         queries.push(await t.any(query));
        //     }
        //     for (const element of inLanguageArr) {
        //         query = "INSERT INTO inlanguage (inlanguage, url, educationalmaterialid) VALUES ($1,$2,$3) ON CONFLICT (inlanguage, educationalmaterialid) DO NOTHING;";
        //         console.log(query);
        //         queries.push(await t.any(query, [element.value, element.url, req.params.id]));
        //     }
        // }
        // keywords
        console.log("inserting keywords");
        let params = [];
        arr = req.body.keywords;
        if (arr == undefined) {
            query = "DELETE FROM keyword where educationalmaterialid = $1;";
            response  = await t.any(query, [req.params.id]);
            queries.push(response);
        }
        else {
        for (let i = 1; i <= arr.length; i++) {
            params.push("('" + arr[i - 1].key + "')");
        }
            query = "select id from (select * from keyword where educationalmaterialid = $1) as i left join" +
            "(select t.keywordkey from ( values " + params.join(",") + " ) as t(keywordkey)) as a on i.keywordkey = a.keywordkey where a.keywordkey is null;";
            response  = await t.any(query, [req.params.id]);
            queries.push(response);
            for (const element of response) {
                query = "DELETE FROM keyword where id = " + element.id + ";";
                console.log(query);
                queries.push(await t.any(query));
            }
            for (const element of arr) {
                query = "INSERT INTO keyword (value, educationalmaterialid, keywordkey) VALUES ($1,$2,$3) ON CONFLICT (keywordkey, educationalmaterialid) DO UPDATE SET value = $1;";
                console.log(query, [element.value, req.params.id, element.key]);
                queries.push(await t.any(query, [element.value, req.params.id, element.key]));
            }
        }
        // publisher
        console.log("inserting publisher");
        params = [];
        arr = req.body.publisher;
        console.log(arr);
        if (arr == undefined) {
            query = "DELETE FROM publisher where educationalmaterialid = $1;";
            console.log(query, [req.params.id]);
            response  = await t.any(query, [req.params.id]);
            queries.push(response);
        }
        else {
            for (let i = 1; i <= arr.length; i++) {
                params.push("('" + arr[i - 1].key + "')");
            }
            query = "select id from (select * from publisher where educationalmaterialid = $1) as i left join" +
            "(select t.publisherkey from ( values " + params.join(",") + " ) as t(publisherkey)) as a on i.publisherkey = a.publisherkey where a.publisherkey is null;";
            console.log(query);
            response  = await t.any(query, [req.params.id]);
            queries.push(response);
            for (const element of response) {
                query = "DELETE FROM publisher where id = " + element.id + ";";
                console.log(query);
                queries.push(await t.any(query));
            }
            for (const element of arr) {
                query = "INSERT INTO publisher (name, educationalmaterialid, publisherkey) VALUES ($1,$2,$3) ON CONFLICT (publisherkey, educationalmaterialid) DO UPDATE SET name = $1";
                console.log(query);
                queries.push(await t.any(query, [element.value, req.params.id, element.key]));
            }
        }
        // isBasedOn
        console.log("inserting isBasedOn");
        params = [];
        arr = req.body.isBasedOn.externals;
        if (arr == undefined) {
            query = "DELETE FROM isbasedonauthor where isbasedonid IN (SELECT id from isbasedon where educationalmaterialid = $1);";
            response  = await t.any(query, [req.params.id]);
            query = "DELETE FROM isbasedon where educationalmaterialid = $1;";
            response  = await t.any(query, [req.params.id]);
            queries.push(response);
        }
        else {
            query = "DELETE FROM isbasedonauthor where isbasedonid IN (SELECT id from isbasedon where educationalmaterialid = $1);";
            response  = await t.any(query, [req.params.id]);
            query = "SELECT * from isbasedon where educationalmaterialid = $1;";
            response  = await t.any(query, [req.params.id]);
            queries.push(response);
            for (const element of response) {
                let toBeDeleted = true;
                for (let i = 0; arr.length > i; i += 1 ) {
                    if (element.name === arr[i].materialname) {
                        toBeDeleted = false;
                    }
                }
                if (toBeDeleted) {
                    query = "DELETE FROM isbasedon where id = " + element.id + ";";
                    console.log(query);
                    queries.push(await t.any(query));
                }
            }
            for (const element of arr) {
                query = "INSERT INTO isbasedon (materialname, url, educationalmaterialid) VALUES ($1,$2,$3) ON CONFLICT (materialname, educationalmaterialid) DO UPDATE SET url = $2 returning id;";
                console.log(query, [element.name, element.url, req.params.id]);
                const resp = await t.one(query, [element.name, element.url, req.params.id]);
                queries.push(resp);
                for (const author of element.author) {
                    query = "INSERT INTO isbasedonauthor (authorname, isbasedonid) VALUES ($1,$2);";
                    console.log(query, [author, resp.id]);
                    queries.push(t.none(query, [author, resp.id]));
                }
            }
        }
// alignmentObjects
        console.log("inserting alignmentObjects");
            arr = req.body.alignmentObjects;

            if (arr == undefined) {
                query = "DELETE FROM alignmentobject where educationalmaterialid = $1;";
                response  = await t.any(query, [req.params.id]);
                queries.push(response);
            }
            else if (arr.length === 0) {
                query = "DELETE FROM alignmentobject where educationalmaterialid = $1;";
                response  = await t.any(query, [req.params.id]);
                queries.push(response);
            }
            else {
                query = "SELECT * from alignmentobject where educationalmaterialid = $1;";
                response  = await t.any(query, [req.params.id]);
                queries.push(response);
                for (const element of response) {
                    let toBeDeleted = true;
                    for (let i = 0; arr.length > i; i += 1 ) {
                        if ( element.alignmenttype === arr[i].alignmentType && element.targetname === arr[i].targetName && element.source === arr[i].source) {
                            toBeDeleted = false;
                        }
                    }
                    if (toBeDeleted) {
                        query = "DELETE FROM alignmentobject where id = " + element.id + ";";
                        console.log(query);
                        queries.push(await t.any(query));
                    }
                }
                const cs = new pgp.helpers.ColumnSet(["alignmenttype", "targetname", "source", "educationalmaterialid", "objectkey", "educationalframework", "targeturl"], {table: "alignmentobject"});
                // data input values:
                // console.log(arr);
                const values: any = [];
                for ( let i = 0; i < arr.length; i += 1) {
                    arr[i].educationalmaterialid = req.params.id;
                }
                arr.forEach(async (element: any) =>  {
                    console.log(element.educationalFramework);
                    const obj = {alignmenttype : element.alignmentType, targetname : element.targetName , source : element.source , educationalmaterialid : req.params.id, objectkey : element.key, educationalframework : ((element.educationalFramework == undefined) ? "" : element.educationalFramework), targeturl : element.targeturl };
                    values.push(obj);
                });
                // console.log(arr);
                console.log(values);
                query = pgp.helpers.insert(values, cs) + " ON CONFLICT (alignmentType, targetName, source, educationalmaterialid) DO NOTHING;";
                console.log(query);
                queries.push(await t.any(query));
                // for (const element of arr) {
                //     query = "INSERT INTO alignmentobject (alignmentType, targetName, source, educationalmaterialid) VALUES ($1,$2,$3,$4) ON CONFLICT (alignmentType, targetName, source, educationalmaterialid) DO NOTHING;";
                //     console.log(query);
                //     queries.push(await t.any(query, [element.alignmentType, element.targetName, element.source, req.params.id]));
                // }
            }
// author
        console.log("inserting author");
        params = [];
        arr = req.body.authors;
        query = "DELETE FROM author where educationalmaterialid = $1;";
        response  = await t.any(query, [req.params.id]);
        queries.push(response);

        for (const element of arr) {
            query = "INSERT INTO author (authorname, organization, educationalmaterialid, organizationkey) VALUES ($1,$2,$3,$4);";
            console.log(query, [element.author, element.organization, req.params.id]);
            queries.push(await t.any(query, [((element.author == undefined) ? "" : element.author), ((element.organization == undefined) ? "" : element.organization.value), req.params.id, ((element.organization == undefined) ? "" : element.organization.key)]));
        }

    // filedetails
    console.log("inserting filedetails");
        params = [];
        arr = req.body.fileDetails;
        if (arr == undefined) {
            // query = "DELETE FROM materialdisplayname where materialid = $1;";
            // console.log(query, [req.params.id]);
            // response  = await t.any(query, [req.params.id]);
            // queries.push(response);
        }
        else {
            for (const element of arr) {
                query = "INSERT INTO materialdisplayname (displayname, language, materialid) (SELECT $1,$2,$3 where $3 in (select id from material where educationalmaterialid = $4)) ON CONFLICT (language, materialid) DO UPDATE Set displayname = $1;";
                // query = "INSERT INTO materialdisplayname (displayname, language, materialid, slug) VALUES ($1,$2,$3,$4) ON CONFLICT (language, materialid) DO UPDATE Set displayname = $1, slug = $4;";
                // const slug = createSlug(element.displayName.fi);
                console.log(element.displayName.fi);
                console.log(query, [element.displayName.fi, "fi", element.id, req.params.id]);
                if (element.displayName.fi === null) {
                    queries.push(await t.any(query, ["", "fi", element.id, req.params.id]));
                }
                else {
                    queries.push(await t.any(query, [element.displayName.fi, "fi", element.id, req.params.id]));
                }
                if (element.displayName.sv === null) {
                    queries.push(await t.any(query, ["", "sv", element.id, req.params.id]));
                }
                else {
                    queries.push(await t.any(query, [element.displayName.sv, "sv", element.id, req.params.id]));
                }
                if (element.displayName.en === null) {
                    queries.push(await t.any(query, ["", "en", element.id, req.params.id]));
                }
                else {
                    queries.push(await t.any(query, [element.displayName.en, "en", element.id, req.params.id]));
                }
                query = "UPDATE material SET materiallanguagekey = $1 WHERE id = $2 AND educationalmaterialid = $3";
                console.log("update material name: " + query, [element.language.key, element.id, req.params.id]);
                queries.push(await t.any(query, [element.language.key, element.id, req.params.id]));
            }
        }
// accessibilityFeatures
            console.log("inserting accessibilityFeatures");
            params = [];
            arr = req.body.accessibilityFeatures;
            if (arr == undefined) {
                query = "DELETE FROM accessibilityfeature where educationalmaterialid = $1;";
                response  = await t.any(query, [req.params.id]);
                queries.push(response);
            }
            else {
                for (let i = 1; i <= arr.length; i++) {
                    params.push("('" + arr[i - 1].key + "')");
                }
                query = "select id from (select * from accessibilityfeature where educationalmaterialid = $1) as i left join" +
                "(select t.accessibilityfeaturekey from ( values " + params.join(",") + " ) as t(accessibilityfeaturekey)) as a on i.accessibilityfeaturekey = a.accessibilityfeaturekey where a.accessibilityfeaturekey is null;";
                console.log(query);
                response  = await t.any(query, [req.params.id]);
                console.log(response);
                queries.push(response);
                for (const element of response) {
                    if (element.dnid !== null) {
                        query = "DELETE FROM accessibilityfeature where id = " + element.id + ";";
                        console.log(query);
                        queries.push(await t.any(query));
                    }
                }
                for (const element of arr) {
                    query = "INSERT INTO accessibilityfeature (accessibilityfeaturekey, value, educationalmaterialid) VALUES ($1,$2,$3) ON CONFLICT (accessibilityfeaturekey, educationalmaterialid) DO NOTHING;";
                    // query = "INSERT INTO materialdisplayname (displayname, language, materialid, slug) VALUES ($1,$2,$3,$4) ON CONFLICT (language, materialid) DO UPDATE Set displayname = $1, slug = $4;";
                    console.log(query, [element.key, element.value, req.params.id]);
                    queries.push(await t.any(query, [element.key, element.value, req.params.id]));
                }
            }
// accessibilityHazards
        console.log("inserting accessibilityHazards");
            params = [];
            arr = req.body.accessibilityHazards;
            if (arr == undefined) {
                query = "DELETE FROM accessibilityhazard where educationalmaterialid = $1;";
                response  = await t.any(query, [req.params.id]);
                queries.push(response);
            }
            else {
                for (let i = 1; i <= arr.length; i++) {
                    params.push("('" + arr[i - 1].key + "')");
                }
                query = "select id from (select * from accessibilityhazard where educationalmaterialid = $1) as i left join" +
                "(select t.accessibilityhazardkey from ( values " + params.join(",") + " ) as t(accessibilityhazardkey)) as a on i.accessibilityhazardkey = a.accessibilityhazardkey where a.accessibilityhazardkey is null;";
                console.log(query);
                response  = await t.any(query, [req.params.id]);
                console.log(response);
                queries.push(response);
                for (const element of response) {
                    if (element.dnid !== null) {
                        query = "DELETE FROM accessibilityhazard where id = " + element.id + ";";
                        console.log(query);
                        queries.push(await t.any(query));
                    }
                }
                for (const element of arr) {
                    query = "INSERT INTO accessibilityhazard (accessibilityhazardkey, value, educationalmaterialid) VALUES ($1,$2,$3) ON CONFLICT (accessibilityhazardkey, educationalmaterialid) DO NOTHING;";
                    // query = "INSERT INTO materialdisplayname (displayname, language, materialid, slug) VALUES ($1,$2,$3,$4) ON CONFLICT (language, materialid) DO UPDATE Set displayname = $1, slug = $4;";
                    console.log(query, [element.key, element.value, req.params.id]);
                    queries.push(await t.any(query, [element.key, element.value, req.params.id]));
                }
            }
// educationalLevels
            console.log("inserting educationalLevels");
            params = [];
            arr = req.body.educationalLevels;
            if (arr == undefined) {
                query = "DELETE FROM educationallevel where educationalmaterialid = $1;";
                response  = await t.any(query, [req.params.id]);
                queries.push(response);
            }
            else {
                for (let i = 1; i <= arr.length; i++) {
                    params.push("('" + arr[i - 1].key + "')");
                }
                query = "select id from (select * from educationallevel where educationalmaterialid = $1) as i left join" +
                "(select t.educationallevelkey from ( values " + params.join(",") + " ) as t(educationallevelkey)) as a on i.educationallevelkey = a.educationallevelkey where a.educationallevelkey is null;";
                console.log(query);
                response  = await t.any(query, [req.params.id]);
                console.log(response);
                queries.push(response);
                for (const element of response) {
                    if (element.dnid !== null) {
                        query = "DELETE FROM educationallevel where id = " + element.id + ";";
                        console.log(query);
                        queries.push(await t.any(query));
                    }
                }
                for (const element of arr) {
                    query = "INSERT INTO educationallevel (educationallevelkey, value, educationalmaterialid) VALUES ($1,$2,$3) ON CONFLICT (educationallevelkey, educationalmaterialid) DO NOTHING;";
                    // query = "INSERT INTO materialdisplayname (displayname, language, materialid, slug) VALUES ($1,$2,$3,$4) ON CONFLICT (language, materialid) DO UPDATE Set displayname = $1, slug = $4;";
                    console.log(query, [element.key, element.value, req.params.id]);
                    queries.push(await t.any(query, [element.key, element.value, req.params.id]));
                }
            }
            // update fileOrder
            console.log("inserting fileOrder");
            params = [];
            arr = req.body.fileOrder;
            console.log(arr);
            if (arr) {
                for (const element of arr) {
                    query = "update material set priority = $1 where id = $2 and educationalmaterialid = $3;";
                    console.log(query, [element.priority, element.id, req.params.id]);
                    queries.push(await t.none(query, [element.priority, element.id, req.params.id]));
                }
            }
        return t.batch(queries);
    })
    .then (async (data: any) => {
        res.status(200).json("data updated");
        elasticSearch.updateEsDocument()
        .catch ((err: Error) => {
            console.log("Es update error do something");
            console.log(err);
        });
    })
    .catch ((err: Error) => {
        console.log(err);
        res.sendStatus(400);
    });
}

async function createUser(req: Request , res: Response , next: NextFunction) {
    try {
        let query;
        console.log(req.body);
        if (req.body.username === undefined) {
            res.status(500).send("username undefined");
        }
        query = "insert into users (firstname , lastname, username, preferredlanguage,preferredtargetname,preferredalignmenttype )values ($1,$2,$3,'fi','','') RETURNING username;";
        const data = await db.any(query, [req.body.firstname, req.body.lastname, req.body.username]);
        res.status(200).json(data);
    }
    catch (err ) {
        console.log(err);
        res.status(500).send(err);
    }
}

async function updateUser(req: Request , res: Response , next: NextFunction) {
    try {
        let query;
        query = "update users set (firstname, lastname, preferredlanguage,preferredtargetname,preferredalignmenttype ) = ($1,$2,$3,$4,$5) where username = $6;";
        console.log(query);
        const data = await db.any(query, [req.body.firstname, req.body.lastname, req.body.preferredlanguage, req.body.preferredtargetname, req.body.preferredalignmenttype, req.session.passport.user.uid]);
        res.status(200).json("user updated");
    }
    catch (err ) {
        console.log(err);
        res.status(500).send("update failed");
    }
}

async function updateTermsOfUsage(req: Request , res: Response , next: NextFunction) {
    try {
        let query;
        query = "update users set termsofusage = '1' where username = $1;";
        console.log(query);
        const data = await db.any(query, [req.session.passport.user.uid]);
        res.status(200).json("terms of usage updated");
    }
    catch (err ) {
        console.log(err);
        res.status(500).send("update failed");
    }
}

async function getUser(req: Request , res: Response , next: NextFunction) {
    try {
        let query;
        query = "SELECT * FROM users where username = $1;";
        console.log(query);
        const data = await db.any(query, [req.session.passport.user.uid]);
        res.status(200).json(data);
    }
    catch (err ) {
        console.log(err);
        res.status(500).send("get failed");
    }
}

async function insertEducationalMaterial(obj: any, func: any) {
    await db.any("BEGIN");
    try {
        const response = await insertIntoEducationalMaterial(obj.educationalmaterial[0]);
        const materialid = response[0].id;
        let mkey = "MaterialName";
        for (const num in obj[mkey]) {
            await insertIntoMaterialName(obj[mkey][num], materialid);
        }
        mkey = "Description";
        for (const num in obj[mkey]) {
            await insertIntoMaterialDescription(obj[mkey][num], materialid);
        }
        mkey = "EducationalAudience";
        for (const num in obj[mkey]) {
            await insertIntoEducationalAudience(obj[mkey][num], materialid);
        }
        mkey = "LearningResourceType";
        for (const num in obj[mkey]) {
            await insertIntoLearningResourceType(obj[mkey][num], materialid);
        }
        mkey = "AccessibilityFeature";
        for (const num in obj[mkey]) {
            await insertIntoAccessibilityFeature(obj[mkey][num], materialid);
        }
        mkey = "AccessibilityHazard";
        for (const num in obj[mkey]) {
            await insertIntoAccessibilityHazard(obj[mkey][num], materialid);
        }
        mkey = "KeyWord";
        for (const num in obj[mkey]) {
            await insertIntoKeyWord(obj[mkey][num], materialid);
        }
        mkey = "EducationalLevel";
        for (const num in obj[mkey]) {
            await insertIntoEducationalLevel(obj[mkey][num], materialid);
        }
        mkey = "EducationalUse";
        for (const num in obj[mkey]) {
            await insertIntoEducationalUse(obj[mkey][num], materialid);
        }
        mkey = "Publisher";
        for (const num in obj[mkey]) {
            await insertIntoPublisher(obj[mkey][num], materialid);
        }
        mkey = "InLanguage";
        for (const num in obj[mkey]) {
            await insertIntoInLanguage(obj[mkey][num], materialid);
        }
        mkey = "AlignmentObject";
        for (const num in obj[mkey]) {
            await insertIntoAlignmentObject(obj[mkey][num], materialid);
        }
        mkey = "Material";
        for (const num in obj[mkey]) {
            await insertIntoMaterial(obj[mkey][num], materialid);
        }
        mkey = "Author";
        for (const num in obj[mkey]) {
            await insertIntoAuthor(obj[mkey][num], materialid);
        }
        await db.any("COMMIT");
        func(undefined, "Success");
    }
    catch (err ) {
        await db.any("ROLLBACK");
        console.log(err);
        func(err);
    }
}

async function insertIntoEducationalMaterial(obj: any) {
    const materialData = {
        technicalname : obj.technicalname,
        createdat : obj.createdat,
        // author : obj.author,
        // organization : obj.organization,
        publishedat : obj.publishedat,
        updatedat : obj.updatedat,
        archivedat : obj.archivedat,
        timerequired : obj.timerequired,
        agerangemin : obj.agerangemin,
        agerangemax : obj.agerangemax,
        // usersid : obj.usersid,
        usersusername : obj.username,
        licensecode : obj.licensecode,
        originalpublishedat : obj.originalpublishedat
    };
    const query = pgp.helpers.insert(materialData, undefined, "educationalmaterial") + "RETURNING id";
    console.log(query);
    const data = await db.any(query);
    return data;
}

async function insertIntoMaterialName(obj: any, materialid: any) {
    const data = {
        materialname : obj.MaterialName,
        language : obj.Language,
        slug : obj.Slug,
        educationalmaterialid : materialid
    };
    const query = pgp.helpers.insert(data, undefined, "materialname") + "RETURNING id";
    console.log(query);
    await db.any(query);
}

async function insertIntoMaterialDescription(obj: any, materialid: any) {
    const data = {
        description : obj.Description,
        language : obj.Language,
        educationalmaterialid : materialid
    };
    const query = pgp.helpers.insert(data, undefined, "materialdescription") + "RETURNING id";
    console.log(query);
    await db.any(query);
}

async function insertIntoEducationalAudience(obj: any, materialid: any) {
    const data = {
        educationalrole : obj.EducationalRole,
        educationalmaterialid : materialid
    };
    const query = pgp.helpers.insert(data, undefined, "educationalaudience") + "RETURNING id";
    console.log(query);
    await db.any(query);
}

async function insertIntoLearningResourceType(obj: any, materialid: any) {
    const data = {
        value : obj.value,
        educationalmaterialid : materialid
    };
    const query = pgp.helpers.insert(data, undefined, "learningresourcetype") + "RETURNING id";
    console.log(query);
    await db.any(query);
}

async function insertIntoAuthor(obj: any, materialid: any) {
    const data = {
        authorname : obj.authorname,
        organization : obj.organization,
        educationalmaterialid : materialid
    };
    const query = pgp.helpers.insert(data, undefined, "author") + "RETURNING id";
    await db.any(query);
}

async function insertIntoAccessibilityFeature(obj: any, materialid: any) {
    const data = {
        value : obj.value,
        educationalmaterialid : materialid
    };
    const query = pgp.helpers.insert(data, undefined, "accessibilityfeature") + "RETURNING id";
    console.log(query);
    await db.any(query);
}

async function insertIntoAccessibilityHazard(obj: any, materialid: any) {
    const data = {
        value : obj.value,
        educationalmaterialid : materialid
    };
    const query = pgp.helpers.insert(data, undefined, "accessibilityhazard") + "RETURNING id";
    console.log(query);
    await db.any(query);
}

async function insertIntoKeyWord(obj: any, materialid: any) {
    const data = {
        value : obj.value,
        keyurl : "",
        educationalmaterialid : materialid
    };
    const query = pgp.helpers.insert(data, undefined, "keyword") + "RETURNING id";
    console.log(query);
    await db.any(query);
}

async function insertIntoEducationalLevel(obj: any, materialid: any) {
    const data = {
        value : obj.value,
        educationalmaterialid : materialid
    };
    const query = pgp.helpers.insert(data, undefined, "educationallevel") + "RETURNING id";
    console.log(query);
    await db.any(query);
}

async function insertIntoEducationalUse(obj: any, materialid: any) {
    const data = {
        value : obj.value,
        educationalmaterialid : materialid
    };
    const query = pgp.helpers.insert(data, undefined, "educationaluse") + "RETURNING id";
    console.log(query);
    await db.any(query);
}

async function insertIntoPublisher(obj: any, materialid: any) {
    const data = {
        name : obj.name,
        educationalmaterialid : materialid
    };
    const query = pgp.helpers.insert(data, undefined, "publisher") + "RETURNING id";
    console.log(query);
    await db.any(query);
}

async function insertIntoInLanguage(obj: any, materialid: any) {
    const data = {
        inlanguage : obj.name,
        url : "",
        educationalmaterialid : materialid
    };
    const query = pgp.helpers.insert(data, undefined, "inlanguage") + "RETURNING id";
    console.log(query);
    await db.any(query);
}

async function insertIntoAlignmentObject(obj: any, materialid: any) {
    const data = {
        alignmenttype : obj.alignmenttype,
        targetname : obj.targetname,
        source : obj.source,
        educationalmaterialid : materialid
    };
    const query = pgp.helpers.insert(data, undefined, "alignmentobject") + "RETURNING id";
    console.log(query);
    await db.any(query);
}

async function insertIntoMaterial(obj: any, materialid: any) {
    const data = {
        // materialname : obj.materialname,
        link : obj.link,
        priority : obj.priority,
        educationalmaterialid : materialid
    };
    const query = pgp.helpers.insert(data, undefined, "material") + "RETURNING id";
    console.log(query);
    await db.any(query);
}

function createSlug(str: String) {
    str = str.replace(/[ä]/g, "a");
    str = str.replace(/[ö]/g, "o");
    str = str.replace(/[å]/g, "a");
    str = str.replace(/[^a-zA-Z0-9]/g, "");
    return str;
}



module.exports = {
    getMaterial : getMaterial,
    getMaterialData : getMaterialData,
    getRecentMaterial : getRecentMaterial,
    getUserMaterial : getUserMaterial,
    updateMaterial : updateMaterial,
    createUser : createUser,
    updateUser : updateUser,
    getUser : getUser,
    deleteMaterial : deleteMaterial,
    deleteRecord : deleteRecord,
    deleteAttachment : deleteAttachment,
    insertEducationalMaterial : insertEducationalMaterial,
    updateTermsOfUsage : updateTermsOfUsage,
    addLinkToMaterial : addLinkToMaterial
};