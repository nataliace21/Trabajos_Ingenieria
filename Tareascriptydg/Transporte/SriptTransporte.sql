Create database Transporte;


USE Transporte;


create table camion(
placaCamion int AUTO_INCREMENT PRIMARY KEY,
modeloCamion VARCHAR(20) NOT NULL,
potenciaCamion VARCHAR(20) NOT NULL,
tipoCamion VARCHAR(30) NOT NULL
);
create table detallec(
idDetallec int AUTO_INCREMENT PRIMARY KEY,
idCamioneroFK int NOT NULL,
placaCamionFK int NOT NULL,
foreign key (idCamioneroFK) references camionero(idCamionero) on delete cascade on update cascade,
foreign key (placaCamionFK) references camion(placaCamion) on delete cascade on update cascade
);
create table camionero(
idCamionero int AUTO_INCREMENT PRIMARY KEY,
nombreCamionero VARCHAR(20) NOT NULL,
telefonoCamionero VARCHAR(20) NOT NULL,
direccionCamionero VARCHAR(30) NOT NULL
);

create table paquete(
codigoPaquete int AUTO_INCREMENT PRIMARY KEY,
codigoCiudadFK int NOT NULL,
FKidCamionero int NOT NULL,
descripcionPaquete VARCHAR(20) NOT NULL,
destinatarioPaquete VARCHAR(20) NOT NULL,
dirreccionPaquete VARCHAR(30) NOT NULL,
foreign key (codigoCiudadFK) references ciudad(codigoCiudad) on delete cascade on update cascade,
foreign key (FKidCamionero) references camionero(idCamionero) on delete cascade on update cascade
);

create table ciudad(
codigoCiudad int AUTO_INCREMENT PRIMARY KEY,
nombreCiudad VARCHAR(20) NOT NULL
);


describe camionero;
describe camion;
describe ciudad;
describe paquete;
describe detallec;
