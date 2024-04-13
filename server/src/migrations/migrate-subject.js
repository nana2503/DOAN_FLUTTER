// migrations/create-subject.js

'use strict';
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('Subject', {
      subject_id: {
        allowNull: false,
        primaryKey: true,
        type: Sequelize.STRING
      },
      subject_name: {
        type: Sequelize.STRING
      },
      department_id: {
        type: Sequelize.STRING,
        allowNull: false,
        references: {
          model: 'Department',
          key: 'department_id'
        }
      },
      credits: {
        type: Sequelize.INTEGER
      }
    });
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('Subject');
  }
};
