import winston, { format, Logform } from 'winston';
import { ConsoleTransportOptions } from 'winston/lib/winston/transports';

// Custom logging levels
const loggingLevels = {
  levels: {
    // digi: 0,
    info: 0,
    http: 1,
    error: 2,
    warn: 3,
    debug: 4,
  },
};

// Options for console logging
const logLevel: string | undefined = process.env.LOG_LEVEL;
const consoleOptions: ConsoleTransportOptions = {
  level: process.env.NODE_ENV === 'production' ? logLevel || 'error' : logLevel || 'debug',
  handleExceptions: true,
};

// Dedicated file logging and rotation for the Digivisio HTTP requests.
// const digivisioLogPath: string = process.env.DIGIVISIO_LOG_PATH as string;

// Configuration for logging format and transports
export const winstonLogger = winston.createLogger({
  exitOnError: false,
  format: format.combine(
    format.splat(), // Use also printf format with argument specifiers %d %s %o etc.
    format.timestamp({ format: 'YYYY-MM-DD HH:mm:ss' }),
    format.printf((log: Logform.TransformableInfo) => `[${log.level.toUpperCase()}] ${log.timestamp} ${log.message}`),
  ),
  levels: loggingLevels.levels,
  transports: [
    // new winston.transports.File({
    //   filename: 'digivisio/digivisio.log',
    //   handleExceptions: true,
    //   level: 'digi',
    // }),
    new winston.transports.Console(consoleOptions),
  ],
});

export default winstonLogger;
