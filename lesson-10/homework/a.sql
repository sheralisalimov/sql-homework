--1
SELECT e.EmployeeName, e.Salary, d.DepartmentName
FROM Employee e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > 50000;
--2
SELECT c.FirstName, c.LastName, o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE YEAR(o.OrderDate) = 2023;
--3
SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID;
--4
SELECT s.SupplierName, p.ProductName
FROM Suppliers s
LEFT JOIN Products p ON s.SupplierID = p.SupplierID;
--5
SELECT o.OrderID, o.OrderDate, p.PaymentDate, p.Amount
FROM Orders o 
FULL OUTER JOIN Payments p ON o.OrderID = p.OrderID;
--6
SELECT e.FullName AS EmployeeName, m.FullName AS ManagerName
FROM Employees e
LEFT JOIN Employees m ON e.ManagerID = m.EmployeeID;
--7
SELECT s.StudentName, c.CourseName
FROM EmployeeName e
JOIN Students s ON e.StudentID = s.StudentID
JOIN courses c ON e.CourseID = c.CourseID
WHERE c.CourseName = 'Math 101';
--8
SELECT c.FirstName, c.LastName, o.Quantity
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.Quantity > 3;
--9
SELECT e.FullName AS EmployeeName, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Human Resources';
--10
SELECT d.DepartmentName, COUNT(e.EmployeeID) AS EmployeeCount
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP by d.DepartmentName 
HAVING COUNT(e.EmployeeID) > 5;
--11
SELECT p.ProductCodes, p.PraductName
FROM Products p
LEFT JOIN Sales s ON p.ProductID = s.ProductID
WHERE s.ProductID IS NULL;
--12
SELECT c.FirstName, c.LastName, COUNT(o.OrderID) as TotelOrders
FROM Customers c 
JOIN Orders o ON c.CostmerID = o.CostmerID
GROUP by c.FirstName, c.LastName;
--13
SELECT e.FullName AS EmployeeName, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID;
--14
SELECT e1.FullName AS Employees1, e2.Fullname AS Employees2, e1.ManagerID
FROM Employees e1
join Employees e2 ON e1.ManagerID = e2.ManagerID AND e1.EmployeeID < e2.EmployeeID
WHERE e1.ManagerID IS NOT NULL;
--15
SELECT e.FullName as EmployeeName, e.DepartmentName
FROM Eployees e 
INNER JOIN Departments d ON e.DepartmntID = d.DepartmntID;
--16
SELECT e.FullName as EmployeeName, e.Salary, d.DepartmentName
FROM Employees e
JOIN Department d ON e.DepartmentID = d.DepartmentID
where d.DepartmentName = 'sales'AND e.Salary > 60000; 
--17
SELECT o.OrderID, o.OrderDate, p.PaymentDate, p.Amount
FROM Oders o 
INNER JOIN Payments p ON o.OrderID = p.OrderID;
--18
SELECT p.ProductID, p.ProductName
FROM Products p
INNER JOIN Orders ON p.ProductID = o.productID
WHERE o.OrderID IS NULL;
--19
SELECT e.FullName as EmployeeNamee, e.salary
FROM Employees e
where e.Salary >(
    SELECT avg(e2.Salary)
    FROM Employees e2
    WHERE e2.DepartmentID = e.DeparmentID);
--20
SELECT o.OrderID, o.OrderDate
FROM Orders o
LEFT JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.OrderID IS NULL
AND o.OrderDate < '2020-01-01';
--21
SELECT p.ProductID, p.ProductsName
FROM Products p 
LEFT JOIN Catigories c ON p.CatigoryId = c.CatigoryID
WHERE c.CatigoryID IS NULL;
--22
SELECT e1.FullName AS Employee1, e2.FullName AS Employee2, e1.ManagerID, e1.Salary
FROM Employees e1
JOIN Employees e2 ON e1.ManagerID = e2.MenagerID AND e1.Employee < e2.Employee
WHERE e1.ManagerID IS NOT NULL AND e1.Salary > 60000 AND e2.Salary > 60000;
--23
SELECT e.FullName AS EmployeeName, d.DeparmentName
FROM Employees e
JOIN Deporments d ON e.DepormentID = d.DepormentID
WHERE d.DepormentName LIKE 'm%';
--24
SELECT s.SaleID , p.ProductName, s.SaleAmount
FROM Sales s 
JOIN Products p ON s.ProductID = p.ProductID
WHERE s.Selamount >500;
--25
SELECT s.StudentID, s.StudentName 
FROM Students s 
WHERE s.StudentId is NOT NULL(
    SELECT s1.StudentID 
    FROM Enrollments e
    JOIN Courses c ON e.CoursesId = c.CoursesID
    Where c.CoursesName = 'mont 101');
--26
SELECT o.OrderID, o.OrderDate, p.PaymentID
FROM Orders s
LEFT JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.PaymentsID IS NULL;
--27
SELECT p.ProductsName, p.ProductsName, c.CotigoresName
FROM Products p
JOIN Catigores c ON p.Catigores = c.Catigores
WHERE c.catigoryName IN ('Electronics','Furniture');
