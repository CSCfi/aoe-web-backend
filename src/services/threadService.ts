import { Worker, WorkerOptions } from 'worker_threads';
import path from 'path';
import { Request, Response } from 'express';
import config from '../configuration';

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
 * Worker creation function to execute a process in a new thread in parallel to main process.
 * Request data is enriched and sent to the message queue system for further analysis.
 *
 * @param req express.Request
 * @param res express.Response
 */
export function runMessageQueueThread(req: Request, res?: Response): Promise<any> {
  // Interrupt analytics post processing if Kafka producer disabled in environment variables.
  if (!config.MESSAGE_QUEUE_OPTIONS.kafkaProducerEnabled) return Promise.resolve(undefined);

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
