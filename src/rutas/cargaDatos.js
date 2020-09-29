
var tablatemp = `CREATE TEMPORARY TABLE carga(
    nombre_compania VARCHAR(50),
    contacto_compania VARCHAR(50),
    correo_compania VARCHAR(50),
    telefono_compania VARCHAR(15),
    tipo CHAR,
    nombre VARCHAR(50),
    correo VARCHAR(50),
    telefono VARCHAR(50),
    fecha_registro DATE,
    direccion VARCHAR(50),
    ciudad VARCHAR(50),
    codigo_postal INT,
    region VARCHAR(50),
    producto VARCHAR(50),
    categoria_producto VARCHAR(50),
    cantidad INT,
    precio_unitario DOUBLE
);`

var cargaMasiva = `LOAD DATA LOCAL INFILE '/home/gabriela/Documentos/DataCenterData.csv'
INTO TABLE carga
CHARACTER SET latin1
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(nombre_compania,contacto_compania,correo_compania,telefono_compania,tipo,nombre,correo,telefono,@varfecha,direccion,ciudad,codigo_postal,region,producto,categoria_producto,cantidad,precio_unitario)
SET fecha_registro = STR_TO_DATE (@varfecha,'%d/%m/%Y');`

var borrarTemp = 'DROP TABLE carga'

exports.borrarTemp = borrarTemp
exports.cargaMasiva = cargaMasiva
exports.tablatemp = tablatemp