const connection = require("./../db");
const pgp = connection.pgp;
const db = connection.db;
import { Collection } from "./../collection/collection";
import { aoeThumbnailDownloadUrl, aoeCollectionThumbnailDownloadUrl } from "./../services/urlService";

/**
 *
 * @param username
 * @param collection
 * create new collection to database
 */
export async function insertCollection(username: string, collection: Collection) {
    try {
        const id = await db.tx(async (t: any) => {
            let query;
            query = "insert into collection (createdat, updatedat, createdby, collectionname) values (now(),now(),$1, $2) returning id;";
            console.log("CollectionQueries insertCollection: " + query, [username, collection.name]);
            const id = await t.oneOrNone(query, [username, collection.name]);
            query = "INSERT INTO userscollection (usersusername, collectionid) VALUES ($1,$2) ON CONFLICT (usersusername, collectionid) DO NOTHING;";
            console.log("CollectionQueries insertCollection: " + query, [username, id.id]);
            await t.none(query, [username, id.id]);
            return {id};
        });
        return id.id;
    }
    catch (err) {
        console.log(err);
        throw new Error(err);
    }
}
/**
 *
 * @param collection
 * insert educational materials to collection
 */
export async function insertEducationalMaterialToCollection(collection: Collection) {
    try {
        const values: object[] = [];
        collection.emId.map(id => values.push({collectionid : collection.collectionId, educationalmaterialid: id}));
        const cs = new pgp.helpers.ColumnSet(["collectionid", "educationalmaterialid"], {table: "collectioneducationalmaterial"});
        const query = pgp.helpers.insert(values, cs) + " ON CONFLICT (collectionid, educationalmaterialid) DO NOTHING;";
        console.log(query);
        await db.none(query);
    }
    catch (err) {
        console.log(err);
        throw new Error(err);
    }
}
/**
 *
 * @param collection
 * remove educational materials from collection
 */
export async function deleteEducationalMaterialFromCollection(collection: Collection) {
    try {
        const values: object[] = [];
        // collection.emId.map(id => values.push({collectionid : collection.collectionId, educationalmaterialid: id}));
        const query = "DELETE FROM collectioneducationalmaterial WHERE collectionid = $1 AND educationalmaterialid IN ($2:list);";
        console.log(pgp.as.format(query), [ collection.collectionId, collection.emId]);
        await db.none(query, [ collection.collectionId, collection.emId]);
    }
    catch (err) {
        console.log(err);
        throw new Error(err);
    }
}
/**
 *
 * @param username
 * get collection for user
 */
export async function userCollections(username: string) {
    try {
        const data = await db.tx(async (t: any) => {
            console.log("userCollections:");
            const query = "select collection.id, publishedat, updatedat, createdat, collectionname as name, description, ct.filekey as thumbnail from collection join userscollection as uc on collection.id = uc.collectionid left join collectionthumbnail as ct on collection.id = ct.collectionid and ct.obsoleted = 0 where usersusername = $1;";
            console.log(query, [username]);
            const collections = await Promise.all(
                await t.map(query, [ username ], async (q: any) => {
                const emIds = await t.any("select educationalmaterialid as id, priority from collectioneducationalmaterial where collectionid = $1;", [q.id]
                );
                q.emIds = emIds.map(m => m.id);
                if (q.thumbnail) {
                    q.thumbnail = await aoeCollectionThumbnailDownloadUrl(q.thumbnail);
                }
                return q; }
                )
            );
            return {collections};
        });
        return data;
    }
    catch (err) {
        console.log(err);
        throw new Error(err);
    }
}
/**
 *
 * @param collectionId
 * @param username
 * get collection educational materials and metadata
 * if published username is not required
 * otherwise check if username is owner of the collection to return data
 */
export async function collectionQuery(collectionId: string, username?: string) {
    try {
        const data = await db.task(async (t: any) => {
            let query = "select id, publishedat, updatedat, createdat, collectionname as name, description from collection where id = $1;";
            console.log(query, [ collectionId ]);
            const collection = await t.oneOrNone(query, [ collectionId ]);
            let owner = false;
            if (!collection) {
                return {};
            }
            query = "Select * from userscollection where collectionid = $1 and usersusername = $2;";
            if (!collection.publishedat) {
                if (!username) {
                    return {};
                }
                const ownerResult = await t.oneOrNone(query, [ collectionId , username]);
                if (!ownerResult) {
                    return {};
                }
                else {
                    owner = true;
                }
            }
            else {
                if (!username) {
                    owner = false;
                }
                const ownerResult = await t.oneOrNone(query, [ collectionId , username]);
                if (!ownerResult) {
                    owner = false;
                }
                else {
                    owner = true;
                }
            }
            query = "SELECT value, keywordkey as key FROM collectionkeyword WHERE collectionid = $1;";
            const keywords = await t.any(query, [ collectionId ]);
            query = "SELECT language FROM collectionlanguage WHERE collectionid = $1;";
            const languageObjects = await t.any(query, [ collectionId ]);
            const languages = languageObjects.map(o => o.language);
            query = "SELECT alignmenttype, targetname, source, educationalframework, objectkey, targeturl FROM collectionalignmentobject WHERE collectionid = $1;";
            const alignmentObjects = await t.any(query, [ collectionId ]);
            query = "SELECT value, educationalusekey as key FROM collectioneducationaluse WHERE collectionid = $1;";
            const educationalUses = await t.any(query, [ collectionId ]);
            query = "SELECT educationalrole as value, educationalrolekey as key FROM collectioneducationalaudience WHERE collectionid = $1;";
            const educationalRoles = await t.any(query, [ collectionId ]);
            query = "SELECT value, accessibilityhazardkey as key FROM collectionaccessibilityhazard WHERE collectionid = $1;";
            const accessibilityHazards = await t.any(query, [ collectionId ]);
            query = "SELECT value, accessibilityfeaturekey as key FROM collectionaccessibilityfeature WHERE collectionid = $1;";
            const accessibilityFeatures = await t.any(query, [ collectionId ]);
            console.log(query, [collection.id]);
            query = "SELECT value, educationallevelkey as key FROM collectioneducationallevel WHERE collectionid = $1;";
            const educationalLevels = await t.any(query, [ collectionId ]);

            query = "select educationalmaterialid as id, priority, publishedat from collectioneducationalmaterial as cem left join educationalmaterial as em on cem.educationalmaterialid = em.id where collectionid = $1;";
            const educationalmaterials = await Promise.all(await t.map(query, [collection.id], async (q: any) => {
                console.log(query, [q.id]);
                query = "select authorname, organization, organizationkey from author where educationalmaterialid = $1;";
                console.log(query, [q.id]);
                q.author = await t.any(query, [q.id]);
                query = "select licensecode as key, l.license as value from educationalmaterial as m left join licensecode as l ON l.code = m.licensecode where id = $1;";
                console.log(query, [q.id]);
                q.license = await t.oneOrNone(query, [q.id]);
                query = "select * from materialname where educationalmaterialid = $1;";
                console.log(query, [q.id]);
                const emname =  await t.any(query, [q.id]);
                q.name = emname.reduce(function(map, obj) {
                    map[obj.language] = obj.materialname;
                    return map;
                }, {});
                query = "select * from materialdescription where educationalmaterialid = $1;";
                const emdescription =  await t.any(query, [q.id]);
                q.description = emdescription.reduce(function(map, obj) {
                    map[obj.language] = obj.description;
                    return map;
                }, {});
                query = "Select filekey as thumbnail from thumbnail where educationalmaterialid = $1 and obsoleted = 0;";
                const thumbnailresponse = await t.oneOrNone(query, [q.id]);
                if (thumbnailresponse) {
                    thumbnailresponse.thumbnail = await aoeThumbnailDownloadUrl(thumbnailresponse.thumbnail);
                }
                q.thumbnail = thumbnailresponse;

                query = "select * from learningresourcetype where educationalmaterialid = $1;";
                q.learningResourceTypes = await t.any(query, [q.id]);

                return q;
            }));
            query = "SELECT id, heading, description, priority FROM collectionheading WHERE collectionid = $1;";
            const headings = await t.any(query, [ collectionId ]);

            query = "Select filepath, filekey as thumbnail from collectionthumbnail where collectionid = $1 and obsoleted = 0;";
            let response = await db.oneOrNone(query, [collectionId]);
            let thumbnail = undefined;
            if (response) {
                thumbnail = await aoeCollectionThumbnailDownloadUrl(response.thumbnail);
            }
            query = "select concat(firstname, ' ', lastname) as name from userscollection join users on usersusername = username where collectionid = $1;";
            response = await t.any(query, [collectionId]);
            const authors = [];
            response.map(o => authors.push(o.name));
            return {collection, keywords, languages, alignmentObjects, educationalUses, educationalRoles, educationalmaterials, accessibilityHazards, accessibilityFeatures, educationalLevels, headings, owner, thumbnail, authors};
        });
        return data;
    }
    catch (err) {
        console.log(err);
        throw new Error(err);
    }
}
/**
 *
 * @param collection
 * insert metadata to collection
 */
export async function insertCollectionMetadata(collection: Collection) {
    try {
        const collectionId = collection.collectionId;
        const data = await db.tx(async (t: any) => {
            const queries = [];
            console.log("updateCollection: ");
            const description = (collection.description) ? collection.description : "";
            console.log(description);
            let query = "UPDATE collection SET description = $1, collectionname = $2, updatedat = now() where id = $3;";
            console.log(query, [collectionId]);
            let response  = await t.none(query, [description, collection.name, collectionId]);

            query = "DELETE FROM collectionkeyword where collectionid = $1;";
            console.log(query, [collectionId]);
            response  = await t.none(query, [collectionId]);
            queries.push(response);
            let arr;
            if (collection.keywords) {
                arr = collection.keywords;
                for (const element of arr) {
                    query = "INSERT INTO collectionkeyword (collectionid, value, keywordkey) VALUES ($1,$2,$3);";
                    console.log(query, [collectionId, element.value, element.key]);
                    response =  await t.none(query, [collectionId, element.value, element.key]);
                    queries.push(response);
                }
            }

            query = "DELETE FROM collectionlanguage where collectionid = $1;";
            console.log(query, [collectionId]);
            response  = await t.none(query, [collectionId]);
            queries.push(response);
            if (collection.languages) {
                arr = collection.languages;
                for (const element of arr) {
                    query = "INSERT INTO collectionlanguage (collectionid, language) VALUES ($1,$2);";
                    console.log(query, [collectionId, element]);
                    response =  await t.none(query, [collectionId, element]);
                    queries.push(response);
                }
            }
            query = "DELETE FROM collectioneducationalaudience where collectionid = $1;";
            console.log(query, [collectionId]);
            response  = await t.none(query, [collectionId]);
            queries.push(response);
            if (collection.educationalRoles) {
                arr = collection.educationalRoles;
                for (const element of arr) {
                    query = "INSERT INTO collectioneducationalaudience (collectionid, educationalrole, educationalrolekey) VALUES ($1,$2,$3);";
                    console.log(query, [collectionId, element.value, element.key]);
                    response =  await t.none(query, [collectionId, element.value, element.key]);
                    queries.push(response);
                }
            }
            query = "DELETE FROM collectionalignmentobject where collectionid = $1;";
            console.log(query, [collectionId]);
            response  = await t.none(query, [collectionId]);
            queries.push(response);
            if (collection.alignmentObjects) {
                arr = collection.alignmentObjects;
                for (const element of arr) {
                    query = "INSERT INTO collectionalignmentobject (collectionid, alignmenttype, targetname, source, objectkey, educationalframework, targeturl) VALUES ($1,$2,$3,$4,$5,$6,$7);";
                    console.log(query, [collectionId, element.alignmentType, element.targetName, element.source, element.key, element.educationalFramework, element.targetUrl]);
                    response =  await t.none(query, [collectionId, element.alignmentType, element.targetName, element.source, element.key, element.educationalFramework, element.targetUrl]);
                    queries.push(response);
                }
            }
            query = "DELETE FROM collectioneducationaluse where collectionid = $1;";
            console.log(query, [collectionId]);
            response  = await t.none(query, [collectionId]);
            queries.push(response);
            if (collection.educationalUses) {
                arr = collection.educationalUses;
                for (const element of arr) {
                    query = "INSERT INTO collectioneducationaluse (collectionid, value, educationalusekey) VALUES ($1,$2,$3);";
                    console.log(query, [collectionId, element.value, element.key]);
                    response =  await t.none(query, [collectionId, element.value, element.key]);
                    queries.push(response);
                }
            }
            query = "DELETE FROM collectionaccessibilityhazard where collectionid = $1;";
            console.log(query, [collectionId]);
            response  = await t.none(query, [collectionId]);
            queries.push(response);
            if (collection.accessibilityHazards) {
                arr = collection.accessibilityHazards;
                for (const element of arr) {
                    query = "INSERT INTO collectionaccessibilityhazard (collectionid, value, accessibilityhazardkey) VALUES ($1,$2,$3);";
                    console.log(query, [collectionId, element.value, element.key]);
                    response =  await t.none(query, [collectionId, element.value, element.key]);
                    queries.push(response);
                }
            }
            query = "DELETE FROM collectionaccessibilityfeature where collectionid = $1;";
            console.log(query, [collectionId]);
            response  = await t.none(query, [collectionId]);
            queries.push(response);
            if (collection.accessibilityFeatures) {
                arr = collection.accessibilityFeatures;
                for (const element of arr) {
                    query = "INSERT INTO collectionaccessibilityfeature (collectionid, value, accessibilityfeaturekey) VALUES ($1,$2,$3);";
                    console.log(query, [collectionId, element.value, element.key]);
                    response =  await t.none(query, [collectionId, element.value, element.key]);
                    queries.push(response);
                }
            }

            query = "DELETE FROM collectioneducationallevel where collectionid = $1;";
            console.log(query, [collectionId]);
            response  = await t.none(query, [collectionId]);
            queries.push(response);
            if (collection.educationalLevels) {
                arr = collection.educationalLevels;
                for (const element of arr) {
                    query = "INSERT INTO collectioneducationallevel (collectionid, value, educationallevelkey) VALUES ($1,$2,$3);";
                    console.log(query, [collectionId, element.value, element.key]);
                    response =  await t.none(query, [collectionId, element.value, element.key]);
                    queries.push(response);
                }
            }

            if (collection.publish) {
                query = "UPDATE collection SET publishedat = now() where id = $1 and publishedat IS NULL;";
                console.log(query, [collectionId]);
                response  = await t.none(query, [collectionId]);
                queries.push(response);
            }
            if (collection.materials) {
                arr = collection.materials;
                for (const element of arr) {
                    query = "UPDATE collectioneducationalmaterial SET priority = $1 where collectionid = $2 and educationalmaterialid = $3;";
                    console.log(query, [element.priority, collectionId, element.id]);
                    response  = await t.none(query, [element.priority, collectionId, element.id]);
                    queries.push(response);
                }
            }

            query = "DELETE FROM collectionheading where collectionid = $1;";
            console.log(query, [collectionId]);
            response  = await t.none(query, [collectionId]);
            queries.push(response);
            if (collection.headings) {
                arr = collection.headings;
                for (const element of arr) {
                    query = "INSERT INTO collectionheading (collectionid, heading, description, priority) VALUES ($1,$2,$3,$4);";
                    console.log(query, [collectionId, element.heading, element.description, element.priority]);
                    response  = await t.none(query, [collectionId, element.heading, element.description, element.priority]);
                    queries.push(response);
                }
            }
            return t.batch(queries);
        });
        return data;
    }
    catch (err) {
        console.log(err);
        throw new Error(err);
    }
}
export async function recentCollectionQuery() {
    try {
        const data = await db.task(async (t: any) => {
            console.log("recentCollectionQuery:");
            let query = "select collection.id, publishedat, updatedat, createdat, collectionname as name, description from collection WHERE publishedat IS NOT NULL ORDER BY updatedAt DESC LIMIT 6;";
            console.log(query);
            const collections = await Promise.all(
                await t.map(query, [], async (q: any) => {
                    query = "SELECT value, keywordkey as key FROM collectionkeyword WHERE collectionid = $1;";
                    q.keywords = await t.any(query, [ q.id ]);
                    query = "SELECT language FROM collectionlanguage WHERE collectionid = $1;";
                    const languageObjects = await t.any(query, [ q.id ]);
                    q.languages = languageObjects.map(o => o.language);
                    query = "SELECT alignmenttype, targetname, source, educationalframework, objectkey, targeturl FROM collectionalignmentobject WHERE collectionid = $1;";
                    q.alignmentObjects = await t.any(query, [ q.id ]);
                    query = "SELECT value, educationalusekey as key FROM collectioneducationaluse WHERE collectionid = $1;";
                    q.educationalUses = await t.any(query, [ q.id ]);
                    query = "SELECT educationalrole as value, educationalrolekey as key FROM collectioneducationalaudience WHERE collectionid = $1;";
                    q.educationalRoles = await t.any(query, [ q.id ]);
                    query = "SELECT value, accessibilityhazardkey as key FROM collectionaccessibilityhazard WHERE collectionid = $1;";
                    q.accessibilityHazards = await t.any(query, [ q.id ]);
                    query = "SELECT value, accessibilityfeaturekey as key FROM collectionaccessibilityfeature WHERE collectionid = $1;";
                    q.accessibilityFeatures = await t.any(query, [ q.id ]);
                    query = "SELECT value, educationallevelkey as key FROM collectioneducationallevel WHERE collectionid = $1;";
                    q.educationalLevels = await t.any(query, [ q.id ]);
                    query = "Select filepath, filekey as thumbnail from collectionthumbnail where collectionid = $1 and obsoleted = 0;";
                    let response = await t.oneOrNone(query, [q.id]);
                    q.thumbnail = undefined;
                    if (response) {
                        q.thumbnail = await aoeCollectionThumbnailDownloadUrl(response.thumbnail);
                    }
                    query = "select concat(firstname, ' ', lastname) as name from userscollection join users on usersusername = username where collectionid = $1;";
                    response = await t.any(query, [q.id]);
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
        console.log(err);
        throw new Error(err);
    }
}