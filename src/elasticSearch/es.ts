import { aoeThumbnailDownloadUrl } from "./../services/urlService";
const elasticsearch = require("@elastic/elasticsearch");
const fs = require("fs");
const path = require("path");
const index = process.env.ES_INDEX;
const client = new elasticsearch.Client({ node: process.env.ES_NODE,
log: "trace",
keepAlive: true});
export namespace Es {
    export let ESupdated = {value : new Date()};
}
import { Request, Response, NextFunction } from "express";
const connection = require("./../db");
const pgp = connection.pgp;
const db = connection.db;
const TransactionMode = pgp.txMode.TransactionMode;
const isolationLevel = pgp.txMode.isolationLevel;

// Create a reusable transaction mode (serializable + read-only + deferrable):
const mode = new TransactionMode({
    tiLevel: isolationLevel.serializable,
    readOnly: true,
    deferrable: true
});

/** Check the ES connection status */
async function createEsIndex () {
    console.log("Create Elasticsearch index");
    client.ping({
        // ping usually has a 3000ms timeout
        // requestTimeout: 1000
      }, async function (error: any) {
        if (error) {
            console.trace("elasticsearch cluster is down!");
            console.log(error);
        } else {
            console.log("All is well");
            const result: boolean = await indexExists(index);
            console.log("ES index exists: " + result);
            if (result) {
                console.log("ES deleting index: " + index);
                await deleteIndex(index);
            }
            const createIndexResult: boolean = await createIndex(index);
            if (createIndexResult) {
                try {
                    await addMapping(index);
                    let i = 0;
                    let n;
                    console.log(Es.ESupdated);
                    console.log(new Date().toUTCString());
                    Es.ESupdated.value = new Date();
                    do {
                        n = await metadataToEs(i, 1000);
                        i++;
                    } while (n);
                    console.log("Elastic index is ready");
                }
                catch (e) {
                    console.log(e);
                }
            }
        }
      });
    }

async function deleteIndex (index: string) {
    const b = client.indices.delete({
        index: index
    }).then((data: any) => {
        return data.body;
    })
    .catch((err: any) => {
    console.log(err);
    return false;
    });
    console.log(b);
    return b;
}

async function createIndex (index: string) {
    const b = client.indices.create({
        index: index
    }).then((data: any) => {
        return data.body;
    })
    .catch((err: any) => {
    console.log(err);
    return false;
    });
    console.log(b);
    return b;
}

function indexExists (index: string): boolean {
    const b = client.indices.exists({
        index: index
      }).then((data: any) => {
            return data.body;
      })
      .catch((err: any) => {
          console.log(err);
          return false;
      });
      return b;
}
async function addMapping(index: string) {
    return new Promise(async (resolve, reject) => {
        const rawdata = fs.readFileSync(process.env.ES_MAPPING_FILE);
        const data = JSON.parse(rawdata);
        client.indices.putMapping({
            index: index,
            // body: aoemapping
            body: data.mappings
        }, (err: any, resp: any) => {
            if (err) {
            console.log(err);
            reject(new Error(err));
            }
            else {
            console.log("ES mapping created: ", resp.body);
            resolve();
            }
        });
    });
}

async function metadataToEs(offset: number, limit: number) {
    return new Promise(async (resolve, reject) => {
    const countquery = "select count(*) from educationalmaterial";
    db.tx({mode}, async (t: any)  => {
        const params: any = [];
        params.push(offset * limit);
        params.push(limit);
        let query = "select em.id, em.createdat, em.publishedat, em.updatedat, em.archivedat, em.timerequired, em.agerangemin, em.agerangemax, em.obsoleted, em.originalpublishedat, em.expires, em.suitsallearlychildhoodsubjects, em.suitsallpreprimarysubjects, em.suitsallbasicstudysubjects, em.suitsalluppersecondarysubjects, em.suitsalluppersecondarysubjectsnew, em.suitsallvocationaldegrees, em.suitsallselfmotivatedsubjects, em.suitsallbranches" +
        " from educationalmaterial as em where em.obsoleted = 0 and em.publishedat IS NOT NULL order by em.id asc OFFSET $1 LIMIT $2;";
        return t.map(query, params, async (q: any) => {
            const m: any = [];
            t.map("select m.id, m.materiallanguagekey as language, link, version.priority, filepath, originalfilename, filesize, mimetype, format, filekey, filebucket, obsoleted " +
            "from (select materialid, publishedat, priority from versioncomposition where publishedat = (select max(publishedat) from versioncomposition where educationalmaterialid = $1)) as version " +
            "left join material m on m.id = version.materialid left join record r on m.id = r.materialid where m.educationalmaterialid = $1", [q.id], (q2: any) => {
                t.any("select * from materialdisplayname where materialid = $1;", q2.id)
                    .then((data: any) => {
                        q2.materialdisplayname = data;
                        m.push(q2);
                    });
                q.materials = m;
                });
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
            response = await t.map(query, [q.id], (q2: any) => {
                t.any("select * from isbasedonauthor where isbasedonid = $1;", q2.id)
                .then((data: any) => {
                    q2.author = data;
                });
            return q2;
            });
            // response = await t.any(query, [q.id]);
            q.isbasedon = response;

            // query = "select * from inlanguage where educationalmaterialid = $1;";
            // response = await t.any(query, [q.id]);
            // q.inlanguage = response;

            query = "select * from alignmentobject where educationalmaterialid = $1;";
            response = await t.any(query, [q.id]);
            q.alignmentobject = response;

            query = "SELECT users.firstname, users.lastname FROM educationalmaterial INNER JOIN users ON educationalmaterial.usersusername = users.username WHERE educationalmaterial.id = $1;";
            response = await t.any(query, [q.id]);
            q.owner = response;

            query = "select * from educationalaudience where educationalmaterialid = $1;";
            response = await t.any(query, [q.id]);
            q.educationalaudience = response;

            query = "select * from thumbnail where educationalmaterialid = $1 and obsoleted = 0 limit 1;";
            response = await t.oneOrNone(query, [q.id]);
            if (response) {
                response.filepath = await aoeThumbnailDownloadUrl(response.filekey);
            }
            q.thumbnail = response;

            query = "select licensecode as key, license as value from educationalmaterial as m left join licensecode as l on m.licensecode = l.code WHERE m.id = $1;";
            const responseObj = await t.oneOrNone(query, [q.id]);
            q.license = responseObj;
            return q;
            }).then(t.batch)
            .catch((error: any) => {
                console.trace(error);
                return error;
            }) ;
        })
        .then( async (data: any) => {
            console.log("inserting data to elastic material number: " + (offset * limit + 1));
            if (data.length > 0) {
            const body = data.flatMap(doc => [{ index: { _index: index, _id: doc.id } }, doc]);
            // console.log("THIS IS BODY:");
            // console.log(JSON.stringify(body));
            const { body: bulkResponse } = await client.bulk({ refresh: true, body });
            if (bulkResponse.errors) {
                const erroredDocuments = [];
                // The items array has the same order of the dataset we just indexed.
                // The presence of the `error` key indicates that the operation
                // that we did for the document has failed.
                bulkResponse.items.forEach((action, i) => {
                const operation = Object.keys(action)[0];
                if (action[operation].error) {
                    erroredDocuments.push({
                    // If the status is 429 it means that you can retry the document,
                    // otherwise it's very likely a mapping error, and you should
                    // fix the document before to try it again.
                    status: action[operation].status,
                    error: action[operation].error,
                    operation: body[i * 2],
                    document: body[i * 2 + 1]
                    });
                }
                });
                console.log(erroredDocuments);
            }
            resolve(data.length);
        }
        else {
            resolve(data.length);
        }

    }
    ).catch(err => {
        console.log(err);
        reject();
    });
});
}

async function updateEsDocument() {
    return new Promise(async (resolve, reject) => {
    db.tx({mode}, async (t: any)  => {
        const params: any = [];
        params.push(Es.ESupdated.value);
        let query = "select em.id, em.createdat, em.publishedat, em.updatedat, em.archivedat, em.timerequired, em.agerangemin, em.agerangemax, em.obsoleted, em.originalpublishedat, em.expires, em.suitsallearlychildhoodsubjects, em.suitsallpreprimarysubjects, em.suitsallbasicstudysubjects, em.suitsalluppersecondarysubjects, em.suitsalluppersecondarysubjectsnew, em.suitsallvocationaldegrees, em.suitsallselfmotivatedsubjects, em.suitsallbranches" +
        " from educationalmaterial as em where updatedat > $1 and em.publishedat IS NOT NULL;";
        // console.log(query);
        return t.map(query, params, async (q: any) => {
            const m: any = [];
            t.map("select m.id, m.materiallanguagekey as language, link, version.priority, filepath, originalfilename, filesize, mimetype, format, filekey, filebucket, obsoleted " +
            "from (select materialid, publishedat, priority from versioncomposition where publishedat = (select max(publishedat) from versioncomposition where educationalmaterialid = $1)) as version " +
            "left join material m on m.id = version.materialid left join record r on m.id = r.materialid where m.educationalmaterialid = $1", [q.id], (q2: any) => {
                t.any("select * from materialdisplayname where materialid = $1;", q2.id)
                    .then((data: any) => {
                        q2.materialdisplayname = data;
                        m.push(q2);
                    });
                q.materials = m;
                });
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
            response = await t.map(query, [q.id], (q2: any) => {
                t.any("select * from isbasedonauthor where isbasedonid = $1;", q2.id)
                .then((data: any) => {
                    q2.author = data;
                });
            return q2;
            });

            // response = await t.any(query, [q.id]);
            q.isbasedon = response;

            // query = "select * from inlanguage where educationalmaterialid = $1;";
            // response = await t.any(query, [q.id]);
            // q.inlanguage = response;

            query = "select * from alignmentobject where educationalmaterialid = $1;";
            response = await t.any(query, [q.id]);
            q.alignmentobject = response;

            query = "SELECT users.firstname, users.lastname FROM educationalmaterial INNER JOIN users ON educationalmaterial.usersusername = users.username WHERE educationalmaterial.id = $1;";
            response = await t.any(query, [q.id]);
            q.owner = response;

            query = "select * from educationalaudience where educationalmaterialid = $1;";
            response = await t.any(query, [q.id]);
            q.educationalaudience = response;

            query = "select * from thumbnail where educationalmaterialid = $1 and obsoleted = 0 limit 1;";
            response = await t.oneOrNone(query, [q.id]);
            if (response) {
                response.filepath = await aoeThumbnailDownloadUrl(response.filekey);
            }
            q.thumbnail = response;

            query = "select licensecode as key, license as value from educationalmaterial as m left join licensecode as l on m.licensecode = l.code WHERE m.id = $1;";
            const responseObj = await t.oneOrNone(query, [q.id]);
            q.license = responseObj;
            return q;
            }).then(t.batch)
            .catch((error: any) => {
                console.trace(error);
                return error;
            }) ;
        })
        .then( async (data: any) => {
            if (data.length > 0) {
            const body = data.flatMap(doc => [{ index: { _index: index, _id: doc.id } }, doc]);
            const { body: bulkResponse } = await client.bulk({ refresh: true, body });
            if (bulkResponse.errors) {
                console.log(bulkResponse.errors);
            }
            else {
                console.log("Elasticsearch updated");
                Es.ESupdated.value = new Date();
            }
            resolve(data.length);
        }
        else {
            resolve(data.length);
        }

    }
    ).catch(err => {
        console.log(err);
        reject(err);
    });
});
}

if (process.env.CREATE_ES_INDEX) {
        createEsIndex();
}


module.exports = {
    createEsIndex : createEsIndex,
    updateEsDocument : updateEsDocument
};