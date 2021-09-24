import promise from 'bluebird';
import moment from 'moment';
import pgPromise, {IConnected, IDatabase, IEventContext, IInitOptions, IMain} from 'pg-promise';
import {IClient} from 'pg-promise/typescript/pg-subset';

const PG_HOST: string = process.env.PG_HOST || '';
const PG_PORT: string = process.env.PG_PORT || '';
const PG_USER: string = process.env.PG_USER || '';
const PG_PASS: string = process.env.PG_PASS || '';
const PG_DATA: string = process.env.PG_DATA || '';

const PG_URL_FULL: string = 'postgres://' + PG_USER + ':' + PG_PASS + '@' + PG_HOST + ':' + PG_PORT + '/' + PG_DATA;
const PG_URL_HOST: string = 'postgres://' + PG_HOST + ':' + PG_PORT;

// Options and error handlers for pg-promise.
const initOptions: IInitOptions = {
    error: (error: Error, e: IEventContext<IClient>) => {
        if (e.cn) {
            console.error('PG [' + PG_URL_HOST + '] Connection Error:', e.cn);
            console.error('ERROR:', error.message);
        }
    },
    promiseLib: promise,
};

// Initialize pg-promise with options.
const pgp: IMain = pgPromise(initOptions);

// Converter for TYPE_TIMESTAMP
const TYPE_TIMESTAMP = 1114;
pgp.pg.types.setTypeParser(TYPE_TIMESTAMP, (str: string) => moment.utc(str).toISOString());

// Initialize DB connection
const db: IDatabase<any> = pgp(PG_URL_FULL);

// Test DB connection
db.connect()
    .then((obj: IConnected<any, IClient>) => {
        console.log('PG [' + PG_URL_HOST + '] Connection is operable');
        obj.done();
    })
    .catch((error: Error) => {
        console.error('PG [' + PG_URL_HOST + '] Connection Test Error:', error);
    });

export default {
    pgp,
    db,
};
