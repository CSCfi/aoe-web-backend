/// <reference path="es.ts" />
import {
    Client,
    RequestParams,
    ApiResponse,
  } from "@elastic/elasticsearch";
const index = process.env.ES_INDEX;

const client = new Client({node: process.env.ES_NODE});

const connection = require("./../db");
const pgp = connection.pgp;
const db = connection.db;
const TransactionMode = pgp.txMode.TransactionMode;
const isolationLevel = pgp.txMode.isolationLevel;
const mode = new TransactionMode({
    tiLevel: isolationLevel.serializable,
    readOnly: true,
    deferrable: true
});

// const Es = require("./es");
import { Es } from "./es";
import * as es2 from "./es";
// const config = Es.ESupdated.value;
// console.log(es2.thisistest);
// console.log("config=" + config);
// console.log("config.txt=" + JSON.stringify(config));
import { Request, Response, NextFunction } from "express";
interface SearchBody {
query: {
    match: { foo: string }
};
}

interface MultiMatchSeachBody {
    query: {
        multi_match: {
            query: string,
            fields: Array<string>;
        }
    };
}
async function elasticSearchQuery(req: Request, res: Response) {
    const fields = [ "accessibilityfeature.value",
    "accessibilityhazard.value",
    "alignmentobject.alignmenttype",
    "alignmentobject.educationalframework",
    "author.authorname",
    "author.organization",
    "educationalaudience.educationalrole",
    "educationallevel.value",
    "educationaluse.value",
    "inlanguage.inlanguage",
    "isbasedon.author",
    "isbasedon.materialname",
    "learningresourcetype.value",
    "licensecode",
    "materialdescription.description",
    "materialname.materialname",
    "materials.materialdisplayname.displayname",
    "materials.link",
    "materials.originalfilename",
    "owner.firstname",
    "owner.lastname",
    "publisher.name"
    ];
    const body: MultiMatchSeachBody = {
        "query": {
          "multi_match": {
            "query": req.body.keywords,
            "fields": fields
          }
        }
      };
    client.search({"index" : index,
                    "body" : body}
    , (err: Error, result: any) => {
        if (err) {
            console.log(JSON.stringify(err));
            res.status(500).json(err);
        }
        else {
            res.status(200).json(result);
        }
      });
}

// async function updateEsDocument(id: string) {
//     // const body = { doc: {"agerangemin": 1, "agerangemax": 99}};
//     // const resp = await client.update({
//     //     "id" : id,
//     //     "index" : index,
//     //     "refresh": "true",
//     //     "body" : body}
//         const body = { "agerangemin": undefined, "agerangemax": 99};
//         const resp = await client.index({
//             "id" : id,
//             "index" : index,
//             "refresh": "true",
//             "body" : body}
//     // })
//     , (err: Error, result: any) => {
//         if (err) {
//             console.log(JSON.stringify(err));
//         }
//         console.log("Response: " + JSON.stringify(resp));
//     });
// }



module.exports = {
    elasticSearchQuery : elasticSearchQuery
};