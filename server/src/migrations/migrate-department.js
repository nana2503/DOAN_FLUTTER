// migrations/create-department.js

'use strict';
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('Department', {
      department_id: {
        allowNull: false,
        primaryKey: true,
        type: Sequelize.STRING
      },
      department_name: {
        type: Sequelize.STRING
      }
    });
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('Department');
  }
};
