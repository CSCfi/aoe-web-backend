import dotenv from 'dotenv';
dotenv.config();

import consoleStamp from 'console-stamp';
import errorHandler from 'errorhandler';
import app from './app';
import { winstonLogger } from './util';

/**
 * Add timestamp to console logging.
 */
consoleStamp(console, {
    format: ':date(yyyy-mm-dd HH:MM:ss)',
});

/**
 * Error Handler. Provides full stack - remove for production
 */
app.use(errorHandler());

/**
 * Start Express server.
 */
const server = app.listen(process.env.PORT || 3000, () => {
    winstonLogger.debug('App is running at http://localhost:%d in %s mode', app.get('port'), app.get('env'));
});

/**
 * Socket timeout and event handler logging (disabled)
 */
server.on('connection', (socket) => {
    socket.setTimeout(600 * 60 * 1000);
    // winstonLogger.debug("SOCKET OPENED" + JSON.stringify(socket.address()));
    // socket.on("end", function () {
    //     winstonLogger.debug("SOCKET END: other end of the socket sends a FIN packet");
    // });
    // socket.on("timeout", function () {
    //     winstonLogger.debug("SOCKET TIMEOUT");
    // });
    // socket.on("error", function (error) {
    //     winstonLogger.debug("SOCKET ERROR: " + JSON.stringify(error));
    // });
    // socket.on("close", function (had_error) {
    //     winstonLogger.debug("SOCKET CLOSED. IT WAS ERROR: " + had_error);
    // });
});

export default server;
