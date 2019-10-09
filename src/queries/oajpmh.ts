import { Request, Response, NextFunction } from "express";
import { any } from "bluebird";
const connection = require("./../db");
const pgp = connection.pgp;
const db = connection.db;

async function getMaterialMetaData(req: Request , res: Response) {
    const min = req.body.min;
    // db.task(buildTree)
    db.task((t: any)  => {
        const params: any = [];
        let query = "select em.id, em.createdat, em.publishedat, em.updatedat, em.archivedat, em.timerequired, em.agerangemin, em.agerangemax, em.licensecode, em.obsoleted, em.originalpublishedat, em.expires, em.suitsallearlychildhoodsubjects, em.suitsallpreprimarysubjects, em.suitsallbasicstudysubjects, em.suitsalluppersecondarysubjects, em.suitsallvocationaldegrees, em.suitsallselfmotivatedsubjects, em.suitsallbranches" +
        " from educationalmaterial as em order by em.id asc;";
        if (req.body.dateMin !== undefined && req.body.dateMax !== undefined && req.body.materialPerPage !== undefined && req.body.pageNumber !== undefined) {
            console.log(req.body.dateMin);
            console.log(req.body.dateMax);
            console.log(req.body.materialPerPage);
            params.push(req.body.dateMin);
            params.push(req.body.dateMax);
            params.push(req.body.pageNumber);
            params.push(req.body.materialPerPage);
            query = "select em.id, em.createdat, em.publishedat, em.updatedat, em.archivedat, em.timerequired, em.agerangemin, em.agerangemax, em.licensecode, em.obsoleted, em.originalpublishedat, em.expires, em.suitsallearlychildhoodsubjects, em.suitsallpreprimarysubjects, em.suitsallbasicstudysubjects, em.suitsalluppersecondarysubjects, em.suitsallvocationaldegrees, em.suitsallselfmotivatedsubjects, em.suitsallbranches" +
            " from educationalmaterial as em where em.updatedat >= timestamp $1 and em.updatedat < timestamp $2 order by em.id asc OFFSET $3 LIMIT $4;";
        }
        console.log(query, params);
        return t.map(query, params, async (q: any) => {
        const m: any = [];
        t.map("select m.id, m.materiallanguage as language, m.materiallanguagekey as key, link, priority, filepath, originalfilename, filesize, mimetype, format, filekey, filebucket, obsoleted from material m left join record r on m.id = r.materialid where m.educationalmaterialid = $1", [q.id], (q2: any) => {
            t.any("select * from materialdisplayname where materialid = $1;", q2.id)
                .then((data: any) => {
                    q2.materialdisplayname = data;
                    m.push(q2);
                });
            q.materials = m;
            });
        query = "select * from materialname where educationalmaterialid = $1;";
        const materialName = await t.any(query, q.id);
        q.materialName = materialName;
        query = "select * from materialdescription where educationalmaterialid = $1;";
        const materialDescription = await t.any(query, q.id);
        q.materialDescription = materialDescription;

        query = "select * from educationalaudience where educationalmaterialid = $1;";
        let response = await t.any(query, [q.id]);
        q.educationalaudience = response;

        query = "select * from learningresourcetype where educationalmaterialid = $1;";
        response = await t.any(query, [q.id]);
        q.learningresourcetype = response;

        query = "select * from accessibilityfeature where educationalmaterialid = $1;";
        response = await t.any(query, [q.id]);
        q.accessibilityfeature = response;

        query = "select * from accessibilityhazard where educationalmaterialid = $1;";
        response = await t.any(query, [q.id]);
        q.accessibilityhazard = response;

        query = "select * from keyword where educationalmaterialid = $1;";
        response = await t.any(query, [q.id]);
        q.keyword = response;

        query = "select * from educationallevel where educationalmaterialid = $1;";
        response = await t.any(query, [q.id]);
        q.educationallevel = response;

        query = "select * from educationaluse where educationalmaterialid = $1;";
        response = await t.any(query, [q.id]);
        q.educationaluse = response;

        query = "select * from publisher where educationalmaterialid = $1;";
        response = await t.any(query, [q.id]);
        q.publisher = response;

        query = "select * from author where educationalmaterialid = $1;";
        response = await t.any(query, [q.id]);
        q.author = response;

        query = "select * from isbasedon where educationalmaterialid = $1;";
        response = await t.any(query, [q.id]);
        q.isbasedon = response;

        query = "select * from inlanguage where educationalmaterialid = $1;";
        response = await t.any(query, [q.id]);
        q.inlanguage = response;

        query = "select * from aligmentobject where educationalmaterialid = $1;";
        response = await t.any(query, [q.id]);
        q.aligmentobject = response;

        query = "SELECT users.firstname, users.lastname FROM educationalmaterial INNER JOIN users ON educationalmaterial.usersusername = users.username WHERE educationalmaterial.id = $1;";
        response = await t.any(query, [q.id]);
        q.owner = response;

        query = "select * from educationalaudience where educationalmaterialid = $1;";
        response = await t.any(query, [q.id]);
        q.educationalaudience = response;
        return q;
        }).then(t.batch)
        .catch((error: any) => {
            console.log(error);
            return error;
        }) ;
    })
    .then((data: any) => {
        res.status(200).json(data);
    })
    .catch((error: any) => {
        console.log(error);
        res.sendStatus(500);
    });
}



async function buildTree(t: any) {
    console.log("tämä on: " + t);
    return t.map("select em.id, em.createdat, em.publishedat, em.updatedat, em.archivedat, em.timerequired, em.agerangemin, em.agerangemax, em.licensecode, em.obsoleted, em.originalpublishedat, em.expires" +
    " from educationalmaterial as em order by em.id asc;", [], async (q: any) => {
        console.log("tämä on: " + t);
        const m: any = [];
        t.map("select m.id, m.materiallanguage as language, m.materiallanguagekey as key, link, priority, filepath, originalfilename, filesize, mimetype, format, filekey, filebucket, obsoleted from material m left join record r on m.id = r.materialid where m.educationalmaterialid = $1", [q.id], (q2: any) => {
            t.any("select * from materialdisplayname where materialid = $1;", q2.id)
                .then((data: any) => {
                    q2.materialdisplayname = data;
                    m.push(q2);
                });
            q.materials = m;
            });
        let query = "select * from materialname where educationalmaterialid = $1;";
        const materialName = await t.any(query, q.id);
        q.materialName = materialName;
        query = "select * from materialdescription where educationalmaterialid = $1;";
        const materialDescription = await t.any(query, q.id);
        q.materialDescription = materialDescription;

        query = "select * from educationalaudience where educationalmaterialid = $1;";
        let response = await t.any(query, [q.id]);
        q.educationalaudience = response;

        query = "select * from learningresourcetype where educationalmaterialid = $1;";
        response = await t.any(query, [q.id]);
        q.learningresourcetype = response;

        query = "select * from accessibilityfeature where educationalmaterialid = $1;";
        response = await t.any(query, [q.id]);
        q.accessibilityfeature = response;

        query = "select * from accessibilityhazard where educationalmaterialid = $1;";
        response = await t.any(query, [q.id]);
        q.accessibilityhazard = response;

        query = "select * from keyword where educationalmaterialid = $1;";
        response = await t.any(query, [q.id]);
        q.keyword = response;

        query = "select * from educationallevel where educationalmaterialid = $1;";
        response = await t.any(query, [q.id]);
        q.educationallevel = response;

        query = "select * from educationaluse where educationalmaterialid = $1;";
        response = await t.any(query, [q.id]);
        q.educationaluse = response;

        query = "select * from publisher where educationalmaterialid = $1;";
        response = await t.any(query, [q.id]);
        q.publisher = response;

        query = "select * from author where educationalmaterialid = $1;";
        response = await t.any(query, [q.id]);
        q.author = response;

        query = "select * from isbasedon where educationalmaterialid = $1;";
        response = await t.any(query, [q.id]);
        q.isbasedon = response;

        query = "select * from inlanguage where educationalmaterialid = $1;";
        response = await t.any(query, [q.id]);
        q.inlanguage = response;

        query = "select * from aligmentobject where educationalmaterialid = $1;";
        response = await t.any(query, [q.id]);
        q.aligmentobject = response;

        query = "SELECT users.firstname, users.lastname FROM educationalmaterial INNER JOIN users ON educationalmaterial.usersusername = users.username WHERE educationalmaterial.id = $1;";
        response = await t.any(query, [q.id]);
        q.owner = response;

        query = "select * from educationalaudience where educationalmaterialid = $1;";
        response = await t.any(query, [q.id]);
        q.educationalaudience = response;
        return q;
    }).then(t.batch)
    .catch((error: any) => {
        console.log(error);
        return error;
    }) ; // settles the array of generated promises
}

// function buildTree(t: any) {
//     return t.map("select em.id, em.createdat, em.publishedat, em.updatedat, em.archivedat, em.timerequired, em.agerangemin, em.agerangemax, em.licensecode, em.obsoleted, em.originalpublishedat, em.expires" +
//     " from educationalmaterial as em order by em.id asc;", [], (q: any) => {
//         console.log(q.id);
//         return t.any("select * from material where educationalmaterialid = $1;", q.id)
//             .then((data: any) => {
//                 q.materials = data;
//                 return q;
//             });
//     }).then(t.batch); // settles the array of generated promises
// }


module.exports = {
    getMaterialMetaData : getMaterialMetaData
};
