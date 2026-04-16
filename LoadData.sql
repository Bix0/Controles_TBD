-- ==========================================
-- 1. TABLAS CATÁLOGO / REFERENCIA (3FN)
-- ==========================================

CREATE TABLE Comuna (
    Id_Comuna INT PRIMARY KEY,
    Nombre_Comuna VARCHAR(100) NOT NULL
);

CREATE TABLE Rol_Empleado (
    Id_Rol INT PRIMARY KEY,
    Nombre_Rol VARCHAR(50) NOT NULL
);

CREATE TABLE Categoria_Producto (
    Id_Categoria_Prod INT PRIMARY KEY,
    Nombre_Categoria VARCHAR(50) NOT NULL
);

CREATE TABLE Categoria_Servicio (
    Id_Categoria_Serv INT PRIMARY KEY,
    Nombre_Categoria VARCHAR(50) NOT NULL
);

-- ==========================================
-- 2. TABLAS PRINCIPALES (1FN Aplicada)
-- ==========================================

CREATE TABLE Peluqueria (
    Id_Peluqueria INT PRIMARY KEY,
    Id_Comuna INT NOT NULL,
    Calle VARCHAR(150) NOT NULL,
    Numero VARCHAR(20) NOT NULL,
    FOREIGN KEY (Id_Comuna) REFERENCES Comuna(Id_Comuna)
);

CREATE TABLE Cliente (
    Id_Cliente INT PRIMARY KEY,
    Rut_Cliente VARCHAR(20) UNIQUE NOT NULL,
    Nombres VARCHAR(100) NOT NULL,
    Apellido_Paterno VARCHAR(100) NOT NULL,
    Apellido_Materno VARCHAR(100),
    Correo_Cliente VARCHAR(150) UNIQUE NOT NULL,
    Fecha_Nac DATE,
    Genero VARCHAR(20),
    Id_Comuna INT,
    FOREIGN KEY (Id_Comuna) REFERENCES Comuna(Id_Comuna)
);

CREATE TABLE Empleado (
    Id_Empleado INT PRIMARY KEY,
    Nombres VARCHAR(100) NOT NULL,
    Apellidos VARCHAR(100) NOT NULL,
    Id_Rol INT NOT NULL,
    Id_Peluqueria INT NOT NULL,
    FOREIGN KEY (Id_Rol) REFERENCES Rol_Empleado(Id_Rol),
    FOREIGN KEY (Id_Peluqueria) REFERENCES Peluqueria(Id_Peluqueria)
);

CREATE TABLE Producto (
    Id_Producto INT PRIMARY KEY,
    Nombre_Producto VARCHAR(150) NOT NULL,
    Precio_Producto INT NOT NULL,
    Stock INT NOT NULL,
    Id_Categoria_Prod INT NOT NULL,
    FOREIGN KEY (Id_Categoria_Prod) REFERENCES Categoria_Producto(Id_Categoria_Prod)
);

CREATE TABLE Servicio (
    Id_Servicio INT PRIMARY KEY,
    Nombre VARCHAR(150) NOT NULL,
    Precio INT NOT NULL,
    Id_Categoria_Serv INT NOT NULL,
    FOREIGN KEY (Id_Categoria_Serv) REFERENCES Categoria_Servicio(Id_Categoria_Serv)
);

-- ==========================================
-- 3. TABLAS DE RELACIÓN Y TRANSACCIONALES
-- ==========================================

CREATE TABLE Clientes_Peluqueria (
    Id_Cliente INT NOT NULL,
    Id_Peluqueria INT NOT NULL,
    PRIMARY KEY (Id_Cliente, Id_Peluqueria),
    FOREIGN KEY (Id_Cliente) REFERENCES Cliente(Id_Cliente),
    FOREIGN KEY (Id_Peluqueria) REFERENCES Peluqueria(Id_Peluqueria)
);

CREATE TABLE Sueldo (
    Id_Sueldo INT PRIMARY KEY,
    Id_Empleado INT NOT NULL,
    Fecha DATE NOT NULL,
    Monto INT NOT NULL,
    Estado VARCHAR(50) NOT NULL,
    FOREIGN KEY (Id_Empleado) REFERENCES Empleado(Id_Empleado)
);

-- Se ajustan los tipos de datos según análisis 1FN
CREATE TABLE Horario (
    Id_Horario INT PRIMARY KEY,
    Dia_Semana INT NOT NULL, -- Ej: 1=Lunes, 7=Domingo
    Hora_Inicio TIME NOT NULL,
    Hora_Fin TIME NOT NULL
);

CREATE TABLE Citas (
    Id_Cita INT PRIMARY KEY,
    Id_Peluqueria INT NOT NULL,
    Id_Cliente INT NOT NULL,
    Id_Empleado INT NOT NULL,
    Id_Horario INT NOT NULL,
    Fecha_Cita DATE NOT NULL, -- Añadido: Faltaba la fecha específica de la cita
    FOREIGN KEY (Id_Peluqueria) REFERENCES Peluqueria(Id_Peluqueria),
    FOREIGN KEY (Id_Cliente) REFERENCES Cliente(Id_Cliente),
    FOREIGN KEY (Id_Empleado) REFERENCES Empleado(Id_Empleado),
    FOREIGN KEY (Id_Horario) REFERENCES Horario(Id_Horario)
);

CREATE TABLE Pago (
    Id_Pago INT PRIMARY KEY,
    Id_Cita INT NOT NULL,
    Fecha DATE NOT NULL,
    Total INT NOT NULL, 
    Medio_de_pago VARCHAR(50) NOT NULL,
    Estado VARCHAR(50) NOT NULL,
    Tipo_Comprobante VARCHAR(50) NOT NULL,
    FOREIGN KEY (Id_Cita) REFERENCES Citas(Id_Cita)
);

-- Se permite NULL en Producto y Servicio para solventar problema de 2FN/Semántica
CREATE TABLE Detalle_Cita (
    Id_Detalle INT PRIMARY KEY,
    Id_Cita INT NOT NULL,
    Id_Producto INT NULL, 
    Id_Servicio INT NULL, 
    Precio_Pagado INT NOT NULL,
    Cantidad INT NOT NULL DEFAULT 1,
    FOREIGN KEY (Id_Cita) REFERENCES Citas(Id_Cita),
    FOREIGN KEY (Id_Producto) REFERENCES Producto(Id_Producto),
    FOREIGN KEY (Id_Servicio) REFERENCES Servicio(Id_Servicio)
);