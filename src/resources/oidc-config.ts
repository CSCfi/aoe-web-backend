import ah from '../services/authService';
import connectRedis from 'connect-redis';
import config from '../config';
import { CookieOptions, Express, NextFunction, Request, Response } from 'express';
import session, { Cookie } from 'express-session';
import openidClient, { custom, HttpOptions } from 'openid-client';
import passport from 'passport';
import redisClient from './redis-client';
import { isLoginEnabled } from '../services/routeEnablerService';
import { winstonLogger } from '../util/winstonLogger';
// import uuid from 'uuid/v4';

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
        ah.insertUserToDatabase(userinfo)
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
  app.get(
    '/api/login',
    isLoginEnabled,
    passport.authenticate('oidc', {
      successRedirect: '/',
      failureRedirect: '/api/login',
      failureFlash: true,
      scope: 'openid profile offline_access',
    }),
  );

  app.post('/api/logout', (req: Request, res: Response) => {
    const cookieRef: Cookie = req.session.cookie;
    const deleteCookie: CookieOptions = {
      maxAge: -1,
      signed: cookieRef.signed,
      expires: cookieRef.expires,
      httpOnly: cookieRef.httpOnly,
      path: cookieRef.path,
      domain: cookieRef.domain,
      secure: !!cookieRef.secure, // Type conflict boolean | 'auto' | undefined => boolean | undefined
      sameSite: cookieRef.sameSite,
    };
    req.logout((done) => done());
    req.session.destroy((error) => {
      winstonLogger.debug('Logout request /logout | session termination errors: %o', error);
      // res.setHeader('Cache-Control', 'no-store');
      res.clearCookie('connect.sid', deleteCookie);
      res.status(200).json({ message: 'logged out' });
      // res.redirect(['https://', config.SESSION_COOKIE_OPTIONS.domain, '/#/logout'].join(''));
    });
  });

  // Redirect endpoint and handlers after successful or failed authorization.
  app.get(
    '/api/secure/redirect',
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
  // OPTIONAL IN-MEMORY SESSION STORAGE:
  // const MemoryStore = require('memorystore')(session);
  // app.use(session({
  //     cookie: config.SESSION_COOKIE_OPTIONS, // { maxAge: 86400000 },
  //     store: new MemoryStore({
  //         checkPeriod: 86400000 // prune expired entries every 24h
  //     }),
  //     resave: config.SESSION_CONFIG_OPTIONS.resave as boolean,
  //     secret: process.env.SESSION_SECRET as string,
  //     rolling: config.SESSION_CONFIG_OPTIONS.rolling as boolean,
  //     saveUninitialized: config.SESSION_CONFIG_OPTIONS.saveUninitialized as boolean,
  //     proxy: false,
  // }))
  const RedisStore = connectRedis(session);
  app.use(
    session({
      // genid: () => {
      //     const id = uuid();
      //     winstonLogger.debug('UUID: %s', id);
      //     return id; // use UUIDs for session IDs
      // },
      store: new RedisStore({ client: redisClient }), // disableTTL: true
      resave: config.SESSION_CONFIG_OPTIONS.resave as boolean,
      rolling: config.SESSION_CONFIG_OPTIONS.rolling as boolean,
      saveUninitialized: config.SESSION_CONFIG_OPTIONS.saveUninitialized as boolean,
      secret: process.env.SESSION_SECRET as string,
      proxy: config.SESSION_CONFIG_OPTIONS.proxy,
      cookie: config.SESSION_COOKIE_OPTIONS,
    }),
  );
};

export default {
  authInit,
  sessionInit,
};
