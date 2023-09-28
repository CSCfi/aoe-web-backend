import AWS, { S3 } from 'aws-sdk';
import { ServiceConfigurationOptions } from 'aws-sdk/lib/service';
import config from '../config';

/**
 * AWS S3 cloud storage configuration.
 * @type {{endpoint: string, credentials: {accessKeyId: string, secretAccessKey: string}, region: string}}
 */
const configS3: ServiceConfigurationOptions = {
  credentials: {
    accessKeyId: config.CLOUD_STORAGE_CONFIG.accessKey,
    secretAccessKey: config.CLOUD_STORAGE_CONFIG.accessSecret,
  },
  endpoint: config.CLOUD_STORAGE_CONFIG.apiURL,
  region: config.CLOUD_STORAGE_CONFIG.region,
};
AWS.config.update(configS3);
export const s3: S3 = new AWS.S3();

export default {
  s3,
};
