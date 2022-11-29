import { createHash } from 'crypto';
import moment from 'moment';
import { Worker, WorkerOptions } from 'worker_threads';
import path from 'path';
import { Request, Response } from 'express';
import { TypeSearchOptions, TypeSearchRequest } from './dto/IMessageSearchRequest';
import { TypeActivityMetadata, TypeMaterialActivity } from './dto/IMessageMaterialActivity';

// Session ID anonymized and shortened with MD5 hash algorithm.
const md5 = (content: string) => {
    return createHash('md5').update(content).digest('hex');
};

// Extend worker data with request specific parameters related to the messqge queue target topic.
const extendWorkerDataWithTopicDetails = (req: Request, res?: Response): TypeActivityMetadata | TypeSearchOptions => {
    if (req.url.includes('search')) return {
        keywords: req.body.keywords,
        filters: req.body.filters,
    } as TypeSearchOptions;

    if (req.url.includes('material') && res) return {
        eduMaterialId: req.params.edumaterialid,
        interaction: req.query.interaction || 'view',
        metadata: {
            created: res.locals.createdAt,
            updated: res.locals.updatedAt,
            organizations: res.locals.author?.filter(obj => obj.organizationkey).map(obj => obj.organizationkey),
            educationalLevels: res.locals.educationalLevels?.map(obj => obj.educationallevelkey),
            educationalSubjects: res.locals.educationalAlignment?.map(obj => obj.objectkey),
        }
    } as TypeActivityMetadata;
};

const selectWorkerFile = (req: Request): string => {

    // Compile the worker file with .import.js in localhost environment for Nodemon project execution.
    if (process.env.NODE_ENV === 'localhost' && req.url.includes('search')) return 'workerSearch.import.js';
    if (process.env.NODE_ENV === 'localhost' && req.url.includes('material')) return 'workerActivity.import.js';
    if (req.url.includes('search')) return 'workerSearch.js';
    if (req.url.includes('material')) return 'workerActivity.js';
    return null;
}

/**
 * Worker creation function to execute a process in a new thread in parallel to main process.
 * Request data is enriched and sent to the message queue system for further analysis.
 *
 * @param req express.Request
 * @param res express.Response
 */
export function runMessageQueueThread(req: Request, res?: Response): Promise<any> {
    const workerData: TypeMaterialActivity | TypeSearchRequest = {
        sessionId: md5(req.headers['cookie']) as string,
        timestamp: moment.utc().toISOString() as string,
        ...extendWorkerDataWithTopicDetails(req, res) as TypeActivityMetadata | TypeSearchOptions,
    };
    return new Promise((resolve, reject) => {
        const workerFile = selectWorkerFile(req);
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
