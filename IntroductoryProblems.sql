

/* Exercise 1 */
SELECT *
FROM Shippers;

/* Exercise 2 */

SELECT CategoryName, Description
FROM Categories;

/* Exercise 3 */

SELECT FirstName, LastName, HireDate
FROM Employees
WHERE Title = 'Sales Representative';

/* Exercise 4 */

SELECT FirstName, LastName, HireDate
FROM Employees
WHERE Title = 'Sales Representative' AND Country = 'USA';

/* Exercise 5 */

SELECT OrderID, OrderDate
FROM Orders
WHERE EmployeeID = 5;

/* Exercise 6 */

SELECT SupplierID, ContactName, ContactTitle
FROM Suppliers
WHERE ContactTitle != 'Marketing Manager';

/* Exercise 7 */

SELECT ProductID, ProductName
FROM Products
WHERE ProductName LIKE '%queso%';

/* Exercise 8 */
SELECT OrderID, CustomerID, ShipCountry
FROM Orders
WHERE Shipcountry = 'France' OR ShipCountry = 'Belgium';

/* Exercise 9 */
SELECT OrderID, CustomerID, ShipCountry
FROM Orders
WHERE ShipCountry IN ('Brazil', 'Mexico', 'Argentina', 'Venezuela')

/* Exercise 10 */

SELECT FirstName, LastName, Title, BirthDate
FROM Employees
ORDER BY BirthDate;

/* Exercise 11 */
SELECT FirstName, LastName, Title, CAST(BirthDate AS DATE) AS DateOnlyBirthDate
FROM Employees
ORDER BY BirthDate;

/* Exercise 12 */
SELECT FirstName, LastName, CONCAT(FirstName, ' ', LastName) AS FullName
FROM Employees

/* Exercise 13 */

SELECT OrderID, ProductID, UnitPrice, Quantity, UnitPrice * Quantity AS TotalPrice
FROM OrderDetails
ORDER BY OrderID, ProductID

/* Exercise 14 */
SELECT COUNT(*) AS TotalCustomers
FROM Customers


/* Exercise 15 */
SELECT MIN(OrderDate) AS FirstOrder
FROM Orders

/* Exercise 16 */
SELECT Country
FROM Customers
GROUP BY Country

/* Exercise 17 */
SELECT ContactTitle, COUNT(ContactTitle) AS TotalContactTitle
FROM Customers
GROUP BY ContactTitle
ORDER BY TotalContactTitle DESC

/* Exercise 18 */

SELECT ProductID, ProductName, CompanyName
FROM Products
JOIN
   (SELECT SupplierID, CompanyName
	FROM Suppliers) AS sup
ON Products.SupplierID = sup.SupplierID
ORDER BY ProductID

/* Exercise 19 */

SELECT OrderID, CAST(OrderDate AS DATE) AS OrderDate, Shipper
FROM Orders
JOIN 
	(SELECT ShipperID, CompanyName AS Shipper
	FROM Shippers) AS shipper
ON Orders.ShipVia = shipper.ShipperID
WHERE OrderID < 10270
ORDER BY OrderID