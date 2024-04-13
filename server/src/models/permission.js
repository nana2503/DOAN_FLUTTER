// models/permission.js

'use strict';
const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class Permission extends Model {
    static associate(models) {
      Permission.belongsTo(models.User, { foreignKey: 'user_id' });
      Permission.belongsTo(models.Role, { foreignKey: 'role_id' });
    }
  }

  Permission.init({
    permission_id: {
      type: DataTypes.STRING,
      primaryKey: true
    },
    role_id: DataTypes.STRING,
    user_id: DataTypes.STRING
  }, {
    sequelize,
    modelName: 'Permission',
    timestamps: false
  });

  return Permission;
};
