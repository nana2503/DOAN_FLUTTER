// models/class.js

'use strict';
const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class Class extends Model {
    static associate(models) {
      Class.hasMany(models.Student, { foreignKey: 'class_id' });
    }
  }

  Class.init({
    class_id: {
      type: DataTypes.STRING,
      primaryKey: true
    },
    class_name: DataTypes.STRING,
    department_id: DataTypes.STRING
  }, {
    sequelize,
    modelName: 'Class',
    timestamps: false
  });

  return Class;
};
