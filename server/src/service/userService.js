//src/service/userService.js
import bcrypt from "bcryptjs";
import mysql from "mysql2/promise";
const salt = bcrypt.genSaltSync(10);
import db from "../models";

const hashUserPassword = (userPassword) => {
  let hashPassword = bcrypt.hashSync(userPassword, salt);
  return hashPassword;
};
const createNewUser = async (userId, password, username) => {
  let hashPass = hashUserPassword(password);
  await db.User.create({
    userId: userId,
    password: hashPass,
    username: username,
  });
};
const getUserList = async () => {
  let users = [];
  users = await db.User.findAll();
  return users;
};
const deleteUser = async (userId) => {
  await db.User.destroy({
    where: {
      userId: userId,
    },
  });
};
module.exports = {
  createNewUser,
  getUserList,
  deleteUser,
  updateUserInfor,
};
