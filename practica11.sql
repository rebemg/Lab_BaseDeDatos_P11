DROP TABLE IF EXISTS empleado CASCADE;
DROP TABLE IF EXISTS departamento CASCADE;
DROP TABLE IF EXISTS cliente CASCADE;
DROP TABLE IF EXISTS producto CASCADE;
DROP TABLE IF EXISTS detalle_pedido CASCADE;
DROP TABLE IF EXISTS pedido CASCADE;
DROP TABLE IF EXISTS inventario CASCADE;

CREATE TABLE IF NOT EXISTS empleado (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50),
    puesto VARCHAR(50),
    salario NUMERIC(10,2),
    fecha_contratacion DATE
);


CREATE TABLE IF NOT EXISTS departamento (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS cliente (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(100)
);


CREATE TABLE IF NOT EXISTS producto (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio NUMERIC(10,2)
);


CREATE TABLE IF NOT EXISTS pedido (
    id SERIAL PRIMARY KEY,
    cliente_id INT NOT NULL REFERENCES cliente(id),
    fecha DATE NOT NULL
);


CREATE TABLE IF NOT EXISTS detalle_pedido (
    pedido_id INT NOT NULL REFERENCES pedido(id),
    producto_id INT NOT NULL REFERENCES producto(id),
    cantidad INT NOT NULL,
    PRIMARY KEY(pedido_id, producto_id)
);

CREATE TABLE inventario (
    producto_id INT PRIMARY KEY REFERENCES producto(id),
    stock INT NOT NULL
);

INSERT INTO empleado (nombre, puesto, salario, fecha_contratacion)
VALUES 
('Ana Torres', 'Analista', 15000, '2026-10-02'),
('Luis Gómez', 'Gerente', 30000, '2026-09-15'),
('Marta Ruiz', 'Desarrolladora', 22000, '2026-08-10'),
('Carlos Pérez', 'Soporte', 14000, '2026-07-01'),
('Diana López', 'Analista', 16000, '2026-10-01');

INSERT INTO departamento (nombre)
VALUES 
('Recursos Humanos'),
('Finanzas'),
('Tecnología'),
('Ventas');

INSERT INTO cliente (nombre, direccion) VALUES
('Luis Gómez', 'Av. Universidad 123'),
('Marta Ruiz', 'Calle Reforma 456'),
('Carlos Pérez', 'Av. Central 789'),
('Diana López', 'Calle Norte 22'),
('Ana Torres', 'Av. Sur 77');

INSERT INTO producto (nombre, precio) VALUES
('Libro A', 250.00),
('Libro B', 300.00),
('Libro C', 150.00),
('Laptop', 25000.00),
('Mouse', 500.00);

INSERT INTO pedido (cliente_id, fecha) VALUES
(1, '2026-10-05'),
(2, '2026-10-06'),
(3, '2026-10-07'),
(4, '2026-10-08'),
(5, '2026-10-09');

INSERT INTO detalle_pedido (pedido_id, producto_id, cantidad)
VALUES 
(1, 1, 2),
(1, 2, 1),
(2, 3, 3),
(3, 4, 1),
(4, 5, 2),
(5, 2, 1)
ON CONFLICT (pedido_id, producto_id)
DO UPDATE SET cantidad = detalle_pedido.cantidad + EXCLUDED.cantidad;

INSERT INTO inventario (producto_id, stock)
VALUES
(1, 100),
(2, 50),
(3, 80),
(4, 30),
(5, 20);

-- indices
CREATE INDEX idx_empleado_salario
ON empleado(salario);

CREATE INDEX idx_empleado_puesto
ON empleado(puesto);

CREATE INDEX idx_cliente_nombre
ON cliente(nombre);

CREATE INDEX idx_producto_nombre
ON producto(nombre);

CREATE INDEX idx_pedido_cliente
ON pedido(cliente_id);

CREATE INDEX idx_pedido_fecha
ON pedido(fecha);

CREATE INDEX idx_detalle_producto
ON detalle_pedido(producto_id);

CREATE INDEX idx_inventario_stock
ON inventario(stock);

-- Actualizar estadisticas
VACUUM ANALYZE;

-- Analisis
EXPLAIN ANALYZE
SELECT * FROM empleado
WHERE salario > 15000;

EXPLAIN ANALYZE
SELECT * FROM empleado
WHERE puesto = 'Analista';

EXPLAIN ANALYZE
SELECT * FROM pedido
WHERE fecha >= '2026-10-07';

EXPLAIN ANALYZE
SELECT c.nombre, p.fecha
FROM cliente c
INNER JOIN pedido p
ON c.id = p.cliente_id;

EXPLAIN ANALYZE
SELECT pr.nombre, dp.cantidad
FROM producto pr
INNER JOIN detalle_pedido dp
ON pr.id = dp.producto_id;

EXPLAIN ANALYZE
SELECT * FROM inventario
WHERE stock < 50;
