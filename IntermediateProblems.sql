/* Exercise 20 */

SELECT CategoryName, COUNT(*) AS TotalProducts
FROM Products
JOIN Categories
ON Products.CategoryID = Categories.CategoryID
GROUP BY CategoryName
ORDER BY TotalProducts DESC


/* Exercise 21 */

SELECT Country, City, COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY Country, City
ORDER BY TotalCustomers DESC

/* Exercise 22 */

SELECT ProductID, ProductName, UnitsInStock, ReorderLevel
FROM Products
WHERE UnitsInStock < ReorderLevel
ORDER BY ProductID

/* Exercise 23 */

SELECT 
	ProductID,
	ProductName AS 'Product Name',
	UnitsInStock AS 'Units In Stock',
	UnitsOnOrder AS 'Units On Order',
	ReorderLevel AS 'Reorder Level',
	Discontinued
FROM Products
WHERE UnitsInStock + UnitsOnOrder <= ReorderLevel AND Discontinued = 'false'


/* Exercise 24 */

SELECT CustomerID, CompanyName, Region
FROM Customers
ORDER BY CASE WHEN Region IS NULL THEN 1 ELSE 0 END ASC, Region ASC, CustomerID


/* Exercise 25 */
SELECT TOP 3 ShipCountry, AVG(Freight) AS AverageFreight
FROM Orders
GROUP BY ShipCountry
ORDER BY AverageFreight DESC

/* Exercise 26 */

SELECT TOP 3 ShipCountry, AVG(Freight) AS AverageFreight
FROM Orders
WHERE OrderDate >= '20150101' AND OrderDate < '20160101'
GROUP BY ShipCountry
ORDER BY AverageFreight DESC

/* Exercise 27 */

SELECT ShipCountry, AVG(Freight) AS AverageFreight
FROM Orders
WHERE OrderDate BETWEEN '20150101' AND '20160101' 
GROUP BY ShipCountry
ORDER BY AverageFreight DESC

/* Exercise 28 */

SELECT ShipCountry, AVG(Freight) AS AverageFreight
FROM Orders
GROUP BY ShipCountry
ORDER BY AverageFreight DESC
