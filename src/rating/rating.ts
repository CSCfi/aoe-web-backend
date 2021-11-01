import { Request, Response, NextFunction } from 'express';
import { ErrorHandler } from '../helpers/errorHandler';
import { insertRating, insertRatingAverage, getRatings, getUserRatings } from '../queries/ratingQueries';
import { RatingInformation } from "./interface/rating-information.interface";

/**
 * Save rating information for the educational material and recount rating averages.
 *
 * @param req  Request<any>
 * @param res  Response<any>
 * @param next NextFunction
 */
export async function addRating(req: Request, res: Response, next: NextFunction): Promise<any> {
    try {
        const ratingInformation: RatingInformation = {
            educationalMaterialId: req.body.materialId,
            ratingContent: req.body.ratingContent,
            ratingVisual: req.body.ratingVisual,
            feedbackPositive: req.body.feedbackPositive,
            feedbackSuggest: req.body.feedbackSuggest,
            feedbackPurpose: req.body.feedbackPurpose
        };
        await insertRating(ratingInformation, req.session.passport.user.uid);
        res.status(200).json({'status': ratingInformation});
        await insertRatingAverage(req.body.materialId);
    } catch (error) {
        console.error(error);
        next(new ErrorHandler(500, 'Issue adding rating'));
    }
}

/**
 * Get educational material ratings.
 *
 * @param req  Request<any>
 * @param res  Response<any>
 * @param next NextFunction
 */
export async function getRating(req: Request, res: Response, next: NextFunction): Promise<any> {
    try {
        const response = await getRatings(req.params.materialId);
        if (!response.averages) {
            next(new ErrorHandler(404, 'No rating found'));
        } else {
            res.status(200).json(response);
        }
    } catch (error) {
        console.error(error);
        next(new ErrorHandler(500, 'Issue getting rating'));
    }
}

/**
 * Get educational material ratings for a user.
 *
 * @param req  Request<any>
 * @param res  Response<any>
 * @param next NextFunction
 */
export async function getUserRating(req: Request, res: Response, next: NextFunction): Promise<any> {
    try {
        const response = await getUserRatings(req.session.passport.user.uid, req.params.materialId);
        if (!response.materialId) {
            next(new ErrorHandler(404, 'No rating found'));
        } else {
            res.status(200).json(response);
        }
    } catch (error) {
        console.error(error);
        next(new ErrorHandler(500, 'Issue getting user rating'));
    }
}

export default {
    addRating,
    getRating,
    getUserRating
};
