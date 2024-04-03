
//src/service/userApiService.js
import { where } from "sequelize";
import db from "../models";
import { checkUserIdExist,checkPhoneExist,hashUserPassword} from "../service/loginRegisterService";
import bcrypt from 'bcryptjs';
const salt = bcrypt.genSaltSync(10);
const getOneUser = async (userId) => {
    try {
        let user = await db.User.findOne({
            where : {userId : userId },
            attributes: ['userId', 'username', 'address', 'sex', 'phone', 'classId'],
            include: {model: db.Class, attributes: ['className']}
        })
        if(user){
            return {
                EM : 'Get one user success',
                EC: 0,
                DT: user
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
const getAllUser = async () => {
    try {
        const users = await db.User.findAll({
          
            attributes: ["userId", "username", "address", "phone", "sex", "classId"],
            include: { model: db.Class, attributes: ["className"] },
        });
        // console.log( users);
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
    console.log( "update1",data);
    let transaction;
    try {
        // Bắt đầu một transaction
        transaction = await db.sequelize.transaction();

        // Tìm thông tin lớp học trong database
        let classInfo = await db.Class.findOne({ where: { className: data.className }, transaction });

        // Nếu không tìm thấy thông tin lớp học, thêm lớp học mới vào database
        if (!classInfo) {
            classInfo = await db.Class.create({ className: data.className }, { transaction });
        }

        // Cập nhật dữ liệu cho bảng User
        const updatedUser = await db.User.update(
            { 
                username: data.username, 
                address: data.address, 
                sex: data.sex,
                classId: classInfo.id // Sử dụng id của lớp học đã tìm hoặc tạo ra
            },
            { where: { userId: data.userId }, transaction }
        );

        // Kiểm tra xem dữ liệu User đã được cập nhật thành công hay không
        if (updatedUser[0] === 0) {
            throw new Error('User not found');
        }

        // Commit transaction nếu tất cả các bước đều thành công
        await transaction.commit();
        return {
            EM: 'Cập nhật thông tin của sinh viên thành công !!!',
            EC: 0,
            DT: updatedUser
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
                EM : 'Xóa sinh viên thành công',
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
const getListUserFromClass = async () => {
    try {
        let userCount = await db.User.findAll({
            attributes: ['userId', 'username', 'address', 'sex', 'phone', 'classId'],
            include: {model: db.Class, attributes: ['className']}
        }); 
        let count = userCount.length;
        if (count > 0) {
            return {
                EM: 'Get list user from class success',
                EC: 0,
                DT: {
                    userInClass: userCount,
                    count: count
                }
            };
        } else {
            return {
                EM: 'No user found in the class',
                EC: 0,
                DT: { }
            };
        }
    } catch (e) {
        return {
            EM: 'Error from get list student in class',
            EC: 1,
            DT: []
        };
    }
};

module.exports={
    getAllUser,createNewUser,updateUser,deleteUser,getUserWithPagination, getOneUser,getListUserFromClass
}