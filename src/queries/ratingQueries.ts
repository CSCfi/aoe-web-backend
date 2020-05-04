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
        const ratings: Array<RatingResponse> = [];
        const data = await db.task(async (t: any) => {
            let query;
            console.log("RatingQueries getRatings: " + query, [materialId]);
            query = "SELECT ratingcontentaverage, ratingvisualaverage from educationalmaterial where id = $1 and obsoleted = 0;";
            const averages = await t.oneOrNone(query, [materialId]);
            if (!averages) {
                return {};
            }
            query = "SELECT count(*) FROM rating where educationalmaterialid = $1;";
            const ratingsCount = await t.oneOrNone(query, [materialId]);
            query = "select materialname, language from materialname where educationalmaterialid = $1;";
            const name = await t.any(query, [materialId]);
            query = "SELECT educationalmaterialid, ratingcontent, ratingvisual, feedbackpositive, feedbacksuggest, feedbackpurpose, updatedat, firstname, lastname FROM rating inner join users on rating.usersusername = users.username where educationalmaterialid = $1";
            const ratings = await t.any(query, [materialId]);
            return {ratingsCount, averages, name, ratings}; // (response);
        });
        if (!data.averages) {
            return {};
        }
        for (const element of data.ratings) {
            ratings.push({"materialId" : element.educationalmaterialid,
            "ratingContent": element.ratingcontent,
            "ratingVisual": element.ratingvisual,
            "feedbackPositive": element.feedbackpositive,
            "feedbackSuggest": element.feedbacksuggest,
            "feedbackPurpose": element.feedbackpurpose,
            "updatedAt": element.updatedat,
            "firstName": element.firstname,
            "lastName": element.lastname});
        }
        const name = data.name.reduce(function(map, obj) {
            map[obj.language] = obj.materialname;
            return map;
        }, {});
        return {"ratingsCount" : data.ratingsCount.count,
        "averages": (!data.averages) ? undefined : {"content": data.averages.ratingcontentaverage, "visual": data.averages.ratingvisualaverage},
        "name": name,
        ratings};
    }
    catch (err) {
        console.log(err);
        throw new Error(err);
    }
}

export async function getUserRatings(username: string, materialId: string) {
    try {
        const data = await db.task(async (t: any) => {
            const query = "SELECT educationalmaterialid, ratingcontent, ratingvisual, feedbackpositive, feedbacksuggest, feedbackpurpose, updatedat from rating where usersusername = $1 and educationalmaterialid = $2;";
            console.log(query, [username, materialId]);
            const ratings = await t.oneOrNone(query, [username, materialId]);
            return {ratings};
        });
        if (!data.ratings) {
            return {};
        }
        else {
            return {
                "materialId": materialId,
                "ratingContent": data.ratings.ratingcontent,
                "ratingVisual": data.ratings.ratingvisual,
                "feedbackPositive": data.ratings.feedbackpositive,
                "feedbackSuggest": data.ratings.feedbacksuggest,
                "feedbackPurpose": data.ratings.feedbackpurpose,
                "updatedAt": data.ratings.updatedat
            };
        }
    }
    catch (err) {
        console.error(err);
        throw new Error(err);
    }
}