import axios, { AxiosRequestConfig } from 'axios';
import { updateEduMaterialVersionURN } from '../queries/apiQueries';
import { getEdumaterialVersionsWithoutURN } from '../queries/pidQueries';
import { getEduMaterialVersionURL } from './urlService';
import { winstonLogger } from '../util';
import { IRegisterPID } from './dto/IRegisterPID';

/**
 * Request for PID registration using URN type.
 * @param url string Resource URL for PID registration.
 */
export const registerPID = async (url: string): Promise<any> => {
    try {
        const pidRegistrationParams: IRegisterPID = {
            url: url as string,
            pid_type: 'URN',
            persist: '0',
        };
        const requestHeaders: Record<string, string> = {
            'Content-Type': 'application/json',
            'apikey': process.env.PID_KEY as string,
        };
        const response: Record<string, unknown> = await axios.post(
            process.env.PID_SERVICE_URL as string,
            pidRegistrationParams as IRegisterPID,
            { headers: requestHeaders } as AxiosRequestConfig);
        return response.data;
    } catch (error) {
        winstonLogger.error('PID registration failed in registerPID(): ' + error);
    }
}

/**
 *
 */
export const processEntriesWithoutPID = async (): Promise<void> => {
    try {
        const limit = 5000;
        const eduMaterialVersions: { educationalmaterialid: string, publishedat: string }[] =
            await getEdumaterialVersionsWithoutURN(limit);

        let eduMaterialVersionURL: string;
        let registeredURN: string;
        for (const eduMaterialVersion of eduMaterialVersions) {
            try {
                eduMaterialVersionURL = await getEduMaterialVersionURL(eduMaterialVersion.educationalmaterialid, eduMaterialVersion.publishedat);
                registeredURN = await registerPID(eduMaterialVersionURL);
                if (typeof registeredURN === 'string' && registeredURN.length > 0) {
                    await updateEduMaterialVersionURN(eduMaterialVersion.educationalmaterialid, eduMaterialVersion.publishedat, registeredURN);
                } else {
                    throw new Error('PID registration failed for invalid URN');
                }
                winstonLogger.debug('URN registration completed: eduMaterialVersionURL=%s => registeredURN=%s', eduMaterialVersionURL, registeredURN);
            } catch (error) {
                winstonLogger.error('PID registration for an educational material version failed in processEntriesWithoutPID() ' +
                    '[educationalmaterialid=%s, eduMaterialVersionURL=%s, registeredURN=%s]: ' + error,
                    eduMaterialVersion.educationalmaterialid, eduMaterialVersionURL, registeredURN);
                break;
            }
        }
    } catch (error) {
        winstonLogger.error('PID registration for educational materials without PID failed in processEntriesWithoutPID(): ' + error);
    }
}

export default {
    processEntriesWithoutPID,
    registerPID
}