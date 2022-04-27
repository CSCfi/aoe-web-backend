import ah from '../services/authService';
import connectRedis from 'connect-redis';
import { ErrorHandler } from '../helpers/errorHandler';
import { Express, NextFunction, Request, Response } from 'express';
import session from 'express-session';
import openidClient, { custom, HttpOptions } from 'openid-client';
import passport from 'passport';
import redisClient from './redis-client';
import { isLoginEnabled } from '../services/routeEnablerService';
import { winstonLogger } from '../util';
import uuid from 'uuid/v4';

const Issuer = openidClient.Issuer;
const Strategy = openidClient.Strategy;

/**
 * Configuration for OpenID Connect Authorization Management
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
                            winstonLogger.error(err);
                            return done('Login error when inserting suomi.fi information to database ', undefined);
                        });
                } else if (tokenset.claims().acr == process.env.HAKAACR) {
                    ah.InsertUserToDatabase(userinfo, tokenset.claims().acr)
                        .then(() => {
                            const nameparsed = userinfo.given_name + ' ' + userinfo.family_name;
                            return done(undefined, {uid: userinfo.eppn, name: nameparsed});
                        })
                        .catch((err: Error) => {
                            winstonLogger.error(err);
                            return done('Login error', undefined);
                        });
                } else if (tokenset.claims().acr == process.env.MPASSACR) {
                    ah.InsertUserToDatabase(userinfo, tokenset.claims().acr)
                        .then(() => {
                            const nameparsed = userinfo.given_name + ' ' + userinfo.family_name;
                            return done(undefined, {uid: userinfo.mpass_uid, name: nameparsed});
                        })
                        .catch((err: Error) => {
                            winstonLogger.error(err);
                            return done('Login error', undefined);
                        });
                } else {
                    winstonLogger.error('Unknown authentication method: ' + tokenset.claims().acr);
                    throw new ErrorHandler(400, 'Unknown authentication method');
                }
            }),
        );
    })
    .catch((error: any) => {
        winstonLogger.error(error);
    });

/**
 * Initialize OpenID Connect authorization and attach to Express application.
 * @param app Express
 */
export const authInit = (app: Express): void => {
    const httpOptions: HttpOptions = {
        timeout: Number(process.env.HTTP_OPTIONS_TIMEOUT) || 5000,
        retry: Number(process.env.HTTP_OPTIONS_RETRY) || 2,
        // clock_tolerance: Number(process.env.HTTP_OPTIONS_CLOCK_TOLERANCE) || 5,
    }
    custom.setHttpOptionsDefaults(httpOptions);
    app.use(passport.initialize());
    app.use(passport.session());

    // Login endpoint for the client application.
    app.get('/login', isLoginEnabled, passport.authenticate('oidc', {
            successRedirect: '/',
            failureRedirect: '/login',
            failureFlash: true,
            scope: 'openid profile offline_access',
        }),
    );

    // Redirect endpoint and handlers after successful or failed authorization.
    app.get('/secure/redirect', (req: Request, res: Response, next: NextFunction) => {
            next();
        },
        passport.authenticate('oidc', {
            failureRedirect: process.env.FAILURE_REDIRECT_URI,
            failureFlash: true,
            successRedirect: process.env.SUCCESS_REDIRECT_URI,
        }),
    );
}

/**
 * Initialize session management and attach to Express application.
 * @param app Express
 */
export const sessionInit = (app: Express): void => {
    const RedisStore = connectRedis(session);

    app.use(
        session({
            genid: () => {
                return uuid(); // use UUIDs for session IDs
            },
            store: new RedisStore({client: redisClient}),
            resave: false,
            saveUninitialized: true,
            secret: process.env.SESSION_SECRET || 'dev_secret',
            cookie: {
                httpOnly: true,
                maxAge: Number(process.env.SESSION_COOKIE_MAX_AGE) || 60 * 60 * 1000,
            },
        }),
    );
}

export default {
    authInit,
    sessionInit
}