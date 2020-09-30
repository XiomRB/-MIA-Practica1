
var cargaMasiva = `LOAD DATA LOCAL INFILE '/home/gabriela/Documentos/DataCenterData.csv'
INTO TABLE carga
CHARACTER SET latin1
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(nombre_compania,contacto_compania,correo_compania,telefono_compania,tipo,nombre,correo,telefono,@varfecha,direccion,ciudad,codigo_postal,region,producto,categoria_producto,cantidad,precio_unitario)
SET fecha_registro = STR_TO_DATE (@varfecha,'%d/%m/%Y');

INSERT INTO Categoria (nombre)
SELECT DISTINCT categoria_producto FROM carga;

INSERT INTO Producto (nombre,precio,categoria)
SELECT DISTINCT carga.producto,carga.precio_unitario,Categoria.id FROM carga, Categoria
WHERE Categoria.nombre = carga.categoria_producto;

INSERT INTO Empresa (nombre,correo,telefono,contacto)
SELECT DISTINCT nombre_compania, correo_compania, telefono_compania, contacto_compania FROM carga;

INSERT INTO Region (nombre)
SELECT DISTINCT region FROM carga;

INSERT INTO Ciudad (nombre, region)
SELECT DISTINCT carga.ciudad, Region.id FROM carga,Region
WHERE Region.nombre = carga.region;

INSERT INTO CodigoPostal (id, ciudad)
SELECT DISTINCT carga.codigo_postal, Ciudad.id FROM carga,Ciudad
WHERE Ciudad.nombre = carga.ciudad;

INSERT INTO Cliente (nombre, correo, telefono, direccion, fecha_reg, postal)
SELECT DISTINCT c.nombre, c.correo, c.telefono, c.direccion, c.fecha_registro, c.codigo_postal FROM carga AS c, Ciudad AS city
WHERE city.nombre = c.ciudad AND c.tipo = 'C' ;

INSERT INTO Proveedor (nombre, correo, telefono, direccion, fecha_reg, postal)
SELECT DISTINCT c.nombre, c.correo, c.telefono, c.direccion, c.fecha_registro, c.codigo_postal FROM carga AS c, Ciudad AS city
WHERE city.nombre = c.ciudad AND c.tipo = 'P';

INSERT INTO Venta(cliente, empresa)
SELECT DISTINCT c.id, e.id FROM Cliente AS c, Empresa AS e, carga AS ca 
WHERE ca.nombre = c.nombre AND e.nombre = ca.nombre_compania GROUP BY c.nombre, e.nombre;

INSERT INTO Adquisicion (proveedor, empresa)
SELECT DISTINCT p.id, e.id FROM Proveedor AS p, Empresa AS e, carga AS ca 
WHERE ca.nombre = p.nombre AND e.nombre = ca.nombre_compania GROUP BY p.nombre, e.nombre;

INSERT INTO DetalleVenta (venta,producto,cantidad,subtotal)
SELECT v.id, p.id, SUM(c.cantidad), SUM(c.cantidad)*p.precio FROM Venta AS v, carga AS c, Producto AS p, Cliente AS cl, Empresa AS e
WHERE c.producto = p.nombre AND cl.nombre = c.nombre AND v.cliente = cl.id AND e.nombre = c.nombre_compania AND e.id = v.empresa
GROUP BY v.id, p.id;

INSERT INTO DetalleAdquisicion (adquisicion, producto, cantidad,subtotal)
SELECT a.id, p.id, SUM(c.cantidad),SUM(c.cantidad)*p.precio FROM Adquisicion AS a, carga AS c, Producto AS p, Proveedor AS pr, Empresa AS e
WHERE c.producto = p.nombre AND pr.nombre = c.nombre AND a.proveedor = pr.id AND e.nombre = c.nombre_compania AND e.id = a.empresa
GROUP BY a.id, p.id;`

var borrarTemp = 'DROP TEMPORARY TABLE carga'

exports.borrarTemp = borrarTemp
exports.cargaMasiva = cargaMasiva