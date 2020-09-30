----------------------------------------------------CREANDO MODELO ---------------------------------------------
CREATE TABLE Categoria(
    id int AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(50)
);
INSERT INTO Categoria (nombre)
SELECT DISTINCT categoria_producto FROM carga;


CREATE TABLE Producto(
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    categoria INT,
    precio DOUBLE,
    CONSTRAINT FK_Producto_categoria FOREIGN KEY (categoria) REFERENCES Categoria(id)
);
INSERT INTO Producto (nombre,precio,categoria)
SELECT DISTINCT carga.producto,carga.precio_unitario,Categoria.id FROM carga, Categoria
WHERE Categoria.nombre = carga.categoria_producto;


CREATE TABLE Empresa(
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(50),
    correo VARCHAR(50),
    telefono VARCHAR(15),
    contacto VARCHAR(35)
);
INSERT INTO Empresa (nombre,correo,telefono,contacto)
SELECT DISTINCT nombre_compania, correo_compania, telefono_compania, contacto_compania FROM carga;


CREATE TABLE Region(
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(25)
);
INSERT INTO Region (nombre)
SELECT DISTINCT region FROM carga;


CREATE TABLE Ciudad(
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(25),
    region INT,
    CONSTRAINT FK_Ciudad_region FOREIGN KEY (region) REFERENCES Region(id)
);
INSERT INTO Ciudad (nombre, region)
SELECT DISTINCT carga.ciudad, Region.id FROM carga,Region
WHERE Region.nombre = carga.region;


CREATE TABLE CodigoPostal(
    id INT NOT NULL PRIMARY KEY,
    ciudad INT NOT NULL,
    CONSTRAINT FK_CodigoPostal_ciudad FOREIGN KEY (ciudad) REFERENCES Ciudad(id)
);
INSERT INTO CodigoPostal (id, ciudad)
SELECT DISTINCT carga.codigo_postal, Ciudad.id FROM carga,Ciudad
WHERE Ciudad.nombre = carga.ciudad;


CREATE TABLE Cliente(
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(35) NOT NULL,
    correo VARCHAR(50),
    telefono VARCHAR(15),
    direccion VARCHAR(50),
    postal INT,
    fecha_reg DATE,
    CONSTRAINT FK_Cliente_postal FOREIGN KEY (postal) REFERENCES CodigoPostal(id)
);
INSERT INTO Cliente (nombre, correo, telefono, direccion, fecha_reg, postal)
SELECT DISTINCT c.nombre, c.correo, c.telefono, c.direccion, c.fecha_registro, c.codigo_postal FROM carga AS c, Ciudad AS city
WHERE city.nombre = c.ciudad AND c.tipo = 'C' ;


CREATE TABLE Proveedor(
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(35) NOT NULL,
    correo VARCHAR(50),
    telefono VARCHAR(15),
    direccion VARCHAR(50),
    postal INT,
    fecha_reg DATE,
    CONSTRAINT FK_Proveedor_postal FOREIGN KEY (postal) REFERENCES CodigoPostal(id)
);
INSERT INTO Proveedor (nombre, correo, telefono, direccion, fecha_reg, postal)
SELECT DISTINCT c.nombre, c.correo, c.telefono, c.direccion, c.fecha_registro, c.codigo_postal FROM carga AS c, Ciudad AS city
WHERE city.nombre = c.ciudad AND c.tipo = 'P';


CREATE TABLE Venta(
    id INT PRIMARY  KEY  AUTO_INCREMENT NOT NULL,
    cliente INT NOT NULL,
    empresa INT NOT NULL,
    CONSTRAINT FK_Venta_cliente FOREIGN KEY (cliente) REFERENCES Cliente(id),
    CONSTRAINT FK_Venta_empresa FOREIGN KEY (empresa) REFERENCES Empresa(id)
);
INSERT INTO Venta(cliente, empresa)
SELECT DISTINCT c.id, e.id FROM Cliente AS c, Empresa AS e, carga AS ca 
WHERE ca.nombre = c.nombre AND e.nombre = ca.nombre_compania GROUP BY c.nombre, e.nombre;


CREATE TABLE Adquisicion(
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    proveedor INT NOT NULL,
    empresa INT NOT NULL,
    CONSTRAINT FK_Adquisicion_proveedor FOREIGN KEY (proveedor) REFERENCES Proveedor(id),
    CONSTRAINT FK_Adquisicion_empresa FOREIGN KEY (empresa) REFERENCES Empresa(id)
);
INSERT INTO Adquisicion (proveedor, empresa)
SELECT DISTINCT p.id, e.id FROM Proveedor AS p, Empresa AS e, carga AS ca 
WHERE ca.nombre = p.nombre AND e.nombre = ca.nombre_compania GROUP BY p.nombre, e.nombre;


CREATE TABLE DetalleVenta(
    venta INT NOT NULL,
    producto INT NOT NULL,
    cantidad INT,
    subtotal DOUBLE,
    PRIMARY KEY (venta, producto),
    CONSTRAINT FK_DetalleVenta_venta FOREIGN KEY (venta) REFERENCES Venta(id),
    CONSTRAINT FK_DetalleVenta_producto FOREIGN KEY (producto) REFERENCES Producto(id)
);
INSERT INTO DetalleVenta (venta,producto,cantidad,subtotal)
SELECT v.id, p.id, SUM(c.cantidad), SUM(c.cantidad)*p.precio FROM Venta AS v, carga AS c, Producto AS p, Cliente AS cl, Empresa AS e
WHERE c.producto = p.nombre AND cl.nombre = c.nombre AND v.cliente = cl.id AND e.nombre = c.nombre_compania AND e.id = v.empresa
GROUP BY v.id, p.id;


CREATE TABLE DetalleAdquisicion(
    adquisicion INT NOT NULL,
    producto INT NOT NULL,
    cantidad INT,
    subtotal DOUBLE,
    PRIMARY KEY (adquisicion, producto),
    CONSTRAINT FK_DetalleAdquisicion_adquisicion FOREIGN KEY (adquisicion) REFERENCES Adquisicion(id),
    CONSTRAINT FK_DetalleAdquisicion_producto FOREIGN KEY (producto) REFERENCES Producto(id)
);
INSERT INTO DetalleAdquisicion (adquisicion, producto, cantidad,subtotal)
SELECT a.id, p.id, SUM(c.cantidad),SUM(c.cantidad)*p.precio FROM Adquisicion AS a, carga AS c, Producto AS p, Proveedor AS pr, Empresa AS e
WHERE c.producto = p.nombre AND pr.nombre = c.nombre AND a.proveedor = pr.id AND e.nombre = c.nombre_compania AND e.id = a.empresa
GROUP BY a.id, p.id;


----------------------------------------------------------------------BORRANDO MODELO----------------------------------------------------------
DROP TABLE DetalleAdquisicion;
DROP TABLE DetalleVenta;
DROP TABLE Adquisicion;
DROP TABLE Venta;
DROP TABLE Proveedor;
DROP TABLE Cliente;
DROP TABLE CodigoPostal;
DROP TABLE Ciudad;
DROP TABLE Region;
DROP TABLE Empresa;
DROP TABLE Producto;
DROP TABLE Categoria;