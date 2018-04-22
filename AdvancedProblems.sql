USE northwind;
/* Exercise 32 */

SELECT c.CustomerID, c.CompanyName, o.OrderID, sum(od.UnitPrice * od.Quantity) AS amount
FROM Customers AS c
INNER JOIN Orders AS o ON c.CustomerID = o.CustomerID
INNER JOIN OrderDetails AS od ON o.OrderID = od.OrderID
WHERE YEAR(o.OrderDate) = 2016
GROUP BY c.CustomerID, c.CompanyName, o.OrderID
HAVING amount >= 1000
ORDER BY amount DESC;

/* Exercise 33 */

SELECT c.CustomerID, c.CompanyName, sum(od.UnitPrice * od.Quantity) AS amount
FROM Customers AS c
JOIN Orders AS o ON c.CustomerID = o.CustomerID
JOIN OrderDetails AS od ON o.OrderID = od.OrderID
WHERE o.OrderDate BETWEEN '20160101' AND '20170101'
GROUP BY c.CustomerID, c.CompanyName
HAVING amount >= 15000
ORDER BY amount DESC;

/* Exercise 34 */

SELECT c.CustomerID, c.CompanyName, sum(od.UnitPrice * od.Quantity) AS amount,
	   sum(od.UnitPrice * od.Quantity) - (1 - od.Discount) AS amount_discounted 
FROM Customers AS c
JOIN Orders AS o ON c.CustomerID = o.CustomerID
JOIN OrderDetails AS od ON o.OrderID = od.OrderID
WHERE o.OrderDate BETWEEN '20160101' AND '20170101'
GROUP BY c.CustomerID, c.CompanyName
HAVING amount_discounted >= 15000
ORDER BY amount_discounted DESC;

/* Exercise 35 */

SELECT EmployeeID, OrderID, OrderDate
FROM Orders
WHERE DAY(DATE_ADD(OrderDate, INTERVAL 1 DAY)) = 1
ORDER BY EmployeeID, OrderID;

/* Exercise 36 */

SELECT od.OrderID, COUNT(*) AS TotalOrders
FROM OrderDetails AS od
JOIN Orders ON od.OrderID = Orders.OrderID
GROUP BY od.OrderID
ORDER BY TotalOrders DESC
LIMIT 10;

/* Exercise 37 */

SELECT COUNT(*) * 0.02 INTO @nrow FROM Orders;
SET @expr = CONCAT('SELECT OrderID FROM Orders ORDER BY RAND() LIMIT', @nrow);
prepare stmt from @expr;
EXECUTE stmt;

/* Exercise 38 */

SELECT *
FROM OrderDetails
WHERE Quantity >= 60
GROUP BY OrderID, Quantity
HAVING COUNT(*) > 1
ORDER BY OrderID;

/* Exercise 39 */

SELECT * 
FROM OrderDetails
WHERE OrderID in (SELECT DISTINCT OrderID FROM OrderDetails WHERE Quantity >= 60 GROUP BY OrderID, Quantity HAVING COUNT(*) > 1 ORDER BY OrderID)
ORDER BY Quantity;

/* Exercise 40 */

SELECT od.OrderID, ProductID, UnitPrice, Quantity, Discount
FROM OrderDetails AS od
JOIN (
	SELECT DISTINCT OrderID
	FROM OrderDetails
	WHERE Quantity >= 60
	GROUP BY OrderID, Quantity
	HAVING COUNT(*) > 1
) as ode
ON od.OrderID = ode.OrderID;

/* Exercise 41 */

SELECT OrderID,
		CAST(OrderDate AS DATE) AS OrderDate,
		CAST(RequiredDate AS DATE) AS RequiredDate,
        CAST(ShippedDate AS DATE) AS ShippedDate
FROM Orders
WHERE ShippedDate > RequiredDate;

/* Exercise 42 */

SELECT o.EmployeeID, e.LastName, COUNT(*) AS TotalLateOrders
FROM Employees AS e
JOIN Orders AS o ON o.EmployeeID = e.EmployeeID
WHERE CAST(o.ShippedDate AS DATE) >= CAST(o.RequiredDate AS DATE)
GROUP BY o.EmployeeID, e.LastName
ORDER BY COUNT(*) DESC;

/* Exercise 43 */

SELECT e.EmployeeID, e.LastName, COUNT(*) AS TotalOrders, late.TotalLateOrders
FROM Employees AS e
JOIN Orders AS o ON o.EmployeeID = e.EmployeeID
JOIN (
	SELECT o.EmployeeID, e.LastName, COUNT(*) AS TotalLateOrders
	FROM Employees AS e
	JOIN Orders AS o ON o.EmployeeID = e.EmployeeID
	WHERE CAST(o.ShippedDate AS DATE) >= CAST(o.RequiredDate AS DATE)
	GROUP BY o.EmployeeID, e.LastName
	ORDER BY COUNT(*) DESC
) AS late ON e.EmployeeID = late.EmployeeID
GROUP BY e.EmployeeID, e.LastName;

/* Exercise 44 */

SELECT e.EmployeeID, e.LastName, COUNT(*) AS TotalOrders, late.TotalLateOrders
FROM Employees AS e
JOIN Orders AS o ON o.EmployeeID = e.EmployeeID
LEFT JOIN (
	SELECT o.EmployeeID, e.LastName, COUNT(*) AS TotalLateOrders
	FROM Employees AS e
	JOIN Orders AS o ON o.EmployeeID = e.EmployeeID
	WHERE CAST(o.ShippedDate AS DATE) >= CAST(o.RequiredDate AS DATE)
	GROUP BY o.EmployeeID, e.LastName
	ORDER BY COUNT(*) DESC
) AS late ON e.EmployeeID = late.EmployeeID
GROUP BY e.EmployeeID, e.LastName;

/* Exercise 45 */

SELECT e.EmployeeID,
	   e.LastName,
       COUNT(*) AS TotalOrders,
       CASE WHEN late.TotalLateOrders IS NULL THEN 0 ELSE late.TotalLateOrders END AS TotalLateOrders
FROM Employees AS e
JOIN Orders AS o ON o.EmployeeID = e.EmployeeID
LEFT JOIN (
	SELECT o.EmployeeID, e.LastName, COUNT(*) AS TotalLateOrders
	FROM Employees AS e
	JOIN Orders AS o ON o.EmployeeID = e.EmployeeID
	WHERE CAST(o.ShippedDate AS DATE) >= CAST(o.RequiredDate AS DATE)
	GROUP BY o.EmployeeID, e.LastName
	ORDER BY COUNT(*) DESC
) AS late ON e.EmployeeID = late.EmployeeID
GROUP BY e.EmployeeID, e.LastName;

/* Exercise 46 */

SELECT e.EmployeeID,
	   e.LastName,
       COUNT(*) AS TotalOrders,
       CASE WHEN late.TotalLateOrders IS NULL
       THEN 0
       ELSE late.TotalLateOrders
       END AS TotalLateOrders,
       (CASE WHEN late.TotalLateOrders IS NULL
       THEN 0
       ELSE late.TotalLateOrders
       END) / COUNT(*) AS 'Percent Late Orders'
FROM Employees AS e
JOIN Orders AS o ON o.EmployeeID = e.EmployeeID
LEFT JOIN (
	SELECT o.EmployeeID, e.LastName, COUNT(*) AS TotalLateOrders
	FROM Employees AS e
	JOIN Orders AS o ON o.EmployeeID = e.EmployeeID
	WHERE CAST(o.ShippedDate AS DATE) >= CAST(o.RequiredDate AS DATE)
	GROUP BY o.EmployeeID, e.LastName
	ORDER BY COUNT(*) DESC
) AS late ON e.EmployeeID = late.EmployeeID
GROUP BY e.EmployeeID, e.LastName;


/* Exercise 47 */

SELECT e.EmployeeID,
	   e.LastName,
       COUNT(*) AS TotalOrders,
       CASE WHEN late.TotalLateOrders IS NULL
       THEN 0
       ELSE late.TotalLateOrders
       END AS TotalLateOrders,
       CAST((CASE WHEN late.TotalLateOrders IS NULL
       THEN 0
       ELSE late.TotalLateOrders
       END) / COUNT(*) AS DECIMAL(8,2)) AS 'Percent Late Orders'
FROM Employees AS e
JOIN Orders AS o ON o.EmployeeID = e.EmployeeID
LEFT JOIN (
	SELECT o.EmployeeID, e.LastName, COUNT(*) AS TotalLateOrders
	FROM Employees AS e
	JOIN Orders AS o ON o.EmployeeID = e.EmployeeID
	WHERE CAST(o.ShippedDate AS DATE) >= CAST(o.RequiredDate AS DATE)
	GROUP BY o.EmployeeID, e.LastName
	ORDER BY COUNT(*) DESC
) AS late ON e.EmployeeID = late.EmployeeID
GROUP BY e.EmployeeID, e.LastName;

/* Exercise 48 */

SELECT *,
	   CASE WHEN
       totorder BETWEEN 0 AND 1000 THEN 'Low' WHEN
       totorder BETWEEN 1000 AND 5000 THEN 'Medium' WHEN
       totorder BETWEEN 5000 AND 10000 THEN 'High' WHEN
       totorder >= 10000 THEN 'Very high' 
       END AS customergroup
FROM (
	SELECT o.CustomerID,
		   c.CompanyName,
		   SUM(od.UnitPrice * od.Quantity) AS totorder
	FROM Orders AS o
	JOIN OrderDetails AS od ON o.OrderID = od.OrderID
	JOIN Customers AS c ON o.CustomerID = c.CustomerID
	WHERE o.OrderDate BETWEEN '20160101' AND '20170101'
	GROUP BY o.CustomerID, c.CompanyName
	ORDER BY o.CustomerID, c.CompanyName
) AS mt;


/* Exercise 49 */

SELECT *,
	   CASE WHEN
       totorder BETWEEN 0 AND 1000 THEN 'Low' WHEN
       totorder BETWEEN 1000 AND 5000 THEN 'Medium' WHEN
       totorder BETWEEN 5000 AND 10000 THEN 'High' WHEN
       totorder >= 10000 THEN 'Very high' 
       END AS customergroup
FROM (
	SELECT o.CustomerID,
		   c.CompanyName,
		   SUM(od.UnitPrice * od.Quantity) AS totorder
	FROM Orders AS o
	JOIN OrderDetails AS od ON o.OrderID = od.OrderID
	JOIN Customers AS c ON o.CustomerID = c.CustomerID
	WHERE o.OrderDate BETWEEN '20160101' AND '20170101'
	GROUP BY o.CustomerID, c.CompanyName
	ORDER BY o.CustomerID, c.CompanyName
) AS mt
WHERE mt.CustomerID = 'MAISD';