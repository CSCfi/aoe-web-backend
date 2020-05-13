const connection = require("./../db");
const pgp = connection.pgp;
const db = connection.db;

export async function insertCollection(username: string) {
    try {
        const id = await db.tx(async (t: any) => {
            const queries: any = [];
            let query;
            query = "insert into collection (createdat, updatedat, createdby) values (now(),now(),$1) returning id;";
            const id = await t.oneOrNone(query, username);
            query = "INSERT INTO userscollection (usersusername, collectionid) VALUES ($1,$2) ON CONFLICT (usersusername, collectionid) DO NOTHING;";
            console.log("CollectionQueries insertCollection: " + query, [username, id.id]);
            const response = await t.none(query, [username, id.id]);
            // queries.push(response);
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
        console.log("here");
        const values: object[] = [];
        emId.map(id => values.push({collectionid : collectionId, educationalmaterialid: id}));
        console.log("here");
        const cs = new pgp.helpers.ColumnSet(["collectionid", "educationalmaterialid"], {table: "collectioneducationalmaterial"});
        console.log("here");
        const query = pgp.helpers.insert(values, cs) + " ON CONFLICT (collectionid, educationalmaterialid) DO NOTHING;";
        console.log(query);
        await db.none(query);
    }
    catch (err) {
        console.log(err);
        throw new Error(err);
    }
}