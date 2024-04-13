// models/score.js

'use strict';
const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class Score extends Model {
    static associate(models) {
      Score.belongsTo(models.User, { foreignKey: 'user_id' });
      Score.belongsTo(models.Subject, { foreignKey: 'subject_id' });
    }
  }

  Score.init({
    score_id: {
      type: DataTypes.STRING,
      primaryKey: true
    },
    score_gk: DataTypes.FLOAT,
    score_ck: DataTypes.FLOAT,
    score_qt: DataTypes.FLOAT,
    semester: DataTypes.STRING,
    user_id: DataTypes.STRING,
    subject_id: DataTypes.STRING
  }, {
    sequelize,
    modelName: 'Score',
    timestamps: false
  });

  return Score;
};
