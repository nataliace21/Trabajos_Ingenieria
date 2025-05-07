const mongoose=require('mongoose');


const itemSchemas=new mongoose.Schema({
    nombre:{type:String,require:true},
    descripcion:String,
    creadoEn:{type:Date,default:Date.now}
});

module.exports=mongoose.model('item',itemSchemas)