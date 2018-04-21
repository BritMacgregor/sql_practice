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
	SELECT OrderID
	FROM OrderDetails
	WHERE Quantity >= 60
	GROUP BY OrderID, Quantity
	HAVING COUNT(*) > 1
) as ode
ON od.OrderID = ode.OrderID;