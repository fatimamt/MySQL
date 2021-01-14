# EJERCICIOS SESIÓN 3
-- Fatima Martínez Torres
-- st1809101@upy.edu.mx

USE classicmodels;

# 1
SELECT orderNumber, sum(quantityOrdered) AS Productos
FROM orderdetails
GROUP BY orderNumber;

# 2
SELECT od.orderNumber, o.status, sum(od.quantityOrdered * od.priceEach) AS CostoTotal
FROM orderdetails AS od
INNER JOIN orders AS o
	ON od.orderNumber = o.orderNumber
GROUP BY orderNumber;

# 3
SELECT od.orderNumber, o.orderDate, od.orderLineNumber, p.productName, od.quantityOrdered, od.priceEach
FROM orderdetails AS od
INNER JOIN orders AS o
	ON o.orderNumber = od.orderNumber
JOIN products AS p
	ON p.productCode = od.productCode;

# 4
SELECT od.orderNumber, p.productName, p.MSRP, od.priceEach
FROM products AS p
JOIN orderdetails AS od
	ON p.productCode = od.productCode;

# 5
SELECT c.customerNumber, c.customerName, o.orderNumber, o.status
FROM orders AS o
LEFT JOIN customers AS c
	ON o.customerNumber = c.customerNumber;
-- ¿De qué nos sirve hacer LEFT JOIN en lugar de JOIN?
-- Asegurar que se toman en cuenta todos las órdenes.

# 6
SELECT *
FROM customers AS c
LEFT JOIN orders AS o
	ON c.customerNumber = o.customerNumber
WHERE o.ordernumber IS NULL;

# 7
SELECT e.lastName, e.firstName, c.customerName, pay.checkNumber, pay.amount
FROM customers AS c
LEFT JOIN payments AS pay 
	ON c.customerNumber = pay.customerNumber
LEFT JOIN employees AS e
	ON c.salesRepEmployeeNumber = e.employeeNumber;

# 8
# 8.5
SELECT c.customerNumber, c.customerName, o.orderNumber, o.status
FROM orders AS o
RIGHT JOIN customers AS c
	ON o.customerNumber = c.customerNumber;
-- En esta consulta se buscan a los clientes que tienen una orden, mientras que enel LEFT JOIN se 
-- buscan las ordenes según los clientes.

# 8.6
SELECT *
FROM customers AS c
RIGHT JOIN orders AS o
	ON c.customerNumber = o.customerNumber
WHERE o.ordernumber IS NULL;
-- A diferencia del anterior, la consulta con el RIGHT JOIN termina siendo innecesaria ya que se buscan
-- las órdenes que no tengan algun cliente asociado, por lo que puede ser imposible.

# 8.7
SELECT e.lastName, e.firstName, c.customerName, pay.checkNumber, pay.amount
FROM customers AS c
RIGHT JOIN payments AS pay 
	ON c.customerNumber = pay.customerNumber
RIGHT JOIN employees AS e
	ON c.salesRepEmployeeNumber = e.employeeNumber;
-- En la consulta con RIGHT JOIN se buscan los pagos que contengan algun cliente, por eso salen
-- registros con empleados sin algún cliente asociado.

# 9
CREATE VIEW consulta_6_vista_1 AS (SELECT *
								FROM customers AS c
                                LEFT JOIN orders AS o
									ON c.customerNumber = o.customerNumber
								WHERE o.ordernumber IS NULL);
                                
CREATE VIEW consulta_4_vista_2 AS (SELECT od.orderNumber, p.productName, p.MSRP, od.priceEach
								FROM products AS p
								JOIN orderdetails AS od
									ON p.productCode = od.productCode);
                                    
CREATE VIEW consulta_2_vista_3 AS (SELECT od.orderNumber, o.status, sum(od.quantityOrdered * od.priceEach) AS CostoTotal
								FROM orderdetails AS od
								INNER JOIN orders AS o
									ON od.orderNumber = o.orderNumber
								GROUP BY orderNumber);