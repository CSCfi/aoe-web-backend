import { Request, Response, NextFunction } from "express";
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
export async function addRating(req: Request , res: Response) {
    try {
      const rating = new Rating(req.body.materialId, req.body.ratingContent, req.body.ratingVisual, req.body.feedbackPositive, req.body.feedbackSuggest, req.body.feedbackPurpose);
      await insertRating(rating, req.session.passport.user.uid);
      res.status(200).json({"status": rating});
      insertRatingAverage(req.body.materialId);
    }
    catch (error) {
      console.error(error);
      res.status(500).json({"error": "something went wrong"});
    }
}

export async function getRating(req: Request, res: Response) {
  try {
    const response = await getRatings(req.params.materialId);
    console.log(response);
    if (!response.averages) {
      res.sendStatus(404);
    }
    else {
      res.status(200).json(response);
    }
  }
  catch (error) {
    console.error(error);
    res.status(500).json({"error": "something went wrong"});
  }
}

export async function getUserRating(req: Request, res: Response) {
  try {
    const response = await getUserRatings(req.session.passport.user.uid, req.params.materialId);
    if (!response.materialId) {
      res.sendStatus(404);
    } else {
      res.status(200).json(response);
    }
  }
  catch (error) {
    console.error(error);
    res.status(500).json({"error": "error in getting users ratings"});
  }
}
export async function addRatingToDatabase(rating: Rating) {

}