const express = require('express');
const router = express.Router()

const connection = require('../conexion')
const carga = require('./cargaDatos')
const modelo = require('./creacionTablas')
const consulta = require('./consultas')

router.get('/cargarTemporal', (req,res) => {
    connection.query(carga.cargaMasiva, (err,result) =>{
        if(!err) {
            console.log(result[0])
            console.log(result[1])
            console.log(result[2])
            console.log(result[3])
            console.log(result[4])
            console.log(result[5])
            console.log(result[6])
            console.log(result[7])
            console.log(result[8])
            console.log(result[9])
            console.log(result[10])
            console.log(result[11])
            console.log(result[12])
            res.send('Datos cargados con exito')
            
        }else {
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
    connection.query(modelo.crearModelo, (err,result) =>{
        if(!err){
            console.log(result[0])
            console.log(result[1])
            console.log(result[2])
            console.log(result[3])
            console.log(result[4])
            console.log(result[5])
            console.log(result[6])
            console.log(result[7])
            console.log(result[8])
            console.log(result[9])
            console.log(result[10])
            console.log(result[11])
            console.log(result[12])
            res.send('Modelo creado')
        } else {
            console.log(err)
            res.send('Hubo un error al crear el Modelo, verifique....')
        }
    })
})

router.get('/eliminarModelo', (req,res) => {
    connection.query(modelo.borrarModelo, (err,result) =>{
        if(!err) res.send('Modelo eliminado')
        else {
            console.log(err)
            res.send('Hubo un error al eliminar el Modelo, verifique....')
        }
    })
})

router.get('/consulta1', (req,res) => {
    connection.query(consulta.c1, (err,rows,fields) =>{
        if(!err) res.json(rows)
        else {
            console.log(err)
            res.send('Error al realizar la consulta...')
        }
    })
})

router.get('/consulta2', (req,res) => {
    connection.query(consulta.c2, (err,rows,fields) =>{
        if(!err) res.json(rows)
        else {
            console.log(err)
            res.send('Error al realizar la consulta...')
        }
    })
})

router.get('/consulta3', (req,res) => {
    connection.query(consulta.c3, (err,rows,fields) =>{
        if(!err) res.json(rows)
        else {
            console.log(err)
            res.send('Error al realizar la consulta...')
        }
    })
})

router.get('/consulta4', (req,res) => {
    connection.query(consulta.c4, (err,rows,fields) =>{
        if(!err) res.json(rows)
        else {
            console.log(err)
            res.send('Error al realizar la consulta...')
        }
    })
})

router.get('/consulta5', (req,res) => {
    connection.query(consulta.c5, (err,rows,fields) =>{
        if(!err) res.json(rows)
        else {
            console.log(err)
            res.send('Error al realizar la consulta...')
        }
    })
})

router.get('/consulta6', (req,res) => {
    connection.query(consulta.c6, (err,rows,fields) =>{
        if(!err) res.json(rows)
        else {
            console.log(err)
            res.send('Error al realizar la consulta...')
        }
    })
})

router.get('/consulta7', (req,res) => {
    connection.query(consulta.c7, (err,rows,fields) =>{
        if(!err) res.json(rows)
        else {
            console.log(err)
            res.send('Error al realizar la consulta...')
        }
    })
})

router.get('/consulta8', (req,res) => {
    connection.query(consulta.c8, (err,rows,fields) =>{
        if(!err) res.json(rows)
        else {
            console.log(err)
            res.send('Error al realizar la consulta...')
        }
    })
})

router.get('/consulta9', (req,res) => {
    connection.query(consulta.c9, (err,rows,fields) =>{
        if(!err) res.json(rows)
        else {
            console.log(err)
            res.send('Error al realizar la consulta...')
        }
    })
})

router.get('/consulta10', (req,res) => {
    connection.query(consulta.c10, (err,rows,fields) =>{
        if(!err) res.json(rows)
        else {
            console.log(err)
            res.send('Error al realizar la consulta...')
        }
    })
})

module.exports = router