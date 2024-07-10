import { db } from '@resource/postgresClient';
import winstonLogger from '@util/winstonLogger';
import { NextFunction, Request, Response } from 'express';
import { body, header, Result, ValidationChain, ValidationError, validationResult } from 'express-validator';
import DOMPurify from 'isomorphic-dompurify';

// DOMPurify hook to add opening target and security attributes for the links embedded in notifications.
DOMPurify.addHook('afterSanitizeAttributes', (element: Element): void => {
  if (element.tagName === 'A' && !element.hasAttribute('target')) element.setAttribute('target', '_blank');
  if (element.tagName === 'A' && !element.hasAttribute('rel')) element.setAttribute('rel', 'noopener noreferrer');
});

export const addCollectionValidationRules = (): ValidationChain[] => {
  return [
    body('collectionId', 'Integer collectionId must exist').exists().bail().isInt(),
    body('emId', 'emId expected').exists(),
    body('emId', 'Array emId expected').isArray(),
    body('emId.*').isInt(),
    // body("emId").custom(arr => arr.every((e) => { return Number.isInteger(parseInt(e)); })),
  ];
};

export const createCollectionValidationRules = (): ValidationChain[] => {
  return [
    body('name', 'String name must exist max length 255 characters').exists().bail().isString().isLength({ max: 255 }),
  ];
};

export const fileUploadRules = (): ValidationChain[] => {
  return [
    header('content-type')
      .exists({ checkFalsy: true })
      .withMessage('Content-Type header missing')
      .bail()
      .contains('multipart/form-data')
      .withMessage('Upload is not a multipart form'),
  ];
};

export const isEncoded = (str: string): boolean => {
  try {
    return decodeURIComponent(str) !== str;
  } catch (err) {
    return true;
  }
};

export const metadataExtensionValidationRules = (): ValidationChain[] => {
  return [
    body('keywords.*.key', 'string key expected ').if(body('keywords').exists()).isString(),
    body('keywords.*.value', 'string value expected ').if(body('keywords').exists()).isString(),

    body('accessibilityFeatures.*.key', 'string key expected ').if(body('accessibilityFeatures').exists()).isString(),
    body('accessibilityFeatures.*.value', 'string value expected ')
      .if(body('accessibilityFeatures').exists())
      .isString(),

    body('educationalLevels.*.key', 'string key expected ').if(body('educationalLevels').exists()).isString(),
    body('educationalLevels.*.value', 'string value expected ').if(body('educationalLevels').exists()).isString(),

    body('accessibilityHazards.*.key', 'string key expected ').if(body('accessibilityHazards').exists()).isString(),
    body('accessibilityHazards.*.value', 'string value expected ').if(body('accessibilityHazards').exists()).isString(),
  ];
};

export const ratingValidationRules = (): ValidationChain[] => {
  return [
    body('materialId').exists(),
    body('ratingContent').exists().optional({ nullable: true }).isInt({ min: 1, max: 5 }),
    body('ratingVisual').exists().optional({ nullable: true }).isInt({ min: 1, max: 5 }),
    body('feedbackPositive').exists().optional({ nullable: true }).isLength({ max: 1000 }),
    body('feedbackSuggest').exists().optional({ nullable: true }).isLength({ max: 1000 }),
    body('feedbackPurpose').exists().optional({ nullable: true }).isLength({ max: 1000 }),
  ];
};

export const removeCollectionValidationRules = (): ValidationChain[] => {
  return [
    body('collectionId', 'Integer collectionId must exist').exists().bail().isInt(),
    body('emId', 'emId expected').exists(),
    body('emId', 'Array emId expected').isArray(),
    body('emId.*').isInt(),
  ];
};

export const rulesValidate = async (req: Request, res: Response, next: NextFunction): Promise<any> => {
  const errors: Result<ValidationError> = validationResult(req);
  if (errors.isEmpty()) {
    return next();
  }
  const extractedErrors: any[] = [];
  errors.array().map((err: ValidationError) => extractedErrors.push({ [err.param]: err.msg }));
  winstonLogger.debug('body: ', req.body, 'validation errors: ', extractedErrors);
  return res.status(422).send({
    errors: extractedErrors,
  });
};

export const updateCollectionValidationRules = (): ValidationChain[] => {
  return [
    body('collectionId', 'Integer collectionId must exist').exists().bail().isInt(),
    body('name', 'String name must exist max length 255 characters').exists().bail().isString().isLength({ max: 255 }),
    body('publish', 'publish boolean expected').if(body('publish').exists()).isBoolean(),
    body('description', 'string description expected max length 2000 characters')
      .if(body('description').exists())
      .isString()
      .isLength({ max: 2000 }),
    body('keywords.*.key', 'string key expected ').if(body('keywords').exists()).isString(),
    body('keywords.*.value', 'string value expected ').if(body('keywords').exists()).isString(),
    body('languages.*').isString(),
    body('educationalRoles.*.key', 'string key expected ').if(body('educationalRoles').exists()).isString(),
    body('educationalRoles.*.value', 'string value expected ').if(body('educationalRoles').exists()).isString(),

    body('alignmentObjects.*.alignmentType', 'alignmentType expected ').if(body('alignmentObjects').exists()).exists(),
    body('alignmentObjects.*.targetName', 'targetName expected ').if(body('alignmentObjects').exists()).exists(),
    body('alignmentObjects.*.source', 'source expected ').if(body('alignmentObjects').exists()).exists(),
    body('alignmentObjects.*.key', 'key expected ').if(body('alignmentObjects').exists()).exists(),
    body('educationalUses.*.key', 'string key expected ').if(body('educationalUses').exists()).isString(),
    body('educationalUses.*.value', 'string value expected ').if(body('educationalUses').exists()).isString(),

    body('accessibilityHazards.*.key', 'string key expected ').if(body('accessibilityHazards').exists()).isString(),
    body('accessibilityHazards.*.value', 'string value expected ').if(body('accessibilityHazards').exists()).isString(),

    body('accessibilityFeatures.*.key', 'string key expected ').if(body('accessibilityFeatures').exists()).isString(),
    body('accessibilityFeatures.*.value', 'string value expected ')
      .if(body('accessibilityFeatures').exists())
      .isString(),
    body('materials.*.id', 'educationalmaterial id expected').if(body('materials').exists()).isInt(),
    body('materials.*.priority', 'priority expected').if(body('materials').exists()).isInt(),
    body('headings.*.heading', 'heading expected max length 255 characters')
      .if(body('headings').exists())
      .isString()
      .isLength({ max: 255 }),
    body('headings.*.description', 'description max length 2000 characters')
      .if(body('headings').exists())
      .optional({ nullable: true })
      .isString()
      .isLength({ max: 2000 }),
    body('headings.*.priority', 'priority expected').if(body('headings').exists()).isInt(),
  ];
};

export const validateNotification = (): ValidationChain[] => {
  return [
    body('text', 'not a valid string max 500 characters')
      .exists()
      .optional({ nullable: false })
      .bail()
      .isString()
      .customSanitizer((text: string) => {
        const decoded: string = isEncoded(text) ? decodeURIComponent(text) : text;
        return DOMPurify.sanitize(decoded, {
          ALLOWED_ATTR: ['href', 'rel', 'target'],
          ALLOWED_TAGS: ['a', 'b', 'i'],
        });
      })
      .isLength({ max: 500, min: 1 })
      .bail()
      .customSanitizer((text: string) => encodeURIComponent(text)),
    body('type', 'not a valid value of ERROR or INFO').exists().isIn(['ERROR', 'INFO']),
    body('showSince', 'not a valid ISODate string').exists().optional({ nullable: true }).isISO8601().toDate(),
    body('showUntil', 'not a valid ISODate string').exists().optional({ nullable: true }).isISO8601().toDate(),
  ];
};

export const validateNotificationUpdate = (): ValidationChain[] => {
  return [
    body('id', 'not a valid ID string').exists().optional({ nullable: false }).bail().isString(),
    body('text', 'not a valid string max 500 characters')
      .exists()
      .optional({ nullable: false })
      .bail()
      .isString()
      .customSanitizer((text: string) => {
        const decoded: string = isEncoded(text) ? decodeURIComponent(text) : text;
        return DOMPurify.sanitize(decoded, {
          ALLOWED_ATTR: ['href', 'rel', 'target'],
          ALLOWED_TAGS: ['a', 'b', 'i'],
        });
      })
      .isLength({ max: 500, min: 1 })
      .bail()
      .customSanitizer((text: string) => encodeURIComponent(text)),
    body('type', 'not a valid value of ERROR or INFO').exists().isIn(['ERROR', 'INFO']),
    body('createdAt', 'not a valid ISODate string').exists().optional({ nullable: true }).isISO8601().toDate(),
    body('showSince', 'not a valid ISODate string').exists().optional({ nullable: true }).isISO8601().toDate(),
    body('showUntil', 'not a valid ISODate string').exists().optional({ nullable: true }).isISO8601().toDate(),
    body('disabled', 'not a valid boolean value').exists().optional({ nullable: false }).isBoolean(),
  ];
};

export const validateRatingUser = async (req: Request, res: Response, next: NextFunction): Promise<any> => {
  const { usersusername } = await db.task(async (t: any) => {
    const query = 'SELECT usersusername FROM educationalmaterial WHERE id = $1';
    const educationalMateriaId: number = parseInt(req.body.materialId, 10);
    return await t.oneOrNone(query, [educationalMateriaId]);
  });
  if (usersusername === req.session.passport.user.uid) {
    return res.status(400).send({
      error: {
        status: 400,
        message: 'Bad Request',
        description: 'Rating user same as educational material owner',
      },
    });
  }
  return next();
};

export default {
  addCollectionValidationRules,
  createCollectionValidationRules,
  fileUploadRules,
  isEncoded,
  metadataExtensionValidationRules,
  ratingValidationRules,
  removeCollectionValidationRules,
  rulesValidate,
  updateCollectionValidationRules,
  validateNotification,
  validateNotificationUpdate,
  validateRatingUser,
};
