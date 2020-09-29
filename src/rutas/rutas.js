const express = require('express');
const router = express.Router()

const connection = require('../conexion')
const carga = require('./cargaDatos')

router.get('/cargarTemporal',(req,res)=>{
    connection.query(carga.tablatemp, (err,result) =>{
        if(!err) console.log('Tabla temporal creada')
        else {
            console.log(err)
        }
    })
    connection.query(carga.cargaMasiva, (err,result) =>{
        if(!err) res.send('Datos cargados con exito')
        else {
            console.log(err)
            res.send('Error al cargar los datos')
        }
    })
})

router.get('/eliminarTemporal',(req,res)=>{
    connection.query(carga.borrarTemp, (err,result) =>{
        if(!err) res.send('Tabla temporal borrada con exito')
        else {
            console.log(err)
            res.send('La tabla no existe')
        }
    })

})



module.exports = router