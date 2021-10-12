import connection from '../resources/pg-config.module';

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
            console.log("Materials set obsoleted: " + JSON.stringify(id));
            query = "UPDATE attachment set obsoleted = 1 WHERE materialid = $1 returning id;";
            for (const element of id) {
                console.log("materialQueries removeEducationalMaterial: " + query, [element.id]);
                const attachmentid = await t.any(query, [element.id]);
                console.log("set obsoleted attachments: " + JSON.stringify(attachmentid));
            }
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
      const query = "select id, firstname, lastname, email from users;";
      return await db.any(query);
    }
    catch (error) {
        throw new Error(error);
    }
  }

  export async function getOwnerName(materialid: string) {
    try {
        const query = "select firstname, lastname from educationalmaterial as em join users on em.usersusername = users.username where em.id = $1;";
        return await db.oneOrNone(query, [materialid]);
      }
      catch (error) {
          throw new Error(error);
      }
  }

  export async function getMaterialName(materialid: string) {
    try {
        const query = "select materialname, language from materialname where educationalmaterialid = $1";
        return await db.any(query, [materialid]);
      }
      catch (error) {
          throw new Error(error);
      }
  }
