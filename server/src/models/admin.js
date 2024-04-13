// models/admin.js

'use strict';
const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class Admin extends Model {
    static associate(models) {
      Admin.belongsTo(models.User, { foreignKey: 'user_id' });
    }
  }

  Admin.init({
    admin_id: {
      type: DataTypes.STRING,
      primaryKey: true
    },
    user_id: DataTypes.STRING
  }, {
    sequelize,
    modelName: 'Admin',
    timestamps: false
  });

  return Admin;
};
