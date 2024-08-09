/*Ejercicio 4
Nivel de dificultad: Experto
1. Crea una tabla llamada "Pedidos" con las columnas: "id" (entero, clave
primaria), "id_usuario" (entero, clave foránea de la tabla "Usuarios") y
"id_producto" (entero, clave foránea de la tabla "Productos").*/
CREATE TABLE IF NOT EXISTS public.pedidos(
	id INT PRIMARY KEY,
	id_usuario INT,
	id_producto INT,
	CONSTRAINT fk_usuarios FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
	CONSTRAINT fk_productos FOREIGN KEY (id_producto) REFERENCES productos(id)
)

/*2. Inserta al menos tres registros en la tabla "Pedidos" que relacionen usuarios con
productos.*/
INSERT INTO public.pedidos(id, id_usuario, id_producto)
VALUES('2', '2', '2')

/*3. Realiza una consulta que muestre los nombres de los usuarios y los nombres de
los productos que han comprado, incluidos aquellos que no han realizado
ningún pedido (utiliza LEFT JOIN y COALESCE).*/
SELECT u.nombre AS usuario, pro.nombre AS producto, u.id AS usuario_id
FROM public.usuarios u
LEFT JOIN public.pedidos p
	ON u.id = p.id_usuario
LEFT JOIN public.productos pro
	ON pro.id = p.id_producto
WHERE COALESCE (pro.precio, 0) = 0
OR pro.precio IS NOT NULL

/*4. Realiza una consulta que muestre los nombres de los usuarios que han
realizado un pedido, pero también los que no han realizado ningún pedido
(utiliza LEFT JOIN).*/
SELECT u.nombre AS usuario
FROM public.usuarios u
LEFT JOIN public.pedidos p
ON u.id = p.id_usuario

/*5. Agrega una nueva columna llamada "cantidad" a la tabla "Pedidos" y actualiza
los registros existentes con un valor (utiliza ALTER TABLE y UPDATE)*/
ALTER TABLE pedidos
ADD COLUMN cantidad INT

UPDATE public.pedidos
SET cantidad = 3
WHERE cantidad IS NULL