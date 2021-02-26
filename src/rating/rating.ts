import { Request, Response, NextFunction } from "express";
import { ErrorHandler } from "./../helpers/errorHandler";
const { check, validationResult } = require("express-validator");
import { insertRating, insertRatingAverage, getRatings, getUserRatings } from "./../queries/ratingQueries";
interface RateRequestBody {
    "materialId": string;
    "ratingContent": number;
    "ratingVisual": number;
    "feedbackPositive": string;
    "feedbackSuggest": string;
    "feedbackPurpose": string;
}

export class Rating {
  constructor(public materialId: string, public ratingContent: number, public ratingVisual: number, public feedbackPositive: string, public feedbackSuggest: string, public feedbackPurpose: string) {}
}
/**
 *
 * @param req
 * @param res
 * @param next
 * add rating to educational material
 */
export async function addRating(req: Request , res: Response, next: NextFunction) {
    try {
      const rating = new Rating(req.body.materialId, req.body.ratingContent, req.body.ratingVisual, req.body.feedbackPositive, req.body.feedbackSuggest, req.body.feedbackPurpose);
      await insertRating(rating, req.session.passport.user.uid);
      res.status(200).json({"status": rating});
      insertRatingAverage(req.body.materialId);
    }
    catch (error) {
      console.error(error);
      next(new ErrorHandler(500, "Issue adding rating"));
    }
}
/**
 *
 * @param req
 * @param res
 * @param next
 * get educational material ratings
 */
export async function getRating(req: Request, res: Response, next: NextFunction) {
  try {
    const response = await getRatings(req.params.materialId);
    if (!response.averages) {
      next(new ErrorHandler(404, "No rating found"));
    }
    else {
      res.status(200).json(response);
    }
  }
  catch (error) {
    console.error(error);
    next(new ErrorHandler(500, "Issue getting rating"));
  }
}
/**
 *
 * @param req
 * @param res
 * @param next
 * get educational material ratings for a user
 */
export async function getUserRating(req: Request, res: Response, next: NextFunction) {
  try {
    const response = await getUserRatings(req.session.passport.user.uid, req.params.materialId);
    if (!response.materialId) {
      next(new ErrorHandler(404, "No rating found"));
    } else {
      res.status(200).json(response);
    }
  }
  catch (error) {
    console.error(error);
    next(new ErrorHandler(500, "Issue getting user rating"));
  }
}
export async function addRatingToDatabase(rating: Rating) {

}