--------------------------------------CREANDO TABLE TEMPORAL PARA CARGA MASIVA
CREATE TEMPORARY TABLE carga(
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
);

----------------------------------------------------CREANDO MODELO ---------------------------------------------
CREATE TABLE Categoria(
    id int AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(50)
);

CREATE TABLE Producto(
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    categoria INT,
    precio DOUBLE,
    CONSTRAINT FK_Producto_categoria FOREIGN KEY (categoria) REFERENCES Categoria(id)
);

CREATE TABLE Empresa(
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(50),
    correo VARCHAR(50),
    telefono VARCHAR(15),
    contacto VARCHAR(35)
);

CREATE TABLE Region(
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(25)
);

CREATE TABLE Ciudad(
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(25),
    region INT,
    CONSTRAINT FK_Ciudad_region FOREIGN KEY (region) REFERENCES Region(id)
);

CREATE TABLE CodigoPostal(
    id INT NOT NULL PRIMARY KEY,
    ciudad INT NOT NULL,
    CONSTRAINT FK_CodigoPostal_ciudad FOREIGN KEY (ciudad) REFERENCES Ciudad(id)
);

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

CREATE TABLE Venta(
    id INT PRIMARY  KEY  AUTO_INCREMENT NOT NULL,
    cliente INT NOT NULL,
    empresa INT NOT NULL,
    CONSTRAINT FK_Venta_cliente FOREIGN KEY (cliente) REFERENCES Cliente(id),
    CONSTRAINT FK_Venta_empresa FOREIGN KEY (empresa) REFERENCES Empresa(id)
);

CREATE TABLE Adquisicion(
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    proveedor INT NOT NULL,
    empresa INT NOT NULL,
    CONSTRAINT FK_Adquisicion_proveedor FOREIGN KEY (proveedor) REFERENCES Proveedor(id),
    CONSTRAINT FK_Adquisicion_empresa FOREIGN KEY (empresa) REFERENCES Empresa(id)
);

CREATE TABLE DetalleVenta(
    venta INT NOT NULL,
    producto INT NOT NULL,
    cantidad INT,
    subtotal DOUBLE,
    PRIMARY KEY (venta, producto),
    CONSTRAINT FK_DetalleVenta_venta FOREIGN KEY (venta) REFERENCES Venta(id),
    CONSTRAINT FK_DetalleVenta_producto FOREIGN KEY (producto) REFERENCES Producto(id)
);

CREATE TABLE DetalleAdquisicion(
    adquisicion INT NOT NULL,
    producto INT NOT NULL,
    cantidad INT,
    subtotal DOUBLE,
    PRIMARY KEY (adquisicion, producto),
    CONSTRAINT FK_DetalleAdquisicion_adquisicion FOREIGN KEY (adquisicion) REFERENCES Adquisicion(id),
    CONSTRAINT FK_DetalleAdquisicion_producto FOREIGN KEY (producto) REFERENCES Producto(id)
);

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