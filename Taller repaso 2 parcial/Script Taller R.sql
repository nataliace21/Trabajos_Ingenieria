/*Taller1*/

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
describe usuario
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


call ObtenerNombreCargo (1)
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

