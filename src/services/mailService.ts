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
        subject: "Materiaali vanhenee - Avointen oppimateriaalien kirjasto (aoe.fi)",
        text: expirationEmailText
      };
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

export async function getExpiredMaterials() {
    const query = "select distinct email from educationalmaterial join users on educationalmaterial.usersusername = username where expires < NOW() + INTERVAL '3 days' and expires >= NOW() + INTERVAL '1 days';";
    const data = await db.any(query);
    return data;
}

export async function updateEmail(user: string, email: string) {
    try {
        const query = "update users set email = $1, verifiedemail = false where username = $2;";
        await db.none(query, [email, user]);
    }
    catch (error) {
        throw new Error(error);
    }
}

export async function updateVerifiedEmail(user: string) {
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
    console.log(verificationEmailText);
    const mailOptions = {
        from: process.env.EMAIL_FROM,
        to: email,
        subject: "Sähköpostin vahvistus - Avointen oppimateriaalien kirjasto (aoe.fi)",
        text: verificationEmailText
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

const verificationEmailText =
"Hei,\n" +
"olet syöttänyt sähköpostisi Avointen oppimateriaalien kirjaston Omat tiedot -sivulle. Vahvista sähköpostiosoitteesi ilmoitusten vastaanottamiseksi klikkaamalla linkkiä: \n" +
"${url}\n" +
"Ystävällisin terveisin,\n" +
"AOE-tiimi\n\n" +
"Hi,\n" +
"you have submitted your email at the My Account page at the Library of Open Educational Resources. To receive notifications please verify your email by clicking here:\n" +
"${url}\n" +
"Best regards,\n" +
"AOE Team\n\n" +
"Hej,\n" +
"du har angett din e-postadress på sidan Mitt konto i Biblioteket för öppna lärresurser. Bekräfta din e-postadress för att få meddelanden genom att klicka på länken: \n" +
"${url}\n" +
"Med vänlig hälsning,\n" +
"AOE-team\n";

const expirationEmailText =
"Hei,\n" +
"Oppimateriaalille asettamasi vanhenee-päivämäärä lähestyy. Voit halutessasi muokata vanhenee-päivämäärää ja tarvittaessa päivittää materiaalisi Omat oppimateriaalit –näkymässä.\n" +
"Ystävällisin terveisin,\n" +
"AOE-tiimi\n" +
"Tämä on automaattinen viesti. Mikäli et halua enää saada näitä viestejä, voit muuttaa viestiasetuksia Avointen oppimateriaalien kirjaston Omat tiedot –näkymässä.\n\n" +
"Hi,\n" +
"The expires date you have given to your educational resource is near. You can change the date and update your resource from My open educational resources view.\n" +
"Best Regards,\n" +
"AOE Team\n" +
"This is an automated message. If you do not wish to receive these messages anymore you can change your settings in the My Account view at the Library of Open Educational Resources.\n\n" +
"Hej,\n" +
"Det föråldras-datum som du har gett till din lärresurs är nära. Du kan redigera det föråldras-datum och uppdatera din lärresurs från Mina lärresurser-sidan.\n" +
"Med vänliga hälsningar,\n" +
"AOE-team\n" +
"Detta är ett automatiskt meddelande. Om du vill inte få dessa meddelandena, kan du förändra dina inställningar I vyn Mitt konto på Biblioteket för öppna lärresurser.";