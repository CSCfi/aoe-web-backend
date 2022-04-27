import dotenv from 'dotenv';

// Load the environment variables before anything else.
dotenv.config();

import app from './app';
import consoleStamp from 'console-stamp';
import errorHandler from 'errorhandler';
import fs from 'fs';
import https from 'https';
import { Server, Socket } from 'net';
import { winstonLogger } from './util';

// Add timestamp to console logging.
consoleStamp(console, {
    format: ':date(yyyy-mm-dd HH:MM:ss)',
});

app.use(errorHandler());

// Start HTTP or HTTPS server depending on NODE_ENV variable ('localhost' | 'development' | 'production').
let server: Server;
if (process.env.NODE_ENV === 'localhost') {
    const options = {
        key: fs.readFileSync('./cert/cert.key') as Buffer,
        cert: fs.readFileSync('./cert/cert.crt') as Buffer,
    };
    server = https.createServer(options, app).listen(process.env.PORT || 3000, () => {
        winstonLogger.info('App is running at https://localhost:%d in %s mode', app.get('port'), app.get('env'));
    });
} else {
    server = app.listen(process.env.PORT || 3000, () => {
        winstonLogger.info('App is running at http://localhost:%d in %s mode', app.get('port'), app.get('env'));
    });
}

// Socket event handlers for the debugging purposes.
server.on('connection', (socket: Socket) => {
    socket.setTimeout(600 * 60 * 1000);
    // winstonLogger.debug('SOCKET OPENED: ' + JSON.stringify(socket.address()));
    // socket.on('end', () => console.log('SOCKET END: other end of the socket sends a FIN packet'));
    socket.on('timeout', () => {
        // winstonLogger.debug("SOCKET TIMEOUT");
        // socket.destroy();
        socket.end();
    });
    socket.on('error', () => {
        // winstonLogger.error('SOCKET ERROR: %s', JSON.stringify(error));
        // socket.destroy();
        socket.end();
    });
    // socket.on('close', (isError: boolean) => {
    //     winstonLogger.debug('SOCKET CLOSED: ' + JSON.stringify({ isError: isError }));
    // });
});

export default server;
