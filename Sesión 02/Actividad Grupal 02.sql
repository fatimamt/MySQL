# EJERCICIOS SESIÓN 2
-- Fatima Martínez Torres
-- st1809101@upy.edu.mx

USE classicmodels;
SHOW tables;
DESCRIBE employees;

# 1
SELECT employeeNumber, lastName, firstName
FROM employees
WHERE firstName LIKE 'A%';

# 2
SELECT employeenumber, lastName, firstName
FROM employees
WHERE lastName LIKE '%on';

# 3
SELECT employeeNumber, lastName, firstName 
FROM employees
WHERE firstName LIKE '%on%';

# 4
SELECT employeeNumber, lastName, firstName
FROM employees
WHERE firstName LIKE "G_____";

# 5
SELECT employeeNumber, lastName, firstName 
FROM employees 
WHERE firstName NOT LIKE 'B%';

# 6
SELECT productCode, productName
FROM products
WHERE productCode LIKE '%\_20%';

# 7
SELECT orderNumber, sum(quantityOrdered * priceEach) AS totalOrden
FROM orderdetails
GROUP BY orderNumber;

# 8
SELECT year(orderDate) AS orderYear, count(*) AS ordersPerYear
FROM orders
GROUP BY orderYear;

# 9
SELECT lastName, firstName
FROM employees
WHERE officeCode IN
	(SELECT officeCode
	FROM offices
	WHERE country = "USA");

# 10
SELECT customerNumber, checkNumber, amount
FROM payments
WHERE amount IN
	(SELECT max(amount) AS maxAmount
	FROM payments);

# 11
SELECT customerNumber, checkNumber, amount
FROM payments
WHERE amount > (SELECT AVG(amount)
                FROM payments);

# 12
SELECT customerName
FROM customers
WHERE customerNumber NOT IN (SELECT customerNumber
							 FROM orders);

# 13
SELECT MAX(quantityOrdered) AS max_quantity, MIN(quantityOrdered) AS min_quantity, AVG(quantityOrdered) AS avg_quantity
FROM orderdetails;

# 14 Dentro de la tabla orders, obten el número de órdenes que hay por cada estado.
SELECT status, count(orderNumber) AS total_orders
FROM orders
GROUP BY status;
