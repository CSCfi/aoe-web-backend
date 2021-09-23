const connection = require("./../db");
const pgp = connection.pgp;
const db = connection.db;

export async function getEmptyUrns(limit: number) {
    try {
        return await db.task(async (t: any) => {
            const query = "SELECT educationalmaterialid, publishedat FROM educationalmaterialversion " +
                "WHERE urn IS NULL " +
                "ORDER BY educationalmaterialid " +
                "LIMIT $1;";
            console.log("getEmptyUrns");
            console.log(query);
            return await t.any(query, [limit]);
        });
    } catch (error) {
        throw new Error(error);
    }
}
