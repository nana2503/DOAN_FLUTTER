// models/subject.js

'use strict';
const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class Subject extends Model {
    static associate(models) {
      Subject.belongsTo(models.Department, { foreignKey: 'department_id' });
    }
  }

  Subject.init({
    subject_id: {
      type: DataTypes.STRING,
      primaryKey: true
    },
    subject_name: DataTypes.STRING,
    department_id: DataTypes.STRING,
    credits: DataTypes.INTEGER
  }, {
    sequelize,
    modelName: 'Subject',
    timestamps: false
  });

  return Subject;
};
