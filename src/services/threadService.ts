import { createHash } from 'crypto';
import moment from 'moment';
import { Worker, WorkerOptions } from 'worker_threads';
import path from 'path';
import { SearchOptionsType } from './dto/ISearchOptions';
import { Request } from 'express';
import { SearchMessageType } from './dto/ISearchMessage';

// Import the worker file in .ts format in localhost environment for nodemon live rebuild.
const workerFile = process.env.NODE_ENV === 'localhost' ? 'workerSearch.import.js' : 'workerSearch.js';

const md5 = (content: string) => {
    return createHash('md5').update(content).digest('hex');
}

/**
 * Worker creation function to execute a process in a new thread in parallel to main process.
 *
 * Request data is enriched and sent to the message queue system for further analysis.
 *
 * @param req express.Request
 */
export function runMessageQueueThread(req: Request): Promise<any> {
    const workerData: SearchMessageType = {
        sessionId: md5(req.headers.cookie) as string,
        timestamp: moment.utc().toISOString() as string,
        ...req.body as SearchOptionsType,
    }
    return new Promise((resolve, reject) => {
        const worker = new Worker(
            path.resolve(__dirname, `workers/${workerFile}`),
            { workerData } as WorkerOptions,
        );
        worker
            .on('message', resolve)
            .on('error', reject)
            .on('exit', (code: number) => {
                if (code !== 0) reject(new Error(`Worker thread terminated with exit code ${code}`));
            });
    });
}
