const express=require('express');
const mongoose=require('mongoose');
const bodyParser=require('body-parser');
const cors=require('cors');
const itemRoutes=require('./routes/productoRoutes')

const app=express();
const PORT=3000;

//Midleware
app.use(bodyParser.json());
app.use(cors());

//conexion a mongo

mongoose.connect('mongodb://localhost:27017/miapp'),({
    useNewUrlParser:true,
    useUnifiedTopologt:true,
})
.then(()=>console.log("MongoDB Conectado"))
.catch(err=>console.err(err))

//Rutas

app.use('api/items',itemsRoutes);

app.listen(PORT,()=>{
    console.log(`Servidor conectado en http://localhost:${PORT}`);
});


