import config from '../../configuration';
import { parentPort, workerData } from 'worker_threads';
import { winstonLogger } from '../../util/winstonLogger';
import { kafkaProducer } from '../../resources/kafka-client';
import { TypeSearchRequest } from '../dto/IMessageSearchRequest';
import { createHash } from 'crypto';
import moment from 'moment';

const message: TypeSearchRequest = {
    sessionId: createHash('md5').update(workerData.req.headers['cookie']).digest('hex') as string,
    timestamp: moment.utc().toISOString() as string,
    keywords: workerData.req.body.keywords,
    filters: workerData.req.body.filters,
}

const produceKafkaMessage = async (): Promise<void> => {
    await kafkaProducer.connect();
    await kafkaProducer.send({
        topic: config.MESSAGE_QUEUE_OPTIONS.topicSearchRequests,
        messages: [
            {
                value: JSON.stringify(message),
            },
        ],
    });
    await kafkaProducer.disconnect();
}

produceKafkaMessage()
    .then(() => parentPort.postMessage(message))
    .catch(error => winstonLogger.error('Message producer failed in workerSearch.ts: %o', error));
