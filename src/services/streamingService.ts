import config from '../configuration';
import { httpsClient } from '../resources';
import { winstonLogger } from '../util/winstonLogger';

/**
 * Criteria check for Streaming service redirect.
 * Expect minimum file size, allowed mime types and the streaming service to be operable.
 * @param {{originalfilename: string, filesize: number, mimetype: string}} fileDetails
 * @param {string} fileStorageId
 * @return {Promise<boolean>}
 */
export const requestRedirected = async (
  fileDetails: { originalfilename: string; filesize: number; mimetype: string },
  fileStorageId: string,
): Promise<boolean> => {
  const criteriaFulfilled: boolean =
    fileDetails.filesize >= config.STREAM_REDIRECT_CRITERIA.minFileSize &&
    config.STREAM_REDIRECT_CRITERIA.mimeTypeArr.indexOf(fileDetails.mimetype) > -1;
  const streamingOperable: boolean = await streamingStatusCheck(fileStorageId);
  return criteriaFulfilled && streamingOperable;
};

/**
 * Streaming service status check request to redirect downloads only to an operable service.
 * Expect fast success response in 1 second or reject the redirect.
 * @param {string} fileStorageId
 * @return {Promise<boolean>} Streaming service operable: true | false
 */
export const streamingStatusCheck = (fileStorageId: string): Promise<boolean> => {
  return httpsClient({
    headers: {
      'Cache-Control': 'no-cache',
    },
    host: config.STREAM_STATUS_REQUEST.host as string,
    method: 'HEAD',
    path: (config.STREAM_STATUS_REQUEST.path as string) + fileStorageId,
    timeout: 1000,
  }).then(
    ({ statusCode }) => {
      winstonLogger.debug('Streaming service status: %s', statusCode);
      return statusCode === 200;
    },
    (error) => {
      winstonLogger.debug('Streaming service status check not passed: ' + error);
      return false;
    },
  );
};

export default {
  requestRedirected,
  streamingStatusCheck,
};
