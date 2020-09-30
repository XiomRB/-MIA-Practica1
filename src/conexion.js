const mysql = require('mysql')

const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'MIA_practica1',
    multipleStatements: 'true'
});

connection.connect(function(error){
    if(!!error) console.log('Error al conectar')
    else console.log('Conectado a MIA_practica1')
})

module.exports = connection