import db from "../models";

const getClass = async(req,res)=>{
try {
    let data=await db.Class.findAll({
    });
    return {
        EM : 'get class success',
        EC: 0,
        DT: data
    
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
    getClass
}