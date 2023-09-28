import config from '../config';
import { Kafka, Partitioners } from 'kafkajs';

const kafka = new Kafka({
  clientId: config.MESSAGE_QUEUE_OPTIONS.clientId as string,
  brokers: config.MESSAGE_QUEUE_OPTIONS.brokerServers.split(',') as string[],
});

export const kafkaProducer = kafka.producer({
  allowAutoTopicCreation: true,
  createPartitioner: Partitioners.DefaultPartitioner,
  transactionTimeout: 60000,
});

export default {
  kafkaProducer,
};
