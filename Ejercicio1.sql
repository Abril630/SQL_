/*Ejercicio 1
1. Crear una tabla llamada "Clientes" con las columnas: id (entero, clave primaria),
nombre (texto) y email (texto).*/
CREATE TABLE IF NOT EXISTS clientes(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(255) NOT NULL,
	email VARCHAR(255)
)

/*2. Insertar un nuevo cliente en la tabla "Clientes" con id=1, nombre="Juan" y
email="juan@example.com".*/
INSERT INTO public.clientes(nombre, email)
VALUES('Juan', 'juan@example.com'), ('María', 'maria@example.com'), ('Ana', 'ana@example.com')

/*3. Actualizar el email del cliente con id=1 a "juan@gmail.com".*/
UPDATE public.clientes
SET email = 'juan@gmail.com'
WHERE id = 1

/*4. Eliminar el cliente con id=1 de la tabla "Clientes".*/
DELETE FROM public.clientes
WHERE id = 1

/*5. Crear una tabla llamada "Pedidos" con las columnas: id (entero, clave primaria),
cliente_id (entero, clave externa referenciando a la tabla "Clientes"), producto
(texto) y cantidad (entero).*/
CREATE TABLE pedidos(
	id INT PRIMARY KEY,
	cliente_id INT NOT NULL,
	producto VARCHAR(255),
	cantidad INT,
	CONSTRAINT FK_cliente_id FOREIGN KEY(cliente_id) REFERENCES clientes(id) 
)

/*6. Insertar un nuevo pedido en la tabla "Pedidos" con id=1, cliente_id=1,
producto="Camiseta" y cantidad=2.*/
INSERT INTO public.pedidos(id, cliente_id, producto, cantidad)
VALUES('1', '1', 'Camiseta', '2'), ('2', '2', 'Calcetines', '4'), ('3', '3', 'Pantalón', '2')

/*7. Actualizar la cantidad del pedido con id=1 a 3.*/
UPDATE public.pedidos
SET cantidad = 3
WHERE id = 1

/*8. Eliminar el pedido con id=1 de la tabla "Pedidos".*/
DELETE FROM public.pedidos
WHERE id = 1

/*9. Crear una tabla llamada "Productos" con las columnas: id (entero, clave
primaria), nombre (texto) y precio (decimal).*/
CREATE TABLE IF NOT EXISTS productos(
	id INT PRIMARY KEY,
	nombre VARCHAR(255) NOT NULL,
	precio DECIMAL
)

/*10. Insertar varios productos en la tabla "Productos" con diferentes valores.*/
INSERT INTO public.productos(id, nombre, precio)
VALUES('1', 'Camiseta', '50'), ('2', 'Calcetines', '7.5'), ('3', 'Pantalón', '65')

/*11. Consultar todos los clientes de la tabla "Clientes".*/
SELECT c.nombre
FROM public.clientes c

/*12. Consultar todos los pedidos de la tabla "Pedidos" junto con los nombres de los
clientes correspondientes.*/
SELECT c.id AS id,
	c.nombre AS Nombre,
	p.producto AS Producto,
	p.cantidad AS Cantidad
FROM public.clientes c
INNER JOIN public.pedidos p
ON c.id = p.cliente_id

/*13. Consultar los productos de la tabla "Productos" cuyo precio sea mayor a $50.*/
SELECT *
FROM public.productos pro
WHERE pro.precio > 50

/*14. Consultar los pedidos de la tabla "Pedidos" que tengan una cantidad mayor o
igual a 5.*/
SELECT *
FROM public.pedidos p
WHERE cantidad >= 5

/*15. Consultar los clientes de la tabla "Clientes" cuyo nombre empiece con la letra
"A".*/
SELECT *
FROM public.clientes c
WHERE nombre ILIKE 'A%'

/*16. Realizar una consulta que muestre el nombre del cliente y el total de pedidos realizados por cada cliente.*/
SELECT c.nombre, COUNT(p.id) AS total_pedidos
FROM public.clientes c
LEFT JOIN public.pedidos p 
ON c.id = p.cliente_id
GROUP BY c.nombre
	
/*17. Realizar una consulta que muestre el nombre del producto y la cantidad total de
pedidos de ese producto.*/
SELECT pro.nombre AS producto, SUM(p.cantidad) AS cantidad_total
FROM public.productos pro
LEFT JOIN public.pedidos p
ON pro.nombre = p.producto
GROUP BY pro.nombre
	
/*18. Agregar una columna llamada "fecha" a la tabla "Pedidos" de tipo fecha.*/
ALTER TABLE public.pedidos
ADD COLUMN fecha DATE

/*19. Agregar una clave externa a la tabla "Pedidos" que haga referencia a la tabla "Productos" en la columna "producto".*/
ALTER TABLE pedidos
ADD COLUMN IF NOT EXISTS id_producto INTEGER

ALTER TABLE pedidos
ADD CONSTRAINT FK_producto_pedido FOREIGN KEY (id_producto) REFERENCES productos(id)

/*20. Realizar una consulta que muestre los nombres de los clientes, los nombres de
los productos y las cantidades de los pedidos donde coincida la clave externa.*/
SELECT c.nombre, p.producto, p.cantidad
FROM public.clientes c
LEFT JOIN public.pedidos p 
ON c.id = p.cliente_id