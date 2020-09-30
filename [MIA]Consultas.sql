----------------------------CONSULTA 1------------------------------- Kiona Trevino 	284 	16933.250000000004
---------------Mostrar el nombre del proveedor, número de teléfono, número de orden,
---------------total de la orden por la cual se haya pagado la mayor cantidad de dinero.
SELECT p.nombre, p.telefono, a.id, SUM(da.subtotal) AS total 
FROM Proveedor AS p, Adquisicion AS a, DetalleAdquisicion AS da 
WHERE da.adquisicion = a.id AND p.id = a.proveedor 
GROUP BY a.id, p.nombre, p.telefono ORDER BY total DESC LIMIT 1;


----------------------------CONSULTA2----------------------------- Allistair Mcguire 	47110.22
----Mostrar el número de cliente, nombre, apellido y total del cliente que más
----productos ha comprado.
SELECT c.id, c.nombre, SUM(dv.cantidad), SUM(subtotal) FROM DetalleVenta AS dv, Venta AS v, Cliente c
WHERE v.id = dv.venta AND c.id = v.cliente
GROUP BY v.cliente ORDER BY SUM(cantidad) DESC LIMIT 1;


----------------------------CONSULTA3------------------------------
----Mostrar la dirección, región, ciudad y código postal hacia la cual se han hecho
---más solicitudes de pedidos y a cuál menos (en una sola consulta).
(SELECT cl.direccion, r.nombre, ci.nombre, cl.postal, COUNT(v.id) AS No_Compras 
FROM DetalleVenta AS dv, Venta v, Cliente cl, Region  AS r, Ciudad AS ci, CodigoPostal AS pos
WHERE v.id = dv.venta AND cl.id = v.cliente AND cl.postal = pos.id AND ci.id = pos.ciudad AND ci.region = r.id
GROUP BY cl.direccion,r.nombre,ci.nombre, cl.postal ORDER BY COUNT(v.id) DESC LIMIT 5)
UNION
(SELECT cl.direccion, r.nombre, ci.nombre, cl.postal, COUNT(v.id) AS No_Compras 
FROM DetalleVenta AS dv, Venta v, Cliente cl, Region  AS r, Ciudad AS ci, CodigoPostal AS pos
WHERE v.id = dv.venta AND cl.id = v.cliente AND cl.postal = pos.id AND ci.id = pos.ciudad AND ci.region = r.id
GROUP BY cl.direccion,r.nombre,ci.nombre, cl.postal ORDER BY COUNT(v.id) ASC LIMIT 5);


----------------------------CONSULTA4-------------------------------
---Mostrar el número de cliente, nombre, apellido, el número de órdenes que ha
--realizado y el total de cada uno de los cinco clientes que más han comprado
--productos de la categoría ‘Cheese’.
SELECT v.cliente, cl.nombre, COUNT(v.id) AS No_Compras, SUM(dv.subtotal) AS Total FROM DetalleVenta AS dv, Venta v, Producto AS p, Categoria AS c, Cliente cl
WHERE p.id = dv.producto AND c.id = p.categoria AND v.id = dv.venta AND c.nombre LIKE 'Cheese' AND cl.id = v.cliente
GROUP BY v.cliente,cl.nombre ORDER BY SUM(dv.cantidad) DESC LIMIT 5;


-----------------------------CONSULTA5-----------------------------
----Mostrar el número de mes de la fecha de registro, nombre y apellido de todos
----los clientes que más han comprado y los que menos han comprado (en
----dinero) utilizando una sola consulta.
(SELECT MONTH(c.fecha_reg), c.nombre, SUM(dv.subtotal) AS Total 
FROM Cliente AS c, Venta AS v, DetalleVenta AS dv 
WHERE dv.venta = v.id AND c.id = v.cliente 
GROUP BY c.fecha_reg, c.nombre ORDER BY SUM(dv.subtotal) DESC LIMIT 5) 
UNION 
(SELECT MONTH(c.fecha_reg), c.nombre, SUM(dv.subtotal) AS Total 
FROM Cliente AS c, Venta AS v, DetalleVenta AS dv 
WHERE dv.venta = v.id AND c.id = v.cliente 
GROUP BY c.fecha_reg, c.nombre ORDER BY SUM(dv.subtotal) ASC LIMIT 5);


--------------CONSULTA6-------------------
--Mostrar el nombre de la categoría más y menos vendida y el total vendido en
--dinero (en una sola consulta).
(SELECT c.nombre, SUM(dv.subtotal) AS Total 
FROM Categoria AS c, DetalleVenta AS dv, Venta AS v, Producto AS p
WHERE dv.venta = v.id  AND p.id = dv.producto AND p.categoria = c.id
GROUP BY c.nombre ORDER BY SUM(dv.subtotal) DESC LIMIT 5)
UNION
(SELECT c.nombre, SUM(dv.subtotal) AS Total 
FROM Categoria AS c, DetalleVenta AS dv, Venta AS v, Producto AS p
WHERE dv.venta = v.id  AND p.id = dv.producto AND p.categoria = c.id
GROUP BY c.nombre ORDER BY SUM(dv.subtotal) ASC LIMIT 5);


-------------------------CONSULTA7----------------------
--. Mostrar el top 5 de proveedores que más productos han vendido (en dinero)
---de la categoría de productos ‘Fresh Vegetables’.
SELECT p.id, p.nombre, SUM(da.subtotal) AS Total
FROM Proveedor AS p, DetalleAdquisicion AS da, Adquisicion AS a, Producto AS pr, Categoria AS c
WHERE p.id = a.proveedor AND a.id = da.adquisicion AND pr.id = da.producto AND c.id = pr.categoria AND c.nombre LIKE 'Fresh Vegetables'
GROUP BY p.id, p.nombre ORDER BY SUM(da.subtotal) DESC LIMIT 5;


------------------------------CONSULTA8----------------------------
-------Mostrar la dirección, región, ciudad y código postal de los clientes que más
-------han comprado y de los que menos (en dinero) en una sola consulta.
(SELECT cl.nombre AS Nombre_Cliente, cl.direccion AS Direccion, r.nombre AS region, ci.nombre As ciudad, cl.postal AS Codigo_Postal, SUM(dv.subtotal) AS Total 
FROM DetalleVenta AS dv, Venta v, Cliente cl, Region  AS r, Ciudad AS ci, CodigoPostal AS pos
WHERE v.id = dv.venta AND cl.id = v.cliente AND cl.postal = pos.id AND ci.id = pos.ciudad AND ci.region = r.id
GROUP BY cl.nombre, cl.direccion,r.nombre,ci.nombre, cl.postal ORDER BY SUM(dv.subtotal) DESC LIMIT 5)
UNION
(SELECT cl.nombre, cl.direccion, r.nombre, ci.nombre, cl.postal, SUM(dv.subtotal) AS Total 
FROM DetalleVenta AS dv, Venta v, Cliente cl, Region  AS r, Ciudad AS ci, CodigoPostal AS pos
WHERE v.id = dv.venta AND cl.id = v.cliente AND cl.postal = pos.id AND ci.id = pos.ciudad AND ci.region = r.id
GROUP BY cl.nombre, cl.direccion,r.nombre,ci.nombre, cl.postal ORDER BY SUM(dv.subtotal) ASC LIMIT 5);

-------------------------------CONSULTA9--------------------------------
----Mostrar el nombre del proveedor, número de teléfono, número de orden, Total de la orden por la cual se haya obtenido la menor cantidad de producto.
SELECT p.nombre AS PROVEEDOR, p.telefono AS TELEFONO, a.id AS ORDEN,SUM(da.cantidad), SUM(da.subtotal) AS TOTAL
FROM Proveedor AS p, Adquisicion AS a, DetalleAdquisicion AS da
WHERE p.id = a.proveedor AND da.adquisicion = a.id AND SUM(da.cantidad) = MIN(SUM(da.cantidad))
 GROUP BY p.nombre, p.telefono, a.id ORDER BY SUM(da.cantidad) ASC

 --------------------------CONSULTA10---------------
 --Mostrar el top 10 de los clientes que más productos han comprado de la categoría ‘Seafood’.
SELECT c.nombre, SUM(dv.cantidad) FROM Cliente AS c, DetalleVenta AS dv, Venta AS v, Producto AS p, Categoria AS cat
WHERE c.id = v.cliente AND dv.venta = v.id AND p.id = dv.producto AND cat.id = p.categoria AND cat.nombre LIKE'Seafood' 
GROUP BY c.nombre ORDER BY SUM(dv.cantidad) DESC LIMIT 10
