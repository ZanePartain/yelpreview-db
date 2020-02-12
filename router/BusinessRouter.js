import express from 'express';
// import { userController } from '../controllers/userController';
import { db } from '../db/index';

/**
* A class representing all user routes
*/
class BusinessRouter {
    constructor(){
        this.router = express.Router();
        this.loadRoutes();
    }


    loadRoutes() {
        console.log('loading business routes...');


        this.router.get('/business', (req, resp) => {
            console.log('Business Route Hit.');
            db.any('SELECT * FROM business', [true])
            .then( res => console.log(res))
            .catch( err => console.log(err));
        });
    }
}

export const businessRouter = new BusinessRouter().router;
