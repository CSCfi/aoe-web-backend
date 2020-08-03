import express, { Response, Request, NextFunction } from "express";
import compression from "compression";  // compresses requests
import lusca from "lusca";
import dotenv from "dotenv";
import path from "path";
// Load environment variables from .env file, where API keys and passwords are configured
dotenv.config({path: ".env"});
const util = require("util");
const ah = require("./services/authService");
import expressValidator from "express-validator";

const passport = require("passport");
const flash = require("connect-flash");
const session = require("express-session");
import { ErrorHandler, handleError } from "./helpers/errorHandler";
const cors = require("cors");
const app = express();
const morgan = require("morgan");
const bodyParser = require("body-parser");

import * as homeController from "./controllers/home";

const apiRouter = require("./routes/routes");
// Create Express server
const redis = require("redis");
const redisclient = redis.createClient({
    host: process.env.REDIS_HOST,
    port: process.env.REDIS_PORT,
}
);
const RedisStore = require("connect-redis")(session);

// setInterval(() => ah.authIssuer(), 30000);
const { custom } = require("openid-client");
custom.setHttpOptionsDefaults({
  timeout: Number(process.env.HTTP_OPTIONS_TIMEOUT) || 5000,
  retry: Number(process.env.HTTP_OPTIONS_RETRY) || 2,
  clock_tolerance : Number(process.env.HTTP_OPTIONS_CLOCK_TOLERANCE) || 5,
//   hooks: {
//     beforeRequest: [
//       (options) => {
//         console.log("--> %s %s", options.method.toUpperCase(), options.href);
//         console.log("--> HEADERS %o", options.headers);
//         if (options.body) {
//           console.log("--> BODY %s", options.body);
//         }
//       },
//     ],
//     afterResponse: [
//       (response) => {
//         console.log("<-- %i FROM %s %s", response.statusCode, response.request.gotOptions.method.toUpperCase(), response.request.gotOptions.href);
//         console.log("<-- HEADERS %o", response.headers);
//         if (response.body) {
//           console.log("<-- BODY %s", response.body);
//         }
//         return response;
//       },
//     ],
// onError: [
//     error => {
//         console.log("this is error ####################");
//         const {response} = error;
//          if (response && response.body) {
//             error.name = "GitHubError";
//             error.message = `${response.body.message} (${error.statusCode})`;
//         }

//          return error;
//     }
// ]
//   },
});

const Issuer = require("openid-client").Issuer;
const Strategy = require("openid-client").Strategy;
app.set("trust proxy", 1);
app.use(session({
    store: new RedisStore( {client: redisclient}),
    resave: false,
    saveUninitialized: true,
    secret: process.env.SESSION_SECRET,
    credentials: "include",
    cookie: {
        httpOnly: true,
        maxAge: Number(process.env.SESSION_COOKIE_MAX_AGE) || 60 * 60 * 1000}
}));

passport.serializeUser(function (user, done) {
    done(undefined, user);
});

passport.deserializeUser((userinfo, done) => {
    done(undefined, {user: userinfo.id});
});

Issuer.discover(process.env.PROXY_URI)
    .then(function (testIssuer, req: Request) {
        const client = new testIssuer.Client({
            client_id: process.env.CLIENT_ID,
            client_secret: process.env.CLIENT_SECRET,
            redirect_uri: process.env.REDIRECT_URI,
            response_type: "code",
        });
        console.log("Discovered issuer %s %O", testIssuer.issuer, testIssuer.metadata);
        passport.use("oidc", new Strategy({client}, (tokenset: any, userinfo: any, done: any, next: NextFunction) => {
            console.log("tokenset", tokenset);
            console.log("access_token", tokenset.access_token);
            console.log("id_token", tokenset.id_token);
            console.log("claims", tokenset.claims());
            console.log("userinfo", userinfo);
            console.log("Typeof userinfo: " + typeof (userinfo));
            console.log("expires_in", tokenset.expires_in);

            // Here we launch the insert to the database
            // First we check if the login occured via suomi.fi, if so then use another key, as not to save SoSign to database.
            // Else check haka. Save the eppn to the database.
            // Else check mpass. Save the uid to the database.

            if (tokenset.claims().acr == process.env.SUOMIACR) {

                ah.InsertUserToDatabase(userinfo, tokenset.claims().acr)
                .then(() => {
                    const nameparsed = userinfo.given_name + " " + userinfo.family_name;
                    return done(undefined, {uid: userinfo.sub, name: nameparsed, email: userinfo.email});
                })
                .catch((err: Error) => {
                        console.log(err);
                        return done("Login error when inserting suomi.fi information to database ", undefined);
                    }
                );
            }
            else if (tokenset.claims().acr == process.env.HAKAACR) {

            ah.InsertUserToDatabase(userinfo, tokenset.claims().acr)
                .then(() => {
                    const nameparsed = userinfo.given_name + " " + userinfo.family_name;
                    return done(undefined, {uid: userinfo.eppn, name: nameparsed, email: userinfo.email});
                })
                .catch((err: Error) => {
                        console.log(err);
                        return done("Login error", undefined);
                    }
                );
            }
            else if (tokenset.claims().acr == process.env.MPASSACR) {
                ah.InsertUserToDatabase(userinfo, tokenset.claims().acr)
                    .then(() => {
                        const nameparsed = userinfo.given_name + " " + userinfo.family_name;
                        return done(undefined, {uid: userinfo.mpass_uid, name: nameparsed, email: userinfo.email});
                    })
                    .catch((err: Error) => {
                            console.log(err);
                            return done("Login error", undefined);
                        }
                    );
                }
            else {
                console.error("Unknown authentication method: " + tokenset.claims().acr);
                throw new ErrorHandler(400, "Unknown authentication method");
            }
        }));
    });
app.use(flash());
app.use(passport.initialize());
app.use(passport.session());

app.get("/login", passport.authenticate("oidc", {
    successRedirect: "/",
    failureRedirect: "/login",
    failureFlash: true,
    scope: "openid profile offline_access"
}));

app.get("/secure/redirect", function (req: Request, res: Response, next: NextFunction) {
        console.log("here");
        next();
    }
    , passport.authenticate("oidc", {
        "callback": true,
        failureRedirect: process.env.FAILURE_REDIRECT_URI,
        failureFlash: true,
        successRedirect: process.env.SUCCESS_REDIRECT_URI
    })
);

const cookieParser = require("cookie-parser");
app.use(cookieParser());
app.use(morgan("dev"));
app.use(compression());

/**
 * CORS configuration
 */
const corsOptions = {
    origin: ["https://demo.aoe.fi", "https://aoe.fi", "https://86.50.27.30:80"],
    methods: ["GET", "HEAD", "PUT", "PATCH", "POST", "DELETE"],
    optionsSuccessStatus: 200
};
app.use(cors(corsOptions));

app.use(bodyParser.json({extended: true, limit: "1mb"}));
app.use(bodyParser.urlencoded({extended: true, limit: "1mb"}));
app.set("port", 3000);
app.set("views", path.join(__dirname, "../views"));
app.set("view engine", "pug");
app.get("/", homeController.index);
app.use("/", apiRouter);
app.use(lusca.xframe("SAMEORIGIN"));
app.use(lusca.xssProtection);

app.use((err, req, res, next) => {
    handleError(err, res);
  });

require("./aoeScheduler");
const es = require("./elasticSearch/es");

module.exports = app;
export default app;
