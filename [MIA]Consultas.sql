----------------------------CONSULTA 1
SELECT p.nombre, p.telefono, a.id, a.cantidad*pr.precio AS total 
FROM Proveedor AS p, Adquisicion AS a, Producto AS pr
WHERE p.id = a.proveedor ORDER BY total DESC 