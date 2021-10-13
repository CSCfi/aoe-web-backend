import connection from "../resources/pg-config.module";
import { IDatabase } from 'pg-promise';

const db: IDatabase<any> = connection.db;

export async function updateViewCounter(id: string): Promise<void> {
    try {
        await db.tx(async (t: any) => {
            const query =
                "UPDATE educationalmaterial " +
                "SET viewcounter = viewcounter + 1, counterupdatedat = NOW() " +
                "WHERE id = $1";
            await t.none(query, [id]);
        });
    } catch (error) {
        throw new Error(error);
    }
}

export async function updateDownloadCounter(educationalMaterialId: number): Promise<void> {
    try {
        await db.tx(async (t: any) => {
            const query =
                "UPDATE educationalmaterial " +
                "SET downloadcounter = downloadcounter + 1, counterupdatedat = NOW() " +
                "WHERE id = $1";
            await t.none(query, [educationalMaterialId]);
        });
    } catch (error) {
        throw new Error(error);
    }
}

export const getPopularityQuery =
    "SELECT a/NULLIF(b,0) AS popularity FROM " +
    "(SELECT (SELECT (viewcounter + downloadcounter + (SELECT COUNT(*) FROM rating WHERE id = $1)) " +
    "FROM educationalmaterial WHERE id = $1) AS a, " +
    "(SELECT (SELECT EXTRACT(DAY FROM (SELECT SUM(NOW() - publishedat) FROM educationalmaterial WHERE id = $1))) AS b)) " +
    "AS c";
export async function getPopularity(id: string): Promise<any> {
    try {
        const response = await db.task(async (t: any) => {
            return await t.oneOrNone(getPopularityQuery, [id]);
        });
        return response.popularity;
    } catch (error) {
        throw new Error(error);
    }
}
