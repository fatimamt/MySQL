USE tienda;

# EJEMPLO 1

SHOW KEYS FROM venta;

SELECT * 
FROM empleado AS e
JOIN puesto AS p
	ON e.id_puesto = p.id_puesto;
    
SELECT *
FROM puesto AS p
LEFT JOIN empleado e
ON p.id_puesto = e.id_puesto;

SELECT *
FROM empleado AS e
RIGHT JOIN puesto AS p
ON e.id_puesto = p.id_puesto;

# RETO 1

# ¿Cuál es el nombre de los empleados que realizaron cada venta?
SELECT v.clave, nombre, apellido_paterno, apellido_materno
FROM empleado AS e
JOIN venta AS v
	ON e.id_empleado = v.id_empleado;

SELECT DISTINCT nombre, apellido_paterno, apellido_materno
FROM empleado AS e
JOIN venta AS v
	ON e.id_empleado = v.id_empleado;

# ¿Cuál es el nombre de los artículos que se han vendido?
SELECT v.clave, nombre
FROM articulo AS a
JOIN venta AS v
	ON a.id_articulo = v.id_articulo;
    
SELECT DISTINCT nombre
FROM articulo AS a
JOIN venta AS v
	ON a.id_articulo = v.id_articulo;

# ¿Cuál es el total de cada venta?
SELECT v.clave, round(sum(a.precio), 2) TOTAL
FROM venta AS v
JOIN articulo AS a
	ON v.id_articulo = a.id_articulo
GROUP BY v.clave;

# EJEMPLO 2

SELECT v.clave, v.fecha, a.nombre producto, a.precio, concat(e.nombre, ' ', e.apellido_paterno) empleado 
FROM venta v
JOIN empleado e
  ON v.id_empleado = e.id_empleado
JOIN articulo a
  ON v.id_articulo = a.id_articulo;
  
CREATE VIEW tickets_404 AS
(SELECT v.clave, v.fecha, a.nombre producto, a.precio, concat(e.nombre, ' ', e.apellido_paterno) empleado 
FROM venta v
JOIN empleado e
  ON v.id_empleado = e.id_empleado
JOIN articulo a
  ON v.id_articulo = a.id_articulo);
  
SELECT *
FROM tickets_404;

SELECT clave, round(sum(precio),2) total
FROM tickets_404
GROUP BY clave;

# RETO 2
# Obtener el puesto de un empleado.
CREATE VIEW empleado_puesto_404 AS
(SELECT e.id_empleado, p.id_puesto, p.nombre AS PUESTO, e.nombre, e.apellido_paterno, e.apellido_materno
FROM puesto AS p
JOIN empleado AS e
	ON p.id_puesto = e.id_puesto);

SELECT * FROM empleado_puesto_404;

# Saber qué artículos ha vendido cada empleado.
CREATE VIEW articulo_empleado_404 AS
(SELECT v.clave, concat(e.nombre, ' ', e.apellido_paterno, ' ', e.apellido_materno) AS empleado, a.nombre AS articulo
FROM venta v
JOIN empleado e
	ON e.id_empleado = v.id_empleado
JOIN articulo a
	ON v.id_articulo = a.id_articulo
ORDER BY v.clave);

SELECT * FROM articulo_empleado_404;

# Saber qué puesto ha tenido más ventas.
CREATE VIEW puesto_ventas_404 AS
(SELECT p.nombre, count(v.clave) AS total_ventas
FROM venta v
JOIN empleado e
	ON v.id_empleado = e.id_empleado
JOIN puesto p
	ON e.id_puesto = p.id_puesto
GROUP BY p.nombre);

SELECT *
FROM puesto_ventas_404
ORDER BY total_ventas DESC
LIMIT 1;