import { Rating } from "./../rating/rating";
const connection = require("./../db");
const pgp = connection.pgp;
const db = connection.db;
const TransactionMode = pgp.txMode.TransactionMode;
const isolationLevel = pgp.txMode.isolationLevel;

// Create a reusable transaction mode (serializable + read-only + deferrable):
const mode = new TransactionMode({
    tiLevel: isolationLevel.serializable,
    readOnly: true,
    deferrable: true
});

interface RatingResponse {
        "materialId": string;
        "ratingContent": number;
        "ratingVisual": number;
        "feedbackPositive": string;
        "feedbackSuggest": string;
        "feedbackPurpose": string;
        "updatedAt": string;
        "firstName": string;
        "lastName": string;
}
export async function insertRating(rating: Rating, username: string) {
    try {
        await db.tx(async (t: any) => {
            const queries: any = [];
            let query;
            query = "INSERT INTO rating (ratingcontent, ratingvisual, feedbackpositive, feedbacksuggest, feedbackpurpose, educationalmaterialid, usersusername, updatedat) VALUES ($1,$2,$3,$4,$5,$6,$7,now()) ON CONFLICT (educationalmaterialid, usersusername) DO " +
            "UPDATE SET ratingcontent = $1, ratingvisual = $2, feedbackpositive = $3, feedbacksuggest = $4, feedbackpurpose = $5, updatedat = now();";
            console.log("RatingQueries insertRating: " + query, [rating.ratingContent, rating.ratingVisual, rating.feedbackPositive, rating.feedbackSuggest, rating.feedbackPurpose, rating.materialId, username]);
            const response = await t.none(query, [rating.ratingContent, rating.ratingVisual, rating.feedbackPositive, rating.feedbackSuggest, rating.feedbackPurpose, rating.materialId, username]);
            queries.push(response);
            return t.batch(queries);
        });
    }
    catch (err) {
        console.log(err);
        throw new Error(err);
    }
}

export async function insertRatingAverage(id: string) {
    try {
        await db.tx(async (t: any) => {
            const queries: any = [];
            let query;
            query = "update educationalmaterial set ratingcontentaverage = (select avg(ratingcontent) from rating where educationalmaterialid = $1), ratingvisualaverage = (select avg(ratingvisual) from rating where educationalmaterialid = $1) where id = $1;";
            console.log("RatingQueries insertRatingAverage: " + query, [id]);
            const response = await t.none(query, [id]);
            queries.push(response);
            return t.batch(queries);
        });
    }
    catch (err) {
        console.log(err);
        throw new Error(err);
    }
}

export async function getRatings(materialId: string) {
    try {
        const ratingList: Array<RatingResponse> = [];
        const data = await db.task(async (t: any) => {
            let query;
            query = "SELECT educationalmaterialid, ratingcontent, ratingvisual, feedbackpositive, feedbacksuggest, feedbackpurpose, updatedat, firstname, lastname FROM rating inner join users on rating.usersusername = users.username where educationalmaterialid = $1";
            console.log("RatingQueries getRatings: " + query, [materialId]);
            const response = await t.any(query, [materialId]);
            return t.batch(response);
        });
        for (const element of data) {
            ratingList.push({"materialId" : element.educationalmaterialid,
            "ratingContent": element.ratingcontent,
            "ratingVisual": element.ratingvisual,
            "feedbackPositive": element.feedbackpositive,
            "feedbackSuggest": element.feedbacksuggest,
            "feedbackPurpose": element.feedbackpurpose,
            "updatedAt": element.updatedat,
            "firstName": element.firstname,
            "lastName": element.lastname});
        }
        return ratingList;
    }
    catch (err) {
        console.log(err);
        throw new Error(err);
    }
}