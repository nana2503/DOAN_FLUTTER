import express from "express";
import homeController from '../controller/homeController';
import apiController from '../controller/apiController';
import userController from '../controller/userController';
import classController from '../controller/classController';
import pointController from '../controller/pointController';
import subjectController from '../controller/subjectController'
import {checkUserJWT,checkUserPermission} from '../middleware/JWTAction';

const router = express.Router();

/**
 * 
 * @param {*} app express app
 * 
 */


const initApiRoutes = (app) => {
 


//rest api
router.all('*',checkUserJWT,checkUserPermission);

router.post("/register",apiController.handleRegister);
router.post("/logout",apiController.handleLogout);
router.post("/login",apiController.handleLogin);
router.get("/account", userController.getUserAccount);

router.get("/user/read", userController.readFunc);
router.post("/user/create", userController.createFunc);
router.put("/user/update", userController.updateFunc);
router.delete("/user/delete", userController.deleteFunc);

router.get("/class/read", classController.readFunc);
router.get("/point/read", pointController.readFunc);
//router.get("/subject/read", subjectController.readFunc);
    return app.use("/api/v1/", router);
}
export default initApiRoutes;