import { user, password, database, port, host } from '../config';
import UserRepository from './repos/users';
import BusinessRepository from './repos/business';
import CategoryRepository from './repos/category';
const pgPromise = require('pg-promise');

const initOptions = {
    extend(obj, dc) {
        obj.users = new UserRepository(obj,pgp);
        obj.business = new BusinessRepository(obj,pgp);
        obj.category = new CategoryRepository(obj, pgp);
    }
}

const config = {
    user: user,
    host: host,
    database: database,
    password: password,
    port: port,
};

export const pgp = pgPromise(initOptions);
export const db = pgp(config);