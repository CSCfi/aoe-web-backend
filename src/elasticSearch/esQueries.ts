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
        from?: number,
        size?: number,
    };
}

interface ShardsResponse {
  total: number;
  successful: number;
  failed: number;
  skipped: number;
}

interface Explanation {
  value: number;
  description: string;
  details: Explanation[];
}

interface SearchResponse<T> {
  took: number;
  timed_out: boolean;
  _scroll_id?: string;
  _shards: ShardsResponse;
  hits: {
    total: {
      value: number;
      relation: string;
    }
    max_score: number;
    hits: Array<{
      _index: string;
      _type: string;
      _id: string;
      _score: number;
      _source: T;
      _version?: number;
      _explanation?: Explanation;
      fields?: any;
      highlight?: any;
      inner_hits?: any;
      matched_queries?: string[];
      sort?: string[];
    }>;
  };
  aggregations?: any;
}

interface Source {
    id: number;
    createdat: Date;
    publishedat: Date;
    updatedat: Date;
    archivedat: Date;
    timerequired: string;
    agerangemin: string;
    agerangemax: string;
    licensecode: string;
    obsoleted: number;
    originalpublishedat: Date;
    expires: Date;
    suitsallearlychildhoodsubjects: boolean;
    suitsallpreprimarysubjects: boolean;
    suitsallbasicstudysubjects: boolean;
    suitsalluppersecondarysubjects: boolean;
    suitsallvocationaldegrees: boolean;
    suitsallselfmotivatedsubjects: boolean;
    suitsallbranches: boolean;
    // materials: Array<{
    //         id: number;
    //         language: string;
    //         link: string;
    //         priority: number;
    //         filepath: string;
    //         originalfilename: string;
    //         filesize: number;
    //         mimetype: string;
    //         format: string;
    //         filekey: string;
    //         filebucket: string;
    //         obsoleted: number;
    //         materialdisplayname: Array<{
    //                 id: string;
    //                 displayname: string;
    //                 language: string;
    //                 materialid: number;
    //           }>;
    //     }>;
    materialname: Array<{
        id: number;
        materialname: string;
        language: string;
        slug: string;
        educationalmaterialid: number;
    }>;
    materialdescription: Array<{
        id: number;
        description: string;
        language: string;
        educationalmaterialid: number;
    }>;
    educationalaudience: Array<{
        id: number;
        educationalrole: string;
        educationalmaterialid: number;
        educationalrolekey: string;
    }>;
    learningresourcetype: Array<{
        id: number;
        value: string;
        educationalmaterialid: number;
        learningresourcetypekey: string;
    }>;
    accessibilityfeature: Array<{
            id: number;
            value: string;
            educationalmaterialid: number;
            accessibilityfeaturekey: string;
    }>;
    accessibilityhazard: Array<{
      id: number;
      value: string;
      educationalmaterialid: number;
      accessibilityhazardkey: string;
    }>;
    keyword: Array<{
      id: number;
      value: string;
      educationalmaterialid: number;
      keywordkey: string;
    }>;
    educationallevel: Array<{
      id: number;
      value: string;
      educationalmaterialid: number;
      educationallevelkey: string;
    }>;
    educationaluse: Array<{
      id: number;
      value: string;
      educationalmaterialid: number;
      educationalusekey: string;
    }>;
    publisher: Array<{
    }>;
    author: Array<{
      id: number;
      authorname: string;
      organization: string;
      educationalmaterialid: number;
      organizationkey: string;
    }>;
    isbasedon: Array<{
    }>;
    inlanguage: Array<{
    }>;
    alignmentobject: Array<{
      id: number;
      educationalmaterialid: number;
      alignmenttype: string;
      targetname: string;
      source: string;
      educationalframework: string;
      objectkey: string;
      targeturl: string;
    }>;
    owner: Array<{
            firstname: string;
            lastname: string;
    }>;
    thumbnail: string;
}

// interface AoeBody {
//   hits: number;
//   results?: Array<
//     {
// _source: T;

interface AoeBody<T> {
    hits: number;
    results?: Array<T>;
}
interface AoeResult {
        id?: number;
        createdAt?: Date;
        publishedAt?: Date;
        updatedAt?: Date;
        materialName?: Array<{
          materialname: string;
          language: string;
        }>;
        description?: Array<{
          description: string;
          language: string;
        }>;
        authors?: Array<{
          authorname: string;
          organization: string;
          organizationkey: string;
        }>;
        learningResourceTypes?: Array<{
          value: string;
          learningresourcetypekey: string;
        }>
        ;
        license?: string;
        // alignmentObjects: Array<{
        //   id: number;
        //   educationalmaterialid: number;
        //   alignmenttype: string;
        //   targetname: string;
        //   source: string;
        //   educationalframework: string;
        //   objectkey: string;
        //   targeturl: string;
        // }>;
        educationLevels?: Array<{
          value: string;
          educationallevelkey: string;
        }>;
        thumbnail?: string;
      }


async function aoeResponseMapper (response: ApiResponse<SearchResponse<Source>> ) {
  console.log("response:");
  console.log(response);
  const resp: AoeBody<AoeResult> = {
    hits : response.body.hits.total.value
  };

  const hits = response.body.hits.hits;
  hits.map(hit => console.log(hit));
  const source = hits.map(hit => hit._source);
  // resp.hits = response.body.hits.total;
  const result = source.map(obj => {
    const rObj: AoeResult = {};
    rObj.id = obj.id,
    rObj.createdAt = obj.createdat,
    rObj.publishedAt = obj.publishedat,
    rObj.updatedAt = obj.updatedat;
    const mname = obj.materialname;
    rObj.materialName = mname.map(name => ({materialname : name.materialname, language : name.language}));
    rObj.description = obj.materialdescription.map(description => (
      {description : description.description, language : description.language}));
    rObj.authors = obj.author.map(author => (
      {authorname : author.authorname, organization : author.organization, organizationkey : author.organizationkey}));
    rObj.learningResourceTypes = obj.learningresourcetype.map(lrt => ({value : lrt.value, learningresourcetypekey : lrt.learningresourcetypekey}));
    rObj.license =  obj.licensecode,
    rObj.educationLevels =  obj.educationallevel.map(el => ({value : el.value, educationallevelkey : el.educationallevelkey})),
    rObj.thumbnail =  obj.thumbnail;
    return rObj;
    }
  );
  // console.log(source);
  resp.results = result;
  console.log(resp);
  return resp;
}

async function elasticSearchQuery(req: Request, res: Response) {
  try {
    const fields = [ "accessibilityfeature.value",
    "accessibilityhazard.value",
    "alignmentobject.targetname",
    "alignmentobject.educationalframework",
    "author.authorname",
    "author.organization",
    "educationalaudience.educationalrole",
    "educationallevel.value",
    "educationaluse.value",
    "inlanguage.inlanguage",
    "isbasedon.author",
    "isbasedon.materialname",
    "keyword.value",
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
            "fields": fields,
          }
        }
      };
    client.search({"index" : index,
                    "from" : 0,
                    "size" : 1000,
                    "body" : body}
    , async (err: Error, result: ApiResponse<SearchResponse<Source>>) => {
        if (err) {
            console.log(JSON.stringify(err));
            res.status(500).json(err);
        }
        else {
          const body: AoeBody<AoeResult> = await aoeResponseMapper(result);
          // aoeResponseMapper(result);
          console.log(body);
            res.status(200).json(body);
        }
      });
    }
    catch (err) {
      console.log(err);
      res.sendStatus(500);
    }
}

module.exports = {
    elasticSearchQuery : elasticSearchQuery
};