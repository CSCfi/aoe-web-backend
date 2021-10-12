import winston, { format, Logform } from 'winston';
import { ConsoleTransportOptions } from "winston/lib/winston/transports";

// Custom logging levels
const loggingLevels = {
    levels: {
        error: 0,
        warn: 1,
        info: 2,
        http: 3,
        debug: 4
    }
};

// Options for console logging
const logLevel: string | undefined = process.env.LOG_LEVEL;
const consoleOptions: ConsoleTransportOptions = {
    level: process.env.NODE_ENV === 'production' ? logLevel || 'error' : logLevel || 'debug',
    handleExceptions: true
};

// Configuration for logging format and transports
export default winston.createLogger({
    exitOnError: false,
    format: format.combine(
        format.splat(), // Use also printf format with argument specifiers %d %s %o etc.
        format.timestamp({format: 'YYYY-MM-DD HH:mm:ss'}),
        format.printf((log: Logform.TransformableInfo) => `[${log.level.toUpperCase()}] ${log.timestamp} ${log.message}`)
    ),
    levels: loggingLevels.levels,
    transports: [
        new (winston.transports.Console)(consoleOptions)
    ]
});
