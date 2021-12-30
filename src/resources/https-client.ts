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
                        let obj = JSON.parse(output);
                        resolve({
                            statusCode: response.statusCode,
                            data: obj
                        });
                    } catch (error) {
                        winstonLogger.error('Response failed in HTTPS client: ' + error);
                        reject(error);
                    }
                });
        });
        request.on('error', (error: Error) => {
            winstonLogger.error('Request failed in HTTPS client: ' + error);
            reject(error);
        });
        request.end();
    });
}
