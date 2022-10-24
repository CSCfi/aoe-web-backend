import ah from '../services/authService';
import connectRedis from 'connect-redis';
import config from '../configuration';
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
        const deleteCookie = config.SESSION_COOKIE_OPTIONS;
        deleteCookie.maxAge = 0;
        req.logout();
        req.session.destroy((error) => {
            winstonLogger.debug('Logout request /logout | session termination errors: %o', error);
            res.clearCookie('connect.sid', deleteCookie);
            res.redirect('/#/logout');
        });
    });

    // Redirect endpoint and handlers after successful or failed authorization.
    app.get('/api/secure/redirect', (req: Request, res: Response, next: NextFunction) => {
            winstonLogger.debug('Login redirect /secure/redirect | URI: %s', process.env.SUCCESS_REDIRECT_URI);
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

    app.use(
        session({
            genid: () => {
                return uuid(); // use UUIDs for session IDs
            },
            store: new RedisStore({ client: redisClient }),
            resave: false,
            saveUninitialized: true,
            secret: process.env.SESSION_SECRET || 'secret',
            proxy: true,
            cookie: config.SESSION_COOKIE_OPTIONS,
        }),
    );
};

export default {
    authInit,
    sessionInit
};