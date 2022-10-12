import { winstonLogger } from '../util';
import { db } from '../resources/pg-connect';

export const getEdumaterialVersionsWithoutURN = async (limit: number): Promise<any> => {
    try {
        return await db.task(async (t: any) => {
            const query = "SELECT educationalmaterialid, publishedat " +
                "FROM educationalmaterialversion " +
                "WHERE urn IS NULL " +
                "ORDER BY educationalmaterialid " +
                "LIMIT $1";
            return await t.any(query, [limit]);
        });
    } catch (error) {
        winstonLogger.error('Request for educational material versions without PID failed: ' + error);
        throw new Error(error);
    }
}

export default {
    getEdumaterialVersionsWithoutURN,
}
