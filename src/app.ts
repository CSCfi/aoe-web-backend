import bodyParser from 'body-parser';
import apiRoot from './api/routes-root';
import apiV1 from './api/routes-v1';
import apiV2 from './api/routes-v2';
import express, { Request, Router } from 'express';
import compression from 'compression';
import lusca from 'lusca';
import path from 'path';
import flash from 'connect-flash';
import { handleError } from './helpers/errorHandler';
import cors from 'cors';
import h5pAjaxExpressRouter from 'h5p-nodejs-library/build/src/adapters/H5PAjaxRouter/H5PAjaxExpressRouter';
import { h5pEditor } from './h5p/h5p';
import { oidc } from './resources';
import { aoeScheduler, morganLogger } from './util';
import { winstonLogger } from './util/winstonLogger';
import { createProxyMiddleware } from 'http-proxy-middleware';
import config from './configuration';

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

/**
 * CORS Configuration
 */
const corsOptions = {
    allowedHeaders: ['Accept', 'Authorization', 'Content-Type', 'Origin', 'Range', 'X-Requested-With'],
    credentials: true,
    methods: ['GET', 'HEAD', 'PUT', 'PATCH', 'POST', 'DELETE'],
    optionsSuccessStatus: 204,
    origin: ['https://demo.aoe.fi', 'https://aoe.fi', 'https://86.50.27.30:80', 'http://localhost:4200'],
};
app.use(cors(corsOptions));

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
oidc.sessionInit(app);
oidc.authInit(app);

// Handle H5P Ajax requests
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

// Statistics requests forwarded to AOE Analytics Service.
app.use('/api/v2/statistics', createProxyMiddleware({
    target: config.SERVER_CONFIG_OPTIONS.oaipmhAnalyticsURL,
    logLevel: 'debug',
    changeOrigin: true,
    pathRewrite: (path: string, req: Request) => {
        const rewritePath = path.replace('/v2', '');
        winstonLogger.debug('Proxied request to path [%s] with the content [%s] using the headers: %o',
            rewritePath,
            JSON.stringify(req.body),
            req.headers);
        return rewritePath;
    },
}));

app.use(bodyParser.json({ limit: '1mb' }));
app.use(bodyParser.urlencoded({ extended: true, limit: '1mb' }));
app.use('/favicon.ico', express.static('./views/favicon.ico'));
app.use('/', apiRouterRoot);
app.use('/api/v1/', apiRouterV1);
app.use('/api/v2/', apiRouterV2);
app.use(lusca.xframe('SAMEORIGIN'));
app.use(lusca.xssProtection);
app.use((err, req, res) => {
    handleError(err, res);
});

// Root status page with Pug template
app.set('views', './views');
app.set('view engine', 'pug');

app.set('port', 3000);

// TODO: To be removed after full refectoring of aoeScheduler.ts
require('./util/aoeScheduler');

// Start scheduled maintenance processes
aoeScheduler.startScheduledCleaning();
aoeScheduler.startScheduledRegistrationForPIDs();
aoeScheduler.startScheduledSearchIndexUpdate();

export default app;
