CREATE TABLE clientes (
    id INT PRIMARY KEY,
    nombre VARCHAR(100),
    correo VARCHAR(100)
);

CREATE TABLE productos (
    id INT PRIMARY KEY,
    nombre VARCHAR(100),
    precio DECIMAL(10,2)
);

CREATE TABLE ordenes (
    id INT PRIMARY KEY,
    cliente_id INT,
    producto_id INT,
    cantidad INT,
    fecha DATE,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);

-- Insertar clientes
INSERT INTO clientes VALUES 
(1, 'Juan Torres', 'juan.torres@mail.com'),
(2, 'Carla Mendoza', 'carla.mendoza@mail.com'),
(3, 'Luis Salazar', 'luis.salazar@mail.com'),
(4, 'Rosa Paredes', 'rosa.paredes@mail.com'),
(5, 'Diego Huamán', 'diego.huaman@mail.com');

-- Insertar productos
INSERT INTO productos VALUES 
(1, 'Audífonos Bluetooth', 100.00),
(2, 'Teclado Mecánico', 150.00),
(3, 'Lámpara LED', 40.00),
(4, 'Silla Ergonómica', 300.00),
(5, 'Monitor 24"', 200.00);

-- Insertar órdenes
INSERT INTO ordenes VALUES 
(1, 1, 2, 1, '2025-03-10'),
(2, 1, 5, 1, '2025-03-11'),
(3, 2, 1, 2, '2025-03-12'),
(4, 3, 3, 1, '2025-03-12'),
(5, 4, 1, 1, '2025-03-13'),
(6, 4, 4, 1, '2025-03-14'),
(7, 5, 5, 1, '2025-03-15'),
(8, 3, 2, 1, '2025-03-15'),
(9, 2, 4, 1, '2025-03-16'),
(10, 1, 3, 2, '2025-03-17');

--=========================================================================================================================--
--Consulta:
--=========================================================================================================================--
--1. ¿Cuál es el producto más vendido?
SELECT p.nombre, SUM(o.cantidad) AS total_vendido
FROM ordenes o
JOIN productos p ON o.producto_id = p.id
GROUP BY p.nombre
ORDER BY total_vendido DESC
LIMIT 1;

--2. ¿Qué cliente ha comprado más veces?
SELECT c.nombre, COUNT(o.id) AS total_ordenes
FROM ordenes o
JOIN clientes c ON o.cliente_id = c.id
GROUP BY c.nombre
ORDER BY total_ordenes DESC
LIMIT 1;

-- 3. ¿Cuánto se vendió por producto el último mes?
SELECT p.nombre, SUM(o.cantidad * p.precio) AS total_vendido
FROM ordenes o
JOIN productos p ON o.producto_id = p.id
WHERE o.fecha >= '2025-03-01' AND o.fecha < '2025-04-01'
GROUP BY p.nombre
ORDER BY total_vendido DESC;
