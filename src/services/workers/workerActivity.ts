import config from '../../configuration';
import { parentPort, workerData } from 'worker_threads';
import { winstonLogger } from '../../util/winstonLogger';
import { kafkaProducer } from '../../resources/kafka-client';
import { TypeMaterialActivity } from '../dto/IMessageMaterialActivity';
import moment from 'moment';
import { createHash } from 'crypto';

const message: TypeMaterialActivity = {
    sessionId: createHash('md5').update(workerData.headers['cookie']).digest('hex') as string,
    timestamp: moment.utc().toISOString() as string,
    eduMaterialId: workerData.params.edumaterialid,
    interaction: workerData.query.interaction || 'view',
    metadata: {
        created: workerData.locals.createdAt,
        updated: workerData.locals.updatedAt,
        organizations: workerData.locals.author?.filter(obj => obj.organizationkey).map(obj => obj.organizationkey),
        educationalLevels: workerData.locals.educationalLevels?.map(obj => obj.educationallevelkey),
        educationalSubjects: workerData.locals.educationalAlignment?.map(obj => obj.objectkey),
    }
}

const produceKafkaMessage = async (): Promise<void> => {
    await kafkaProducer.connect();
    await kafkaProducer.send({
        topic: config.MESSAGE_QUEUE_OPTIONS.topicMaterialActivity,
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
