// migrations/create-role.js

'use strict';
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('Role', {
      role_id: {
        allowNull: false,
        primaryKey: true,
        type: Sequelize.STRING
      },
      role_name: {
        type: Sequelize.STRING
      }
    });
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('Role');
  }
};
