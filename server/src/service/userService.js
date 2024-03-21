//src/service/userService.js
import bcrypt from 'bcryptjs';
import mysql from  'mysql2/promise';
const salt = bcrypt.genSaltSync(10);
import db from '../models';

const hashUserPassword = (userPassword) => {
    let hashPassword = bcrypt.hashSync(userPassword, salt);
    return hashPassword;
}
 const createNewUser = async(userId, password, username) => {
        let hashPass = hashUserPassword(password);
       await db.User.create(
            {
                userId: userId,
                password: hashPass,
                username: username
            }
        )
       
 }
 const getUserList = async() => {

    let users = [];
    users = await db.User.findAll();
    return users;
    



 }
 const deleteUser = async(userId) => {

    await db.User.destroy({
        where: {
          userId:userId
        }
      })
  
 }
 const getUserById = async(userId) => {

    let user = {};
   user = await db.User.findOne({ where: { userId: userId } });
    return user.get({plain : true});

 }
 const updateUserInfor = async( username, userId) => {
    await db.User.update(
      { username:username }, 
      {
        where: {userId: userId }
      }
      );
    
 }
module.exports = {
    createNewUser, getUserList, deleteUser, updateUserInfor, getUserById
 }