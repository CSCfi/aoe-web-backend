// const nodemailer = require("nodemailer");
import { Request, Response, NextFunction } from "express";
import { createTransport } from "nodemailer";
import { rdbms } from '../resources';
import { sign, verify } from "jsonwebtoken";
import { winstonLogger } from '../util';

// import { ErrorHandler } from "./../helpers/errorHandler";
// const pgp = rdbms.pgp;
const db = rdbms.db;
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
        winstonLogger.debug(materials);
        const emailArray = materials.filter(m => m.email != undefined).map(m => m.email);
        mailOptions.to = emailArray;
        winstonLogger.debug(emailArray);
        if (!(process.env.SEND_EMAIL === "1")) {
            winstonLogger.debug("Email sending disabled");
        }
        else {
            const materials = await getExpiredMaterials();
            winstonLogger.debug(materials);
            for (const element of emailArray) {
                mailOptions.to = element;
                const info = await transporter.sendMail(mailOptions);
                winstonLogger.debug("Message sent: %s", info.messageId);
                // winstonLogger.debug("Message sent: %s", info.response);
            }
        }
    }
    catch (error) {
        winstonLogger.debug(error);
    }
}

export async function sendRatingNotificationMail() {
    try {
        const emails = await getNewRatings();
        winstonLogger.debug(emails);
        const emailArray = emails.filter(m => m.email != undefined).map(m => m.email);
        winstonLogger.debug("emailArray: " + emailArray);
        const holder = {};
        emails.forEach(function(d) {
            if (holder.hasOwnProperty(d.email)) {
              holder[d.email] = holder[d.email] + ", " + d.materialname;
            } else {
              holder[d.email] = d.materialname;
            }
          });
        winstonLogger.debug(holder);
        if (!(process.env.SEND_EMAIL === "1")) {
            winstonLogger.debug("Email sending disabled");
        }
        else {
            for (const element of emailArray) {
                const mailOptions = {
                    from: process.env.EMAIL_FROM,
                    to: element,
                    subject: "Uusi arvio - Avointen oppimateriaalien kirjasto (aoe.fi)",
                    text: await ratingNotificationText(holder[element])
                  };
                winstonLogger.debug("sending rating mail to: " + element);
                try {
                    const info = await transporter.sendMail(mailOptions);
                    winstonLogger.debug("Message sent: %s", info.messageId);
                    // winstonLogger.debug("Message sent: %s", info.response);
                }
                catch (error) {
                    winstonLogger.error(error);
                }
            }
        }
    }
    catch (error) {
        winstonLogger.debug(error);
    }
}
export async function getExpiredMaterials() {
    const query = "select distinct email from educationalmaterial join users on educationalmaterial.usersusername = username where expires < NOW() + INTERVAL '2 days' and expires >= NOW() + INTERVAL '1 days';";
    const data = await db.any(query);
    return data;
}

export async function getNewRatings() {
    const query = "select distinct email, m.materialname from rating join educationalmaterial as em on em.id = rating.educationalmaterialid join materialname as m on em.id = m.educationalmaterialid join users on em.usersusername = users.username where rating.updatedat > (now() -  INTERVAL '1 days') and m.language = 'fi';";
    const data = await db.any(query);
    return data;
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

export async function sendVerificationEmail(user: string, email: string) {
    const jwtSecret = process.env.JWT_SECRET;
    const date = new Date();
    const mail = {
        "id": user,
        "created": date.toString()
        };
    const token_mail_verification = sign(mail, jwtSecret, { expiresIn: "1d" });

    const url = process.env.BASE_URL + "verify?id=" + token_mail_verification;
    winstonLogger.debug(url);
    winstonLogger.debug(await verificationEmailText(url));
    const mailOptions = {
        from: process.env.EMAIL_FROM,
        to: email,
        subject: "Sähköpostin vahvistus - Avointen oppimateriaalien kirjasto (aoe.fi)",
        html: await verificationEmailText(url)
    };
    if (process.env.SEND_EMAIL === "1") {
    const info = await transporter.sendMail(mailOptions);
    winstonLogger.debug("Message sent: %s", info.messageId);
    // winstonLogger.debug("Message sent: %s", info.response);
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
            winstonLogger.debug(id);
            updateVerifiedEmail(id);
            return res.redirect(process.env.VERIFY_EMAIL_REDIRECT_URL || "/");
        } catch (err) {
            winstonLogger.debug(err);
            return res.sendStatus(403);
        }
    } else {
        return res.sendStatus(403);
    }
}

async function verificationEmailText(url) {
const verificationEmailText =
`<p>Hei</p>
<p>olet syöttänyt sähköpostisi Avointen oppimateriaalien kirjaston Omat tiedot -sivulle.</p>
<p><a href=${url}>Vahvista sähköpostiosoitteesi ilmoitusten vastaanottamiseksi klikkaamalla linkkiä</a></p>
<p></p>
<p>you have submitted your email at the My Account page at the Library of Open Educational Resources.</p>
<p><a href=${url}>To receive notifications please verify your email by clicking here</a></p>
<p></p>
<p>du har angett din e-postadress på sidan Mitt konto i Biblioteket för öppna lärresurser.</p>
<p><a href=${url}>Bekräfta din e-postadress för att få meddelanden genom att klicka på länken</a></p>
<p></p>
<p>Jos linkki ei avaudu, kopioi se tästä:</p>
${url}
<p></p>
<p>Ystävällisin terveisin, Best regards, Med vänlig hälsning,</p>
<p>AOE-tiimi</p>`;
return verificationEmailText;
}

const expirationEmailText =
`Hei,
Oppimateriaalille asettamasi vanhenee-päivämäärä lähestyy. Voit halutessasi muokata vanhenee-päivämäärää ja tarvittaessa päivittää materiaalisi Omat oppimateriaalit –näkymässä.
Ystävällisin terveisin,
AOE-tiimi
Tämä on automaattinen viesti. Mikäli et halua enää saada näitä viestejä, voit muuttaa viestiasetuksia Avointen oppimateriaalien kirjaston Omat tiedot –näkymässä.

Hi,
The expires date you have given to your educational resource is near. You can change the date and update your resource from My open educational resources view.
Best Regards,
AOE Team
This is an automated message. If you do not wish to receive these messages anymore you can change your settings in the My Account view at the Library of Open Educational Resources.

Hej,
Det föråldras-datum som du har gett till din lärresurs är nära. Du kan redigera det föråldras-datum och uppdatera din lärresurs från Mina lärresurser-sidan.
Med vänliga hälsningar,
AOE-team
Detta är ett automatiskt meddelande. Om du vill inte få dessa meddelandena, kan du förändra dina inställningar I vyn Mitt konto på Biblioteket för öppna lärresurser.`;

async function ratingNotificationText(materials: string) {
const ratingNotificationText =
`Hei,
Oppimateriaalisi on saanut uuden arvion. Voit lukea sen valitsemalla oppimateriaalin Omat oppimateriaalit -näkymästä.
Materiaalit: ${materials}
Ystävällisin terveisin,
AOE-tiimi
Tämä on automaattinen viesti. Mikäli et halua enää saada näitä viestejä, voit muuttaa viestiasetuksia Avointen oppimateriaalien kirjaston Omat tiedot –näkymässä.

Hi,
Your educational resource has received a new review. You can view it by choosing the resource in My open educational resources.
Materials: ${materials}
Best Regards,
AOE Team
This is an automated message. If you do not wish to receive these messages anymore you can change your settings in the My Account view at the Library of Open Educational Resources.

Hej,
Din lärresurs har fått en ny recension. Du kan läsa den från Mina lärresurser -sidan.
Lärresurser: ${materials}
Med vänliga hälsningar,
AOE-team
Detta är ett automatiskt meddelande. Om du vill inte få dessa meddelandena, kan di förändra dina inställningar i vyn Mitt konto på Biblioteket för öppna lärresurser.`;
return ratingNotificationText;
}
