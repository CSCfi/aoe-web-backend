import redis, { RedisClient } from 'redis';

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
    console.log('REDIS [redis://' + redisHost + ':' + redisPort + '] Connecting...');
});
redisClient.on('ready', () => {
    console.log('REDIS [redis://' + redisHost + ':' + redisPort + '] Connection is operable');
});
redisClient.on('reconnecting', () => {
    console.log('REDIS [redis://' + redisHost + ':' + redisPort + '] Reconnecting...');
});
redisClient.on('error', (error: Error) => {
    console.error('REDIS [redis://' + redisHost + ':' + redisPort + '] Error: ' + error);
});

export default redisClient;
