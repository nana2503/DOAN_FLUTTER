import db from "../models";

const getSubject = async(req,res)=>{
try {
    let data=await db.Subject.findAll({
    });
    return {
        EM : 'get Subject success',
        EC: 0,
        DT: data
    
    }
} catch (error) {
    console.log(exports)
    return {
        EM : 'get Subject success',
        EC: 1,
        DT:[]
    
    } 
}
}
module.exports={
    getSubject
}