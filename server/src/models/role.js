// models/role.js

'use strict';
const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class Role extends Model {
    static associate(models) {
      Role.hasMany(models.User, { foreignKey: 'role_id' });
      Role.hasMany(models.Permission, { foreignKey: 'role_id' });
    }
  }

  Role.init({
    role_id: {
      type: DataTypes.STRING,
      primaryKey: true
    },
    role_name: DataTypes.STRING
  }, {
    sequelize,
    modelName: 'Role',
    timestamps: false
  });

  return Role;
};
