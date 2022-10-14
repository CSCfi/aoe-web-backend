import ah from '../services/authService';
import connectRedis from 'connect-redis';
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
passport.deserializeUser((userinfo: Record<string, unknown>, done) => {
    done(undefined, { user: userinfo.id });
});
Issuer.discover(process.env.PROXY_URI)
    .then((oidcIssuer: InstanceType<typeof Issuer>) => {
        const client = new oidcIssuer.Client({
            client_id: process.env.CLIENT_ID,
            client_secret: process.env.CLIENT_SECRET,
            redirect_uri: process.env.REDIRECT_URI,
            response_type: 'code',
        });
        passport.use(
            'oidc',
            new Strategy({ client }, (tokenset: any, userinfo: Record<string, unknown>, done: any) => {
                ah.InsertUserToDatabase(userinfo)
                    .then(() => {
                        const nameparsed = userinfo.given_name + ' ' + userinfo.family_name;
                        return done(undefined, { uid: userinfo.uid, name: nameparsed });
                    })
                    .catch((err: Error) => {
                        winstonLogger.error('Saving user information failed: %s', err);
                        return done('Saving user information failed', undefined);
                    });
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
    };
    custom.setHttpOptionsDefaults(httpOptions);

    app.use(passport.initialize());
    app.use(passport.session());

    // Login endpoint for the client application.
    app.get('/api/login', isLoginEnabled, passport.authenticate('oidc', {
            successRedirect: '/',
            failureRedirect: '/api/login',
            failureFlash: true,
            scope: 'openid profile offline_access',
        }),
    );

    app.get('/api/logout', (req: Request, res: Response) => {
        req.logout();
        req.session.destroy((error) => {
            winstonLogger.error('Destroying session on logout failed: %o', error);
        });
        res.status(200).json({ status: 'ok' });
    });

    // Redirect endpoint and handlers after successful or failed authorization.
    app.get('/api/secure/redirect', (req: Request, res: Response, next: NextFunction) => {
            winstonLogger.debug('Login request /secure/redirect');
            next();
        },
        passport.authenticate('oidc', {
            failureRedirect: process.env.FAILURE_REDIRECT_URI,
            failureFlash: true,
            successRedirect: process.env.SUCCESS_REDIRECT_URI,
        }),
    );
};

/**
 * Initialize session and cookie management with Redis storage.
 *
 * @param app Express
 */
export const sessionInit = (app: Express): void => {
    const RedisStore = connectRedis(session);

    const domainSelector = {
        production: 'aoe.fi',
        development: 'demo.aoe.fi',
        localhost: 'localhost',
    }
    app.use(
        session({
            genid: () => {
                return uuid(); // use UUIDs for session IDs
            },
            store: new RedisStore({ client: redisClient }),
            resave: true,
            saveUninitialized: true,
            secret: process.env.SESSION_SECRET || 'dev_secret',
            cookie: {
                domain: domainSelector[process.env.NODE_ENV],
                httpOnly: true,
                maxAge: Number(process.env.SESSION_COOKIE_MAX_AGE) || 60 * 60 * 1000,
                path: '/api',
                sameSite: 'none',
                secure: false,
            },
        }),
    );
};

export default {
    authInit,
    sessionInit
};