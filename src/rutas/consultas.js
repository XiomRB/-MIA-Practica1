const { createQuery } = require("../conexion")

var c1 = `SELECT p.nombre AS PROVEEDOR, p.telefono AS TELEFONO, a.id AS ORDEN, SUM(da.subtotal) AS TOTAL 
FROM Proveedor AS p, Adquisicion AS a, DetalleAdquisicion AS da 
WHERE da.adquisicion = a.id AND p.id = a.proveedor 
GROUP BY a.id, p.nombre, p.telefono ORDER BY total DESC LIMIT 1;`

var c2 = `SELECT c.id AS ID, c.nombre AS NOMBRE, SUM(dv.cantidad) AS NO_PRODUCTOS, SUM(subtotal) AS TOTAL FROM DetalleVenta AS dv, Venta AS v, Cliente c
WHERE v.id = dv.venta AND c.id = v.cliente
GROUP BY v.cliente ORDER BY SUM(cantidad) DESC LIMIT 1;`

var c3 = `(SELECT cl.direccion AS DIRECCION, r.nombre AS REGION, ci.nombre AS CIUDAD, cl.postal AS COD_POSTAL, COUNT(v.id) AS NO_COMPRAS
FROM DetalleVenta AS dv, Venta v, Cliente cl, Region  AS r, Ciudad AS ci, CodigoPostal AS pos
WHERE v.id = dv.venta AND cl.id = v.cliente AND cl.postal = pos.id AND ci.id = pos.ciudad AND ci.region = r.id
GROUP BY cl.direccion,r.nombre,ci.nombre, cl.postal ORDER BY COUNT(v.id) DESC LIMIT 1)
UNION
(SELECT cl.direccion AS DIRECCION, r.nombre AS REGION, ci.nombre AS CIUDAD, cl.postal AS COD_POSTAL, COUNT(v.id) AS NO_COMPRAS
FROM DetalleVenta AS dv, Venta v, Cliente cl, Region  AS r, Ciudad AS ci, CodigoPostal AS pos
WHERE v.id = dv.venta AND cl.id = v.cliente AND cl.postal = pos.id AND ci.id = pos.ciudad AND ci.region = r.id
GROUP BY cl.direccion,r.nombre,ci.nombre, cl.postal ORDER BY COUNT(v.id) ASC LIMIT 1);`

var c4 = `SELECT v.cliente AS ID, cl.nombre AS CLIENTE, COUNT(v.id) AS NO_COMPRAS, SUM(dv.subtotal) AS TOTAL 
FROM DetalleVenta AS dv, Venta v, Producto AS p, Categoria AS c, Cliente cl
WHERE p.id = dv.producto AND c.id = p.categoria AND v.id = dv.venta AND c.nombre LIKE 'Cheese' AND cl.id = v.cliente
GROUP BY v.cliente,cl.nombre ORDER BY SUM(dv.cantidad) DESC LIMIT 5;`

var c5 = `(SELECT MONTH(c.fecha_reg) AS MES, c.nombre AS CLIENTE, SUM(dv.subtotal) AS TOTAL 
FROM Cliente AS c, Venta AS v, DetalleVenta AS dv 
WHERE dv.venta = v.id AND c.id = v.cliente 
GROUP BY c.fecha_reg, c.nombre ORDER BY SUM(dv.subtotal) DESC LIMIT 5) 
UNION 
(SELECT MONTH(c.fecha_reg) AS MES, c.nombre AS CLIENTE, SUM(dv.subtotal) AS TOTAL 
FROM Cliente AS c, Venta AS v, DetalleVenta AS dv 
WHERE dv.venta = v.id AND c.id = v.cliente 
GROUP BY c.fecha_reg, c.nombre ORDER BY SUM(dv.subtotal) ASC LIMIT 5);`

var c6 = `(SELECT c.nombre AS CATEGORIA, SUM(dv.subtotal) AS TOTAL 
FROM Categoria AS c, DetalleVenta AS dv, Venta AS v, Producto AS p
WHERE dv.venta = v.id  AND p.id = dv.producto AND p.categoria = c.id
GROUP BY c.nombre ORDER BY SUM(dv.subtotal) DESC LIMIT 1)
UNION
(SELECT c.nombre AS CATEGORIA, SUM(dv.subtotal) AS TOTAL 
FROM Categoria AS c, DetalleVenta AS dv, Venta AS v, Producto AS p
WHERE dv.venta = v.id  AND p.id = dv.producto AND p.categoria = c.id
GROUP BY c.nombre ORDER BY SUM(dv.subtotal) ASC LIMIT 1);`

var c7 = `SELECT p.id, p.nombre, SUM(da.subtotal) AS Total
FROM Proveedor AS p, DetalleAdquisicion AS da, Adquisicion AS a, Producto AS pr, Categoria AS c
WHERE p.id = a.proveedor AND a.id = da.adquisicion AND pr.id = da.producto AND c.id = pr.categoria AND c.nombre LIKE 'Fresh Vegetables'
GROUP BY p.id, p.nombre ORDER BY SUM(da.subtotal) DESC LIMIT 5;`

var c8 = `(SELECT cl.nombre AS CLIENTE, cl.direccion AS DIRECCION, r.nombre AS REGION, ci.nombre As CIUDAD, cl.postal AS COD_POSTAL, SUM(dv.subtotal) AS TOTAL 
FROM DetalleVenta AS dv, Venta v, Cliente cl, Region  AS r, Ciudad AS ci, CodigoPostal AS pos
WHERE v.id = dv.venta AND cl.id = v.cliente AND cl.postal = pos.id AND ci.id = pos.ciudad AND ci.region = r.id
GROUP BY cl.nombre, cl.direccion,r.nombre,ci.nombre, cl.postal ORDER BY SUM(dv.subtotal) DESC LIMIT 5)
UNION
(SELECT cl.nombre AS CLIENTE, cl.direccion AS DIRECCION, r.nombre AS REGION, ci.nombre As CIUDAD, cl.postal AS COD_POSTAL, SUM(dv.subtotal) AS TOTAL 
FROM DetalleVenta AS dv, Venta v, Cliente cl, Region  AS r, Ciudad AS ci, CodigoPostal AS pos
WHERE v.id = dv.venta AND cl.id = v.cliente AND cl.postal = pos.id AND ci.id = pos.ciudad AND ci.region = r.id
GROUP BY cl.nombre, cl.direccion,r.nombre,ci.nombre, cl.postal ORDER BY SUM(dv.subtotal) ASC LIMIT 5);`

var c9 = `SELECT p.nombre AS PROVEEDOR, p.telefono AS TELEFONO, a.id AS ORDEN,SUM(da.cantidad), SUM(da.subtotal) AS TOTAL
FROM Proveedor AS p, Adquisicion AS a, DetalleAdquisicion AS da
WHERE p.id = a.proveedor AND da.adquisicion = a.id 
 GROUP BY p.nombre, p.telefono, a.id ORDER BY SUM(da.cantidad), SUM(da.subtotal),p.nombre ASC LIMIT 1`

 var c10 = `SELECT c.nombre AS CLIENTE, SUM(dv.cantidad) AS NO_PRODUCTOS FROM Cliente AS c, DetalleVenta AS dv, Venta AS v, Producto AS p, Categoria AS cat
 WHERE c.id = v.cliente AND dv.venta = v.id AND p.id = dv.producto AND cat.id = p.categoria AND cat.nombre LIKE'Seafood' 
 GROUP BY c.nombre ORDER BY SUM(dv.cantidad) DESC LIMIT 10`

 exports.c1 = c1
 exports.c2 = c2
 exports.c3 = c3
 exports.c4 = c4
 exports.c5 = c5
 exports.c6 = c6
 exports.c7 = c7
 exports.c8 = c8
 exports.c9 = c9
 exports.c10 = c10