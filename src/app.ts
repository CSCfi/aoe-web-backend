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


// const ah = require("./queries/authservice");
// API keys and Passport configuration
// import * as passportConfig from "./config/passport";
const cors = require("cors");
const app = express();
const morgan = require("morgan");
const bodyParser = require("body-parser");

import * as homeController from "./controllers/home";

const apiRouter = require("./routes/routes");
// Create Express server
const redis = require("redis");
const redisclient = redis.createClient();
const RedisStore = require("connect-redis")(session);

// setInterval(() => ah.authIssuer(), 30000);
const { custom } = require("openid-client");
custom.setHttpOptionsDefaults({
  timeout: 5000,
  retry: 2,
  clock_tolerance : 5,
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
//   },
});

const Issuer = require("openid-client").Issuer;
const Strategy = require("openid-client").Strategy;
app.set("trust proxy", 1);
app.use(session({
    store: new RedisStore(),
    resave: false,
    saveUninitialized: true,
    secret: process.env.SESSION_SECRET,
    credentials: "include",
    cookie: {
        httpOnly: true,
        maxAge: 60 * 60 * 1000}
}));


// used to deserialize the user
// passport.deserializeUser(function(id, done) {
//   User.findById(id, function(err, user) {
//       done(err, user);
//   });
// });
// One possible implementation below.
// ** STARTS HERE **
// Issuer.discover("https://test-user-auth.csc.fi")
//     .then(function (testIssuer) {
//         console.log("Discovered issuer %s", testIssuer);
//         const client = new testIssuer.Client({
//             client_id: "bfb7ab6dda3f493fb321233a7e55953f965391ec",
//             client_secret: "ba761d78e42754edb2853fcaca8497acc54f8d05"
//         });
//         client.authorizationUrl({
//             redirect_uri: "https://10.10.10.10:3000/secure/redirect",
//             scope: "openid email profile",
//         });
//         client.Callback("https://10.10.10.10:3000/secure/redirect")
//             .then(function (tokenSet) {
//                 console.log("received and validated tokens %j", tokenSet);
//                 console.log("validated id_token claims %j", tokenSet.claims);
//             });
//         passport.use("oidc", new Strategy({client}, (tokenset: any, userinfo: any, done: any) => {
//             console.log("tokenset", tokenset);
//             console.log("access_token", tokenset.access_token);
//             console.log("id_token", tokenset.id_token);
//             console.log("claims", tokenset.claims);
//             console.log("userinfo", userinfo);
//             User.findOne({ id: tokenset.claims.sub}, function (err, user) {
//                 if (err) return done(err);
//                 return done(undefined, user);
//         });

//     }));
//     console.log("The actual client " + JSON.stringify(client));
//     // console.log("The client auth url " + JSON.stringify(client.authorizationUrl));
// });


// app.get("/secure/redirect", passport.authenticate("oidc", {successRedirect: "/", failureRedirect: "/login"}));
// ** ENDS HERE **
passport.serializeUser(function (user, done) {
    done(undefined, user);
// where is this user.id going? Are we supposed to access this anywhere?
});

passport.deserializeUser((userinfo, done) => {
    done(undefined, {user: userinfo.id});
});

// One possible implementation below.
// ** STARTS HERE **
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
            // **NEVER GET HERE**
            console.log("tokenset", tokenset);
            console.log("access_token", tokenset.access_token);
            console.log("id_token", tokenset.id_token);
            console.log("claims", tokenset.claims());
            console.log("userinfo", userinfo);
            console.log("Typeof userinfo: " + typeof (userinfo));
            console.log("expires_in", tokenset.expires_in);

            // Tässä se laukaisee sen insertin
            ah.InsertUserToDatabase(userinfo)
                .then(() => {
                    const nameparsed = userinfo.given_name + " " + userinfo.family_name;
                    return done(undefined, {uid: userinfo.uid, name: nameparsed, email: userinfo.email});
                })
                .catch((err: Error) => {
                        console.log(err);
                        return done("Login error", undefined);
                    }
                );
        }));
    });
app.use(flash());
app.use(passport.initialize());
app.use(passport.session());


// app.get("/", (req, res) => {
//     // console.log("The req: " + util.inspect(req) + " and user " + req.user);
//     res.json({"hello": "world", "user": "test" + JSON.stringify(req.body)});
//     console.log(util.inspect(req));
// });
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
// passport.authenticate("oidc", function(err, user, info) {
//   if (err) {
//     console.log(err);
//     return next(err); }
//   if (!user) {
//     console.log(res);
//     return res.redirect("/login"); }
//   req.logIn(user, function(err) {
//     if (err) { return next(err); }
//     return res.redirect("/users/" + user.username);
//   });
// function(req: Request, res: Response) {
//   console.log("here2");
//   res.sendStatus(200);
//  })(req, res, next);
);


// Connect to MongoDB
// const apiRouter = require("./routes/routes");
const cookieParser = require("cookie-parser");
// app.use(passport.initialize());
// app.use(passport.session());
// Express configuration
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
app.use(expressValidator);
app.use(lusca.xframe("SAMEORIGIN"));
app.use(lusca.xssProtection);

require("./aoeScheduler");
/**
 * API examples routes.
 */
// app.get("/api", apiController.getApi);
// app.get("/api/facebook", passportConfig.isAuthenticated, passportConfig.isAuthorized, apiController.getFacebook);

// /**
//  * OAuth authentication routes. (Sign in)
//  */
// app.get("/auth/facebook", passport.authenticate("facebook", { scope: ["email", "public_profile"] }));
// app.get("/auth/facebook/callback", passport.authenticate("facebook", { failureRedirect: "/login" }), (req, res) => {
//   res.redirect(req.session.returnTo || "/");
// });
module.exports = app;
export default app;
