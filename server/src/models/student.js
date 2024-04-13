// models/student.js

'use strict';
const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class Student extends Model {
    static associate(models) {
      Student.belongsTo(models.User, { foreignKey: 'user_id' });
      Student.belongsTo(models.Class, { foreignKey: 'class_id' });
    }
  }

  Student.init({
    student_id: {
      type: DataTypes.STRING,
      primaryKey: true
    },
    user_id: DataTypes.STRING,
    class_id: DataTypes.STRING
  }, {
    sequelize,
    modelName: 'Student',
    timestamps: false
  });

  return Student;
};
