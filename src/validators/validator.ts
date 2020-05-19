import { Request, Response, NextFunction } from "express";

import { body, validationResult } from "express-validator";

function ratingValidationRules() {
    console.log("tässä");
    return [
        // username must be an email
        body("materialId")
        .exists(),
        body("ratingContent").exists().optional({nullable: true}).isInt({min: 1, max: 5}),
        body("ratingVisual").exists().optional({nullable: true}).isInt({min: 1, max: 5}),
        body("feedbackPositive").exists().optional({nullable: true}).isLength({ max: 1000 }),
        body("feedbackSuggest").exists().optional({nullable: true}).isLength({ max: 1000 }),
        // password must be at least 5 chars long
        body("feedbackPurpose").exists().optional({nullable: true}).isLength({ max: 1000 }),
      ];
}

async function ratingValidate(req: Request, res: Response, next: NextFunction) {
    const errors = validationResult(req);
    if (errors.isEmpty()) {
        return next();
    }
    const extractedErrors = [];
    errors.array().map(err => extractedErrors.push({ [err.param]: err.msg }));
    return res.status(422).send({
        errors: extractedErrors,
    });
}

module.exports = {
    ratingValidationRules,
    ratingValidate
};