# EJEMPLO 1

USE tienda;
# Empiecen con M
SELECT *
FROM empleado
WHERE nombre LIKE 'M%';
# Terminen con a
SELECT *
FROM empleado
WHERE nombre LIKE '%a';
# Empiecen con M y terminen con a
SELECT *
FROM empleado
WHERE nombre LIKE 'M%a';
# Empiece con M seguida de cualquier letra única y seguida de losa
SELECT *
FROM empleado
WHERE nombre LIKE 'M_losa';

# RETO 1

# ¿Qué artículos incluyen la palabra Pasta en su nombre?
SELECT *
FROM articulo
WHERE nombre LIKE '%Pasta%';

# ¿Qué artículos incluyen la palabra Cannelloni en su nombre?
SELECT *
FROM articulo
WHERE nombre LIKE '%Cannelloni%';

# ¿Qué nombres están separados por un guión (-) por ejemplo Puree - Kiwi?
SELECT *
FROM articulo
WHERE nombre LIKE '%-%';

# EJEMPLO 2
# Se puede usar como calculadora
SELECT (1 + 7) * (10 / (6 - 4));
# Promedio de una columna
SELECT avg(precio)
FROM articulo;
# Número de registros de una columna
SELECT count(*)
FROM articulo;
# Valor máximo de una columna
SELECT max(precio)
FROM articulo;
# Valor mínimo de una columna
SELECT min(precio)
FROM articulo;
# Suma de una columna
SELECT sum(precio) / count(*)
FROM articulo;

# RETO 2

# ¿Cuál es el promedio de salario de los puestos?
SELECT avg(salario)
FROM puesto;

# ¿Cuántos artículos incluyen la palabra Pasta en su nombre?
SELECT count(*)
FROM articulo
WHERE nombre LIKE '%Pasta%';

# ¿Cuál es el salario mínimo y máximo?
SELECT min(salario), max(salario)
FROM puesto;

# ¿Cuál es la suma del salario de los últimos cinco puestos agregados?
SELECT sum(salario)
FROM puesto
WHERE id_puesto > 995;

# EJEMPLO 3
# Usando agrupaciones con SUM
SELECT nombre, sum(precio) AS total
FROM articulo
GROUP BY nombre;
# Usando COUNT
SELECT nombre, count(*) AS cantidad
FROM articulo
GROUP BY nombre
ORDER BY cantidad DESC;
# Usando MIN y MAX
SELECT nombre, min(salario) AS menor, max(salario) AS mayor
FROM puesto
GROUP BY nombre;

# RETO 3

# ¿Cuántos registros hay por cada uno de los puestos?
SELECT nombre, count(nombre) AS cantidad
FROM puesto
GROUP BY nombre;

# ¿Cuánto dinero se paga en total por puesto?
SELECT nombre, sum(salario) AS total
FROM puesto
GROUP BY nombre;

# ¿Cuál es el número total de ventas por vendedor?
SELECT id_empleado, count(clave) AS cantidad_ventas
FROM venta
GROUP BY id_empleado;

# ¿Cuál es el número total de ventas por artículo?
SELECT id_articulo, count(id_venta) AS cantidad_ventas
FROM venta
GROUP BY id_articulo;

# EJEMPLO 4
# Subconsultas usando WHERE: empleados cuyo puesto es Junior Executive
# Identificador de los puestos con ese nombre
SELECT id_puesto
FROM puesto
WHERE nombre = 'Junior Executive';
# Búsqueda de los empleadoS que tienen dichos identificadores
# Filtramos aquellos empleados cuyo id_puesto esté en los resultados de la misma
SELECT *
FROM empleado
WHERE id_puesto IN 
   (SELECT id_puesto
   FROM puesto
   WHERE nombre = 'Junior Executive');

# Subconsultas usando FROM: menor y mayor cantidad de ventas de un artículo
# Cantidad de piezas por venta de un artículo
SELECT clave, id_articulo, count(*) AS cantidad
FROM venta
GROUP BY clave, id_articulo
ORDER BY clave;
# Nuevo agrupamiento para obtener la cantidad mínima y máxima de cada artículo
# sin importar la venta
SELECT id_articulo, min(cantidad), max(cantidad)
FROM 
   (SELECT clave, id_articulo, count(*) AS cantidad
   FROM venta
   GROUP BY clave, id_articulo
   ORDER BY clave) AS subconsulta
GROUP BY id_articulo;

# Subconsultas usando SELECT: sueldo de cada empleado
# Sueldo de cada tipo de empleado
# SELECT salario FROM puesto WHERE id_puesto = e.id_puesto
# Luego lo usamos como subconsulta
SELECT nombre, apellido_paterno, (SELECT salario
								  FROM puesto
                                  WHERE id_puesto = e.id_puesto) AS sueldo
FROM empleado AS e;

# RETO 4

# ¿Cuál es el nombre de los empleados cuyo sueldo es mayor a $10,000?
SELECT nombre, apellido_paterno
FROM empleado
WHERE id_puesto IN
	(SELECT id_puesto
	FROM puesto
	WHERE salario > 10000);

# ¿Cuál es la cantidad mínima y máxima de ventas de cada empleado?
SELECT clave, id_empleado, count(*) AS total_ventas
FROM venta
GROUP BY clave, id_empleado;

SELECT id_empleado, min(total_ventas), max(total_ventas)
FROM
	(SELECT clave, id_empleado, count(*) AS total_ventas
	FROM venta
	GROUP BY clave, id_empleado) AS sq
GROUP BY id_empleado;

# ¿Cuál es el nombre del puesto de cada empleado?
SELECT concat(nombre, ' ', apellido_paterno) AS empleado, (SELECT nombre
								  FROM puesto
                                  WHERE id_puesto = e.id_puesto) AS puesto
FROM empleado AS e;