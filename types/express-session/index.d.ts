export {};

/**
 * Declare TypeScript types and relations between imported JavaScript modules that are not covered by installed @types
 * packages. Declaration file assists TypeScript interpreter to validate e.g. chains like req.session.passport.userH5P
 * which consists of Request<any> [express], Session & Partial<SessionData> [express-session], Passport [passport] and
 * User [express], each from a different 3rd party JS source library.
 *
 * The directory of custom TypeScript declaration files must be added into "typeRoots" of tsconfig.json file and naming
 * conventions must follow [@]types/<module-name>/index.d.ts. It is also possible to place a single index.d.ts file in
 * the root of project's source tree like src/index.d.ts to declare custom types.
 *
 * For more information see https://www.typescriptlang.org/docs/handbook/declaration-files/introduction.html
 */
declare module 'express-session' {
  interface SessionData {
    passport: Passport;
  }

  interface Passport {
    user: User;
  }

  interface User {
    uid: string;
  }
}
