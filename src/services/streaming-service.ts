import env from '../configuration/environments';
import httpsClient from '../resources/https-client';
import { winstonLogger } from '../util';

/**
 * Criteria check for Streaming service redirect.
 * Expect minimum file size, allowed mime types and the streaming service to be operable.
 *
 * @param fileDetails '{ originalfilename: string, filesize: number, mimetype: string }'
 */
export const requestRedirected = async (fileDetails: { originalfilename: string, filesize: number, mimetype: string }): Promise<boolean> => {
    const criteriaFulfilled: boolean = fileDetails.filesize >= env.STREAM_REDIRECT_CRITERIA.minFileSize &&
        env.STREAM_REDIRECT_CRITERIA.mimeTypeArr.indexOf(fileDetails.mimetype) > -1;
    const streamingOperable: boolean = await streamingStatusCheck();
    return criteriaFulfilled && streamingOperable;
};

/**
 * Streaming service status check request to redirect downloads only to an operable service.
 * Expect fast success response in 1 second or reject the redirect.
 *
 * @return Promise<boolean> Streaming service operable: true | false
 */
export const streamingStatusCheck = (): Promise<boolean> => {
    return httpsClient({
        headers: {
            'cache-control': 'no-cache'
        },
        host: process.env.STREAM_STATUS_HOST as string,
        method: 'GET',
        path: process.env.STREAM_STATUS_PATH as string,
        timeout: 1000
    }).then(({ statusCode, data }) => {
        winstonLogger.debug('Streaming status: %s %s', statusCode, JSON.stringify(data));
        return statusCode === 200 && data.operable;
    }, (error) => {
        winstonLogger.debug('Streaming status check not passed: ' + error);
        return false;
    });
}

export default {
    requestRedirected,
    streamingStatusCheck
}
