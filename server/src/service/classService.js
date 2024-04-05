import db from "../models";
const checkClassNameExist = async (className) => {
  let classname = await db.Class.findOne({
    where: { 
      className: className },
  });

  if (classname) {
    return true;
  }
  return false;
};
const getClass = async () => {
  try {
    const classes = await db.Class.findAll();
    return {
      EM: "Get classes success",
      EC: 0,
      DT: classes,
    };
  } catch (error) {
    console.log(error);
    return {
      EM: "Error fetching classes",
      EC: 1,
      DT: [],
    };
  }
};

const createNewClass = async (data) => {
  try {
    console.log("classanme", data)
    let isClassNameExist = await checkClassNameExist(data.className);
    console.log("first",isClassNameExist)
    if(isClassNameExist===true) {
        return{
            EM : 'Môn học này đã tồn tại',
            EC : 2,
            DT :[]
        }
    }
    const newClass = await db.Class.create(data);
    return {
      EM: "Create class success",
      EC: 0,
      DT: newClass,
    };
  } catch (error) {
    console.log(error);
    return {
      EM: "Error creating class",
      EC: 1,
      DT: [],
    };
  }
};

const updateClass = async (id, data) => {
  try {
    const updatedClass = await db.Class.update(data, {
      where: { id },
    });
    return {
      EM: "Update class success",
      EC: 0,
      DT: updatedClass,
    };
  } catch (error) {
    console.log(error);
    return {
      EM: "Error updating class",
      EC: 1,
      DT: [],
    };
  }
};

const deleteClass = async (id) => {
  try {
    const deletedClass = await db.Class.destroy({
      where: { id },
    });
    return {
      EM: "Delete class success",
      EC: 0,
      DT: deletedClass,
    };
  } catch (error) {
    console.log(error);
    return {
      EM: "Error deleting class",
      EC: 1,
      DT: [],
    };
  }
};
const countStudentInClass = async () => {
  
  try {
    const classes = await db.Class.findAll({
      attributes: {exclude: ['createdAt', 'updatedAt']},
      include: {
        model: db.User,
        attributes: [
          "userId",
          "username",
          "address",
          "sex",
          "phone",
          "classId",
        ],
      },
    });
    return {
      EM: "Get classes success",
      EC: 0,
      DT: classes,
    };
  } catch (error) {
    console.log(error);
    return {
      EM: "Error fetching classes",
      EC: 1,
      DT: [],
    };
  }
};
module.exports = {
  getClass,
  createNewClass,
  updateClass,
  deleteClass,
  countStudentInClass,
};
