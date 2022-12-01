import { Router, Response, Request } from 'express';

/**
 * API root status page
 */
export default (router: Router): void => {

    router.get('/', (req: Request, res: Response) => {
        res.render('index', {appTitle: 'AOE Web Service', appStatus: true});
    })
}
