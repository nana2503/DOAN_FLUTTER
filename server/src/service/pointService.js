import db from "../models";
    // try {
        //     const subject = await db.Subject.findAll({
        // });
        // const point = await db.Point.findAll({
        // });
        // const data ={subject,point};
        //   console.log("check subject",points)
const getPoint = async () => {
    try {
        const points = await db.Point.findAll({
            // include: [
            //     { model: db.Subject}
            // ]
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

const updatePoint = async (id, data) => {
    try {
        const updatedPoint = await db.Point.update(data, {
            where: { id }
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
    deletePoint
};
