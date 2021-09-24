import express, {Response, Request, NextFunction} from 'express';
import compression from 'compression';
import lusca from 'lusca';
import path from 'path';
import {isLoginEnabled} from './services/routeEnablerService';
import session from 'express-session';
import passport from 'passport';
import uuid from 'uuid/v4';
import cookieParser from 'cookie-parser';
import flash from 'connect-flash';
import {ErrorHandler, handleError} from './helpers/errorHandler';
import cors from 'cors';
import * as homeController from './controllers/home';
import h5pAjaxExpressRouter from 'h5p-nodejs-library/build/src/adapters/H5PAjaxRouter/H5PAjaxExpressRouter';
import {h5pEditor} from './h5p/h5p';
import apiRouter from './routes/routes';
import ah from './services/authService';
import bodyParser from 'body-parser';
import redisClient from './resources/redis-client.module';
import connectRedis from 'connect-redis';
import openidClient, {custom, HttpOptions} from 'openid-client';

const app = express();

/**
 * OpenID Connect Session Managament
 */
const RedisStore = connectRedis(session);
const httpOptions: HttpOptions = {
    timeout: Number(process.env.HTTP_OPTIONS_TIMEOUT) || 5000,
    retry: Number(process.env.HTTP_OPTIONS_RETRY) || 2,
    // clock_tolerance: Number(process.env.HTTP_OPTIONS_CLOCK_TOLERANCE) || 5,
};
custom.setHttpOptionsDefaults(httpOptions);
const Issuer = openidClient.Issuer;
const Strategy = openidClient.Strategy;
app.set('trust proxy', 1);
app.use(
    session({
        genid: () => {
            return uuid(); // use UUIDs for session IDs
        },
        store: new RedisStore({client: redisClient}),
        resave: false,
        saveUninitialized: true,
        secret: process.env.SESSION_SECRET || 'xyz',
        cookie: {
            httpOnly: true,
            maxAge: Number(process.env.SESSION_COOKIE_MAX_AGE) || 60 * 60 * 1000,
        },
    }),
);

/**
 * OpenID Connect Authorization Management
 */
passport.serializeUser((user, done) => {
    done(undefined, user);
});
passport.deserializeUser((userinfo: any, done) => {
    done(undefined, {user: userinfo.id});
});
Issuer.discover(process.env.PROXY_URI || '')
    .then((testIssuer: InstanceType<typeof Issuer>) => {
        const client = new testIssuer.Client({
            client_id: process.env.CLIENT_ID || '',
            client_secret: process.env.CLIENT_SECRET,
            redirect_uri: process.env.REDIRECT_URI,
            response_type: 'code',
        });
        passport.use(
            'oidc',
            new Strategy({client}, (tokenset: any, userinfo: any, done: any) => {
                if (tokenset.claims().acr == process.env.SUOMIACR) {
                    ah.InsertUserToDatabase(userinfo, tokenset.claims().acr)
                        .then(() => {
                            const nameparsed = userinfo.given_name + ' ' + userinfo.family_name;
                            return done(undefined, {uid: userinfo.sub, name: nameparsed});
                        })
                        .catch((err: Error) => {
                            console.error(err);
                            return done('Login error when inserting suomi.fi information to database ', undefined);
                        });
                } else if (tokenset.claims().acr == process.env.HAKAACR) {
                    ah.InsertUserToDatabase(userinfo, tokenset.claims().acr)
                        .then(() => {
                            const nameparsed = userinfo.given_name + ' ' + userinfo.family_name;
                            return done(undefined, {uid: userinfo.eppn, name: nameparsed});
                        })
                        .catch((err: Error) => {
                            console.error(err);
                            return done('Login error', undefined);
                        });
                } else if (tokenset.claims().acr == process.env.MPASSACR) {
                    ah.InsertUserToDatabase(userinfo, tokenset.claims().acr)
                        .then(() => {
                            const nameparsed = userinfo.given_name + ' ' + userinfo.family_name;
                            return done(undefined, {uid: userinfo.mpass_uid, name: nameparsed});
                        })
                        .catch((err: Error) => {
                            console.error(err);
                            return done('Login error', undefined);
                        });
                } else {
                    console.error('Unknown authentication method: ' + tokenset.claims().acr);
                    throw new ErrorHandler(400, 'Unknown authentication method');
                }
            }),
        );
    })
    .catch((error: any) => {
        console.error(error);
    });

app.use(passport.initialize());
app.use(passport.session());
app.use(cookieParser());
app.use(compression());
app.use(flash());

app.get(
    '/login',
    isLoginEnabled,
    passport.authenticate('oidc', {
        successRedirect: '/',
        failureRedirect: '/login',
        failureFlash: true,
        scope: 'openid profile offline_access',
    }),
);

app.get(
    '/secure/redirect',
    (req: Request, res: Response, next: NextFunction) => {
        // console.log("here");
        next();
    },
    passport.authenticate('oidc', {
        // "callback": true,
        failureRedirect: process.env.FAILURE_REDIRECT_URI,
        failureFlash: true,
        successRedirect: process.env.SUCCESS_REDIRECT_URI,
    }),
);

// Handle H5P ajax request
const h5pRouteOptions = {
    handleErrors: false,
    routeGetContentFile: true,
};
app.use(
    // server is an object initialized with express()
    '/h5p', // the route under which all the Ajax calls will be registered
    h5pAjaxExpressRouter(
        h5pEditor, // an H5P.H5PEditor object
        process.env.H5P_CORE_PATH || path.resolve('h5p/core'), // the path to the h5p core files (of the player)
        process.env.H5P_EDITOR_PATH || path.resolve('h5p/editor'), // the path to the h5p core files (of the editor)
        h5pRouteOptions, // the options are optional and can be left out
        // languageOverride // (optional) can be used to override the language used by i18next http middleware
    ),
);

/**
 * CORS Configuration
 */
const corsOptions = {
    origin: ['https://demo.aoe.fi', 'https://aoe.fi', 'https://86.50.27.30:80', 'http://localhost'],
    methods: ['GET', 'HEAD', 'PUT', 'PATCH', 'POST', 'DELETE'],
    optionsSuccessStatus: 200,
};
app.use(cors(corsOptions));
app.use(bodyParser.json({limit: '1mb'}));
app.use(bodyParser.urlencoded({extended: true, limit: '1mb'}));
app.get('/', homeController.index);
app.use('/', apiRouter);
app.use(lusca.xframe('SAMEORIGIN'));
app.use(lusca.xssProtection);
app.use((err, req, res) => {
    handleError(err, res);
});

app.set('port', 3000);
app.set('views', path.join(__dirname, '../views'));
app.set('view engine', 'pug');
require('./aoeScheduler');

export default app;
