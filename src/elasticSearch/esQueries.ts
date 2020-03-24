/// <reference path="es.ts" />
import {
    Client,
    ApiResponse
  } from "@elastic/elasticsearch";
const index = process.env.ES_INDEX;

const client = new Client({node: process.env.ES_NODE});

import { Request, Response, NextFunction } from "express";
interface MultiMatchSeachBody {
  query: {
    bool: {
      must: Array<object>
    }
  };
}
interface FilterTerm {
  term: {
    [key: string]: string
  };
}
interface MatchObject {
  bool: {
    must: Array<
      {
        match: {
          [key: string]: string
      };
    }>;
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
    materials: Array<{
            id: number;
            language: string;
            link: string;
            priority: number;
            filepath: string;
            originalfilename: string;
            filesize: number;
            mimetype: string;
            format: string;
            filekey: string;
            filebucket: string;
            obsoleted: number;
            materialdisplayname: Array<{
                    id: string;
                    displayname: string;
                    language: string;
                    materialid: number;
              }>;
        }>;
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
interface AoeRequestFilter {
  educationalLevels: Array<string>;
  learningResourceTypes: Array<string>;
  educationalSubjects: Array<string>;
  educationalRoles: Array<string>;
  authors: Array<string>;
  alignmentTypes: Array<string>;
  keywords: Array<string>;
  languages: Array<string>;
  organizations: Array<string>;
  teaches: Array<string>;
}
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
        educationalLevels?: Array<{
          value: string;
          educationallevelkey: string;
        }>;
        keywords?: Array<{
          value: string;
          keywordkey: string;
        }>;
        educationalRoles?: Array<{
          value: string;
          educationalrolekey: string;
        }>;

        languages?: Array<string>;
        educationalSubjects?: Array<{
          value: string;
          key: string;
          source: string;
        }>;
        teaches?: Array<{
          value: string;
          key: string;
        }>;
        thumbnail?: string;
        hasDownloadableFiles?: boolean;
      }

async function aoeResponseMapper (response: ApiResponse<SearchResponse<Source>> ) {
  try {
    const resp: AoeBody<AoeResult> = {
      hits : response.body.hits.total.value
    };
    const hits = response.body.hits.hits;
    if (hits) {
      const source = hits.map(hit => hit._source);
      if (source) {
        const result = source.map(obj => {
          const rObj: AoeResult = {};
          rObj.id = obj.id,
          rObj.createdAt = obj.createdat,
          rObj.publishedAt = obj.publishedat,
          rObj.updatedAt = obj.updatedat;
          const mname = obj.materialname;
          rObj.materialName = (mname) ? mname.map(name => ({materialname : name.materialname, language : name.language})) : undefined;
          rObj.description = (obj.materialdescription) ? obj.materialdescription.map(description => (
            {description : description.description, language : description.language})) : undefined;
          rObj.authors = (obj.author) ? obj.author.map(author => (
            {authorname : author.authorname, organization : author.organization, organizationkey : author.organizationkey})) : undefined;
          rObj.learningResourceTypes = (obj.learningresourcetype) ? obj.learningresourcetype.map(lrt => ({value : lrt.value, learningresourcetypekey : lrt.learningresourcetypekey})) : undefined;
          rObj.license =  obj.licensecode,
          rObj.educationalLevels =  (obj.educationallevel) ? obj.educationallevel.map(el => ({value : el.value, educationallevelkey : el.educationallevelkey})) : undefined,
          rObj.educationalRoles =  (obj.educationalaudience) ? obj.educationalaudience.map(role => ({value : role.educationalrole, educationalrolekey : role.educationalrolekey})) : undefined,
          rObj.keywords =  (obj.keyword) ? obj.keyword.map(word => ({value : word.value, keywordkey : word.keywordkey})) : undefined,
          rObj.languages = (obj.materials) ? [...new Set(obj.materials.map(material => (material.language)))] : undefined,
          rObj.educationalSubjects = (obj.alignmentobject) ? obj.alignmentobject
          .filter(object => {return object.alignmenttype === "educationalSubject"; })
          .map(object => ({key : object.objectkey, source : object.source, value : object.targetname})) : undefined,
          rObj.teaches = (obj.alignmentobject) ? obj.alignmentobject
          .filter(object => {return object.alignmenttype === "teaches"; })
          .map(object => ({key : object.objectkey, value : object.targetname})) : undefined,
          rObj.hasDownloadableFiles = (obj.materials) ? hasDownloadableFiles(obj.materials) : false,
          rObj.thumbnail =  obj.thumbnail;
          return rObj;
          }
        );
        resp.results = result;
      }
      }
    return resp;
  }
  catch (err) {
    console.log(err);
    throw new Error(err);
  }
}

/**
 *
 * @param materials
 * return true if any material has pouta filekey
 */
function hasDownloadableFiles(materials: Array<{ filekey: string }>) {
  try {
    for (const element of materials) {
      if (element.filekey) {
        return true;
      }
    }
    return false;
  }
  catch (err) {
    console.error(err);
    throw new Error(err);
  }
}

async function elasticSearchQuery(req: Request, res: Response) {
  try {
    let from = 0;
    let size = 100;
    if (req.body.from) {
      from = req.body.from;
    }
    if (req.body.size) {
      size = req.body.size;
    }
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
    const mustList = [];
    if (req.body.keywords) {
      mustList.push(createMultiMatchObject(req.body.keywords, fields));
    } else {
      // match all if keywords null
      mustList.push(createMatchAllObject());
    }
    if (req.body.filters) {
      const filters = filterMapper(req.body.filters);
      filters.map(filter => mustList.push(filter));
    }
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
    client.search(query
    , async (err: Error, result: ApiResponse<SearchResponse<Source>>) => {
        if (err) {
            console.log(JSON.stringify(err));
            res.status(500).json(err);
        }
        else {
          try {
            const responseBody: AoeBody<AoeResult> = await aoeResponseMapper(result);
            res.status(200).json(responseBody);
          }
          catch (err) {
            console.log(err);
            res.status(500).json(err);
          }
        }
      });
    }
    catch (err) {
      console.log(err);
      res.sendStatus(500);
    }
}

function filterMapper(filters: AoeRequestFilter) {
    try {
      const filter = [];
      if (filters.educationalLevels) {
        createShouldObject(filter, "educationallevel.educationallevelkey.keyword", filters.educationalLevels);
      }
      if (filters.learningResourceTypes) {
        createShouldObject(filter, "learningresourcetype.learningresourcetypekey.keyword", filters.learningResourceTypes);
      }
      if (filters.educationalSubjects) {
        createShouldObject(filter, "alignmentobject.objectkey.keyword", filters.educationalSubjects, "educationalSubject");
      }
      if (filters.educationalRoles) {
        createShouldObject(filter, "educationalaudience.educationalrolekey.keyword", filters.educationalRoles);
      }
      if (filters.authors) {
        createShouldObject(filter, "author.authorname.keyword", filters.authors);
      }
      if (filters.alignmentTypes) {
        createShouldObject(filter, "alignmentobject.alignmenttype.keyword", filters.alignmentTypes);
      }
      if (filters.keywords) {
        createShouldObject(filter, "keyword.keywordkey.keyword", filters.keywords);
      }
      if (filters.languages) {
        createShouldObject(filter, "materials.language.keyword", filters.languages);
      }
      if (filters.organizations) {
        createShouldObject(filter, "author.organizationkey.keyword", filters.organizations);
      }
      if (filters.teaches) {
        createShouldObject(filter, "alignmentobject.objectkey.keyword", filters.teaches, "teaches");
      }

      return filter;
    }
    catch (err) {
      console.log(err);
      throw new Error(err);
    }
}

function createMatchAllObject() {
  return {"match_all": {}};
}

function createMultiMatchObject(keywords: string, fields: string[]) {
  return {
    "multi_match": {
      "query": keywords,
      "fields": fields,
      "fuzziness" : "AUTO"
    }
  };
}
/**
 *
 * @param filter
 * @param key
 * @param valueList
 * @param alignmentObjectType
 *
 * Creates bool should object for elastic search query
 * uses elastic search term object as default or
 * must match list if alignmentObjectType is defined
 */
function createShouldObject(filter: Array<object>, key: string, valueList: Array<string>, alignmentObjectType?: string) {
  try {
    if (alignmentObjectType) {
      const mustMatchObjectList: MatchObject[] = [];
      valueList.map(key => {
        mustMatchObjectList.push(createMustMatchObject(key, alignmentObjectType));
      });
      if (mustMatchObjectList.length > 0) {
        filter.push({"bool": {"should": mustMatchObjectList}});
      }
    }
    else {
      const shouldFilter: FilterTerm[] = [];
      valueList.map(term => {
            const obj = {};
            obj[key] = term;
            shouldFilter.push({"term": obj});
          });
      if (shouldFilter.length > 0) {
        filter.push({"bool": {"should": shouldFilter}});
      }
    }
  }
  catch (err) {
    console.log(err);
    throw new Error(err);
  }
}

function createMustMatchObject(key: string, type: string) {
  try {
    const mustObj = {"bool": {
                      "must": [ {
                        "match": {
                          "alignmentobject.alignmenttype.keyword": type}
                        },
                                {
                        "match": {
                          "alignmentobject.objectkey.keyword": key}
                        }
                      ]
                    }
                  };
                  return mustObj;
  }
  catch (err) {
    console.log(err);
    throw new Error(err);
  }
}
module.exports = {
    elasticSearchQuery : elasticSearchQuery,
    createShouldObject,
    createMultiMatchObject,
    createMatchAllObject,
    filterMapper,
    aoeResponseMapper,
    hasDownloadableFiles,
    createMustMatchObject
};