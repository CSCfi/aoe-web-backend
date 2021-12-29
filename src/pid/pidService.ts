import axios from "axios";
import { getEmptyUrns } from "./../queries/pidQueries";
import { insertUrn } from "./../queries/apiQueries";
import { aoeMaterialVersionUrl } from "./../services/urlService";
import { winstonLogger } from '../util';
export interface PidData {
    "URL": string;
    "type": string;
    "persist": string;
}
export interface PidHeader {
    "Content-Type": string;
    "apikey": string;
}

export const pidHeader: PidHeader = {"Content-Type": "application/json", "apikey": process.env.PID_KEY};

// axios.interceptors.request.use(request => {
//     winstonLogger.debug("Starting Request", JSON.stringify(request, undefined, 2));
//     return request;
//   });
export async function getPid(url: string) {
    try {
        // const config: AxiosRequestConfig
        const data: PidData = {"URL": url, "type": "URN", "persist": "1"};
        const response = await axios.post(process.env.PID_SERVICE_URL, data, {"headers": pidHeader});
        return response.data;
    }
    catch (error) {
        winstonLogger.error(error);
    }
}

export async function getEmPids() {
    try {
        let offset = 0;
        const limit = 5000;
        const data = await getEmptyUrns(limit);
        winstonLogger.debug("getEmPids " + limit + " ######################################");
        let errorCount = 0;
        for (const element of data) {
            try {
                const aoeurl = await aoeMaterialVersionUrl(element.educationalmaterialid, element.publishedat);
                winstonLogger.debug(aoeurl);
                const pidurn = await getPid(aoeurl);
                await insertUrn(element.educationalmaterialid, element.publishedat, pidurn);
            }
            catch (error) {
                winstonLogger.debug("Error getting urn " + element.educationalmaterialid, element.publishedat);
                winstonLogger.error(error);
                errorCount = errorCount + 1;
            }
            if (errorCount > 10) {
                break;
            }
        }
        offset = offset + limit;
    }
    catch (error) {
        winstonLogger.error(error);
    }
}
