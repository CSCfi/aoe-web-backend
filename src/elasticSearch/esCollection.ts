import { Request, Response, NextFunction } from "express";
import { aoeCollectionThumbnailDownloadUrl } from "./../services/urlService";
import { Client, ApiResponse } from "@elastic/elasticsearch";
import { ErrorHandler } from "./../helpers/errorHandler";
import { MultiMatchSeachBody, SearchResponse, Source, AoeBody, AoeCollectionResult } from "./esTypes";
import { createMatchAllObject } from "./esQueries";

const client = new Client({ node: process.env.ES_NODE});
const connection = require("./../db");
const pgp = connection.pgp;
const db = connection.db;

/**
 *
 * @param req
 * @param res
 * @param next
 * create es collection query
 */
export async function collectionFromEs(obj: any) {
    try {
        const index = process.env.ES_COLLECTION_INDEX;
        let from = Number(process.env.ES_FROM_DEFAULT) || 0;
        let size = Number(process.env.ES_SIZE_DEFAULT) || 100;
        if (obj.from) {
        from = obj.from;
        }
        if (obj.size) {
        size = obj.size;
        }
        const mustList = [];
        // match all if keywords null
        mustList.push(createMatchAllObject());
        // if (req.body.filters) {
        // const filters = filterMapper(req.body.filters);
        // filters.map(filter => mustList.push(filter));
        // }
        const body: MultiMatchSeachBody = {
        "query": {
            "bool" : {
            "must" : mustList
            }
        }
        };
        const query = {"index" : index,
                    "from" : from,
                    "size" : size,
                    "body" : body};
        console.log("Elasticsearch query: " + JSON.stringify(query));
        const result: ApiResponse<SearchResponse<AoeCollectionResult>> = await client.search(query);
        const responseBody: AoeBody<AoeCollectionResult> = await aoeCollectionResponseMapper(result);
        return responseBody;
        }
        catch (err) {
        console.log(err);
        throw new Error(err);
        }
}
/**
 *
 * @param response
 * map collection elasticsearch response to aoe response
 */
export async function aoeCollectionResponseMapper (response: ApiResponse<SearchResponse<AoeCollectionResult>> ) {
    try {
      const resp: AoeBody<AoeCollectionResult> = {
        hits : response.body.hits.total.value
      };
      const hits = response.body.hits.hits;
      if (hits) {
        const source: Array<AoeCollectionResult> = hits.map(hit => hit._source);
        /**
         * map source here if needed
         */
        resp.results = source;
        }
      return resp;
    }
    catch (err) {
      console.log(err);
      throw new Error(err);
    }
  }

export async function getCollectionDataToEs(offset: number, limit: number) {
    try {
        const data = await db.tx(async (t: any) => {
            console.log("recentCollectionQuery:");
            let query = "select collection.id, publishedat, updatedat, createdat, collectionname as name, description from collection WHERE publishedat IS NOT NULL order by collection.id asc OFFSET $1 LIMIT $2;";
            const params: any = [];
            params.push(offset * limit);
            params.push(limit);
            console.log(query, params);
            const collections = await Promise.all(
                await t.map(query, params, async (q: any) => {
                    query = "SELECT value, keywordkey as key FROM collectionkeyword WHERE collectionid = $1;";
                    q.keywords = await db.any(query, [ q.id ]);
                    query = "SELECT language FROM collectionlanguage WHERE collectionid = $1;";
                    const languageObjects = await db.any(query, [ q.id ]);
                    q.languages = languageObjects.map(o => o.language);
                    query = "SELECT alignmenttype, targetname, source, educationalframework, objectkey, targeturl FROM collectionalignmentobject WHERE collectionid = $1;";
                    q.alignmentObjects = await db.any(query, [ q.id ]);
                    query = "SELECT value, educationalusekey as key FROM collectioneducationaluse WHERE collectionid = $1;";
                    q.educationalUses = await db.any(query, [ q.id ]);
                    query = "SELECT educationalrole as value, educationalrolekey as key FROM collectioneducationalaudience WHERE collectionid = $1;";
                    q.educationalRoles = await db.any(query, [ q.id ]);
                    query = "SELECT value, accessibilityhazardkey as key FROM collectionaccessibilityhazard WHERE collectionid = $1;";
                    q.accessibilityHazards = await db.any(query, [ q.id ]);
                    query = "SELECT value, accessibilityfeaturekey as key FROM collectionaccessibilityfeature WHERE collectionid = $1;";
                    q.accessibilityFeatures = await db.any(query, [ q.id ]);
                    query = "SELECT value, educationallevelkey as key FROM collectioneducationallevel WHERE collectionid = $1;";
                    q.educationalLevels = await db.any(query, [ q.id ]);
                    query = "Select filepath, filekey as thumbnail from collectionthumbnail where collectionid = $1 and obsoleted = 0;";
                    let response = await db.oneOrNone(query, [q.id]);
                    q.thumbnail = undefined;
                    if (response) {
                        q.thumbnail = await aoeCollectionThumbnailDownloadUrl(response.thumbnail);
                    }
                    query = "select concat(firstname, ' ', lastname) as name from userscollection join users on usersusername = username where collectionid = $1;";
                    response = await db.any(query, [q.id]);
                    const authors = [];
                    response.map(o => authors.push(o.name));
                    q.authors = authors;
                return q; }
                )
            );
            return {collections};
        });
        return data;
    }
    catch (err) {
        throw new Error(err);
    }
}

export async function collectionDataToEs(index: string, data: any) {
    try {
        if (data.length > 0) {
        const body = data.flatMap(doc => [{ index: { _index: index, _id: doc.id } }, doc]);
        // console.log("THIS IS BODY:");
        // console.log(JSON.stringify(body));
        const { body: bulkResponse } = await client.bulk({ refresh: "true", body });
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
        }
    }
    catch (err) {
        throw new Error(err);
    }
}

export async function getCollectionDataToUpdate(time: Date) {
    try {
        const data = await db.tx(async (t: any) => {
            console.log("updateCollectionQuery:");
            let query = "select collection.id, publishedat, updatedat, createdat, collectionname as name, description from collection WHERE updatedat > $1 and publishedat IS NOT NULL;";
            const params: any = [];
            params.push(time);
            console.log(query, params);
            const collections = await Promise.all(
                await t.map(query, params, async (q: any) => {
                    query = "SELECT value, keywordkey as key FROM collectionkeyword WHERE collectionid = $1;";
                    q.keywords = await db.any(query, [ q.id ]);
                    query = "SELECT language FROM collectionlanguage WHERE collectionid = $1;";
                    const languageObjects = await db.any(query, [ q.id ]);
                    q.languages = languageObjects.map(o => o.language);
                    query = "SELECT alignmenttype, targetname, source, educationalframework, objectkey, targeturl FROM collectionalignmentobject WHERE collectionid = $1;";
                    q.alignmentObjects = await db.any(query, [ q.id ]);
                    query = "SELECT value, educationalusekey as key FROM collectioneducationaluse WHERE collectionid = $1;";
                    q.educationalUses = await db.any(query, [ q.id ]);
                    query = "SELECT educationalrole as value, educationalrolekey as key FROM collectioneducationalaudience WHERE collectionid = $1;";
                    q.educationalRoles = await db.any(query, [ q.id ]);
                    query = "SELECT value, accessibilityhazardkey as key FROM collectionaccessibilityhazard WHERE collectionid = $1;";
                    q.accessibilityHazards = await db.any(query, [ q.id ]);
                    query = "SELECT value, accessibilityfeaturekey as key FROM collectionaccessibilityfeature WHERE collectionid = $1;";
                    q.accessibilityFeatures = await db.any(query, [ q.id ]);
                    query = "SELECT value, educationallevelkey as key FROM collectioneducationallevel WHERE collectionid = $1;";
                    q.educationalLevels = await db.any(query, [ q.id ]);
                    query = "Select filepath, filekey as thumbnail from collectionthumbnail where collectionid = $1 and obsoleted = 0;";
                    let response = await db.oneOrNone(query, [q.id]);
                    q.thumbnail = undefined;
                    if (response) {
                        q.thumbnail = await aoeCollectionThumbnailDownloadUrl(response.thumbnail);
                    }
                    query = "select concat(firstname, ' ', lastname) as name from userscollection join users on usersusername = username where collectionid = $1;";
                    response = await db.any(query, [q.id]);
                    const authors = [];
                    response.map(o => authors.push(o.name));
                    q.authors = authors;
                return q; }
                )
            );
            return {collections};
        });
        return data;
    }
    catch (err) {
        throw new Error(err);
    }
}