// const nodemailer = require("nodemailer");
import { Request, Response, NextFunction } from "express";
import { createTransport, createTestAccount } from "nodemailer";
import { ErrorHandler } from "./../helpers/errorHandler";
const connection = require("./../db");
const pgp = connection.pgp;
const db = connection.db;
const transporter = createTransport({
    host: process.env.TRANSPORT_AUTH_HOST,
    port: Number(process.env.TRANSPORT_PORT),
    secure: false,
    auth: {
        user: process.env.EMAIL_USER
    }
    });



export async function sendExpirationMail() {
    const mailOptions = {
        from: process.env.EMAIL_FROM,
        to: undefined,
        subject: "Sending Email using Node.js",
        text: "That was easy!"
      };
    // const testAccount = await createTestAccount();

  // create reusable transporter object using the default SMTP transport
//   const transporter = createTransport({
//     host: "smtp.ethereal.email",
//     port: 587,
//     secure: false, // true for 465, false for other ports
//     auth: {
//       user: testAccount.user, // generated ethereal user
//       pass: testAccount.pass, // generated ethereal password
//     },
//   });
    try {
        const materials = await getExpiredMaterials();
        console.log(materials);
        const emailArray = materials.filter(m => m.email != undefined).map(m => m.email);
        mailOptions.to = emailArray;
        console.log(emailArray);
        if (!process.env.SEND_EMAIL) {
            console.log("Email sending disabled");
        }
        else {
            const materials = await getExpiredMaterials();
            console.log(materials);
            // const info = await transporter.sendMail(mailOptions);
            // console.log("Message sent: %s", info.messageId);
            // console.log("Message sent: %s", info.response);
            for (const element of emailArray) {
                mailOptions.to = element;
                const info = await transporter.sendMail(mailOptions);
                console.log("Message sent: %s", info.messageId);
                console.log("Message sent: %s", info.response);
            }
        }
    }
    catch (error) {
        console.log(error);
    }
}
// transporter.sendMail(mailOptions, function(error, info){
//   if (error) {
//     console.log(error);
//   } else {
//     console.log("Email sent: " + info.response);
//   }
// });

export async function getExpiredMaterials() {
    const query = "select distinct email from educationalmaterial join users on educationalmaterial.usersusername = username where expires < NOW() + INTERVAL '3 days' and expires >= NOW() + INTERVAL '1 days';";
    const data = await db.any(query);
    return data;
}

export async function updateEmail(user: string, email: string) {
    // req.session.passport.user.uid
    try {
        const query = "update users set email = $1, verifiedemail = false where username = $2;";
        await db.none(query, [email, user]);
    }
    catch (error) {
        throw new Error(error);
    }
}

export async function updateVerifiedEmail(user: string) {
    // req.session.passport.user.uid
    try {
        const query = "update users set verifiedemail = true where username = $1;";
        await db.none(query, [user]);
    }
    catch (error) {
        throw new Error(error);
    }
}

export async function addEmail(req: Request, res: Response, next: NextFunction) {
    try {
        if (!req.isAuthenticated()) {
            return res.sendStatus(403);
        }
        else if (!req.body.email) {
            next(new ErrorHandler(400, "email missing"));
        }
        else {
            await updateEmail(req.session.passport.user.uid, req.body.email);
            await sendVerificationEmail(req.session.passport.user.uid, req.body.email);
            res.sendStatus(200);
        }
    }
    catch (error) {
        console.log(error);
    }
}

// const jwt = require("jsonwebtoken");
import { sign, verify } from "jsonwebtoken";

export async function sendVerificationEmail(user: string, email: string) {
    const jwtSecret = process.env.JWT_SECRET;
    const date = new Date();
    const mail = {
        "id": user,
        "created": date.toString()
        };
    const token_mail_verification = sign(mail, jwtSecret, { expiresIn: "1d" });

    const url = process.env.BASE_URL + "verify?id=" + token_mail_verification;
    console.log(url);
    const mailOptions = {
        from: process.env.EMAIL_FROM,
        to: email,
        subject: "Email verification",
        text: "Click on the link below to veriy your email " + url
    };
    if (process.env.SEND_EMAIL) {
    const info = await transporter.sendMail(mailOptions);
    console.log("Message sent: %s", info.messageId);
    console.log("Message sent: %s", info.response);
    }
    return url;
}

export async function verifyEmailToken(req: Request, res: Response, next: NextFunction) {
    const jwtSecret = process.env.JWT_SECRET;
    const token = req.query.id;
    if (token) {
        try {
            const decoded = await verify(token, jwtSecret);
            const id = decoded.id;
            console.log(id);
            updateVerifiedEmail(id);
            return res.redirect("/");
        } catch (err) {
            console.log(err);
            return res.sendStatus(403);
        }
    } else {
        return res.sendStatus(403);
    }
}