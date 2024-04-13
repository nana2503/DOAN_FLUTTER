// models/department.js

'use strict';
const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class Department extends Model {
    static associate(models) {
      Department.hasMany(models.Lecturer, { foreignKey: 'department_id' });
      Department.hasMany(models.Class, { foreignKey: 'department_id' });
      Department.hasMany(models.Subject, { foreignKey: 'department_id' });
    }
  }

  Department.init({
    department_id: {
      type: DataTypes.STRING,
      primaryKey: true
    },
    department_name: DataTypes.STRING
  }, {
    sequelize,
    modelName: 'Department',
    timestamps: false
  });

  return Department;
};
