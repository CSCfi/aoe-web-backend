const elasticsearch = require("@elastic/elasticsearch");
const fs = require("fs");
const path = require("path");
// const aoemapping = require("./aoemapping");
const index = "aoetest";
const port = 9200;
// const host = process.env.ES_HOST || "localhost"; http://localhost:9200
const client = new elasticsearch.Client({ node: "http://10.0.2.2:9200" ,
log: "trace",
keepAlive: true});

import { Request, Response, NextFunction } from "express";

// process.on("uncaughtException", function (err) {
//     console.log(err);
// });


/** Check the ES connection status */
 async function createEsIndex () {
     console.log("elastic###################################");
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
            console.log("result: " + result);
            if (result) {
                console.log("ES deletind index: " + index);
                await deleteIndex(index);
            }
            const createIndexResult: boolean = await createIndex(index);
            if (createIndexResult) {
                try {
                    addMapping(index);
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
            console.log("here####################");
            console.log(data);
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
        console.log(data);
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
            console.log(data);
            return data.body;
      })
      .catch((err: any) => {
          console.log(err);
          return false;
      });
      console.log(b);
      return b;
}
async function addMapping(index: string) {
    // const rawdata = fs.readFileSync("/Users/juniemin/aoe-backend/src/elasticSearch/aoemapping.json");
    console.log(path.resolve(__dirname, "aoemapping.json"));
    // const rawdata = fs.readFileSync(path.resolve(__dirname, "aoemapping.json"))
    const rawdata = fs.readFileSync("/opt/sources/src/elasticSearch/aoemapping.json")
    // .catch((err: any) => {
    //     console.log(err);
    // });
    const data = JSON.parse(rawdata);
    client.indices.putMapping({
        index: index,
        // body: aoemapping
        body: data.mappings
    }, (err: any, resp: any) => {
        if (err) {
          console.log(err);
        }
        else {
          console.log("response: ", resp);
          console.log("mapping created: ", resp.body);
        }
      });
}

async function elasticSearchQuery(req: Request, res: Response) {
    console.log(
        {"index" : "aoe",
    "body" : req.body});
    client.search({"index" : "aoe",
                    "body" : req.body}
    , (err: Error, result: any) => {
        if (err) {
            console.log(err);
            res.status(500).json(err);
        }
        else {
            res.status(200).json(result);
        }
      });
}

createEsIndex();

module.exports = {
    createEsIndex : createEsIndex,
    elasticSearchQuery : elasticSearchQuery
};