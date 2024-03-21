import db from "../models";
import { checkUserIdExist,checkPhoneExist,hashUserPassword} from "../service/loginRegisterService";
import bcrypt from 'bcryptjs';
const salt = bcrypt.genSaltSync(10);
const getAllUser=async()=>{
    try {
        const users = await db.User.findAll({
            attributes: ["userId", "username", "address", "phone", "sex","classId"],
            include: {model: db.Class, attributes: ["className"]  },
        });
        console.log("check", users);
        if(users) {
            //let data = user.get({plain :true});
            return {
                EM : 'get data success',
                EC: 0,
                DT:users
            
            }
        }
        else {
            return {
                EM : 'get data success',
                EC: 0,
                DT:[]
            
            }
      
}
}catch(e){
    console.log(e)
    return {
        EM : 'error from server',
        EC: 1,
        DT:[]
    
    }
}
}

const getUserWithPagination= async(page, limit)=>{
    try {
        let offset=(page-1)*limit;
        const {count, rows}= await db.User.findAndCountAll({
            offset: offset,
            limit: limit,
            attributes : ["userId", "username", "address", "phone", "sex","classId"],
            include: {model: db.Class, attributes: ["className"]  },
            order:[['userId','DESC']]
        })
        let totalPages=Math.ceil(count / limit);
        let data ={
            totalRows:count,
            totalPages:totalPages,
            users:rows
        }
        return {
            EM : 'fetch ok',
            EC: 0,
            DT: data
        
        }
    } catch (error) {
        console.log(e)
        return {
            EM : 'get data success',
            EC: 0,
            DT:[]
        
        }
    }
}

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
const updateUser=async(data)=>{
    try {
        if(!data.classId){
             return {
            EM : 'error with empty MSSV',
            EC: 1,
            DT:'class'
        
            } 
        }
          let user = await db.User.findOne({
            where : {userId : data.userId }
        })
        if(user){
            await user.update({
                username: data.username,
                address : data.address,
                sex     : data.sex,
                classId : data.classId
            })
             return {
            EM : 'update student success',
            EC: 0,
            DT:''
            } 
        }else{
            return {
            EM: 'student not found',
            EC: 2,
            DT:''
        
        } 
        }
    } catch (error) {
        console.log(e)
        return {
            EM : 'something wrong with service',
            EC: 1,
            DT:[]
        
        } 
    }
}
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