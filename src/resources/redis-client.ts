import redis, { RedisClient } from 'redis';
import { winstonLogger } from '../util';

const redisHost: string = process.env.REDIS_HOST || '';
const redisPort: number = Number(process.env.REDIS_PORT) || 0;
const redisPass: string = process.env.REDIS_PASS || '';

/**
 * Redis Client with Custom Properties
 */
const redisClient: RedisClient = redis.createClient({
    host: redisHost,
    port: redisPort,
    password: redisPass,
    family: '4', // IPv4
});

/**
 * Redis Connection Event Handlers
 */
redisClient.on('connection', () => {
    winstonLogger.debug('REDIS [redis://' + redisHost + ':' + redisPort + '] Connecting...');
});
redisClient.on('ready', () => {
    winstonLogger.debug('REDIS [redis://' + redisHost + ':' + redisPort + '] Connection is operable');
});
redisClient.on('reconnecting', () => {
    winstonLogger.debug('REDIS [redis://' + redisHost + ':' + redisPort + '] Reconnecting...');
});
redisClient.on('error', (error: Error) => {
    winstonLogger.error('REDIS [redis://' + redisHost + ':' + redisPort + '] Error: ' + error);
});

export default function getRedisClient(): RedisClient {
    return redisClient;
}
