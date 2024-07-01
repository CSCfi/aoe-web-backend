import apiRoot from '@api/routes-root';
import apiV1 from '@api/routes-v1';
import apiV2 from '@api/routes-v2';
import oidc from '@resource/oidcConfig';
import { checkAuthenticated } from '@services/authService';
import { initializeH5P, userH5P } from '@services/h5pService';
import aoeScheduler from '@util/aoeScheduler';
import morganLogger from '@util/morganLogger';
import winstonLogger from '@util/winstonLogger';
import bodyParser from 'body-parser';
import compression from 'compression';
import flash from 'connect-flash';
import cors from 'cors';
import express, { NextFunction, Request, Response, Router } from 'express';
import session from 'express-session';
import { createProxyMiddleware } from 'http-proxy-middleware';
import lusca from 'lusca';
import config from './config';
import { sequelize } from './domain/aoeModels';
import { handleError } from './helpers/errorHandler';

const app = express();
app.disable('x-powered-by');

// Load API root modules
const apiRouterRoot: Router = Router();
apiRoot(apiRouterRoot);

// Load API version 1.0
const apiRouterV1: Router = Router();
apiV1(apiRouterV1);

// Load API version 2.0
const apiRouterV2: Router = Router();
apiV2(apiRouterV2);

// Process X-Forwarded-* headers behind a proxy server at localhost (127.0.0.1)
app.set('trust proxy', '127.0.0.1');

// CORS and Referer configurations for the development environments.
if (['development', 'localhost'].includes(process.env.NODE_ENV as string)) {
  app.all('/*', (req: Request, res: Response, next: NextFunction): void => {
    res.header('Referrer-Policy', 'no-referrer');
    next();
  });
  const corsOptions = {
    allowedHeaders: ['Accept', 'Authorization', 'Content-Type', 'Origin', 'Range', 'X-Requested-With'],
    credentials: true,
    methods: ['GET', 'HEAD', 'PUT', 'PATCH', 'POST', 'DELETE'],
    optionsSuccessStatus: 204,
    origin: true,
  };
  app.use(cors(corsOptions));
}

app.use(compression());
app.use(flash());
app.use(morganLogger);

// Add a development helper module (dev.ts) to the application if available.
if (process.env.NODE_ENV === 'localhost') {
  try {
    require('./dev').devHelper(app);
  } catch (error) {
    winstonLogger.debug('Development helper module (dev.ts) not available.');
  }
}

// Initialize session management and OIDC authorization
app.use(
  session({
    secret: config.SESSION_CONFIG_OPTIONS.secret as string,
    resave: config.SESSION_CONFIG_OPTIONS.resave as boolean,
    saveUninitialized: config.SESSION_CONFIG_OPTIONS.saveUninitialized as boolean,
  }),
);
oidc.sessionInit(app);
oidc.authInit(app);

// Initialize H5P editor
initializeH5P().catch((err: unknown): void => {
  winstonLogger.error('Initialization of H5P editor failed: %o', err);
});

// Statistics requests forwarded to AOE Analytics Service.
// Keep the HTTP forwarding before the body parsers to avoid request body changes the proxy cannot handle.
app.use(
  '/api/v2/statistics',
  checkAuthenticated,
  createProxyMiddleware({
    target: config.SERVER_CONFIG_OPTIONS.oaipmhAnalyticsURL,
    logLevel: 'debug',
    logProvider: () => winstonLogger,
    changeOrigin: true,
    pathRewrite: (path: string) => path.replace('/v2', ''),
  }),
);

app.use(bodyParser.json({ limit: '1mb' }));
app.use(bodyParser.urlencoded({ extended: true, limit: '1mb' }));
app.use('/favicon.ico', express.static('./views/favicon.ico'));
app.use('/', apiRouterRoot);
app.use('/api/v1/', apiRouterV1);
app.use('/api/v2/', apiRouterV2);
app.use('/h5p/content', express.static('/webdata/h5p/content'));
app.use('/h5p/core', express.static('/webdata/h5p/core'));
app.use('/h5p/editor', express.static('/webdata/h5p/editor'));
app.use('/h5p/libraries', express.static('/webdata/h5p/libraries'));

app.use(lusca.xframe('SAMEORIGIN'));
app.use(lusca.xssProtection);
app.use((err, req: Response, res: NextFunction): void => {
  handleError(err, res);
});

// Root status page with Pug template
app.set('views', './views');
app.set('view engine', 'pug');

app.set('port', 3000);

// Synchronize database with Sequelize models.
const dbInit = async (): Promise<void> => {
  await sequelize.sync({
    logging: false,
  });
};
dbInit().catch((err: unknown): void => {
  winstonLogger.error('Synchronizing database with Sequelize models failed: %o', err);
  process.exit(1);
});

// TODO: To be removed after full refactoring of aoeScheduler.ts
require('@util/aoeScheduler');

// Start scheduled maintenance processes
aoeScheduler.startScheduledCleaning();
aoeScheduler.startScheduledRegistrationForPIDs();
aoeScheduler.startScheduledSearchIndexUpdate();

export default app;
