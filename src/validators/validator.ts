import { Request, Response, NextFunction } from 'express';
import { body, validationResult } from 'express-validator';
import connection from '../resources/pg-config.module';
import { RatingInformation } from "../rating/interface/rating-information.interface";

const db = connection.db;

export function ratingValidationRules(): any[] {
    return [
        body("materialId").exists(),
        body("ratingContent").exists().optional({nullable: true}).isInt({min: 1, max: 5}),
        body("ratingVisual").exists().optional({nullable: true}).isInt({min: 1, max: 5}),
        body("feedbackPositive").exists().optional({nullable: true}).isLength({max: 1000}),
        body("feedbackSuggest").exists().optional({nullable: true}).isLength({max: 1000}),
        body("feedbackPurpose").exists().optional({nullable: true}).isLength({max: 1000})
    ];
}

export function createCollectionValidationRules() {
    return [
        body("name", "String name must exist max length 255 characters").exists().bail().isString().isLength({max: 255}),
    ];
}

export function addCollectionValidationRules() {
    return [
        body("collectionId", "Integer collectionId must exist").exists().bail().isInt(),
        body("emId", "emId expected").exists(),
        body("emId", "Array emId expected").isArray(),
        body("emId.*").isInt(),
        // body("emId").custom(arr => arr.every((e) => { return Number.isInteger(parseInt(e)); })),
    ];
}

export function removeCollectionValidationRules() {
    return [
        body("collectionId", "Integer collectionId must exist").exists().bail().isInt(),
        body("emId", "emId expected").exists(),
        body("emId", "Array emId expected").isArray(),
        body("emId.*").isInt(),
    ];
}

export function metadataExtensionValidationRules() {
    return [
        body("keywords.*.key", "string key expected ").if(body("keywords").exists())
            .isString(),
        body("keywords.*.value", "string value expected ").if(body("keywords").exists())
            .isString(),

        body("accessibilityFeatures.*.key", "string key expected ").if(body("accessibilityFeatures").exists())
            .isString(),
        body("accessibilityFeatures.*.value", "string value expected ").if(body("accessibilityFeatures").exists())
            .isString(),

        body("educationalLevels.*.key", "string key expected ").if(body("educationalLevels").exists())
            .isString(),
        body("educationalLevels.*.value", "string value expected ").if(body("educationalLevels").exists())
            .isString(),

        body("accessibilityHazards.*.key", "string key expected ").if(body("accessibilityHazards").exists())
            .isString(),
        body("accessibilityHazards.*.value", "string value expected ").if(body("accessibilityHazards").exists())
            .isString()
    ];
}

export function updateCollectionValidationRules() {
    return [
        body("collectionId", "Integer collectionId must exist").exists().bail().isInt(),
        body("name", "String name must exist max length 255 characters").exists().bail().isString().isLength({max: 255}),
        body("publish", "publish boolean expected").if(body("publish").exists()).isBoolean(),
        body("description", "string description expected max length 2000 characters").if(body("description").exists()).isString().isLength({max: 2000}),
        body("keywords.*.key", "string key expected ").if(body("keywords").exists())
            .isString(),
        body("keywords.*.value", "string value expected ").if(body("keywords").exists())
            .isString(),
        body("languages.*").isString(),
        body("educationalRoles.*.key", "string key expected ").if(body("educationalRoles").exists())
            .isString(),
        body("educationalRoles.*.value", "string value expected ").if(body("educationalRoles").exists())
            .isString(),

        body("alignmentObjects.*.alignmentType", "alignmentType expected ").if(body("alignmentObjects").exists())
            .exists(),
        body("alignmentObjects.*.targetName", "targetName expected ").if(body("alignmentObjects").exists())
            .exists(),
        body("alignmentObjects.*.source", "source expected ").if(body("alignmentObjects").exists())
            .exists(),
        body("alignmentObjects.*.key", "key expected ").if(body("alignmentObjects").exists())
            .exists(),
        body("educationalUses.*.key", "string key expected ").if(body("educationalUses").exists())
            .isString(),
        body("educationalUses.*.value", "string value expected ").if(body("educationalUses").exists())
            .isString(),

        body("accessibilityHazards.*.key", "string key expected ").if(body("accessibilityHazards").exists())
            .isString(),
        body("accessibilityHazards.*.value", "string value expected ").if(body("accessibilityHazards").exists())
            .isString(),

        body("accessibilityFeatures.*.key", "string key expected ").if(body("accessibilityFeatures").exists())
            .isString(),
        body("accessibilityFeatures.*.value", "string value expected ").if(body("accessibilityFeatures").exists())
            .isString(),
        body("materials.*.id", "educationalmaterial id expected").if(body("materials").exists())
            .isInt(),
        body("materials.*.priority", "priority expected").if(body("materials").exists())
            .isInt(),
        body("headings.*.heading", "heading expected max length 255 characters").if(body("headings").exists())
            .isString().isLength({max: 255}),
        body("headings.*.description", "description max length 2000 characters").if(body("headings").exists())
            .optional({nullable: true}).isString().isLength({max: 2000}),
        body("headings.*.priority", "priority expected").if(body("headings").exists())
            .isInt()
    ];
}

export async function validateRatingUser(req: Request, res: Response, next: NextFunction): Promise<any> {
    const educationalMaterialOwner: string = await db.task(async (t: any) => {
        const query = 'SELECT usersusername FROM educationalmaterial WHERE id = $1';
        const educationalMateriaId: number = parseInt(req.body.materialId, 10);
        return await t.oneOrNone(query, [educationalMateriaId]);
    });
    console.debug('RATING - ' +
        'educationalMaterialId: ' + req.body.materialId + ', ' +
        'educationalMaterialOwnerId: ' + JSON.stringify(educationalMaterialOwner) + ', ' +
        'authenticatedUser: ' + req.session.passport.user.uid);
    if (educationalMaterialOwner === req.session.passport.user.uid) {
        return res.status(400).send({error: {
                status: 400,
                message: 'Bad Request',
                description: 'Rating user same as educational material owner'
            }
        });
    }
    return next();
}

export async function rulesValidate(req: Request, res: Response, next: NextFunction): Promise<any> {
    const errors = validationResult(req);
    if (errors.isEmpty()) {
        return next();
    }
    const extractedErrors = [];
    errors.array().map(err => extractedErrors.push({[err.param]: err.msg}));
    console.log("body: ", req.body, "validation errors: ", extractedErrors);
    return res.status(422).send({
        errors: extractedErrors,
    });
}

export default {
    ratingValidationRules,
    createCollectionValidationRules,
    addCollectionValidationRules,
    removeCollectionValidationRules,
    metadataExtensionValidationRules,
    updateCollectionValidationRules,
    rulesValidate,
    validateRatingUser
};
