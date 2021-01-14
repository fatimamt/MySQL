# EJEMPLO 2
# Monstrar las bases de datos en el servidor
SHOW DATABASES;
# Usar cierta base de datos
USE tienda;
# Mostrar las tablas en la base de datos usada
SHOW TABLES;
# Describir los elementos de cierta tabla
DESCRIBE venta;

# RETO 1
# Muestra la descripción de las tablas. Por cada tipo de dato que encuentres llena una tabla
DESCRIBE articulo;
DESCRIBE puesto;
DESCRIBE venta;

# EJEMPLO 3
# Seleccionar (o proyectar) los registros del campo "nombre" en la tabla "empleado"
SELECT nombre
FROM empleado;
# Proyectar todos los campos de la tabla "empleados"
SELECT *
FROM empleado;
# Empleados cuo apellido patero es "Risom"
SELECT *
FROM empleado
WHERE apellido_paterno = 'Risom';
# Empleados cuyo id_puesto es mayor a 100
SELECT *
FROM empleado
WHERE id_puesto > 100;
# Registros cuyo id_puesto esté entre 100 y 200
SELECT *
FROM empleado
WHERE id_puesto >= 100
  AND id_puesto <= 200;
# Registros cuyo id_puesto sea 100 o 200
SELECT *
FROM empleado
WHERE id_puesto = 100
   OR id_puesto = 200;
# IN puede acortar un operador OR
SELECT *
FROM empleado
WHERE id_puesto IN (100,200);

# RETO 2
# ¿Cuál es el nombre de los empleados con el puesto 4?
SELECT nombre
FROM empleado
WHERE id_puesto = 4;

# ¿Qué puestos tienen un salario mayor a $10,000?
SELECT nombre
FROM puesto
WHERE salario > 10000;

# ¿Qué artículos tienen un precio mayor a $1,000 y un iva mayor a 100?
SELECT nombre
FROM articulo
WHERE precio > 1000
   AND IVA > 100;

# ¿Qué ventas incluyen los artículos 135 o 963 y fueron hechas por los empleados 835 o 369?
SELECT *
FROM venta
WHERE id_articulo IN (135, 963)
   AND ID_EMPLEADO IN (835, 369);

# EJEMPLO 4
# Registros ordenados de mayor a menor a partir del campo salario
SELECT *
FROM puesto
ORDER BY salario DESC;
# De forma ascendente
SELECT *
FROM puesto
ORDER BY salario ASC;
# O puede omitirse ya que está por defecto
SELECT *
FROM puesto
ORDER BY salario;
#  Limitar el número de registros en una consulta
SELECT *
FROM empleado
LIMIT 5;

# RETO 3
# Usando la base de datos tienda, escribe una consulta que permita obtener el top 5 de puestos por salarios
SELECT *
FROM puesto
ORDER BY salario DESC
LIMIT 5;