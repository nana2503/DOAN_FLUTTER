// models/lecturer.js

'use strict';
const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class Lecturer extends Model {
    static associate(models) {
      Lecturer.belongsTo(models.User, { foreignKey: 'user_id' });
      Lecturer.belongsTo(models.Department, { foreignKey: 'department_id' });
    }
  }

  Lecturer.init({
    lecturer_id: {
      type: DataTypes.STRING,
      primaryKey: true
    },
    user_id: DataTypes.STRING,
    department_id: DataTypes.STRING
  }, {
    sequelize,
    modelName: 'Lecturer',
    timestamps: false
  });

  return Lecturer;
};
