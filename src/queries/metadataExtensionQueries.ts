const connection = require("./../db");
const pgp = connection.pgp;
const db = connection.db;
import { MetadataExtension } from "./../metadataExtension/metadataExtension";

export async function insertMetadataExtension(id: string, username: string, metadata: MetadataExtension) {
    try {
        await db.tx(async (t: any) => {
            let query;
            let response;
            const queries = [];
            console.log("starting insertMetadataExtension");
            query = "DELETE FROM accessibilityfeatureextension where educationalmaterialid = $1 and usersusername = $2;";
            response  = await t.none(query, [id, username]);
            queries.push(response);

            query = "DELETE FROM accessibilityhazardextension where educationalmaterialid = $1 and usersusername = $2;";
            response  = await t.none(query, [id, username]);
            queries.push(response);

            query = "DELETE FROM educationallevelextension where educationalmaterialid = $1 and usersusername = $2;";
            response  = await t.none(query, [id, username]);
            queries.push(response);

            query = "DELETE FROM keywordextension where educationalmaterialid = $1 and usersusername = $2;";
            response  = await t.none(query, [id, username]);
            queries.push(response);

            if (metadata.accessibilityFeatures) {
                query = "INSERT INTO accessibilityfeatureextension (value, accessibilityfeaturekey, educationalmaterialid, usersusername) values ($1, $2, $3, $4) ON CONFLICT ON CONSTRAINT constraint_AccessibilityFeatureExtension DO NOTHING;";
                for (const element of metadata.accessibilityFeatures) {
                    response  = await t.none(query, [element.value, element.key, id, username]);
                    queries.push(response);
                }
            }
            if (metadata.keywords) {
                query = "INSERT INTO keywordextension (value, keywordkey, educationalmaterialid, usersusername) values ($1, $2, $3, $4) ON CONFLICT ON CONSTRAINT constraint_KeyWordExtension DO NOTHING;";
                for (const element of metadata.keywords) {
                    response  = await t.none(query, [element.value, element.key, id, username]);
                    queries.push(response);
                }
            }
            if (metadata.accessibilityHazards) {
                query = "INSERT INTO accessibilityhazardextension (value, accessibilityhazardkey, educationalmaterialid, usersusername) values ($1, $2, $3, $4) ON CONFLICT ON CONSTRAINT constraint_AccessibilityHazardExtension DO NOTHING";
                for (const element of metadata.accessibilityHazards) {
                    response  = await t.none(query, [element.value, element.key, id, username]);
                    queries.push(response);
                }
            }
            if (metadata.educationalLevels) {
                query = "INSERT INTO educationallevelextension (value, educationallevelkey, educationalmaterialid, usersusername) values ($1, $2, $3, $4) ON CONFLICT ON CONSTRAINT constraint_EducationalLevelExtension DO NOTHING";
                for (const element of metadata.educationalLevels) {
                    response  = await t.none(query, [element.value, element.key, id, username]);
                    queries.push(response);
                }
            }
            return t.batch(queries);
        });
    }
    catch (error) {
        throw new Error(error);
    }
}

export async function metadataExtension(id: string) {
    try {
        const data = await db.task(async (t: any) => {
            let query = "SELECT value, keywordkey as key FROM keywordextension WHERE educationalmaterialid = $1;";
            const keywords = await db.any(query, [ id ]);
            query = "SELECT value, accessibilityhazardkey as key FROM accessibilityhazardextension WHERE educationalmaterialid = $1;";
            const accessibilityHazards = await db.any(query, [ id ]);
            query = "SELECT value, accessibilityfeaturekey as key FROM accessibilityfeatureextension WHERE educationalmaterialid = $1;";
            const accessibilityFeatures = await db.any(query, [ id ]);
            query = "SELECT value, educationallevelkey as key FROM educationallevelextension WHERE educationalmaterialid = $1;";
            const educationalLevels = await db.any(query, [ id ]);
            return {keywords, accessibilityHazards, accessibilityFeatures, educationalLevels};
        });
        return data;
    }
    catch (error) {
        throw new Error(error);
    }
}

export async function usersMetadataExtension(id: string, user: string) {
    try {
        const data = await db.task(async (t: any) => {
            let query = "SELECT value, keywordkey as key FROM keywordextension WHERE educationalmaterialid = $1 and usersusername = $2;";
            const keywords = await db.any(query, [ id, user ]);
            query = "SELECT value, accessibilityhazardkey as key FROM accessibilityhazardextension WHERE educationalmaterialid = $1 and usersusername = $2;";
            const accessibilityHazards = await db.any(query, [ id, user ]);
            query = "SELECT value, accessibilityfeaturekey as key FROM accessibilityfeatureextension WHERE educationalmaterialid = $1 and usersusername = $2;";
            const accessibilityFeatures = await db.any(query, [ id, user ]);
            query = "SELECT value, educationallevelkey as key FROM educationallevelextension WHERE educationalmaterialid = $1 and usersusername = $2;";
            const educationalLevels = await db.any(query, [ id, user ]);
            return {keywords, accessibilityHazards, accessibilityFeatures, educationalLevels};
        });
        return data;
    }
    catch (error) {
        throw new Error(error);
    }
}