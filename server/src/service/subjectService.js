import db from "../models";

const getSubject = async () => {
    try {
        const data = await db.Subject.findAll();
        return {
            EM: 'Get Subject success',
            EC: 0,
            DT: data
        };
    } catch (error) {
        console.log(error);
        return {
            EM: 'Error fetching Subject',
            EC: 1,
            DT: []
        };
    }
};

const createNewSubject = async (subjectId,subjectName) => {
    try {
        const newSubject = await db.Subject.create(subjectId,subjectName);
        return {
            EM: 'Create Subject success',
            EC: 0,
            DT: newSubject
        };
    } catch (error) {
        console.log(error);
        return {
            EM: 'Error creating Subject',
            EC: 1,
            DT: []
        };
    }
};
//api updateSubject
const updateSubject = async (data) => {
    try {
        const updatedSubject = await db.Subject.update(
            { subjectName: data.subjectName }, // Dữ liệu cập nhật
            { where: { subjectId: data.subjectId }});
        
        return {
            EM: 'Update Subject success',
            EC: 0,
            DT: updatedSubject
        };
    } catch (error) {
        console.log(error);
        return {
            EM: 'Error updating Subject',
            EC: 1,
            DT: []
        };
    }
};

const deleteSubject = async (subjectId) => {
    try {
        const deletedSubject = await db.Subject.destroy({
            where: { subjectId }
        });
        return {
            EM: 'Delete Subject success',
            EC: 0,
            DT: deletedSubject
        };
    } catch (error) {
        console.log(error);
        return {
            EM: 'Error deleting Subject',
            EC: 1,
            DT: []
        };
    }
};


module.exports = {
    getSubject,
    createNewSubject,
    updateSubject,
    deleteSubject
};
