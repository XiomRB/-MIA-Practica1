----------------------------------------------------CREANDO MODELO E INSERTANDO DATOS---------------------------------------------
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
    ciudad INT,
    fecha_reg DATE,
    CONSTRAINT FK_Cliente_ciudad FOREIGN KEY (ciudad) REFERENCES Ciudad(id)
);
INSERT INTO Cliente (nombre, correo, telefono, direccion, fecha_reg, ciudad)
SELECT DISTINCT c.nombre, c.correo, c.telefono, c.direccion, c.fecha_registro, city.id FROM carga AS c, Ciudad AS city
WHERE city.nombre = c.ciudad AND c.tipo = 'C' ;


CREATE TABLE Proveedor(
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(35) NOT NULL,
    correo VARCHAR(50),
    telefono VARCHAR(15),
    direccion VARCHAR(50),
    ciudad INT,
    fecha_reg DATE,
    CONSTRAINT FK_Proveedor_ciudad FOREIGN KEY (ciudad) REFERENCES Ciudad(id)
);
INSERT INTO Proveedor (nombre, correo, telefono, direccion, fecha_reg, ciudad)
SELECT DISTINCT c.nombre, c.correo, c.telefono, c.direccion, c.fecha_registro, city.id FROM carga AS c, Ciudad AS city
WHERE city.nombre = c.ciudad AND c.tipo = 'P';


CREATE TABLE Venta(
    id INT PRIMARY  KEY  AUTO_INCREMENT NOT NULL,
    cliente INT NOT NULL,
    producto INT NOT NULL,
    cantidad INT NOT NULL,
    CONSTRAINT FK_Venta_cliente FOREIGN KEY (cliente) REFERENCES Cliente(id),
    CONSTRAINT FK_Venta_producto FOREIGN KEY (producto) REFERENCES Producto(id)
);
INSERT INTO Venta (cliente, producto, cantidad)
SELECT DISTINCT cus.id, p.id, c.cantidad FROM Producto AS p, carga AS c, Cliente AS cus
WHERE c.nombre = cus.nombre AND p.nombre = c.producto;

CREATE TABLE Adquisicion(
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    proveedor INT NOT NULL,
    producto INT NOT NULL,
    cantidad INT NOT NULL,
    CONSTRAINT FK_Adquisicion_proveedor FOREIGN KEY (proveedor) REFERENCES Proveedor(id),
    CONSTRAINT FK_Adquisicion_producto FOREIGN KEY (producto) REFERENCES Producto(id)
);
INSERT INTO Adquisicion (proveedor, producto, cantidad)
SELECT DISTINCT prov.id, p.id, c.cantidad FROM Producto AS p, carga AS c, Proveedor AS prov
WHERE c.nombre = prov.nombre AND p.nombre = c.producto;

----------------------------------------------------------------------BORRANDO MODELO----------------------------------------------------------
DROP TABLE DetalleAdquisicion;
DROP TABLE DetalleVenta;
DROP TABLE Adquisicion;
DROP TABLE Venta;
DROP TABLE Proveedor;
DROP TABLE Cliente;
DROP TABLE Ciudad;
DROP TABLE Region;
DROP TABLE Empresa;
DROP TABLE Producto;
DROP TABLE Categoria;