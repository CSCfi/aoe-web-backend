import { IncomingMessage, RequestOptions } from 'http';
import https from 'https';
import { winstonLogger } from '../util';

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
