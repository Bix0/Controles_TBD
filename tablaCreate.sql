-- tablas independientes--

create table Cliente(
id_cliente INTEGER PRIMARY KEY,
nombre_cliente VARCHAR,
rut_cliente VARCHAR,
correo_cliente VARCHAR,
edad_cliente INTEGER,
comuna, VARCHAR,
genero, VARCHAR);

create table Peluqueria(
id_peluqueria INTEGER PRIMARY KEY,
comuna VARCHAR,
numero VARCHAR);

create table Empleado(
id_empleado INTEGER PRIMARY KEY,
rol VARCHAR,
nombre VARCHAR,
);

CREATE table Producto(
id_producto INTEGER PRIMARY KEY,
nombre_producto VARCHAR,
precio_producto INT,
tipo_producto VARCHAR,
stock INT);

CREATE TABLE Servicio(
id_servicio INTEGER PRIMARY KEY,
nombre_servicio VARCHAR,
precio INT,
tipo_servicio VARCHAR);

-- tablas con dependencias --

create table Cliente_peluquerias (
id_cliente INTEGER,
id_peluqueria INTEGER,
PRIMARY KEY (id_cliente, id_peluqueria),
FOREIGN KEY (id_cliente) references Cliente(id_cliente),
FOREIGN KEY (id_peluqueria) references Peluqueria(id_peluqueria));

create table Horario (
	id_horario INTEGER PRIMARY KEY,
	bloque_horario VARCHAR,
	id_peluqieria INT,
	FOREIGN KEY (id_peluqueria) references Peluqueria(id_peluqueria)
);

--- dependencias nivel 2 ---

create table Empleado (
id_empleado INT PRIMARY KEY,
nombre_empleado VARCHAR,
rol VARCHAR,
id_horario INT,
id_peluqueria INT,
FOREIGN KEY (id_horario) references Horario(id_horario),
FOREIGN KEY (id_peluqueria) references Peluqueria(id_peluqueria));

-- depedencias nivel 3 ---

create table Sueldo(
id_sueldo INT PRIMARY KEY,
fecha VARCHAR,
estado VARCHAR,
monto INT,
id_empleado INT,
FOREIGN KEY (id_empleado) references Empleado (id_empleado));

create table Citas(
id_cita INT PRIMARY KEY,
id_peluqueria INT,
id_cliente INT,
id_empleado INT,
id_horario INT,
FOREIGN KEY (id_empleado) references Empleado (id_empleado),
	FOREIGN KEY (id_peluqueria) references Empleado (id_peluqueria),
	FOREIGN KEY (id_cliente) references Empleado (id_cliente),
	FOREIGN KEY (id_horario) references Empleado (id_horario),
);

-- dependencias nivel 5--

create table detalle();