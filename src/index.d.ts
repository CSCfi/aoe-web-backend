
export {};

// fix passport type script issue caused by express-session 1.17.1
declare module "express-session" {
         interface SessionData {
            passport?: Passport;
         }
         // tslint:disable-next-line:no-empty-interface
        interface Passport {
            user: User;
        }

        interface User {
            uid: string;
        }
     }