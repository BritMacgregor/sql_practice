USE Northwind;

/* Exercise 20 */

SELECT CategoryName, COUNT(*) AS TotalProducts
FROM Products
JOIN Categories
ON Products.CategoryID = Categories.CategoryID
GROUP BY CategoryName
ORDER BY TotalProducts DESC;


/* Exercise 21 */

SELECT Country, City, COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY Country, City
ORDER BY TotalCustomers DESC;

/* Exercise 22 */

SELECT ProductID, ProductName, UnitsInStock, ReorderLevel
FROM Products
WHERE UnitsInStock < ReorderLevel
ORDER BY ProductID;

/* Exercise 23 */

SELECT 
	ProductID,
	ProductName AS 'Product Name',
	UnitsInStock AS 'Units In Stock',
	UnitsOnOrder AS 'Units On Order',
	ReorderLevel AS 'Reorder Level',
	Discontinued
FROM Products
WHERE UnitsInStock + UnitsOnOrder <= ReorderLevel AND Discontinued = 'false';


/* Exercise 24 */

SELECT CustomerID, CompanyName, Region
FROM Customers
ORDER BY CASE WHEN Region IS NULL THEN 1 ELSE 0 END ASC, Region ASC, CustomerID;


/* Exercise 25 */
SELECT ShipCountry, AVG(Freight) AS AverageFreight
FROM Orders
GROUP BY ShipCountry
ORDER BY AverageFreight DESC
LIMIT 3;

/* Exercise 26 */

SELECT ShipCountry, AVG(Freight) AS AverageFreight
FROM Orders
WHERE OrderDate >= '20150101' AND OrderDate < '20160101'
GROUP BY ShipCountry
ORDER BY AverageFreight DESC
LIMIT 3;

/* Exercise 27 */

SELECT ShipCountry, AVG(Freight) AS AverageFreight
FROM Orders
WHERE OrderDate BETWEEN '20150101' AND '20160101' 
GROUP BY ShipCountry
ORDER BY AverageFreight DESC;

/* Exercise 28 */

SELECT TOP 3 ShipCountry, AVG(Freight) AS AverageFreight
FROM Orders
WHERE OrderDate >= (DATEADD(year, -1, (SELECT MAX(OrderDate) FROM Orders)))
GROUP BY ShipCountry
ORDER BY AverageFreight DESC;


/* Exercise 29 */

SELECT e.EmployeeID, e.LastName, od.OrderID, p.ProductName, od.Quantity
FROM Orders AS o
JOIN OrderDetails AS od ON o.OrderID = od.OrderID
JOIN Products AS p ON od.ProductID = p.ProductID
JOIN Employees AS e ON o.EmployeeID = e.EmployeeID
ORDER BY o.OrderID, p.ProductID;

/* Exercise 30 */

SELECT c.CustomerID, o.CustomerID
FROM Customers AS c
LEFT JOIN Orders AS o
ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL;


/* Exercise 31 */

SELECT c.CustomerID, o.CustomerID
FROM Customers AS c
LEFT JOIN Orders AS o ON o.CustomerID = c.CustomerID AND o.EmployeeID = 4
WHERE o.CustomerID IS NULL;