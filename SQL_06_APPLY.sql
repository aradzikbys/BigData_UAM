-- EX01
/* Convert below query to replace JOIN with APPLY. */
-- w/o APPLY:
SELECT	P.ProductID,
		P.ProductName,
		S.CompanyName
FROM Products P
JOIN Suppliers S ON P.SupplierID = S.SupplierID
ORDER BY ProductID
		P.ProductName,
		S.CompanyName
FROM Products P 
CROSS APPLY Suppliers as S
WHERE S.SupplierID = P.SupplierID
ORDER BY ProductID
order date and attendant details (function: employeeInfo: FirstName, LastName).
Sort the result according to the order ID. */
    DROP FUNCTION dbo.employeeInfo;  
GO  
CREATE FUNCTION dbo.employeeInfo(@OrderID INT)
RETURNS TABLE   
AS     
RETURN (
	SELECT	E.FirstName, 
			E.LastName,
			E.Address
	FROM	Orders O
	JOIN Employees E ON	O.EmployeeID = E.EmployeeID
	WHERE	O.OrderID = @OrderID
)
will return customer data: CompanyName, ContactName, Address. */
		C.CompanyName,
		C.ContactName,
		C.Address
FROM Orders O
CROSS APPLY Customers C
WHERE C.CustomerID = O.CustomerID

--insert query into function:
    DROP FUNCTION dbo.customerInfo;  
GO  

CREATE FUNCTION dbo.customerInfo(@OrderID INT)  
RETURNS TABLE   
AS     
RETURN (
		SELECT	C.CompanyName,
				C.ContactName,
				C.Address
		FROM Orders O
		CROSS APPLY Customers C
		WHERE	C.CustomerID = O.CustomerID
				AND O.OrderID = @OrderID
		)
UNION ALL
SELECT * FROM dbo.customerInfo(NULL)
UNION ALL
SELECT * FROM dbo.customerInfo(0)

--EX04
/* Update the query from EX02 with customer details: CompanyName, Contact, Address (use
customerInfo function). */

SELECT	O.OrderID,
surname, city, region of the employee and the sum of orders by him served (including the discount!).
SELECT	E.FirstName,
		E.LastName,
		E.City,
		E.Region,
		ROUND(SUM(OD.Quantity * OD.UnitPrice * (1 - OD.Discount)),2) AS OrdersValue
FROM Orders O
OUTER APPLY [Order Details] OD
OUTER APPLY Employees E
WHERE	E.EmployeeID = O.EmployeeID
		AND OD.OrderID = O.OrderID
GROUP BY E.FirstName, E.LastName, E.City, E.Region
ORDER BY OrdersValue DESC;