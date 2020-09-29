const express = require('express');
const app = express();

// Configuracion del servidor 
app.set('port',process.env.PORT || 9090);


//Middlewares ---- Procesos que se ejecutan antes de que lleguen a las rutas
app.use(express.json()); //body parser

//Rutas
app.use(require('./rutas/rutas'))

//Iniciando servidor
app.listen(app.get('port'),()=>{
    console.log('Server on port ', app.get('port'))
})

