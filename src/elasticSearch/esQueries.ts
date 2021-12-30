// <reference path="es.ts" />
import {
    Client,
    ApiResponse
} from "@elastic/elasticsearch";

const index = process.env.ES_INDEX;

const client = new Client({node: process.env.ES_NODE});

import { Request, Response, NextFunction } from "express";
import { ErrorHandler } from "./../helpers/errorHandler";
import {
    SearchResponse,
    Source,
    AoeBody,
    AoeResult,
    AoeRequestFilter,
    MultiMatchSeachBody,
    MatchObject,
    FilterTerm,
    expiresFilterObject
} from "./esTypes";
import { winstonLogger } from '../util';

export async function aoeResponseMapper(response: ApiResponse<SearchResponse<Source>>) {
    try {
        const resp: AoeBody<AoeResult> = {
            hits: response.body.hits.total.value
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
                        rObj.materialName = (mname) ? mname.map(name => ({
                            materialname: name.materialname,
                            language: name.language
                        })) : undefined;
                        rObj.description = (obj.materialdescription) ? obj.materialdescription.map(description => (
                            {description: description.description, language: description.language})) : undefined;
                        rObj.authors = (obj.author) ? obj.author.map(author => (
                            {
                                authorname: author.authorname,
                                organization: author.organization,
                                organizationkey: author.organizationkey
                            })) : undefined;
                        rObj.learningResourceTypes = (obj.learningresourcetype) ? obj.learningresourcetype.map(lrt => ({
                            value: lrt.value,
                            learningresourcetypekey: lrt.learningresourcetypekey
                        })) : undefined;
                        rObj.license = {key: obj.license.key, value: obj.license.value};
                        rObj.educationalLevels = (obj.educationallevel) ? obj.educationallevel.map(el => ({
                            value: el.value,
                            educationallevelkey: el.educationallevelkey
                        })) : undefined,
                            rObj.educationalRoles = (obj.educationalaudience) ? obj.educationalaudience.map(role => ({
                                value: role.educationalrole,
                                educationalrolekey: role.educationalrolekey
                            })) : undefined,
                            rObj.keywords = (obj.keyword) ? obj.keyword.map(word => ({
                                value: word.value,
                                keywordkey: word.keywordkey
                            })) : undefined,
                            rObj.languages = (obj.materials) ? Array.from(new Set(obj.materials.map(material => (material.language)))) : undefined,
                            rObj.educationalSubjects = (obj.alignmentobject) ? obj.alignmentobject
                                .filter(object => {
                                    return object.alignmenttype === "educationalSubject";
                                })
                                .map(object => ({
                                    key: object.objectkey,
                                    source: object.source,
                                    value: object.targetname
                                })) : undefined,
                            rObj.teaches = (obj.alignmentobject) ? obj.alignmentobject
                                .filter(object => {
                                    return object.alignmenttype === "teaches";
                                })
                                .map(object => ({key: object.objectkey, value: object.targetname})) : undefined,
                            rObj.hasDownloadableFiles = (obj.materials) ? hasDownloadableFiles(obj.materials) : false,
                            rObj.thumbnail = obj.thumbnail;
                        rObj.popularity = obj.popularity;
                        rObj.educationalUses = (obj.educationaluse) ? obj.educationaluse.map(element => ({
                            value: element.value,
                            educationalusekey: element.educationalusekey
                        })) : undefined;
                        rObj.accessibilityFeatures = (obj.accessibilityfeature) ? obj.accessibilityfeature.map(element => ({
                            value: element.value,
                            accessibilityfeaturekey: element.accessibilityfeaturekey
                        })) : undefined;
                        rObj.accessibilityHazards = (obj.accessibilityhazard) ? obj.accessibilityhazard.map(element => ({
                            value: element.value,
                            accessibilityhazardkey: element.accessibilityhazardkey
                        })) : undefined;
                        return rObj;
                    }
                );
                resp.results = result;
            }
        }
        return resp;
    } catch (err) {
        throw new Error(err);
    }
}

/**
 *
 * @param materials
 * return true if any material has pouta filekey
 */
export function hasDownloadableFiles(materials: Array<{ filekey: string }>) {
    try {
        for (const element of materials) {
            if (element.filekey) {
                return true;
            }
        }
        return false;
    } catch (err) {
        winstonLogger.error(err);
        throw new Error(err);
    }
}

export const elasticSearchQuery = async (req: Request, res: Response, next: NextFunction): Promise<any> => {
    try {
        let from = Number(process.env.ES_FROM_DEFAULT) || 0;
        let size = Number(process.env.ES_SIZE_DEFAULT) || 100;
        if (req.body.from) {
            from = req.body.from;
        }
        if (req.body.size) {
            size = req.body.size;
        }
        const fields = [
            "accessibilityfeature.value",
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
            "license.value.keyword",
            "license.key",
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
                "bool": {
                    "must": mustList,
                    "filter": expiresFilterObject
                }
            }
        };

        if (req.body.sort) {
            const sort = [];
            // allways sort using popularity if sort exists in body
            if (req.body.sort.popularity === "asc") {
                sort.push({
                    "popularity": "asc"
                });
            } else if (req.body.sort.updatedAt === "asc") {
                sort.push({
                    "updatedat": {"order": "asc"}
                });
            } else if (req.body.sort.updatedAt === "desc") {
                sort.push({
                    "updatedat": {"order": "desc"}
                });
            } else {
                sort.push({
                    "popularity": "desc"
                });
            }
            body.sort = sort;
        }

        const query = {
            "index": index,
            "from": from,
            "size": size,
            "body": body
        };
        winstonLogger.debug('Elasticsearch query: ' + JSON.stringify(query));
        const result: ApiResponse<SearchResponse<Source>> = await client.search(query);
        const responseBody: AoeBody<AoeResult> = await aoeResponseMapper(result);
        res.status(200).json(responseBody);
    } catch (error) {
        next(new ErrorHandler(500, 'Error in elasticSearchQuery(): ' + error));
    }
}

export function filterMapper(filters: AoeRequestFilter) {
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
        if (filters.educationalUses) {
            createShouldObject(filter, "educationaluse.educationalusekey.keyword", filters.educationalUses);
        }
        if (filters.accessibilityFeatures) {
            createShouldObject(filter, "accessibilityfeature.accessibilityfeaturekey.keyword", filters.accessibilityFeatures);
        }
        if (filters.accessibilityHazards) {
            createShouldObject(filter, "accessibilityhazard.accessibilityhazardkey.keyword", filters.accessibilityHazards);
        }
        if (filters.licenses) {
            createShouldObject(filter, "license.key.keyword", filters.licenses);
        }
        return filter;
    } catch (err) {
        throw new Error(err);
    }
}

export function createMatchAllObject() {
    return {"match_all": {}};
}

export function createMultiMatchObject(keywords: string, fields: string[]) {
    return {
        "multi_match": {
            "query": keywords,
            "fields": fields,
            "fuzziness": "AUTO"
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
export function createShouldObject(filter: Array<any>, key: string, valueList: Array<string>, alignmentObjectType?: string) {
    try {
        if (alignmentObjectType) {
            const mustMatchObjectList: MatchObject[] = [];
            valueList.map(key => {
                mustMatchObjectList.push(createMustMatchObject(key, alignmentObjectType));
            });
            if (mustMatchObjectList.length > 0) {
                filter.push({"bool": {"should": mustMatchObjectList}});
            }
        } else {
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
    } catch (err) {
        throw new Error(err);
    }
}

export function createMustMatchObject(key: string, type: string) {
    try {
        const mustObj = {
            "bool": {
                "must": [{
                    "match": {
                        "alignmentobject.alignmenttype.keyword": type
                    }
                },
                    {
                        "match": {
                            "alignmentobject.objectkey.keyword": key
                        }
                    }
                ]
            }
        };
        return mustObj;
    } catch (err) {
        throw new Error(err);
    }
}

export async function deleteDocument(index: string, id: string) {
    try {
        const query = {"index": index, "id": id};
        const resp = await client.delete(query);
        winstonLogger.debug(resp);

    } catch (error) {
        winstonLogger.error(error);
    }
}

export default {
    elasticSearchQuery,
    createShouldObject,
    createMultiMatchObject,
    createMatchAllObject,
    filterMapper,
    aoeResponseMapper,
    hasDownloadableFiles,
    createMustMatchObject,
    deleteDocument
};
