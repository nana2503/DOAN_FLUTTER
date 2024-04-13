// models/user.js

'use strict';
const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class User extends Model {
    static associate(models) {
      User.hasOne(models.Student, { foreignKey: 'user_id' });
      User.hasOne(models.Lecturer, { foreignKey: 'user_id' });
      User.hasOne(models.Admin, { foreignKey: 'user_id' });
      User.hasMany(models.Permission, { foreignKey: 'user_id' });
    }
  }

  User.init({
    user_id: {
      type: DataTypes.STRING,
      primaryKey: true
    },
    user_name: DataTypes.STRING,
    password: DataTypes.STRING,
    email: DataTypes.STRING,
    phone: DataTypes.STRING,
    address: DataTypes.STRING,
    gender: DataTypes.STRING,
    user_type: DataTypes.STRING
  }, {
    sequelize,
    modelName: 'User',
    timestamps: false
  });

  return User;
};
