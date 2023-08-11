import { NextFunction, Request, Response } from 'express';
import config from '../configuration';
import { ErrorHandler } from '../helpers/errorHandler';

export interface AoeRouteMessage {
  enabled: string;
  message: {
    fi: string;
    en: string;
    sv: string;
  };
  alertType: string;
}

export const alertTypeDanger = 'danger';
export const allasErrorMessage =
  'Palvelussamme on tällä hetkellä vikatilanne. Uusien oppimateriaalien tallentaminen on estetty ongelman selvittämisen ajaksi. Korjaamme ongelman mahdollisimman pian. Ajankohtaisimmat tiedot Twitter-kanavallamme @aoe_suomi.';
export const allasErrorMessageEn =
  'We currently have an error that affects using the service. Uploading new learning resources has been blocked until the problem is resolved. We will fix the problem as soon as possible. Find the latest information on our Twitter channel @aoe_suomi.';
export const allasErrorMessageSv =
  'Vi har för närvarande ett fel som påverkar användningen av tjänsten. Publicering av nya lärresurser har blockerats tills problemet har lösts. Vi löser problemet så snart som möjligt. Hitta den senaste informationen på vår Twitter-kanal @aoe_suomi.';
export const loginErrorMessage =
  'Palveluun kirjautumisessa on tällä hetkellä ongelmaa. Selvitämme asiaa ja korjaamme sen mahdollisimman pian. Ajankohtaisimmat tiedot Twitter-kanavallamme @aoe_suomi.';
export const loginErrorMessageEn =
  'There is currently an error in signing in to the service. We will fix the problem as soon as possible. Find the latest information on our Twitter channel @aoe_suomi.';
export const loginErrorMessageSv =
  'Det finns för närvarande ett fel vid inloggning på tjänsten. Vi löser problemet så snart som möjligt. Hitta den senaste informationen på vår Twitter-kanal @aoe_suomi.';

export const isAllasEnabled = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
  if (!config.APPLICATION_CONFIG.isCloudStorageEnabled) {
    const statusCode = 503;
    res.status(statusCode).json({
      status: 'error',
      statusCode,
      message: allasErrorMessage,
    });
    throw new Error('File upload interrupted as the cloud storage is currently disabled in the environment variables.');
  }
  next();
};

export const isLoginEnabled = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
  try {
    const login = Number(process.env.LOGIN_ENABLED);
    if (!login) {
      const statusCode = 503;
      const message = loginErrorMessage;
      res.status(statusCode).json({
        status: 'error',
        statusCode,
        message,
      });
    } else {
      next();
    }
  } catch (err) {
    next(new ErrorHandler(err, 'Issue in login'));
  }
};

export const aoeRoutes = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
  try {
    const allasMessageObject = {
      fi: allasErrorMessage,
      en: allasErrorMessageEn,
      sv: allasErrorMessageSv,
    };
    const loginMessageObject = {
      fi: loginErrorMessage,
      en: loginErrorMessageEn,
      sv: loginErrorMessageSv,
    };
    let allasMessageEnabled = '1';
    if (config.APPLICATION_CONFIG.isCloudStorageEnabled) {
      allasMessageEnabled = '0';
    }
    let loginMessageEnabled = '1';
    if (process.env.LOGIN_ENABLED === '1') {
      loginMessageEnabled = '0';
    }
    const allas: AoeRouteMessage = {
      enabled: allasMessageEnabled,
      message: allasMessageObject,
      alertType: alertTypeDanger,
    };
    const login: AoeRouteMessage = {
      enabled: loginMessageEnabled,
      message: loginMessageObject,
      alertType: alertTypeDanger,
    };
    res.status(200).json({
      allas,
      login,
    });
  } catch (e) {
    next(new ErrorHandler(e, 'Issue in messages info'));
  }
};
