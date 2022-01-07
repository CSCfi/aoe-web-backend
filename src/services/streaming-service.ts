import env from '../configuration/environments';
import httpsClient from '../resources/https-client';
import { winstonLogger } from '../util';

/**
 * Criteria check for Streaming service redirect.
 * Expect minimum file size, allowed mime types and the streaming service to be operable.
 *
 * @param fileDetails '{ originalfilename: string, filesize: number, mimetype: string }'
 * @param fileStorageId File name in cloud object storage
 */
export const requestRedirected = async (fileDetails: { originalfilename: string, filesize: number, mimetype: string },
                                        fileStorageId: string): Promise<boolean> => {
    const criteriaFulfilled: boolean = fileDetails.filesize >= env.STREAM_REDIRECT_CRITERIA.minFileSize &&
        env.STREAM_REDIRECT_CRITERIA.mimeTypeArr.indexOf(fileDetails.mimetype) > -1;
    const streamingOperable: boolean = await streamingStatusCheck(fileStorageId);
    return criteriaFulfilled && streamingOperable;
};

/**
 * Streaming service status check request to redirect downloads only to an operable service.
 * Expect fast success response in 1 second or reject the redirect.
 *
 * @return Promise<boolean> Streaming service operable: true | false
 */
export const streamingStatusCheck = (fileStorageId: string): Promise<boolean> => {
    return httpsClient({
        headers: {
            'Cache-Control': 'no-cache'
        },
        host: env.STREAM_STATUS_REQUEST.host as string,
        method: 'HEAD',
        path: env.STREAM_STATUS_REQUEST.path as string + fileStorageId,
        timeout: 1000
    }).then(({ statusCode }) => {
        winstonLogger.debug('Streaming service status: %s', statusCode);
        return statusCode === 200;
    }, (error) => {
        winstonLogger.debug('Streaming service status check not passed: ' + error);
        return false;
    });
}

export default {
    requestRedirected,
    streamingStatusCheck
}
