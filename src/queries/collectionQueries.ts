import { identifier, objectExpression } from "babel-types";
import { NameObject , setLanguage } from "./apiQueries";

const connection = require("./../db");
const pgp = connection.pgp;
const db = connection.db;

export async function insertCollection(username: string, nameObj: NameObject) {
    try {
        await setLanguage(nameObj);
        const id = await db.tx(async (t: any) => {
            const queries: any = [];
            let query;
            query = "insert into collection (createdat, updatedat, createdby) values (now(),now(),$1) returning id;";
            const id = await t.oneOrNone(query, username);
            query = "INSERT INTO userscollection (usersusername, collectionid) VALUES ($1,$2) ON CONFLICT (usersusername, collectionid) DO NOTHING;";
            console.log("CollectionQueries insertCollection: " + query, [username, id.id]);
            await t.none(query, [username, id.id]);
            query = "INSERT INTO collectionname (collectionname, language, collectionid) VALUES ($1,$2,$3);";
            await t.none(query, [nameObj.fi, "fi", id.id]);
            await t.none(query, [nameObj.sv, "sv", id.id]);
            await t.none(query, [nameObj.en, "en", id.id]);
            return {id};
        });
        return id.id;
    }
    catch (err) {
        console.log(err);
        throw new Error(err);
    }
}
export async function insertEducationalMaterialToCollection(collectionId: string, emId: string[]) {
    try {
        const values: object[] = [];
        emId.map(id => values.push({collectionid : collectionId, educationalmaterialid: id}));
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
export async function userCollections(username: string) {
    try {
        const data = await db.tx(async (t: any) => {
            console.log("userCollections:");
            const query = "select id, publishedat from collection join userscollection as uc on collection.id = uc.collectionid where usersusername = $1;";
            console.log(query, [username]);
            const collections = await t.map(query, [username], async (q: any) => {
                const query2 = "select collectionname, language from collectionname where collectionid = $1;";
                const response = await t.any(query2, q.id);
                q.name = response.reduce(function(map, obj) {
                    map[obj.language] = obj.collectionname;
                    return map;
                }, {});
                return q;
            }).then(t.batch);
            return {collections};
        });
        return data;
    }
    catch (err) {
        console.log(err);
        throw new Error(err);
    }
}

export async function collectionQuery(collectionId: string, username?: string) {
    try {
        const data = await db.tx(async (t: any) => {
            let query = "select id, publishedat from collection where id = $1;";
            console.log("collectionQuery username: " + username);
            console.log(query, [ collectionId ]);
            const collection = await db.oneOrNone(query, [ collectionId ]);
            if (!collection) {
                return {};
            }
            else if (!collection.publishedat) {
                if (!username) {
                    return {};
                }
                query = "Select * from userscollection where collectionid = $1 and usersusername = $2;";
                const owner = await db.oneOrNone(query, [ collectionId , username]);
                if (!owner) {
                    return {};
                }
            }
            query = "select collectionname, language from collectionname where collectionid = $1;";
            let response = await t.any(query, collection.id);
            const name = response.reduce(function(map, obj) {
                map[obj.language] = obj.collectionname;
                return map;
            }, {});
            query = "select educationalmaterialid as id from collectioneducationalmaterial where collectionid = $1;";
            response = await t.any(query, collection.id);
            const materials = response.map(function(obj) {
                return obj.id;
            });
            return {collection, name, materials};
        });
        return data;
    }
    catch (err) {
        console.log(err);
        throw new Error(err);
    }
}