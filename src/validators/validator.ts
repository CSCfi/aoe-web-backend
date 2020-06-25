import { Request, Response, NextFunction } from "express";

import { body, validationResult } from "express-validator";

function ratingValidationRules() {
    return [
        // materialId mandatory
        body("materialId").exists(),
        body("ratingContent").exists().optional({nullable: true}).isInt({min: 1, max: 5}),
        body("ratingVisual").exists().optional({nullable: true}).isInt({min: 1, max: 5}),
        // feedback maximum length 1000
        body("feedbackPositive").exists().optional({nullable: true}).isLength({ max: 1000 }),
        body("feedbackSuggest").exists().optional({nullable: true}).isLength({ max: 1000 }),
        body("feedbackPurpose").exists().optional({nullable: true}).isLength({ max: 1000 }),
      ];
}

function createCollectionValidationRules() {
    return [
        body("name", "String name must exist").exists().bail().isString(),
    ];
}

function addCollectionValidationRules() {
    return [
        body("collectionId", "Integer collectionId must exist").exists().bail().isInt(),
        body("emId", "emId expected").exists(),
        body("emId", "Array emId expected").isArray(),
        body("emId.*").isInt(),
        // body("emId").custom(arr => arr.every((e) => { return Number.isInteger(parseInt(e)); })),
    ];
}

function removeCollectionValidationRules() {
    return [
        body("collectionId", "Integer collectionId must exist").exists().bail().isInt(),
        body("emId", "emId expected").exists(),
        body("emId", "Array emId expected").isArray(),
        body("emId.*").isInt(),
    ];
}

function updateCollectionValidationRules() {
    return [
        body("collectionId", "Integer collectionId must exist").exists().bail().isInt(),
        body("name", "String name must exist").exists().bail().isString(),
        body("publish", "publish boolean expected").if(body("publish").exists()).isBoolean(),
        body("description", "string description expected ").if(body("description").exists()).isString(),
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
        body("alignmentObjects.*.educationalFramework", "educationalFramework expected ").if(body("alignmentObjects").exists())
        .exists(),
        body("alignmentObjects.*.key", "key expected ").if(body("alignmentObjects").exists())
        .exists(),
        body("alignmentObjects.*.targetUrl", "targetUrl expected ").if(body("alignmentObjects").exists())
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
    ];
}

async function rulesValidate(req: Request, res: Response, next: NextFunction) {
    const errors = validationResult(req);
    if (errors.isEmpty()) {
        return next();
    }
    const extractedErrors = [];
    errors.array().map(err => extractedErrors.push({ [err.param]: err.msg }));
    console.log("body: ", req.body, "validation errors: ", extractedErrors);
    return res.status(422).send({
        errors: extractedErrors,
    });
}

module.exports = {
    ratingValidationRules,
    rulesValidate,
    createCollectionValidationRules,
    addCollectionValidationRules,
    removeCollectionValidationRules,
    updateCollectionValidationRules
};