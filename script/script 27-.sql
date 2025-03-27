/*Sentencias de DDL/
/Creacion de base de datos*/
create database PetStore;
/*Habilitar la base de datos*/
use PetStore;
/*Creacion de tablas*/
create table Pet(
idPet int primary key,
nombrePet varchar (15),
generoPet varchar (15),
razaPet varchar (15),
cantidad int (10)
);
create table Cliente(
cedulaCliente int primary key,
nombreCliente varchar (15),
apellidoCliente varchar (15),
direccionCliente varchar (10),
telefono int (10),
idPetFK int,
foreign key (idPetFK) references pet (idPet) on delete cascade on update cascade
);

drop table cliente;
create table Producto(
codigoProducto int primary key,
nombreProducto varchar (15),
marca varchar (15),
precio float,
cedulaClienteFK int
);
create table Vacuna(
codigoVacuna int primary key,
nombreVacuna varchar (15),
dosisVacuna int (10),
enfermedad varchar (15)
);
create table Pet_Vacuna(
codigoVacunaFK int,
idPetFK int,
enfermedad varchar (15)
);
/*crear las relaciones*/
alter table Cliente
add constraint FClientePet
foreign key (idPetFK)
references Pet(idPet);

alter table Producto
add constraint FKProductoCliente
foreign key (cedulaClienteFK)
references Cliente(cedulaCliente);

alter table Pet_Vacuna
add constraint FKMV
foreign key (idPetFK)
references Pet(idPet );

alter table Pet_Vacuna
add constraint FKVM
foreign key (codigoVacunaFK)
references Vacuna(codigoVacuna);

describe Pet;
select * from Cliente;
insert into Pet (idPet,nombrePet,generoPet,razaPet,cantidad) values
(1,"Bruno","Macho","Beagle", 4),
(2,"Milo","Hembra", "Poodle", 10);
describe Cliente;
insert into Cliente (cedulaCliente,nombreCliente,apellidoCliente,direccionCliente, telefono,idPetFK) values
(1011327854,"laura","Enciso","cra45 #62a-35",3078447599,2),
(1051387857,"Mateo","Morales","cra85 #69b-86",3048772984,1);
describe Cliente;
describe Producto;
insert into Producto (codigoProducto,nombreProducto,marca,precio,cedulaClienteFK) values
(654,"comida","laika", 1000,1011327854),
(784,"cama","pet",26000,1051387857);
describe Vacuna;
insert into Vacuna (codigoVacuna,nombreVacuna,dosisVacuna,enfermedad) values
(44,"Bordetella",10,"parvovirus"),
(49,"distemper",7,"moquillo");
describe Pet_Vacuna;
insert into Pet_Vacuna (codigoVacunaFK,idPetFK,enfermedad) values
(44,1,"parvovirus"),
(49,2,"moquillo");


select m * 

/*Elimiacion
#delete from nombreTabla  where condicion*/

delete from  producto where codigoProducto = 11;
describe producto;
delete from producto;

/* Procedimiento almacenados
stored procedure conjunto de instrucciones de SQL que se alamacenan en el y estos se pueden ejecutar muchas veces 
*/
/* Encapsular logica de negocios en un nase de datos , el procedimiento se conecta directamente a la base de datos y es mas seguro que hacer directamente una senttencia 

DELIMITER
CREATE PROCEDURE nombreProcedimiento (parametros: Entrada IN, Salida OUT)
BEGIN 
--Instruccionoes 
END

//DELIMITER*/

select * from producto;
DELIMITER//
CREATE PROCEDURE InsertarPet(in  idPet int, nombrePet varchar(15), generoPet varchar (15), razaPet varchar(15),cantidad int)
begin 
	insert into pet values ( idPet, nombrePet, generoPet, razaPet, cantidad);
end//
DELIMITER;
/*call nombreprocedimeinto  (valores)*/

call InsertarPet (3, " lisa" , "hembra" , "Criollo",7)

select * from Pet;
DELIMITER//ConsultarPrecio
CREATE PROCEDURE ConsultarPrecio(out precio float )
begin 
	select count(*) into precio from producto; 
    
end//
DELIMITER;

call ConsultarPrecio(@resultado);
	select @resultado;
    
    
-- crear un procedimiento para insertar registros en tabla débil
DELIMITER //
CREATE PROCEDURE InsertarVacuna(in codigoVacuna int, in idPet int, in enfermedad varchar(15))
begin
    INSERT INTO Pet_Vacuna (codigoVacunaFK, idPetFK, enfermedad)
    VALUES (codigoVacuna, idPet, enfermedad);
end//
DELIMITER ;

call InsertarVacuna(44, 1, 'Parvovirus');
select * from Pet_Vacuna;
 -- crear procedimiento consultar las vacunas que se le ha aplicado a una mascota
 DELIMITER //
CREATE PROCEDURE ConsultarVacunasMascota(in idPet int)
begin
    select p.nombrePet as Mascota, v.nombreVacuna as Vacuna, pv.enfermedad as Enfermedad
    from Pet p
    join Pet_Vacuna pv on p.idPet = pv.idPetFK
    join Vacuna v on pv.codigoVacunaFK = v.codigoVacuna where p.idPet = idPet;
end//
DELIMITER ;
call ConsultarVacunasMascota(1);
select * from Pet_Vacuna;

-- y que enfermedad esta atacando
 
 DELIMITER //
CREATE PROCEDURE ConsultarPrecioTotal(out precioTotal float)
begin
    select SUM(precio) into precioTotal from Producto;
end//
DELIMITER ;
call ConsultarPrecioTotal(@resultado);


/* Vistas views es una consulta */
/* Tipo de consulta almacenda que no queda registrada en la base de datos, quenera una tabla virtual*/

/* Sintaxis
create  view nombreVista as 
select valoresConsultar from nombreTabla where condiciones" 
consultas simples
condcionales
ordenadas
subconsultas "
 para ejecutar se realiza una consulta de la vista*/

create view  vistaCliente as 
select * from cliente where cedulaCliente=1011327854;

select * from vistaCliente;

create view  telefonoCliente as 
select * from cliente where telefono like "%4%"
and telefono like "%6%" and telefono like  "%7%";
select * from telefonoCliente;

drop view telefonoCliente 

/* modificar una vista 
alter view nombreVista as 
select valoresConsultar from nombreTabla where condiciones" */
/* Eliminar una vista 
Drop view nombreVista */


/* Disparadores Triggers
Tipos:
before insert, before update, before delete: se ejecutan antes de la operacion 
afeter insert, after update, after delete:  se ejecutan despues de la operacion


Sintasix

DELIMITER //
CREATE TRIGGER nombreTrigger
AFTER INSERT ON nombreTABLA 
FOR EACH ROW 
BEGIN 
--INSTRUCCIONES  SQL

END//
DELIMITER ; */
/* Crear un trigger para registrar en una tabla consolidado cada ves que se inserte una mascota*/


create table consolidado(
idPet int primary key,
nombrePet varchar (15),
generoPet varchar (15),
razaPet varchar (15),
cantidad int (10)
);

create table eliminados(
cedulaCliente int primary key,
nombreCliente varchar (15),
apellidoCliente varchar (15),
direccionCliente varchar (10),
telefono int (10),
idPetFK int
);
 
DELIMITER //
CREATE TRIGGER  registrarConsolidadoMascot
AFTER INSERT ON pet
FOR EACH ROW
BEGIN 
	INSERT INTO consolidado values ( NEW.idpet, NEW.nombrePet, NEW.generoPet, NEW.razaPet, NEW.cantidad );
END //
DELIMITER ;
SELECT * FROM consolidado;
insert into pet  values (8, "mateo", "Macho", "labrador", 5)

create table eliminados(
cedulaCliente int primary key,
nombreCliente varchar (15),
apellidoCliente varchar (15),
direccionCliente varchar (10),
telefono int (10),
idPetFK int
);
DROP TABLE eliminados;
/* Cada cliente eliminado */

DELIMITER//
CREATE TRIGGER registrarclientesEilinados
before DELETE on cliente
FOR EACH ROW
BEGIN 
	INSERT INTO eliminados values ( old.cedulaCliente, old.nombreCliente, old.apellidoCliente, old.direccionCliente, 
    old.telefono, old.idPetFK);
    
END //
DELIMITER ;


