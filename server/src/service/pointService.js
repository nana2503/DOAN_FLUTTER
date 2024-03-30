import db from "../models";
const checkSubjectIdExist = async (data) => {
    let subject = await db.Point.findOne({
      where: { 
        subjectId: data.subjectId ,
        hocky:data.hocky,
        userId:data.userId},
    });
  
    if (subject) {
      return true;
    }
    return false;
  };
const getPoint = async () => {
    try {
        const points = await db.Point.findAll({
        });
    
        return {
            EM: 'Get points success',
            EC: 0,
            DT: points
        };
    } catch (error) {
        console.log(error);
        return {
            EM: 'Error fetching points',
            EC: 1,
            DT: []
        };
    }
};

const createNewPoint = async (data) => {
     try {
        let isSubjectIdExist = await checkSubjectIdExist(data);
        console.log("first",isSubjectIdExist)
        if(isSubjectIdExist===true) {
            return{
                EM : 'Mã môn học đã tồn tại',
                EC : 2,
                DT :[]
            }
        }
        const newPoint = await db.Point.create(data);
        return {
            EM: 'Create point success',
            EC: 0,
            DT: newPoint
        };
    } catch (error) {
        console.log(error);
        return {
            EM: 'Error creating point',
            EC: 1,
            DT: []
        };
    }
};
// api updatePoint
const updatePoint = async (data) => {
    try {
        const updatedPoint = await db.Point.update({point: data.point}, {
            where: {subjectId: data.subjectId}
        });
        return {
            EM: 'Update point success',
            EC: 0,
            DT: updatedPoint
        };
    } catch (error) {
        console.log(error);
        return {
            EM: 'Error updating point',
            EC: 1,
            DT: []
        };
    }
};

const deletePoint = async (id) => {
    try {
        const deletedPoint = await db.Point.destroy({
            where: { id }
        });
        return {
            EM: 'Delete point success',
            EC: 0,
            DT: deletedPoint
        };
    } catch (error) {
        console.log(error);
        return {
            EM: 'Error deleting point',
            EC: 1,
            DT: []
        };
    }
};

module.exports = {
    getPoint,
    createNewPoint,
    updatePoint,
    deletePoint,
    checkSubjectIdExist
};
