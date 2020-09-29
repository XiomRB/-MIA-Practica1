const express = require('express');
const router = express.Router()

const connection = require('../conexion')
const carga = require('./cargaDatos')

router.get('/cargarTemporal', (req,res) => {
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

router.get('/eliminarTemporal', (req,res) => {
    connection.query(carga.borrarTemp, (err,result) =>{
        if(!err) res.send('Tabla temporal borrada con exito')
        else {
            console.log(err)
            res.send('La tabla no existe')
        }
    })

})

router.get('/cargarModelo', (req,res) => {

})

router.get('/eliminarModelo', (req,res) => {

})

router.get('/consulta1', (req,res) => {

})

router.get('/consulta2', (req,res) => {

})

router.get('/consulta3', (req,res) => {

})

router.get('/consulta4', (req,res) => {

})

router.get('/consulta5', (req,res) => {

})

router.get('/consulta6', (req,res) => {

})

router.get('/consulta7', (req,res) => {

})

router.get('/consulta8', (req,res) => {

})

router.get('/consulta9', (req,res) => {

})

router.get('/consulta10', (req,res) => {

})

module.exports = router