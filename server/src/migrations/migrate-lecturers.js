// migrations/create-lecturer.js

'use strict';
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('Lecturer', {
      lecturer_id: {
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
      department_id: {
        type: Sequelize.STRING,
        allowNull: false,
        references: {
          model: 'Department',
          key: 'department_id'
        }
      }
    });
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('Lecturer');
  }
};
