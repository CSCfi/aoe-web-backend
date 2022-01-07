import { IncomingMessage, RequestOptions } from 'http';
import https from 'https';
import { winstonLogger } from '../util';

/**
 * HTTP(S) client to execute internal request to other service components.
 * Current implementation is for secured HTTPS requests only.
 * Request options specified and provided as an argument.
 *
 * @param options http.RequestOptions
 */
export default (options: RequestOptions): Promise<any> => {
    return new Promise((resolve, reject) => {
        let request = https.request(options, (response: IncomingMessage) => {
            let output = '';
            response
                .setEncoding('utf8')
                .on('data', (chunk) => {
                    output += chunk;
                })
                .on('end', () => {
                    try {
                        let obj;
                        if (response.headers['content-type'].includes('json')) {
                            obj = JSON.parse(output);
                        } else {
                            obj = output;
                        }
                        resolve({
                            statusCode: response.statusCode,
                            data: obj
                        });
                    } catch (error) {
                        reject(error);
                    }
                })
                .on('error', () => {
                    response.destroy();
                });
        });
        request
            .on('error', (error: Error) => {
                request.abort();
                winstonLogger.error('Request handling failed in HTTPS client: ' + error);
                reject(error);
            })
            .on('timeout', () => {
                request.abort();
                winstonLogger.debug('Request timeout in HTTPS client: %s ms', options.timeout);
            })
            .end();
    });
}
