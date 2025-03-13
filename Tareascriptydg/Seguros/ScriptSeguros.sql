Create database Seguros;


USE Seguros;

create table compania(
idCompania int AUTO_INCREMENT PRIMARY KEY,
nitCompania VARCHAR(20) NOT NULL,
nombreCompania VARCHAR(20) NOT NULL,
fechafunCompania DATE NOT NULL,
replegalCompania VARCHAR(20) NOT NULL
);

create table automovil(
placaAutomovil int AUTO_INCREMENT PRIMARY KEY,
idCompaniaFK int NOT NULL,
serialchasAutomovil VARCHAR(20) NOT NULL,
marcaAutomovil VARCHAR(20) NOT NULL,
modeloAutomovil VARCHAR(20) NOT NULL,
aniofabAutomovil int NOT NULL, 
cilindrajeAutomovil int NOT NULL,
tipoAutomovil VARCHAR(30) NOT NULL,
foreign key (idCompaniaFK) references compania (idCompania) on delete cascade on update cascade
);

create table accidente(
idAccidente int AUTO_INCREMENT PRIMARY KEY,
fechaAccidente date NOT NULL,
lugarAccidente VARCHAR(20) NOT NULL,
numheridosAccidente int NOT NULL,
nummuertosAccidente int NOT NULL
);

create table detallea(
placaAutomovilFK int NOT NULL,
idAccidenteFK int NOT NULL,
dañosDetalle VARCHAR(100) NOT NULL,
foreign key (placaAutomovilFK) references automovil (placaAutomovil) on delete cascade on update cascade,
foreign key (idAccidenteFK) references accidente (idAccidente) on delete cascade on update cascade
);
    

describe compania;
describe automovil;
describe accidente;
describe detallea;