
CREATE TABLE Categoria(
    id int NOT NULL, AUTO_INCREMENT;
    nombre varchar(50) NOT NULL;
    CONSTRAINT Categoria_pk PRIMARY KEY (id);
);

CREATE TABLE Empresa(
    id INT AUTO_INCREMENT, NOT NULL;
    nombre VARCHAR(50) NOT NULL;
    correo VARCHAR(50) DEFAULT NULL;
    telefono VARCHAR(15) DEFAULT NULL;
    contacto VARCHAR(25) DEFAULT NULL;
);