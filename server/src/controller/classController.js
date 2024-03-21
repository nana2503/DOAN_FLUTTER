
import classService from '../service/classService';
const readFunc = async(req, res)=>{
try {
    let data=await classService.getClass();

    return res.status(200).json({
        EM : data.EM,
        EC: data.EC,
        DT: data.DT

    })
    
} catch (error) {
    console.log(e);
    return res.status(500).json({
        EM : 'error from server',
        EC: '-1',
        DT:''
})
}
}
module.exports={
    readFunc
}