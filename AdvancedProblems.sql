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
