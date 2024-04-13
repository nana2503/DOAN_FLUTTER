// migrations/create-score.js

'use strict';
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('Score', {
      score_id: {
        allowNull: false,
        primaryKey: true,
        type: Sequelize.STRING
      },
      score_gk: {
        type: Sequelize.FLOAT
      },
      score_ck: {
        type: Sequelize.FLOAT
      },
      score_qt: {
        type: Sequelize.FLOAT
      },
      semester: {
        type: Sequelize.STRING
      },
      user_id: {
        type: Sequelize.STRING,
        allowNull: false,
        references: {
          model: 'User',
          key: 'user_id'
        }
      },
      subject_id: {
        type: Sequelize.STRING,
        allowNull: false,
        references: {
          model: 'Subject',
          key: 'subject_id'
        }
      }
    });
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('Score');
  }
};
