/*Ejercicio 3
Nivel de dificultad: Difícil
Ejercicios 3
1. Crea una tabla llamada "Productos" con las columnas: "id" (entero, clave
primaria), "nombre" (texto) y "precio" (numérico).*/
CREATE TABLE public.productos(
	id INT PRIMARY KEY,
	nombre VARCHAR(255) NOT NULL,
	precio NUMERIC
)

/*2. Inserta al menos cinco registros en la tabla "Productos".*/
INSERT INTO public.productos(id, nombre, precio)
VALUES('1', 'Gorra', '10'), ('2', 'Pantalón', '30'), ('3', 'Top', '5'), ('4', 'Calcetín', '7'), ('5', 'Short', '20')

/*3. Actualiza el precio de un producto en la tabla "Productos".*/
UPDATE public.productos
SET precio = 9
WHERE id = 3

/*4. Elimina un producto de la tabla "Productos".*/
DELETE FROM public.productos
WHERE id = 4

/*5. Realiza una consulta que muestre los nombres de los usuarios junto con los
nombres de los productos que han comprado (utiliza un INNER JOIN con la
tabla "Productos").*/
ALTER TABLE usuarios
ADD COLUMN producto_id INTEGER,
ADD CONSTRAINT fk_producto
FOREIGN KEY (producto_id) REFERENCES productos(id);

SELECT u.nombre AS usuario, p.nombre AS producto
FROM public.usuarios u
INNER JOIN public.productos p
ON u.id = p.id
