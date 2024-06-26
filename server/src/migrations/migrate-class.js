// migrations/create-class.js

'use strict';
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('Class', {
      class_id: {
        allowNull: false,
        primaryKey: true,
        type: Sequelize.STRING
      },
      class_name: {
        type: Sequelize.STRING
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
    await queryInterface.dropTable('Class');
  }
};
