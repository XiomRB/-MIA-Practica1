const express = require('express');
const app = express();
const mysql = require('mysql');

// Configuracion del servidor 
app.set('port',process.env.PORT || 9090);


//Middlewares ---- Procesos que se ejecutan antes de que lleguen a las rutas
app.use(express.json()); //body parser

//Rutas
app.get('/',function(req,res){
    connection.query(`CREATE TABLE Categoria(
    id int NOT NULL AUTO_INCREMENT,
    nombre varchar(50) NOT NULL,
    CONSTRAINT Categoria_pk PRIMARY KEY (id);
    );`,(err,result) =>{
        if (!err) console.log('Hecho')
        else console.log(err)
    })
    res.send('Listo')
})

//Iniciando servidor
app.listen(app.get('port'),()=>{
    console.log('Server on port ', app.get('port'))
})

//conexion
var connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'MIA_practica1'
});

connection.connect(function(error){
    if(!!error) console.log('Error al conectar')
    else console.log('Conectado')
})