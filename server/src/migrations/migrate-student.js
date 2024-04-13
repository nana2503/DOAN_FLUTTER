// migrations/create-student.js

'use strict';
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('Student', {
      student_id: {
        allowNull: false,
        primaryKey: true,
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
      class_id: {
        type: Sequelize.STRING,
        allowNull: false,
        references: {
          model: 'Class',
          key: 'class_id'
        }
      }
    });
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('Student');
  }
};
