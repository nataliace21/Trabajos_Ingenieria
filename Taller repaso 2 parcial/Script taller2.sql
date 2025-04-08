CREATE DATABASE BibliotecaOnlineBD;
USE BibliotecaOnlineBD;


CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único del cliente
    nombreCliente VARCHAR(100) NOT NULL, -- Nombre del cliente
    correoCliente VARCHAR(100) UNIQUE NOT NULL, -- Correo único
    telefonoCliente VARCHAR(20), -- Teléfono opcional
    direccionCliente VARCHAR(200) -- Dirección del cliente
);

CREATE TABLE Libro (
    idLibro INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único del libro
    tituloLibro VARCHAR(255) NOT NULL, -- Título del libro
    precioLibro DECIMAL(10,2) NOT NULL CHECK (precioLibro > 0), -- Precio del libro (mayor a 0)
    stockLibro INT NOT NULL CHECK (stockLibro >= 0), -- Cantidad en inventario (mínimo 0)
    categoriaLibro VARCHAR(50) -- Categoría del libro
);

CREATE TABLE Pedido (
    idPedido INT AUTO_INCREMENT PRIMARY KEY, -- Identificador del pedido
    idClienteFK INT NOT NULL, -- Cliente que realiza el pedido
    fechaPedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Fecha y hora del pedido
    total DECIMAL(10,2) NOT NULL, -- Monto total del pedido
    FOREIGN KEY (idClienteFK) REFERENCES Cliente(idCliente) -- Relación con la tabla Clientes
);

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