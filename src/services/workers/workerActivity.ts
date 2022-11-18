import config from '../../configuration';
import { parentPort, workerData } from 'worker_threads';
import { winstonLogger } from '../../util/winstonLogger';
import { kafkaProducer } from '../../resources/kafka-client';

const produceKafkaMessage = async (): Promise<void> => {
    await kafkaProducer.connect();
    await kafkaProducer.send({
        topic: config.MESSAGE_QUEUE_OPTIONS.topicMaterialActivity,
        messages: [
            {
                value: JSON.stringify(workerData),
            },
        ],
    });
    await kafkaProducer.disconnect();
}

produceKafkaMessage()
    .then(() => parentPort.postMessage(workerData))
    .catch(error => winstonLogger.error('Message producer failed in workerSearch.ts: %o', error));
