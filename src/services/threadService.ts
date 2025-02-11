import config from '@/config';
import { Request, Response } from 'express';
import path from 'path';
import { Worker, WorkerOptions } from 'worker_threads';

const selectWorkerFile = (req: Request): string => {
  // Compile the worker file with .import.js in localhost environment for Nodemon project execution.
  if (process.env.NODE_ENV === 'localhost') {
    if (req.url.includes('search')) return 'workerSearch.import.js';
    if (req.url.includes('material') || req.url.includes('download')) return 'workerActivity.import.js';
  }
  if (req.url.includes('search')) return 'workerSearch.js';
  if (req.url.includes('material') || req.url.includes('download')) return 'workerActivity.js';
  return null;
};

/**
 * Function to exclude some external requests from analytics data collection by User-Agent identifier.
 * @param {e.Request} req
 * @return {boolean}
 */
export const hasExcludedAgents = (req: Request): boolean => {
  const userAgent: string = req.headers['user-agent'] || '';
  const searchIDs: string[] = config.MESSAGE_QUEUE_OPTIONS.kafkaExcludedAgentIdentifiers;
  const regexRule = new RegExp(searchIDs.join('|'), 'i');
  return regexRule.test(userAgent);
};

/**
 * Worker creation function to execute a process in a new thread in parallel to main process.
 * Request data is enriched and sent to the message queue system for further analysis.
 * @param req express.Request
 * @param res express.Response
 */
export function runMessageQueueThread(req: Request, res?: Response): Promise<any> {
  // Interrupt analytics processing if Kafka producer is disabled or excluded clients are involved.
  if (!config.MESSAGE_QUEUE_OPTIONS.kafkaProducerEnabled || hasExcludedAgents(req)) return Promise.resolve(undefined);

  const workerData = {
    body: req.body,
    headers: req.headers,
    locals: res?.locals,
    params: req.params,
    query: req.query,
  };
  return new Promise((resolve, reject) => {
    const workerFile = selectWorkerFile(req);
    const worker = new Worker(path.resolve(__dirname, `workers/${workerFile}`), { workerData } as WorkerOptions);
    worker
      .on('message', resolve)
      .on('error', reject)
      .on('exit', (code: number) => {
        if (code !== 0) reject(new Error(`Worker thread terminated with exit code ${code}`));
      });
  });
}
