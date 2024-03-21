import db from "../models";
const Sequelize = require('sequelize');
const getPoint = async()=>{
try { 
    const subject = await db.Subject.findAll({
     });
     const point = await db.Point.findAll({
     });
     const data ={subject,point};
      console.log("check subject",data)
    return {
        EM : 'get point success',
        EC: 0,
        DT: data
    
    }
} catch (error) {
    console.log(error)
    return {
        EM : 'get data success',
        EC: 1,
        DT:[]
    
    }
}
}
module.exports={
    getPoint
}