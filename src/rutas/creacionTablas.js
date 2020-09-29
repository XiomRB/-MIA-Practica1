var tablaCat = `CREATE TABLE Categoria(
    id int AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(50)
);`

var tablaProd = `CREATE TABLE Producto(
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    categoria INT,
    precio DOUBLE,
    CONSTRAINT FK_Producto_categoria FOREIGN KEY (categoria) REFERENCES Categoria(id)
);`

var tablaEmp = `CREATE TABLE Empresa(
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(50),
    correo VARCHAR(50),
    telefono VARCHAR(15),
    contacto VARCHAR(35)
)`

var tablaReg = `CREATE TABLE Region(
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(25)
);`

var tablaCity = `CREATE TABLE Ciudad(
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(25),
    region INT,
    postal INT,
    CONSTRAINT FK_Ciudad_region FOREIGN KEY (region) REFERENCES Region(id)
);`

var tablaCust = `CREATE TABLE Cliente(
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(35) NOT NULL,
    correo VARCHAR(50),
    telefono VARCHAR(15),
    direccion VARCHAR,
    ciudad INT,
    fecha_reg DATE,
    CONSTRAINT FK_Cliente_ciudad FOREIGN KEY (ciudad) REFERENCES Ciudad(id)
);`

var tablaProv = `CREATE TABLE Proveedor(
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(35) NOT NULL,
    correo VARCHAR(50),
    telefono VARCHAR(15),
    direccion VARCHAR,
    ciudad INT,
    fecha_reg DATE,
    CONSTRAINT FK_Proveedor_ciudad FOREIGN KEY (ciudad) REFERENCES Ciudad(id)
);`

var tablaVenta = `CREATE TABLE Venta(
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    cliente INT,
    CONSTRAINT FK_Venta_cliente FOREIGN KEY (cliente) REFERENCES Cliente(id)
);`

var tablaAdq =`CREATE TABLE Adquisicion(
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    proveedor INT,
    CONSTRAINT FK_Venta_proveedor FOREIGN KEY (proveedor) REFERENCES Proveedor(id)
);`

var tablaDetV = `CREATE TABLE DetalleVenta(
    venta INT PRIMARY KEY NOT NULL,
    producto INT PRIMARY KEY NOT NULL,
    cantidad INT NOT NULL,
    total DOUBLE,
    CONSTRAINT FK_DetalleVenta_venta FOREIGN KEY (venta) REFERENCES Venta(id),
    CONSTRAINT FK_DetalleVenta_producto FOREIGN KEY (producto) REFERENCES Producto(id)
);`

var tablaDetA = `CREATE TABLE DetalleAdquision(
    adquisicion INT PRIMARY KEY NOT NULL,
    producto INT PRIMARY KEY NOT NULL,
    cantidad INT NOT NULL,
    total DOUBLE,
    CONSTRAINT FK_DetallAdquisicion_adquisicion FOREIGN KEY (adquisicion) REFERENCES Adquisicion(id),
    CONSTRAINT FK_DetalleVenta_producto FOREIGN KEY (producto) REFERENCES Producto(id)
);`
