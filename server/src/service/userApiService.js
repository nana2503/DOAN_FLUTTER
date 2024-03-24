//src/service/userApiService.js
import db from "../models";
import { checkUserIdExist,checkPhoneExist,hashUserPassword} from "../service/loginRegisterService";
import bcrypt from 'bcryptjs';
const salt = bcrypt.genSaltSync(10);
const getAllUser = async () => {
    try {
        const users = await db.User.findAll({
          
            attributes: ["userId", "username", "address", "phone", "sex", "classId"],
            include: { model: db.Class, attributes: ["className"] },
        });
        console.log( users);
        if (users) {
            return {
                EM: 'get data success',
                EC: 0,
                DT: users
            }
        } else {
            return {
                EM: 'get data success',
                EC: 0,
                DT: []
            }
        }
    } catch (e) {
        console.log(e)
        return {
            EM: 'error from server',
            EC: 1,
            DT: []
        }
    }
};


const getUserWithPagination = async (page, limit) => {
    try {
        let offset = (page - 1) * limit;
        const { count, rows } = await db.User.findAndCountAll({
       
            offset: offset,
            limit: limit,
            attributes: ["userId", "username", "address", "phone", "sex", "classId"],
            include: { model: db.Class, attributes: ["className"] },
            order: [['userId', 'DESC']]
        });
        
        let totalPages = Math.ceil(count / limit);
        let data = {
            totalRows: count,
            totalPages: totalPages,
            users: rows
        };

        return {
            EM: 'fetch ok',
            EC: 0,
            DT: data
        };
    } catch (error) {
        console.log(error);
        return {
            EM: 'error from server',
            EC: 1,
            DT: []
        };
    }
};


const createNewUser=async(data)=>{
    try {
let isUserIdExist = await checkUserIdExist(data.userId);
if(isUserIdExist===true) {
    return{
        EM : 'MSSV already exist',
        EC : 1,
        DT :'userId'
    }
}
let isPhoneExist = await checkPhoneExist(data.phone);
if(isPhoneExist===true) {
    return{
        EM : 'The phone number already exist',
        EC : 1,
        DT :'phone'
    }
    
}
//hash user password
let hashPassword = hashUserPassword(data.password);
    //create new user
        await db.User.create({...data, password: hashPassword});
        return {
            EM : 'create ok',
            EC: 0,
            DT:[]
        
        }
    } catch (error) {
        console.log(error)
        return {
            EM : 'something wrong with service',
            EC: 1,
            DT:[]
        
        }
    }
}
const updateUser = async (data) => {
    let transaction;
    try {
        // Bắt đầu một transaction
        transaction = await db.sequelize.transaction();

        // Cập nhật dữ liệu cho bảng User
        const updatedUser = await db.User.update(
            { username: data.username, address: data.address, sex: data.sex },
            { where: { userId: data.userId }, transaction }
        );

        // Kiểm tra xem dữ liệu User đã được cập nhật thành công hay không
        if (updatedUser[0] === 0) {
            throw new Error('User not found');
        }

        // Cập nhật dữ liệu cho bảng Class
        const updatedClass = await db.Class.update(
            { className: data.classname },
            { where: { userId: data.userId }, transaction }
        );

        // Kiểm tra xem dữ liệu Class đã được cập nhật thành công hay không
        if (updatedClass[0] === 0) {
            throw new Error('Class update failed');
        }

        // Commit transaction nếu tất cả các bước đều thành công
        await transaction.commit();

        return {
            EM: 'Update user and class success',
            EC: 0,
            DT: { updatedUser, updatedClass }
        };
    } catch (error) {
        // Nếu có bất kỳ lỗi nào xảy ra, rollback transaction
        if (transaction) await transaction.rollback();
        
        console.error(error);
        return {
            EM: 'Error updating user and class',
            EC: 1,
            DT: []
        };
    }
};

const deleteUser=async(userId)=>{
    try {
        let user = await db.User.findOne({
            where : {userId : userId }
        })
        if(user){
            await user.destroy();
            return {
                EM : 'delete student success',
                EC: 0,
                DT: []
            
            }
        }
        else{
            return {
                EM : ' student not exist',
                EC: 2,
                DT: []
            
            }
        }
    } catch (error) {
        console.log(e)
        return {
            EM : 'get data success',
            EC: 1,
            DT:[]
        
        }
    }
}

module.exports={
    getAllUser,createNewUser,updateUser,deleteUser,getUserWithPagination
}