 /*Apuntes clase*/
-- Creación de la base de datos 'EjercicioClase'
CREATE DATABASE EjercicioClase;
USE EjercicioClase;

-- Creación de la tabla 'Cliente'
CREATE TABLE Cliente(
    codigoCliente INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único, autoincremental
    nombreCliente VARCHAR(50) NOT NULL, -- Nombre del cliente
    domicilioCliente VARCHAR(100) NOT NULL, -- Dirección del cliente
    ciudadCliente VARCHAR(50) NOT NULL, -- Ciudad donde reside
    provinciaCliente VARCHAR(50) NOT NULL, -- Provincia donde reside
    telefonoCliente VARCHAR(20) NOT NULL -- Número de teléfono
);

-- Inserción de datos en la tabla 'Cliente'
INSERT INTO Cliente (nombreCliente, domicilioCliente, ciudadCliente, provinciaCliente, telefonoCliente) VALUES
("Laura", "cra45 #62a-35", "Bogota", "Cundinamarca", "3078447599"),
("Mateo", "cra85 #69b-86", "Medellin", "Antioquia", "3048772984"),
("Camila", "cl47 #60b-30", "Cartagena", "Bolivar", "3115784785"),
("Samuel", "cl49 #6-60", "Bucaramanga", "Santander", "3068774841"),
("Ana", "cra49 #08-48", "Melgar", "Tolima", "3017558240");

-- Mostrar la tabla
describe Cliente;
-- Selección de todos los datos de la tabla 'Cliente'
SELECT * FROM Cliente;

-- Consultas específicas en la tabla 'Cliente'
SELECT codigoCliente, nombreCliente FROM Cliente; -- Selecciona solo código y nombre
SELECT domicilioCliente FROM Cliente WHERE nombreCliente = "Mateo"; -- Dirección de Mateo
SELECT * FROM Cliente WHERE nombreCliente <> "Mateo"; -- Excluye a Mateo
SELECT * FROM Cliente WHERE codigoCliente = 2; -- Cliente con código 2
SELECT * FROM Cliente WHERE NOT nombreCliente = "Mateo"; -- Otra forma de excluir a Mateo

-- Uso de alias para mejorar la legibilidad
SELECT nombreCliente AS "Nombre del Cliente", domicilioCliente AS "Dirección del Cliente", ciudadCliente, provinciaCliente AS "Lugar del Cliente",telefonoCliente AS "Celular del Cliente" 
FROM Cliente;

-- Ordenar los clientes por teléfono de forma ascendente y descendente
SELECT * FROM Cliente ORDER BY telefonoCliente ASC;
SELECT * FROM Cliente ORDER BY telefonoCliente DESC;

-- Filtro para encontrar a un cliente específico
SELECT nombreCliente, domicilioCliente, ciudadCliente, provinciaCliente, telefonoCliente
FROM Cliente WHERE nombreCliente = "Laura";

-- Uso de operadores LIKE para buscar patrones en nombres
SELECT * FROM Cliente WHERE nombreCliente LIKE "%a%"; -- Contiene la letra "a"
SELECT * FROM Cliente WHERE nombreCliente LIKE "M%"; -- Comienza con "M"
SELECT * FROM Cliente WHERE nombreCliente LIKE "%g"; -- Termina en "g"

-- Creación de la base de datos 'TechCorp'
CREATE DATABASE TechCorp;
USE TechCorp;

-- Creación de la tabla 'Departamento'
CREATE TABLE Departamento (
    idDep INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único del departamento
    nombreDep VARCHAR(50) NOT NULL -- Nombre del departamento
);

-- Creación de la tabla 'Cargo'
CREATE TABLE Cargo (
    idCargo VARCHAR(20) PRIMARY KEY, -- Código único para el cargo
    nombreCargo VARCHAR(50) NOT NULL, -- Nombre del cargo
    rangoCargo INT NOT NULL, -- Nivel jerárquico del cargo
    descripcionCargo VARCHAR(255) NOT NULL -- Descripción del cargo
);

-- Creación de la tabla 'Empleado' con claves foráneas
CREATE TABLE Empleado (
    idEmpleado INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único del empleado
    nombreEmpleado VARCHAR(50) NOT NULL, -- Nombre del empleado
    edadEmpleado INT NOT NULL, -- Edad del empleado
    salarioEmpleado DECIMAL(10,2) NOT NULL, -- Salario con 2 decimales
    aniocontEmpleado YEAR NOT NULL, -- Año de contratación
    idCargoFk VARCHAR(20), -- Relación con la tabla 'Cargo'
    idDepFk INT, -- Relación con la tabla 'Departamento'
    FOREIGN KEY (idCargoFk) REFERENCES Cargo(idCargo) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (idDepFk) REFERENCES Departamento(idDep) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Inserción de datos en la tabla 'Departamento'
INSERT INTO Departamento (idDep, nombreDep) VALUES
("","Ventas"),
("", "Dirección"),
("", "IT"),
("", "Gerencia"),
("", "Finanzas");

-- Inserción de datos en la tabla 'Cargo'
INSERT INTO Cargo (idCargo, nombreCargo, rangoCargo, descripcionCargo) VALUES
("103", "Gerente de Operaciones", 2, "Supervisa y optimiza procesos operativos."),
("108", "Analista de Datos", 4, "Analiza e interpreta datos."),
("109", "Supervisor de Producción", 2, "Coordina y supervisa la producción."),
("106", "Contador", 1, "Maneja cuentas y pagos."),
("102", "Asistente Administrativo", 3, "Apoyo en tareas administrativas.");

-- Inserción de datos en la tabla 'Empleado'
INSERT INTO Empleado (idEmpleado,nombreEmpleado, edadEmpleado, salarioEmpleado, aniocontEmpleado, idCargoFk, idDepFk) VALUES
("", "Carlos", 40, 5000.00, 2018, "103", 1),
("", "Ana", 28, 3900.00, 2022, "108", 2),
("", "Camila", 31, 4100.00, 2019, "109", 3),
("", "Alejandro", 26, 3700.00, 2023, "102", 4);

-- Seleccionar todos los datos de las tablas
SELECT * FROM Departamento;
SELECT * FROM Cargo;
SELECT * FROM Empleado;

-- Buscar cargos con un rango específico
SELECT idCargo, nombreCargo, rangoCargo, descripcionCargo FROM Cargo WHERE rangoCargo = 1;

-- Consulta con JOIN para mostrar empleados con más de 3 años de antigüedad
SELECT em.nombreEmpleado, de.nombreDep AS "Departamento", ca.nombreCargo AS "Cargo", em.salarioEmpleado 
FROM Empleado em
INNER JOIN Cargo ca ON em.idCargoFk = Ca.idCargo 
INNER JOIN Departamento de ON em.idDepFk = de.idDep
WHERE YEAR(CURDATE()) - aniocontEmpleado > 3; -- CURDATE Devuelve la fecha actual del sistema 

-- Cálculo de años de antigüedad de los empleados
SELECT em.nombreEmpleado, em.aniocontEmpleado, de.nombreDep AS "Departamento",
       TIMESTAMPDIFF(YEAR, STR_TO_DATE(CONCAT(aniocontEmpleado, '-01-01'), '%Y-%m-%d'),  
       CURDATE()) AS "Años de Antigüedad", 
       nombreCargo, rangoCargo -- TIMESTAMPDIFF(YEAR, fecha1, fecha2)	Calcula la diferencia en años entre dos fechas.  CONCAT(aniocontEmpleado, '-01-01')	Lo convierte a una fecha completa, como "2020-01-01".
-- STR_TO_DATE(..., '%Y-%m-%d')	Convierte ese texto a un formato de fecha válido.
FROM Empleado em
INNER JOIN Cargo ca ON em.idCargoFk = ca.idCargo 
INNER JOIN Departamento de ON em.idDepFk = de.idDep;

-- Selección de cargos que no tienen empleados asignados
SELECT * FROM Cargo WHERE idCargo NOT IN (SELECT DISTINCT idCargoFk FROM Empleado);
SELECT ca.* FROM Cargo ca
LEFT JOIN Empleado em ON ca.idCargo = em.idCargoFk
WHERE em.idCargoFk IS NULL;

-- Mejores 3 salarios 
select * from empleado order by salarioEmpleado desc limit 3;

-- Bono por llevar mas de 5 años trabajando  
SELECT nombreEmpleado, salarioEmpleado, TIMESTAMPDIFF(YEAR, STR_TO_DATE(CONCAT(aniocontEmpleado, '-01-01'), '%Y-%m-%d'), 
CURDATE()) AS "años trabajados", salarioEmpleado * 0.1 AS "Bono"
FROM Empleado
WHERE TIMESTAMPDIFF(YEAR, STR_TO_DATE(CONCAT(aniocontEmpleado, '-01-01'), '%Y-%m-%d'), CURDATE()) > 5;

-- Empleados con mayor salario que la media del salario 
-- cuantos
select count(*) from empleado where salarioEmpleado >(select avg(salarioEmpleado) from empleado);
-- quienes
select nombreEmlpeado from empleado where salarioEmpleado >(select avg(salarioEmpleado) from empleado);

-- Departamentos, conteo de ellos
select * from empleado group by nomEmpleado desc;

-- Empleados que ganen mas y lleven mas de 5 años trabajando 
SELECT nombreEmpleado, salarioEmpleado, TIMESTAMPDIFF(YEAR, STR_TO_DATE(CONCAT(aniocontEmpleado, '-01-01'), '%Y-%m-%d'), CURDATE()) AS "años trabajados"
FROM Empleado
WHERE TIMESTAMPDIFF(YEAR, STR_TO_DATE(CONCAT(aniocontEmpleado, '-01-01'), '%Y-%m-%d'), CURDATE()) = (
SELECT MAX(TIMESTAMPDIFF(YEAR, STR_TO_DATE(CONCAT(aniocontEmpleado, '-01-01'), '%Y-%m-%d'), CURDATE()))
FROM Empleado )AND salarioEmpleado = (SELECT MAX(salarioEmpleado) FROM Empleado)ORDER BY salarioEmpleado DESC LIMIT 5;

-- Rango de edad: Encuentra a los empleados que tienen entre 30 y 40 años. */
select idEmpleado, nombreEmpleado, edadEmpleado from empleado where edadEmpleado >= "30 Años" and edadEmpleado <= "40 Años";

-- ¿Quiénes han sido contratados después del año 2020?
select idEmpleado, nombreEmpleado, aniocontEmpleado from empleado where aniocontEmpleado >= "2020-01-01" ;

-- Distribución de empleados: ¿Cuántos empleados hay en cada departamento? */
select COUNT(depEmpleado) as "Empleados de Ventas" from empleado where depEmpleado = "Ventas";
select COUNT(depEmpleado) as "Empleados de Information Technologhy" from empleado where depEmpleado = "Information Technologhy";

--  ¿Cuál es el salario promedio en la empresa? */
select AVG(salarioEmpleado ) as "Salario Promedio" from empleado;

--  El mejor pagado: ¿Quién es el empleado con el salario más alto?
select idEmpleado, nombreEmpleado, salarioEmpleado from empleado where salarioEmpleado = (select max(salarioEmpleado) from empleado);
-- Consultar rangos between 
select * from empleado where idEmpleado between 1 and 5;

-- consultar un valor que este dentro de una lista de valores   
select * from empleado where departamentoEmpleado in ("Ventas");

/*si un campo es nulo is null¨*/
select * from empleado where nombreEmpleado is null;
select * from empleado order by salarioEmpleado ;
-- 1. Consultas DML (Data Manipulation Language)
-- ¿Cómo insertar, actualizar o eliminar datos en una tabla?
UPDATE empleados SET salario = 3500 WHERE nombre = 'Juan Pérez';
DELETE FROM empleados WHERE nombre = 'Carlos Ruiz';

SELECT * FROM empleados;

-- 2. Uso de HAVING (Filtrar después de un GROUP BY)
-- ¿Cómo obtener departamentos con un salario promedio mayor a un valor específico?
SELECT d.nombreDep AS departamento, AVG(e.salarioEmpleado) AS salario_promedio
FROM empleado e
JOIN departamento d ON e.idDepFk = d.idDep
GROUP BY d.nombreDep
HAVING AVG(e.salarioEmpleado) > 2700;

-- 3. ALTER TABLE (Modificar estructura de tabla)
-- ¿Cómo agregar, modificar o eliminar columnas en una tabla?
ALTER TABLE empleado ADD COLUMN edad INT;
UPDATE empleado SET edad = 30 WHERE idEmpleado = 1;
ALTER TABLE empleado MODIFY COLUMN salarioEmpleado DECIMAL(12,2);
ALTER TABLE empleado DROP COLUMN edad;

--  Uso de MAX (Máximo valor en una columna)
-- ¿Cómo encontrar el salario más alto por departamento?
SELECT d.nombreDep AS departamento, MAX(e.salarioEmpleado) AS salario_maximo
FROM empleado e
JOIN departamento d ON e.idDepFK = d.idDep
GROUP BY d.nombreDep DESC;

-- 5. Uso de COUNT (Contar registros)
-- ¿Cuántos empleados hay por departamento?
SELECT d.nombreDep AS departamento, COUNT(e.idEmpleado) AS total_empleados
FROM empleado e
JOIN departamento d ON e.idDepFK = d.idDep
GROUP BY d.nombreDep;

-- 6. Multiconsultas con JOIN
-- ¿Cómo combinar información con INNER JOIN, LEFT JOIN y RIGHT JOIN?
-- INNER JOIN: solo muestra coincidencias en ambas tablas
SELECT e.nombreEmpleado, d.nombreDep AS departamento
FROM empleado e
INNER JOIN departamento d ON e.idDepFK= d.idDep;

-- LEFT JOIN: muestra todos los empleados aunque no tengan departamento asignado
SELECT e.nombreEmpleado, d.nombreDep AS departamento
FROM empleado e
LEFT JOIN departamento d ON e.idDepFK = d.idDep;

-- RIGHT JOIN: muestra todos los departamentos aunque no tengan empleados
SELECT e.nombreEmpleado, d.nombreDep AS departamento
FROM empleado e
RIGHT JOIN departamento d ON e.idDepFK = d.idDep;

-- 7. Procedimientos almacenados
-- ¿Cómo crear un procedimiento que retorne empleados con salario mayor a un valor?
DELIMITER //
CREATE PROCEDURE ObtenerEmpleadosSalarioMayor(IN salarioEmpleado_min DECIMAL(10,2))
BEGIN
    SELECT nombreEmpleado, salarioEmpleado FROM empleado WHERE salarioEmpleado > salarioEmpleado_min;
END //
DELIMITER ;

CALL ObtenerEmpleadosSalarioMayor(2700);

-- 8. Triggers
-- ¿Cómo validar que el salario ingresado sea al menos 1000?
DELIMITER //
CREATE TRIGGER validar_salario
BEFORE INSERT ON empleado
FOR EACH ROW
BEGIN
    IF NEW.salarioEmpleado < 1000 THEN
        SET NEW.salarioEmpleado = 1000;
    END IF;
END //
DELIMITER ;

-- 9. Vistas
-- ¿Cómo crear una vista para simplificar la consulta de empleados con sus departamentos?
CREATE VIEW Vista_Empleados AS
SELECT e.nombreEmpleado, d.nombreDep AS departamento, e.salarioEmpleado
FROM empleado e
JOIN departamento d ON e.idDepFK = d.idDep;

SELECT * FROM Vista_Empleados;

-- 10. Subconsultas
-- ¿Cómo obtener empleados que ganan más que el salario promedio de su departamento?
SELECT nombreEmpleado, salarioEmpleado
FROM empleado e
WHERE salarioEmpleado > (SELECT AVG(salarioEmpleado) FROM empleado WHERE idDep = idDepFK);

-- 11. Consulta de stock
-- ¿Cómo verificar el stock de productos y listar solo aquellos con unidades disponibles?
CREATE TABLE productos (
    idProd INT AUTO_INCREMENT PRIMARY KEY,
    nombreProd VARCHAR(100),
    stockProd INT
);

INSERT INTO productos (idProd, nombreProd, stockProd) VALUES
("", 'Laptop', 5),
("", 'Mouse', 0),
("", 'Teclado', 12),
("", 'Monitor', 3);

SELECT nombreProd, stockProd FROM productos WHERE stockProd > 0;

-- Índices para optimización
CREATE INDEX idx_nomEmpleado ON empleado(nombreEmpleado);
CREATE INDEX idx_idDeptoFK ON empleado(idDepFK);
CREATE INDEX idx_nombreDepto ON departamento(nombreDep);

-- Funciones almacenadas
-- Cambiar el delimitador para permitir múltiples líneas de código en la función
DELIMITER //
-- Crear la función llamada ObtenerEdadPromedio que no recibe parámetros
CREATE FUNCTION ObtenerEdadPromedio() RETURNS INT
DETERMINISTIC  -- La función siempre devolverá el mismo resultado con los mismos datos
BEGIN
    -- Declaración de una variable local llamada edad_prom de tipo entero
    DECLARE edad_prom INT;
    -- Calcular el promedio de la columna edadEmpleado de la tabla empleado
    -- y guardar el resultado en la variable edad_prom
    SELECT AVG(edadEmpleado) INTO edad_prom FROM empleado;
    -- Devolver el valor almacenado en la variable edad_prom
    RETURN edad_prom;
END //
-- Restaurar el delimitador al valor predeterminado ;
DELIMITER ;
SELECT ObtenerEdadPromedio() AS EdadPromedio;

#Ejercicio 1 votos 
create database votaciones2503816;
use votaciones2503816;

/*CREAR TABLAS*/

create table Genero(
idGenero int primary key auto_increment,
nomGenero varchar (30) not null,
estadog bool not null
);
create table Jornada(
idJornada int primary key auto_increment,
nomJornada varchar (30) not null,
estadoJ bool not null
);
create table TipoDocumento(
idTipoDoc int primary key auto_increment,
nomTipoDoc varchar (30) not null,
estadoTD bool not null
);
create table TipoMiembro(
idTipoMiembro int primary key auto_increment,
nomTipoMiembro varchar (30) not null,
estadoTM bool not null
);
create table Curso(
idCurso int primary key auto_increment,
nomCurso varchar (30) not null,
estadoCu bool not null
);
create table Concejo(
idConcejo int primary key auto_increment,
nomConcejo varchar (30) not null,
estadoCo bool not null
);
create table Cargo(
idCargo int primary key auto_increment,
nomCargo varchar (30) not null,
idConcejoFK int not null,
estadoC bool not null,
foreign key (idConcejoFK) references Concejo (idConcejo)
);
create table Eleccion(
idEleccion int primary key auto_increment,
fechaEleccion date not null, 
anioEleccion int not null,
estadoEl bool not null
);
create table Usuario(
idUsuario int primary key auto_increment,
noDocUsuario int not null,
idTipoDocFk int not null,
nombreUsuario varchar(30) not null,
apellidoUsuario varchar(30) not null,
idGeneroFK int not null,
fechaNacUsuario date not null,
emailUsuario varchar(40) not null,
passwordUsuario varchar(10) not null,
fotoUsuario blob null,
idJornadaFK int not null,
idTipoMiembroFK int not null,
idCursoFK int not null,
estadoU bool not null,
foreign key (idTipoDocFk) references TipoDocumento (idTipoDoc),
foreign key (idGeneroFK) references Genero (idGenero),
foreign key (idJornadaFK) references Jornada (idJornada),
foreign key (idTipoMiembroFk) references TipoMiembro (idTipoMiembro),
foreign key (idCursoFK) references Curso (idCurso)
);
create table PostulacionCandidato(
idPostCandidato int primary key auto_increment,
idUsuarioFK int not null,
idEleccionFK int not null,
idCargoFK int not null, 
propuestas varchar (100),
totalVotos int not null,
estadoCan bool,
foreign key (idUsuarioFK) references Usuario (idUsuario),
foreign key (idEleccionFK) references Eleccion (idEleccion),
foreign key (idCargoFK) references Cargo (idCargo)
); 
create table Votacion(
idVotacion int primary key auto_increment,
horaVotacion time not null,
idUsuarioVotanteFK int not null,
idPostCandidatoFK int not null,
estadoV	bool not null,
foreign key (idUsuarioVotanteFK) references Usuario (idUsuario),
foreign key (idPostCandidatoFK) references PostulacionCandidato (idPostCandidato)
); 


/*nserccion de datos*/
insert into Genero (idGenero,nomGenero,estadog) values
("", "Femenino", true),
("", "Masculino", true);
insert into Jornada (idJornada,nomJornada,estadoJ) values
("", "Mañana", true),
("", "Tarde", true),
("", "Noche", true);
insert into TipoDocumento (idTipoDoc,nomTipoDoc,estadoTD) values
("", "Tarjeta de Identidad", true),
("", "Cédula Ciudadanía", true),
("", "Cédula Extranjeria", true),
("", "Pasaporte", true),
("", "NUIP", false);
insert into TipoMiembro (idTipoMiembro,nomTipoMiembro,estadoTM) values
("", "Estudiante", true),
("", "Profesor", true),
("", "Acudiente", true);
insert into Curso (idCurso,nomCurso,estadoCu) values
("", "901", true),
("", "902", true),
("", "1001", true),
("", "1002", true),
("", "1003", false),
("", "1101", true),
("", "1102", true),
("", "1103", false);
insert into Concejo (idConcejo,nomConcejo,estadoCo) values
("", "Concejo Académico" ,true),
("", "Concejo Directivo",true),
("", "Concejo Convivencia",true);
insert into Cargo (idCargo,nomCargo,idConcejoFK,estadoC) values
("", "Personero", 1,true),
("", "Contralor", 1,true),
("", "Cabildante", 1,true);
insert into Eleccion (idEleccion,fechaEleccion,anioEleccion,estadoEl) values
("", "2020-04-20", 2020, true),
("", "2019-04-15", 2019, true),
("", "2019-04-12", 2019, false),
("", "2018-04-14", 2018, true),
("", "2017-04-12", 2017, true);
insert into Usuario (idUsuario,noDocUsuario,idTipoDocFk,nombreUsuario,apellidoUsuario,
idGeneroFK,fechaNacUsuario,emailUsuario,passwordUsuario,fotoUsuario,idJornadaFK,idTipoMiembroFK,idCursoFK,estadoU) values
("", 101, 2, "Juan", "Pérez", 2, "1990-05-15", "juan.perez@example.com", "password1", NULL, 1, 2, 1, true),
("", 102, 3, "Ana", "González", 1, "1985-10-22", "ana.gonzalez@example.com", "password2", NULL, 2, 1, 2, true),
("", 103, 1, "Carlos", "López", 2, "1992-03-08", "carlos.lopez@example.com", "password3", NULL, 1, 3, 6, false),
("", 104, 4, "María", "Martínez", 1, "1995-12-30", "maria.martinez@example.com", "password4", NULL, 3, 2, 5, true),
("", 105, 1, "Luis", "Fernández", 2, "1998-07-21", "luis.fernandez@example.com", "password5", NULL, 1, 2, 4, true),
("", 106, 5, "Sofía", "Ramírez", 1, "2000-09-10", "sofia.ramirez@example.com", "password6", NULL, 3, 1, 8, true),
("", 107, 2, "Andrés", "Mendoza", 2, "1993-04-18", "andres.mendoza@example.com", "password7", NULL, 1, 3, 7, true),
("", 108, 3, "Laura", "Gómez", 1, "1999-11-25", "laura.gomez@example.com", "password8", NULL, 3, 1, 3, false),
("", 109, 2, "Ricardo", "Torres", 2, "1991-07-03", "ricardo.torres@example.com", "password9", NULL, 1, 3, 2, true),
("", 110, 4, "Valentina", "Ortega", 1, "2002-02-14", "valentina.ortega@example.com", "password10", NULL, 2, 3, 1, true);
insert into PostulacionCandidato (idPostCandidato,idUsuarioFK,idEleccionFK,idCargoFK,propuestas,totalVotos,estadoCan) values
("", 1, 1, 1, "Mejorar entrega refrigerios, Alargar descansos" ,0 ,true),
("", 5, 1, 1,"Mejorar entrega refrigerios, Alargar descansos" ,0 ,true),
("", 7, 1, 1,"Mejorar sala de informática, Construir piscina" ,0 ,true);
insert into Votacion(idVotacion,horaVotacion,idUsuarioVotanteFK,idPostCandidatoFK,estadoV) values
("", "12:08:15", 1, 1,true),
("", "12:12:35", 2, 3,true),
("", "12:14:18", 3, 2,true),
("", "12:15:58", 4, 2,true),
("", "12:18:02", 5, 3,true),
("", "12:24:22", 6, 3,true),
("", "12:28:02", 7, 3,true),
("", "12:30:14", 8, 2,true),
("", "12:40:20", 9, 2,true),
("", "12:45:20", 10, 2,true);
/*Tabla sin inserciones*/

/*Tabla con inserciones*/
select * from Genero;
select * from Jornada;
select * from TipoDocumento;
select * from TipoMiembro;
select * from Curso;
select * from Concejo;
select * from Cargo;
select * from Eleccion;
select * from Usuario;
select * from PostulacionCandidato;
select * from Votacion;

/*Consultas*/
/* 1. Realiza una consulta que muestre el nombre de cada concejo, que tenga asignado un cargo, con el nombre del cargo, al que pertence y el estado atual del mismo*/
select c.nomConcejo, ca.nomCargo, ca.estadoC from Concejo c
inner join cargo ca on c.idConcejo = ca.idConcejoFK;
select c.nomConcejo, ca.nomCargo, ca.estadoC from Concejo c
inner join cargo ca on ca.idConcejoFK =  c.idConcejo;
/* 2. Realiza una consulta que muestre el nombre de cargo de cada concejo, que tenga asginado un cargo con el nombre del cargo al que pertenece y estado actual del mismo. Tenga o no cargo asignado*/
select c.nomConcejo, ca.nomCargo, ca.estadoC from Concejo c
left join cargo ca on c.idConcejo = ca.idConcejoFk ; -- me muestra tdoos los valores del primero y si no tienen en la tabla de la derecha entonces sera null
/* 3. Realice una consulta que muestre cada usuario con su jornada, tipo de miembro y curso*/
select u.nombreUsuario as Nombre, u.apellidoUsuario as apellido, j.nomJornada as Jornada, tm.nomTipoMiembro as Tipo_de_Miembro, c.nomCurso as Curso from Usuario u
inner join jornada j on j.idJornada =u.idJornadaFK
inner join tipomiembro tm on tm.idTipoMiembro = u.idTipoMiembroFK
inner join curso c on c.idcurso = u.idcursoFK;
/*4. Agregue el campo a la tabla estudiante llamada profesión*/
alter table usuario add column profesion varchar(50) not null;
describe usuario;
/*5. Realice una consulta que muestre la cantidad de votos obtenidos por cada candidato en las votaciones registradas*/
select pc.idpostCandidato as id_candidato, u.nombreUsuario as nombre, count(v.idVotacion) as Votos_Total , u.idUsuario as id_usuario from postulacioncandidato pc
inner join votacion v on pc.idpostCandidato = v.idpostCandidatoFK
inner join usuario u on pc.idUsuarioFK = u.idUsuario
group by pc.idpostCandidato,
u.nombreUsuario;
/*6. Implemente tres procedimientos almacenados, tres vistas y dos subconsultas*/
 
#Obtener la información de un usuario dado su idUsuario
DELIMITER //

CREATE PROCEDURE ObtenerUsuarioPorID(IN id_usuario INT)
BEGIN
    SELECT idUsuario, nombreUsuario, apellidoUsuario, emailUsuario
    FROM Usuario
    WHERE idUsuario = id_usuario;
END //

DELIMITER ;

call ObtenerUsuarioPorID (1)
#Obtener el estado (estadoEl) de una elección específica, usando su idEleccion
DELIMITER //

CREATE PROCEDURE ObtenerEstadoEleccion(IN id_eleccion INT)
BEGIN
    SELECT estadoEl
    FROM Eleccion
    WHERE idEleccion = id_eleccion;
END //

DELIMITER ;

call ObtenerEstadoEleccion (3)

#Obtener el nombre del cargo basado en el idCargo

DELIMITER //

CREATE PROCEDURE ObtenerNombreCargo(IN id_cargo INT)
BEGIN
    SELECT nomCargo
    FROM Cargo
    WHERE idCargo = id_cargo;
END //

DELIMITER ;


call ObtenerNombreCargo (1);
/*Vistas*/
create view VistaUsuariosActivos as
select u.idUsuario, u.nombreUsuario, u.apellidoUsuario, u.emailUsuario, tm.nomTipoMiembro as Tipo_de_Miembro, c.nomCurso as Curso
from Usuario u
inner join TipoMiembro tm on u.idTipoMiembroFK = tm.idTipoMiembro
inner join Curso c on u.idCursoFK = c.idCurso
where u.estadoU = true;

select * from VistaUsuariosActivos;

create view VistaCandidatosPorEleccion as
select u.nombreUsuario as Candidato, c.nomCargo as Cargo, COUNT(v.idVotacion) AS Votos
from PostulacionCandidato pc
inner join Usuario u on pc.idUsuarioFK = u.idUsuario
inner join Cargo c on pc.idCargoFK = c.idCargo
left join Votacion v on pc.idPostCandidato = v.idPostCandidatoFK
group by u.nombreUsuario, c.nomCargo;

select * from VistaCandidatosPorEleccion;

/*Subconsultas*/
#seleccionar a los usuarios que no han votado en ninguna elección
select u.nombreUsuario, u.apellidoUsuario
from Usuario u
where u.idUsuario not in (select v.idUsuarioVotanteFK from Votacion v);

#filtrar los candidatos que han recibido más de 3 votos. 
select u.nombreUsuario as Candidato, c.nomCargo as Cargo, COUNT(v.idVotacion) as Votos from PostulacionCandidato pc
inner join Usuario u on pc.idUsuarioFK = u.idUsuario
inner join Cargo c on pc.idCargoFK = c.idCargo
left join Votacion v ON pc.idPostCandidato = v.idPostCandidatoFK
group by  u.nombreUsuario, c.nomCargo
having count(v.idVotacion) > 3;


#Ejercicio 2 Biblioteca

-- 1. Crear la base de datos
CREATE DATABASE BibliotecaOnlineBD;
USE BibliotecaOnlineBD;

-- 2. Crear la tabla de clientes
CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único del cliente
    nombreCliente VARCHAR(100) NOT NULL, -- Nombre del cliente
    correoCliente VARCHAR(100) UNIQUE NOT NULL, -- Correo único
    telefonoCliente VARCHAR(20), -- Teléfono opcional
    direccionCliente VARCHAR(200) -- Dirección del cliente
);

-- 3. Crear la tabla de libros
CREATE TABLE Libro (
    idLibro INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único del libro
    tituloLibro VARCHAR(255) NOT NULL, -- Título del libro
    precioLibro DECIMAL(10,2) NOT NULL CHECK (precioLibro > 0), -- Precio del libro (mayor a 0)
    stockLibro INT NOT NULL CHECK (stockLibro >= 0), -- Cantidad en inventario (mínimo 0)
    categoriaLibro VARCHAR(50) -- Categoría del libro
);

-- 4. Crear la tabla de pedidos
CREATE TABLE Pedido (
    idPedido INT AUTO_INCREMENT PRIMARY KEY, -- Identificador del pedido
    idClienteFK INT NOT NULL, -- Cliente que realiza el pedido
    fechaPedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Fecha y hora del pedido
    total DECIMAL(10,2) NOT NULL, -- Monto total del pedido
    FOREIGN KEY (idClienteFK) REFERENCES Cliente(idCliente) -- Relación con la tabla Clientes
);

-- 5. Crear la tabla de detalles de pedidos
CREATE TABLE DetallePedido (
    idDetalle INT AUTO_INCREMENT PRIMARY KEY, -- Identificador del detalle del pedido
    idPedidoFK INT NOT NULL, -- Relación con el pedido
    idLibroFK INT NOT NULL, -- Relación con el libro
    cantidadLibro INT NOT NULL CHECK (cantidadLibro > 0), -- Cantidad del libro en el pedido
    precioLibro DECIMAL(10,2) NOT NULL, -- Precio unitario del libro en el pedido
    -- subtotal es una columna generada automáticamente multiplicando cantidad * precio_unitario
    -- Se almacena en la base de datos (STORED) y se recalcula cuando cambian cantidad o precio_unitario
    subtotal DECIMAL(10,2) GENERATED ALWAYS AS (cantidadLibro * precioLibro) STORED, -- cada vez que cambien los valores de las columnas cantidad o precio_unitario, el valor de subtotal se actualizará automáticamente
    FOREIGN KEY (idPedidoFK) REFERENCES Pedido(idPedido) ON DELETE CASCADE, -- Si se borra el pedido, se borra el detalle
    FOREIGN KEY (idLibroFK) REFERENCES Libro(idLibro) ON DELETE CASCADE -- Si se borra el libro, se borra el detalle
);

-- 6. Insertar datos 
INSERT INTO Cliente ( idCliente ,nombreCliente, correoCliente, telefonoCliente, direccionCliente) VALUES 
("", "Juan Pérez", "juan.perez@example.com", "123456789", "Calle 123"),
("","Ana López", "ana.lopez@example.com", "987654321", "Avenida 456"),
("","Carlos Sánchez", "carlos.sanchez@example.com", "555666777", "Calle Ficticia 789"),
("","Marta García", "marta.garcia@example.com", "444555666", "Plaza Mayor 321"),
("","Luis Rodríguez", "luis.rodriguez@example.com", "333444555", "Avenida Libertad 100");

INSERT INTO Libro (idLibro, tituloLibro, precioLibro, stockLibro, categoriaLibro)VALUES 
("", "El Principito", 25.99, 10, "Ficción"),
("", "1984", 19.50, 15, "Distopía"),
("", "Cien Años de Soledad", 35.00, 8, "Realismo mágico"),
("", "La Sombra del Viento", 22.75, 12, "Suspenso"),
("", "Crimen y Castigo", 30.00, 5, "Clásico");

INSERT INTO Pedido (idPedido, idClienteFK, total) VALUES 
(1, 1, (SELECT precioLibro * 2 FROM Libro WHERE idLibro = 1)),  -- Pedido del cliente 1 (El Principito, 2 unidades)
(2, 2, (SELECT precioLibro * 1 FROM Libro WHERE idLibro = 2)),  -- Pedido del cliente 2 (1984, 1 unidad)
(3, 3, (SELECT precioLibro * 3 FROM Libro WHERE idLibro = 3)),  -- Pedido del cliente 3 (Cien Años de Soledad, 3 unidades)
(4, 4, (SELECT precioLibro * 1 FROM Libro WHERE idLibro = 4)),  -- Pedido del cliente 4 (La Sombra del Viento, 1 unidad)
(5, 5, (SELECT precioLibro * 1 FROM Libro WHERE idLibro = 5));  -- Pedido del cliente 5 (Crimen y Castigo, 1 unidad)

INSERT INTO DetallePedido (idDetalle, idPedidoFK, idLibroFK, cantidadLibro, precioLibro)VALUES 
(1, 1, 1, 2, (SELECT precioLibro FROM Libro WHERE idLibro = 1)),  -- Detalle para el pedido 1 (El Principito, 2 unidades)
(2, 2, 2, 1, (SELECT precioLibro FROM Libro WHERE idLibro = 2)),  -- Detalle para el pedido 2 (1984, 1 unidad)
(3, 3, 3, 3, (SELECT precioLibro FROM Libro WHERE idLibro = 3)),  -- Detalle para el pedido 3 (Cien Años de Soledad, 3 unidades)
(4, 4, 4, 1, (SELECT precioLibro FROM Libro WHERE idLibro = 4)),  -- Detalle para el pedido 4 (La Sombra del Viento, 1 unidad)
(5, 5, 5, 1, (SELECT precioLibro FROM Libro WHERE idLibro = 5));  -- Detalle para el pedido 5 (Crimen y Castigo, 1 unidad)


select * from DetallePedido
-- 8. Crear trigger para actualizar el stock al realizar un pedido --- NO LO USO PARA EL PROCEDIMIENTO 
DELIMITER //
CREATE TRIGGER actualizar_stock
AFTER INSERT ON DetallePedido
FOR EACH ROW
BEGIN
    UPDATE Libro 
    SET stockLibro = stockLibro - NEW.cantidadLibro
    WHERE idLibro = NEW.idLibroFK;
END;
//
DELIMITER ;

-- 9. Procedimiento almacenado para registrar un pedido
DELIMITER //
CREATE PROCEDURE RegistrarPedido(IN cliente_id INT, IN libro_id INT, IN cantidad INT)
BEGIN
    -- Insertar el pedido con total calculado directamente
    INSERT INTO Pedido (idClienteFK, total) 
    VALUES (cliente_id, (SELECT precioLibro * cantidad FROM Libro WHERE idLibro = libro_id));
    
    -- Insertar en DetallePedido usando el último ID de pedido
    INSERT INTO DetallePedido (idPedidoFK, idLibroFK, cantidadLibro, precioLibro)
    VALUES (LAST_INSERT_ID(), libro_id, cantidad, (SELECT precioLibro FROM Libro WHERE idLibro = libro_id));
    
    -- Actualizar directamente el stock del libro en lugar de usar el trigger
    UPDATE Libro 
    SET stockLibro = stockLibro - cantidad
    WHERE idLibro = libro_id;
END;
//
DELIMITER ;
CALL RegistrarPedido(1, 1, 1);

-- 10. Consultas varias
-- Listar pedidos de un cliente específico con detalles
SELECT p.idPedido, p.fechaPedido, l.tituloLibro, dp.cantidadLibro, dp.precioLibro, dp.subtotal 
FROM Pedido p
JOIN DetallePedido dp ON p.idPedido = dp.idPedidoFK
JOIN Libro l ON dp.idLibroFK = l.idLibro
WHERE p.idClienteFK = 1;

-- Consultar el cliente con más pedidos
SELECT c.idCliente, c.nombreCliente, COUNT(p.idPedido) AS total_pedidos
FROM Cliente c
LEFT JOIN Pedido p ON c.idCliente = p.idClienteFK
GROUP BY c.idCliente, c.nombreCliente
ORDER BY total_pedidos DESC 
LIMIT 1;

-- Seleccionar libros con precio mayor a $20
SELECT * FROM Libro WHERE precioLibro > 20.00;

-- Seleccionar pedidos realizados después del 1 de octubre de 2024
SELECT * FROM Pedido WHERE fechaPedido > '2024-10-01';

-- Seleccionar libros ordenados por precio de mayor a menor
SELECT * FROM Libro ORDER BY precioLibro DESC;

-- Total de clientes y unidades vendidas
SELECT (SELECT COUNT(*) FROM Cliente) AS total_clientes, (SELECT SUM(cantidadLibro) FROM DetallePedido) AS total_unidades_vendidas;

-- Número de pedidos por cliente
SELECT c.nombreCliente, COUNT(p.idPedido) AS numero_pedidos 
FROM Cliente c
LEFT JOIN Pedido p ON c.idCliente = p.idClienteFK
GROUP BY c.idCliente;

-- Nombre del cliente, título del libro y cantidad de cada pedido
SELECT c.nombreCliente, l.tituloLibro, dp.cantidadLibro 
FROM Cliente c
JOIN Pedido p ON c.idCliente = p.idClienteFK
JOIN DetallePedido dp ON p.idPedido = dp.idPedidoFK
JOIN Libro l ON dp.idLibroFK = l.idLibro;

-- Títulos de libros y cantidad total vendida
SELECT l.tituloLibro, SUM(dp.cantidadLibro) AS total_vendido 
FROM Libro l
JOIN DetallePedido dp ON l.idLibro = dp.idLibroFK
GROUP BY l.tituloLibro;

#Extras
-- Modelo lógico para DataVerse
create database DataVerse;

CREATE TABLE Ciudad (
    idCiudad INT PRIMARY KEY AUTO_INCREMENT,
    nombreCiudad VARCHAR(100) NOT NULL,
    paisCiudad VARCHAR(100) NOT NULL
);

CREATE TABLE Sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    tipoSensor VARCHAR(50) NOT NULL,
    ubicacionSensor VARCHAR(255) NOT NULL,
    idCiudadFKS INT,
    FOREIGN KEY (idCiudadFKS) REFERENCES Ciudad(idCiudad)
);

CREATE TABLE LecturaSensor (
    idLecturaS INT PRIMARY KEY AUTO_INCREMENT,
    idSensorFK INT,
    valorLecturaS DECIMAL(10,2) NOT NULL,
    fechahoraLecturaS DATETIME NOT NULL,
    FOREIGN KEY (idSensorFK) REFERENCES Sensor(idSensor)
);

CREATE TABLE Transporte (
    idTransporte INT PRIMARY KEY AUTO_INCREMENT,
    tipoTransporte VARCHAR(50) NOT NULL,
    capacidadTransporte INT NOT NULL,
    idCiudadFKT INT,
    FOREIGN KEY (id_ciudad) REFERENCES Ciudad(id_ciudad)
);

CREATE TABLE RegistroTransporte (
    idRegistroT INT PRIMARY KEY AUTO_INCREMENT,
    idTransporteFK INT,
    pasajerosRegistroT INT NOT NULL,
    fechahoraRegistroT DATETIME NOT NULL,
    FOREIGN KEY (idTransporteFK) REFERENCES Transporte(idTransporte)
);

CREATE TABLE ConsumoEnergetico (
    idConsumo INT PRIMARY KEY AUTO_INCREMENT,
    sectorConsumo VARCHAR(100) NOT NULL,
    valorConsumo DECIMAL(10,2) NOT NULL,
    fechahoraConsumo DATETIME NOT NULL, -- 2025-04-03 15:00:00
    idciudadFK INT,
    FOREIGN KEY (idCiudadFK) REFERENCES Ciudad(idCiudad)
);

CREATE TABLE Seguridad (
    id_evento INT PRIMARY KEY AUTO_INCREMENT,
    tipo_evento VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_hora DATETIME NOT NULL,
    id_ciudad INT,
    FOREIGN KEY (id_ciudad) REFERENCES Ciudad(id_ciudad)
);

CREATE TABLE Red_Social (
    id_post INT PRIMARY KEY AUTO_INCREMENT,
    usuario VARCHAR(100) NOT NULL,
    contenido TEXT NOT NULL,
    fecha_hora DATETIME NOT NULL,
    id_ciudad INT,
    FOREIGN KEY (id_ciudad) REFERENCES Ciudad(id_ciudad)
);

CREATE TABLE Alerta (
    idAlerta INT PRIMARY KEY AUTO_INCREMENT,
    tipoAlerta VARCHAR(100) NOT NULL,
    mensajeAlerta VARCHAR(100) NOT NULL,
    fechahora DATETIME NOT NULL,
    idCiudadFKA INT,
    FOREIGN KEY (idCiudadFKA) REFERENCES Ciudad(idCiudad)
);


/*Procedimientos almacenados
Stored Procedure conjunto de instrucciones de SQL que se almacenan en la base de datos
y estos se pueden ejecutar muchas veces
*/
/*Sintaxis del Procedimiento
DELIMITER//
CREATE PROCEDURE nombreProcedimiento(parametros entrada in salida out)
BEGIN
--instrucciones de SQL 
END
// DELIMITER;
*/

select * from Mascota;
-- Creación de Procedimiento almacenado
DELIMITER //
CREATE PROCEDURE InsertarMascota(in idMascota int, nombreMascota varchar(15),
generoMascota varchar(15),razaMascota varchar(15), cantidad int)
BEGIN
-- instrucciones de SQL 
	insert into mascota values (idMascota,nombreMascota,generoMascota,
    razaMascota,cantidad);

END // 
DELIMITER ;

select * from mascota;

-- ejecutar el procedimiento 
-- Sintaxis es call nombreProcedimiento (valores)
CALL InsertarMascota(5,'Firulais','Macho','Criolla',1);

select * from producto;
describe producto;
DELIMITER //
CREATE PROCEDURE ConsultarPrecio(out precio float)
BEGIN
-- instrucciones de SQL 
	select count(*) into precio from producto;

END // 
DELIMITER ;

call ConsultarPrecio(@resultado);
 select @resultado;
 
 -- crear un procedimiento para insertar registros en tabla débil
 -- crear procedimiento consultar las vacunas que se le ha aplicado a una mascota
 -- y que enfermedad esta atacando
 
/*Vistas Views Es una consulta almacenada en la base de datos que 
genera una tabla virtual*/

/* sintaxis 
create view nombreVista as 
select valoresaConsultar from nombreTabla where condiciones
Ppara ejecutar se realiza una consulta de la vista*/
describe cliente;
create view vistaCliente as
Select * from cliente where cedulaCliente=7226705;

select * from vistaCliente;

/*modificar uuna vista 
alter view nombreVista as 
select valoresaConsultar from nombreTabla where condiciones*/

/*eliminar una vista

drop view nombreVista*/

/* disparadores Triggers
tipos
before insert, before update, 
before delete: se ejecutan antes de la operación.

after insert, after update, 
after delete: se ejecutan despues de la operación.

sintaxis
DELIMITER //
CREATE TRIGGER nombreTrigger
AFTER INSERT ON nombreTabla
FOR EACH ROW
BEGIN
-- INSTRUCCIONES SQL

END //
DELIIMITER;
*/

/*Crear un trigger para registrar en una tabla consolidado 
cada vez que se inserte una mascota*/

DELIMITER //
CREATE TRIGGER regitrarConsolidadoMascota
AFTER INSERT ON mascota
FOR EACH ROW
BEGIN
	INSERT INTO consolidado values(NEW.idMascota,NEW.nombreMascota, new.generoMascota, new.razaMascota,new.cantidad);
END //
DELIMITER ;

drop trigger regitrarConsolidadoMasco;
select * from mascota;
describe mascota;


SET SQL_SAFE_UPDATES=0;
/*Sintaxis de Triggers
create trigger nombre_del_trigger 
{before|after}{insert|select|update|delete}
on nombre_tabla
for each row
begin
--Instrucciones de sql--
end;
*/
Variables old y new (acceder a registros)
New: Al nuevo valor que se va a insertar o modificar.
old: el valor anterior.

Ejemplo:
create trigger validar_precio
after insert on producto
for each row
begin
	if new.precio<0 then
		signal sqlstate '45000'
		set message_text='el precio es incorrecto';
	end if;
end;

create trigger registrar_cambio
after update on empleado
for each row
begin
	insert into historial_cambios values(old.id,old.nobre,new.nombre, now())
end;

create trigger actualizar_inventario
after insert on venta
for each row
begin
	update inventario
    set cantidad=cantidad-new.cantida_vendida
    where idProducto=new.IdProducto;
end;

create trigger registro_papelera
before delete on usuarios
for each row
begin
	insert into usuariosEliminados values (old.id, ol.nombre, ol.apellido, ol.telefono, now());
end;

SET SQL_SAFE_UPDATES=0;

/*Subconsultas: una consulta ue esta dentro de otra consulta
Tipos:
Subconsultas de 1 columna: Devuelve una lista de valores en una
sola columna
Subconsultas de varias columna: Devuelve multiples valores varias 
columnas
Subconsultas correlacionales: Depende de la consulta principal*/
/*Sintaxis

Select camposaConsultar from nombreTablaPirncipal 
Where (Select camposaConsultardelaSubconsulta from nombreTablasecundaria
where condicion)*/
SELECT s.tipo, s.ubicacion, ls.valor, ls.fecha_hora 
FROM Sensor s
JOIN Lectura_Sensor ls ON s.id_sensor = ls.id_sensor
ORDER BY ls.fecha_hora DESC;

SELECT sector, SUM(consumo) AS total_consumo 
FROM Consumo_Energetico 
GROUP BY sector;/*