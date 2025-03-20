Lunes 1
/*Bases de datos*/
/Consultas 0000-00-00/

create database EjercicioClase;

use EjercicioClase;
create table Cliente(
codigoCliente int auto_increment primary key,
nombreCliente varchar (15) not null,
domicilioCliente varchar (15) not null,
ciudadCliente varchar (15)not null,
provinciaCliente varchar (15)not null,
telefonoCliente varchar (15) not null
);

describe Cliente;
insert into Cliente (codigoCliente,nombreCliente,domicilioCliente,ciudadCliente,provinciaCliente,telefonoCliente) values
(" ","laura","cra45 #62a-35","Bogota","cundinamarca","3078447599"),
(" ","Mateo","cra85 #69b-86","Medellin","Antioquia","3048772984"),
(" ","Camila","cl47 #60b-30","Cartagena","Murcia","3115784785"),
(" ","Samuel","cl49 #6-60","Bucaramanga","Santander","3068774841"),
(" ","Ana","cra49 #08-48","Melgar","Tolima","3017558240");

/Consulta general/
select * from Cliente;
/Consultas especificas/
select codigoCliente,nombreCliente from cliente;
/*Clausuras where condiciones operadores lÃ³gicos or () and () 
aritmeticos +- multi divi modulo % comparaciÃ³n == = <>*/
select domicilioCliente from Cliente where nombreCliente = "Mateo"or codigos ;
select * from Cliente where nombreCliente = "Mateo";
select * from Cliente where nombreCliente <> "Mateo"; 
select * from Cliente where codigoCliente = 2; 
select * from Cliente where nombreCliente <=3; 

select * from Cliente where not nombreCliente = "Mateo";

/Alias select campo as "nombre que se sea mostrar"
select nombreCliente as "nombre cliente", domicilioCliente as "dirrecion cliente", ciudadCliente,provinciaCliente as "lugar del cliente",
telefonoCliente as "celular del cliente" from Cliente;

/Ordenar by asc desc select camposaConsultar
from nombreTabla order by campoOrdenar tipo orden*/

select * from Cliente order by telefonoCliente asc;
select * from Cliente order by telefonoCliente desc;

select nombreCliente as "Nombre del cliente", domicilioCliente,ciudadCliente,provinciaCliente,telefonoCliente
from Cliente where nombreCliente = "laura" order by  telefonoCliente asc;

/Consultas agrupando gruop by select camposaconsuktar/

select nombreCliente as "Nombre Cliente", domicilioCliente,ciudadCliente,provinciaCliente,telefonoCliente
from Cliente where nombreCliente = "laura" group by  nombreCliente asc;

/* like not like select camposConsultar from nombreTabla condicion like valor */
select * from Cliente where nombreCliente like "%a%";  /contengan una a/
select * from Cliente where nombreCliente like "%Ma%";  /contengan una a/
select * from Cliente where nombreCliente like "m%";  /empiecen por una m/
select * from Cliente where nombreCliente like "%g";  /terminen una g/

Tarea
create database TechCorp;
USE TechCorp;

/* Creación de la tabla */
create table Empleado (
    nombreEmpleado varchar(15) primary key,
    edadEmpleado int NOT NULL,
    salarioEmpleado int NOT NULL,
    depEmpleado varchar(15) NOT NULL,
    aniocontEmpleado int NOT NULL
);

DESCRIBE Empleado;

/* Inserción de datos */
insert into Empleado (nombreEmpleado, edadEmpleado, salarioEmpleado, depEmpleado, aniocontEmpleado) values
("Carlos", 40, 5000, "Ventas", 2018),  
("Ana", 28, 3900, "Ventas", 2022),  
("Camila", 31, 4100, "Finanzas", 2019),  
("Alejandro", 26, 3700, "Ventas", 2023),  
("Luis", 35, 4500, "IT", 2017),  
("Elena", 32, 3200, "Ventas", 2023),  
("Arturo", 45, 6000, "Gerencia", 2015),  
("Sofía", 29, 3100, "Ventas", 2020),  
("Cristian", 50, 7000, "Dirección", 2010),  
("Valeria", 27, 2800, "Ventas", 2024);  

/* Consulta general */
select * from Empleado;

/* Altos ingresos: ¿Quiénes son los empleados que ganan más de $4,000? */
select * from Empleado where salarioEmpleado > 4000;

/* Fuerza de ventas: Extrae la lista de empleados que trabajan en el departamento de Ventas */
select * from Empleado where depEmpleado = "Ventas";

/* Rango de edad: Encuentra a los empleados que tienen entre 30 y 40 años */
select * from Empleado where edadEmpleado >= 30 and edadEmpleado <= 40;

/* Nuevas contrataciones: ¿Quiénes han sido contratados después del año 2020? */
select * from Empleado where aniocontEmpleado > 2020;

/* Distribución de empleados: ¿Cuántos empleados hay en cada departamento? */
select depEmpleado, COUNT(*) as total_empleados from Empleado group by depEmpleado;

/* Análisis salarial: ¿Cuál es el salario promedio en la empresa? */
select AVG(salarioEmpleado) as salario_promedio from Empleado;

/* Nombres selectivos: Muestra los empleados cuyos nombres comienzan con "A" o "C" */
select * from Empleado where nombreEmpleado like "A%" or nombreEmpleado like "C%";

/* Departamentos específicos: Encuentra a los empleados que no pertenecen al departamento de IT */
select * from Empleado where depEmpleado <> "IT";

/* El mejor pagado: ¿Quién es el empleado con el salario más alto?*/

select * from Empleado order by salarioEmpleado desc LIMIT 1;


Miercoles 

create database techCorp;
use TechCorp;

/* Creación de la tabla */
create table Empleado (
	idEmpleado int primary key,
    nombreEmpleado varchar(15),
    edadEmpleado int NOT NULL,
    salarioEmpleado int NOT NULL,
    depEmpleado varchar(15) NOT NULL,
    aniocontEmpleado int NOT NULL
);

create table Departamento (
idDep int primary key,
idEmpleadoFk int not null,
nombreDep varchar(15),
foreign key (idEmpleadoFk) references Empleado(idEmpleado) on delete cascade on update cascade
);



describe Empleado;

/* Inserción de datos */

insert into Empleado (nombreEmpleado, edadEmpleado, salarioEmpleado, depEmpleado, aniocontEmpleado) values
("Carlos", 40, 5000, "Ventas", 2018,2025),  
("Ana", 28, 3900, "Ventas", 2022,2025),  
("Camila", 31, 4100, "Finanzas", 2019, 2025),  
("Alejandro", 26, 3700, "Ventas", 2023,2025),  
("Luis", 35, 4500, "IT", 2017,2025),  
("Elena", 32, 3200, "Ventas", 2023,2025),  
("Arturo", 45, 6000, "Gerencia", 2015,2025),  
("Sofía", 29, 3100, "Ventas", 2020,2025),  
("Cristian", 50, 7000, "Dirección", 20102025),  
("Valeria", 27, 2800, "Ventas", 2024, 2025);  

/* Consulta general */
select * from Empleado;

/* Altos ingresos: ¿Quiénes son los empleados que ganan más de $4,000? */
select * from Empleado where salarioEmpleado > 4000;

/* Fuerza de ventas: Extrae la lista de empleados que trabajan en el departamento de Ventas */
select * from Empleado where depEmpleado = "Ventas";
select * from Empleado where depEmpleado = "Gerencia";


/* Rango de edad: Encuentra a los empleados que tienen entre 30 y 40 años */
select * from Empleado where edadEmpleado >= 30 and edadEmpleado <= 40;

/* Nuevas contrataciones: ¿Quiénes han sido contratados después del año 2020? */
select * from Empleado where aniocontEmpleado > 2020;

/* Distribución de empleados: ¿Cuántos empleados hay en cada departamento? */
select COUNT(depEmpleado) as total_empleados from Empleado group by depEmpleado;
select depEmpleado, COUNT(depEmpleado) as total_empleados from Empleado group by  depEmpleado desc;

select COUNT(nombreEmpleado) as "ganan_mas" from Empleado where salarioEmpleado > select AVG(salarioEmpleado)  from Empleado;
/* Análisis salarial: ¿Cuál es el salario promedio en la empresa? */
select AVG(salarioEmpleado) as salario_promedio from Empleado;
/* Nombres selectivos: Muestra los empleados cuyos nombres comienzan con "A" o "C" */
select * from Empleado where nombreEmpleado like "A%" or nombreEmpleado like "C%";
/* Departamentos específicos: Encuentra a los empleados que no pertenecen al departamento de IT */
select * from Empleado where depEmpleado <> "IT";
/* El mejor pagado: ¿Quién es el empleado con el salario más alto? */
select * from Empleado order by salarioEmpleado desc LIMIT 1;
select nombreEmpleado,  salarioEmpleado from Empleado where salarioEmpleado= (select max(salarioEmpleado)from Empleado);
/*verififcar valor de rango*/
select * from Empleado where edadEmpleado between 30 and 40;
/* consultar valor denotr una lista de valores in */
select * from Empleado where depEmpleado (ventas, it);
/*funciones agregadadas*/
select * from Empleado order by salarioEmpleado desc;
select * from Empleado where depEmpleado is null;
/* rango de edad: Encuentra a los empleados que tienen entre 30 y 40 años */
SELECT * FROM Empleado WHERE edadEmpleado BETWEEN 30 AND 40;
/* Nuevas contrataciones: ¿Quiénes han sido contratados después del año 2020? */
SELECT * FROM Empleado WHERE aniocontEmpleado > 2020;
/* Distribución de empleados: ¿Cuántos empleados hay en cada departamento? */
SELECT depEmpleado, COUNT(depEmpleado) AS total_empleados FROM Empleado GROUP BY depEmpleado;
/* Análisis salarial: ¿Cuál es el salario promedio en la empresa? */
SELECT AVG(salarioEmpleado) AS salario_promedio FROM Empleado;
/* Nombres selectivos: Muestra los empleados cuyos nombres comienzan con "A" o "C" */
SELECT * FROM Empleado WHERE nombreEmpleado LIKE "A%" OR nombreEmpleado LIKE "C%";
/* Departamentos específicos: Encuentra a los empleados que no pertenecen al departamento de IT */
SELECT * FROM Empleado WHERE depEmpleado <> "IT";
/* El mejor pagado: ¿Quién es el empleado con el salario más alto? */
SELECT * FROM Empleado ORDER BY salarioEmpleado DESC LIMIT 1;
SELECT nombreEmpleado, salarioEmpleado FROM Empleado WHERE salarioEmpleado = (SELECT MAX(salarioEmpleado) FROM Empleado);
/* Verificar valor de rango (rango de edad de 30 a 40 años) */
SELECT * FROM Empleado WHERE edadEmpleado BETWEEN 30 AND 40;
/* Consultar valores dentro de una lista */
SELECT * FROM Empleado WHERE depEmpleado IN ('Ventas', 'IT');
/* Funciones agregadas: Calcular años de contrato */
SELECT *, (2025 - aniocontEmpleado) AS "Anios contrato" FROM Empleado;
/* Consulta de los tres empleados mejor pagados */
SELECT * FROM Empleado ORDER BY salarioEmpleado DESC LIMIT 3;
/* calcular el bono del 10% para cada empleado */
SELECT nombreEmpleado, salarioEmpleado, salarioEmpleado * 0.1 AS bono FROM Empleado;
/* Consulta utilizando HAVING y GROUP BY para mostrar departamentos con más de 5 empleados */
SELECT depEmpleado, COUNT(*) AS "total_empleados" FROM Empleado GROUP BY depEmpleado HAVING COUNT(*) >= 5;

/*Jueves*/

CREATE DATABASE TechCorp;

USE TechCorp;

/* Creación de las tablas */

CREATE TABLE Departamento (
    idDep INT Auto_increment PRIMARY KEY,
    nombreDep VARCHAR(15) not null
);

create table Cargo(
	idCargo varchar(20) primary key,
	nombreCargo varchar(20),
	rangoCargo varchar(20),
	descripcionCargo varchar(20)
);
CREATE TABLE Empleado (
    idEmpleado INT PRIMARY KEY,
    nombreEmpleado VARCHAR(15),
    edadEmpleado INT NOT NULL,
    salarioEmpleado INT NOT NULL,
    depEmpleado VARCHAR(15) NOT NULL,
    aniocontEmpleado INT NOT NULL,
    idCargoFk varchar(20),
    idDepFk int NOT NULL,
    FOREIGN KEY (idCargoFk) REFERENCES Cargo(idCargo) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idDepFk) REFERENCES Departamento(idDep) ON DELETE CASCADE ON UPDATE CASCADE
);

DESCRIBE Empleado;
DESCRIBE Departamento;
DESCRIBE Cargo;

/*Inserción de datos*/
INSERT INTO Departamento (idDep, nombreDep) VALUES
("  ", "Ventas"),
("  ", "Dirección"),
("  ", "IT"),
("  ", "Gerencia"),
("  ", "Finanzas");
INSERT INTO Cargo (idCargo, nombreCargo, rangoCargo, descripcionCargo) VALUES
("103", "Gerente de Operaciones", "2", "Responsable de la supervisión y optimización de los procesos operativos dentro de la empresa."),
("108", "Analista de Datos", "4","Encargado del análisis e interpretación de datos para la toma de decisiones estratégicas."),
("109", "Supervisor de Producción","2","Coordina y supervisa las actividades en la línea de producción para garantizar eficiencia y calidad"),
("106 ", "Contador","1","Responsable de la cuentas de cobro de los pagos dentro de la empresa."),
("102 ", "Asistente Administrativo","3", "Brinda apoyo en tareas administrativas, organización de documentos y atención al cliente interno");
INSERT INTO Empleado (idEmpleado, nombreEmpleado, edadEmpleado, salarioEmpleado, depEmpleado, aniocontEmpleado, idCargoFk,idDepFk) VALUES
(" ", "Carlos", 40, 5000, "Ventas", 2018,"103", 1),
(" ", "Ana", 28, 3900, "Finanzas", 2022,"108", 2),
(" ", "Camila", 31, 4100, "Finanzas", 2019,"109",3),
(" ", "Alejandro", 26, 3700, "Ventas", 2023, "102",4 );

select * from Departamento;
select * from Cargo;
select * from Empleado;

/*1 .mostrar en pantalla los empleados que tengan un cargo especifico*/

SELECT idCargo, nombreCargo, rangoCargo, descripcionCargo from Cargo where rangoCargo = 1;

/*2. mostrar empleados con antiguedad de mas de 3 años, departamemento cargo y salario*/

SELECT nombreEmpleado AS "Nombre", nombreCargo AS "Cargo", rangoCargo AS "Rango" FROM Empleado INNER JOIN Cargo ON Empleado.idCargoFk = Cargo.idCargo
WHERE rangoCargo = 'Rango';

/*3. mostrar empleados con antiguedad de mas de 3 años, departamemento cargo y salario*/
SELECT nombreEmpleado AS "Nombre", depEmpleado AS "Departamento", nombreCargo AS "Cargo", salarioEmpleado AS "Salario"FROM Empleado
INNER JOIN Cargo ON Empleado.idCargoFk = Cargo.idCargo WHERE YEAR(CURDATE()) - aniocontEmpleado > 3;

/* 4 mostrar toda la informacion de un  empleado (nombre,fecha de contrato,departamento,años 
de antiguedad,cargo actual,rango del cargo*/

SELECT nombreEmpleado AS "Nombre", aniocontEmpleado AS "Fecha de Contrato", depEmpleado AS "Departamento",TIMESTAMPDIFF(YEAR, STR_TO_DATE(CONCAT(aniocontEmpleado, '-01-01'), 
'%Y-%m-%d'), CURDATE()) AS "Años de Antigüedad", AS "Cargo Actual", rangoCargo AS "Rango del Cargo"FROM Empleado INNER JOIN Cargo ON Empleado.idCargoFk = Cargo.idCargo;


5. mostrar todos los cargos que no tengan empleados asignados*/


