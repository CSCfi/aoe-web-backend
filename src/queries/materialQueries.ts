const connection = require("./../db");
const pgp = connection.pgp;
const db = connection.db;

export async function updateEducationalMaterial(emid: string) {
    try {
        const id = await db.tx(async (t: any) => {
            let query;
            query = "UPDATE educationalmaterial SET obsoleted = 1 WHERE id = $1;";
            console.log("materialQueries removeEducationalMaterial: " + query, [emid]);
            await t.none(query, [emid]);
            query = "UPDATE material SET obsoleted = 1 WHERE educationalmaterialid = $1 returning id;";
            console.log("materialQueries removeEducationalMaterial: " + query, [emid]);
            const id = await t.any(query, [emid]);
            return {id};
        });
        return id;
    }
    catch (error) {
        throw new Error (error);
    }
}

export async function changeEducationalMaterialUser(emid: string, id: string) {
    try {
        let query;
        return await db.tx(async (t: any) => {
            query = "Select username from users where id = $1;";
            const username = await t.oneOrNone(query, [id]);
            console.log(username);
            if (!username || !username.username) {
                return false;
            }
            else {
                query = "UPDATE educationalmaterial SET usersusername = $1 where id = $2;";
                console.log("changeEducationalMaterialOwner: " + query, [username.username, emid]);
                await t.none(query, [username.username, emid]);
                return true;
            }
        });
    }
    catch (error) {
        throw new Error (error);
    }
}

export async function getUsers() {
    try {
      const query = "select id, firstname, lastname from users;";
      return await db.any(query);
    }
    catch (error) {
        throw new Error(error);
    }
  }