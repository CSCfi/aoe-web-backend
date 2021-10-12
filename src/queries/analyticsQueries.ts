import connection from "../resources/pg-config.module";

const pgp = connection.pgp;
const db = connection.db;

export async function updateViewCounter(id: string) {
    try {
        await db.tx(async (t: any) => {
            const query = "update educationalmaterial set viewcounter = viewcounter + 1, counterupdatedat = now() where id = $1;";
            await t.none(query, [id]);
        });
    }
    catch (error) {
        throw new Error(error);
    }
}

export async function updateDownloadCounter(id: string) {
    try {
        await db.tx(async (t: any) => {
            const query = "update educationalmaterial set downloadcounter = downloadcounter + 1, counterupdatedat = now() where id = $1;";
            await t.none(query, [id]);
        });
    }
    catch (error) {
        throw new Error(error);
    }
}

export const getPopularityQuery = "select a/NULLIF(b,0) as popularity from" +
                            "(select" +
                            "(select (viewcounter + downloadcounter + (select count(*) from rating where id = $1)) " +
                            "from educationalmaterial where id = $1) as a, " +
                            "(select (SELECT EXTRACT(DAY FROM (select sum(now() - publishedat) from educationalmaterial where id = $1))) as b))" +
                            "as c;";
export async function getPopularity(id: string) {
    try {
        const response = await db.task(async (t: any) => {
            return await t.oneOrNone(getPopularityQuery, [id]);
        });
        return response.popularity;
    }
    catch (error) {
        throw new Error(error);
    }
}
