import { Request, Response, NextFunction } from "express";
import { aoeFileDownloadUrl, aoePdfDownloadUrl, aoeThumbnailDownloadUrl } from "./../services/urlService";
const connection = require("./../db");
const pgp = connection.pgp;
const db = connection.db;

async function getMaterialMetaData(req: Request , res: Response) {
    try {
        const min = req.body.min;
        let query2 = "select count(*) from educationalmaterial where publishedat is not null"; // removed: "and obsoleted = 0"
        const params: any = [];
        if (req.body.dateMin !== undefined && req.body.dateMax !== undefined && req.body.materialPerPage !== undefined && req.body.pageNumber !== undefined) {
            params.push(req.body.dateMin);
            params.push(req.body.dateMax);
            query2 = "select count(*) from educationalmaterial where updatedat >= timestamp $1 and updatedat < timestamp $2 and publishedat is not null"; // removed: "and obsoleted = 0"
        }
        const documentcount = await db.oneOrNone(query2, params);
        let pagecount = 0;
        if (req.body.materialPerPage) {
            pagecount = Math.ceil(documentcount.count / req.body.materialPerPage);
        }
        // db.task(buildTree)
        db.task(async (t: any)  => {
            const params: any = [];
            let query = "select em.id, em.createdat, em.publishedat, em.updatedat, em.archivedat, em.timerequired, em.agerangemin, em.agerangemax, em.licensecode, em.obsoleted, em.originalpublishedat, em.expires, em.suitsallearlychildhoodsubjects, em.suitsallpreprimarysubjects, em.suitsallbasicstudysubjects, em.suitsalluppersecondarysubjects, em.suitsallvocationaldegrees, em.suitsallselfmotivatedsubjects, em.suitsallbranches" +
            " from educationalmaterial as em where em.publishedat is not null and em.obsoleted = 0 order by em.id asc;";
            if (req.body.dateMin !== undefined && req.body.dateMax !== undefined && req.body.materialPerPage !== undefined && req.body.pageNumber !== undefined) {
                console.log(req.body.dateMin);
                console.log(req.body.dateMax);
                console.log(req.body.materialPerPage);
                params.push(req.body.dateMin);
                params.push(req.body.dateMax);
                params.push(req.body.pageNumber * req.body.materialPerPage);
                params.push(req.body.materialPerPage);
                query = "select em.id, em.createdat, em.publishedat, em.updatedat, em.archivedat, em.timerequired, em.agerangemin, em.agerangemax, em.licensecode, em.obsoleted, em.originalpublishedat, em.expires, em.suitsallearlychildhoodsubjects, em.suitsallpreprimarysubjects, em.suitsallbasicstudysubjects, em.suitsalluppersecondarysubjects, em.suitsallvocationaldegrees, em.suitsallselfmotivatedsubjects, em.suitsallbranches" +
                " from educationalmaterial as em where em.updatedat >= timestamp $1 and em.updatedat < timestamp $2 and em.publishedat is not null and em.obsoleted = 0 order by em.id asc OFFSET $3 LIMIT $4;";
            }
            console.log(query, params);
            return t.map(query, params, async (q: any) => {
            const m: any = [];
            await Promise.all(await t.map("select m.id, m.materiallanguagekey as language, link, version.priority, originalfilename, filesize, mimetype, format, filekey, filebucket, obsoleted, pdfkey " +
            "from (select materialid, publishedat, priority from versioncomposition where publishedat = (select max(publishedat) from versioncomposition where educationalmaterialid = $1)) as version " +
            "left join material as m on version.materialid = m.id left join record r on m.id = r.materialid where m.educationalmaterialid = $1 and m.obsoleted = 0;", [q.id], async (q2: any) => {
                q2.filepath = await aoeFileDownloadUrl(q2.filekey);
                q2.pdfpath = await aoePdfDownloadUrl(q2.pdfkey);
                t.any("select * from materialdisplayname where materialid = $1;", q2.id)
                    .then((data: any) => {
                        q2.materialdisplayname = data;
                        m.push(q2);
                    });
                q.materials = m;
                }));
            query = "select * from materialname where educationalmaterialid = $1;";
            const materialName = await t.any(query, q.id);
            q.materialname = materialName;
            query = "select * from materialdescription where educationalmaterialid = $1;";
            const materialDescription = await t.any(query, q.id);
            q.materialdescription = materialDescription;

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
            // response = await t.any(query, [q.id]);
            response = await t.map(query, [q.id], (q2: any) => {
                t.any("select * from isbasedonauthor where isbasedonid = $1;", q2.id)
                    .then((data: any) => {
                        q2.author = data;
                    });
                    return q2;
                });
            q.isbasedon = response;

            query = "select * from inlanguage where educationalmaterialid = $1;";
            response = await t.any(query, [q.id]);
            q.inlanguage = response;

            query = "select * from alignmentobject where educationalmaterialid = $1;";
            response = await t.any(query, [q.id]);
            q.alignmentobject = response;

            query = "SELECT users.firstname, users.lastname FROM educationalmaterial INNER JOIN users ON educationalmaterial.usersusername = users.username WHERE educationalmaterial.id = $1;";
            response = await t.any(query, [q.id]);
            q.owner = response;

            query = "select * from educationalaudience where educationalmaterialid = $1;";
            response = await t.any(query, [q.id]);
            q.educationalaudience = response;

            query = "Select filekey, mimetype from thumbnail where educationalmaterialid = $1 and obsoleted = 0;";
            response = await db.oneOrNone(query, [q.id]);
            if (response) {
                response.filepath = await aoeThumbnailDownloadUrl(response.filekey);
                q.thumbnail = response;
            }
            return q;
            }).then(t.batch)
            .catch((error: any) => {
                console.log(error);
                return error;
            }) ;
        })
        .then((data: any) => {
            const obj = {
                "dateMin" : req.body.dateMin,
                "dateMax" : req.body.dateMax,
                "materialPerPage" : req.body.materialPerPage,
                "pageNumber" : req.body.pageNumber,
                "pageTotal": pagecount,
                "completeListSize": documentcount.count,
                "content": data
            };
            res.status(200).json(obj);
        })
        .catch((error: any) => {
            console.log(error);
            res.sendStatus(500);
        });
    }
    catch (err) {
        console.log(err);
        res.sendStatus(500);
    }
}

module.exports = {
    getMaterialMetaData : getMaterialMetaData
};
