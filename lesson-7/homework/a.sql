-- 1. Products jadvalidagi minimal narxdagi mahsulotni topish
SELECT MIN(Price)
FROM Products;

-- 2. Employees jadvalidagi eng yuqori maoshni topish
SELECT MAX(Salary)  
FROM Employees;

-- 3. Customers jadvalidagi qatorlar sonini hisoblash
SELECT COUNT(*) 
FROM Customers;

-- 4. Products jadvalidagi noyob kategoriyalar sonini hisoblash
SELECT COUNT(DISTINCT Category)
FROM Products;

-- 5. Sales jadvalidagi id=7 bo‘lgan mahsulot uchun umumiy savdoni hisoblash
SELECT SUM(SalesAmount)
FROM Sales 
WHERE ProductID = 7;

-- 6. Employees jadvalidagi o‘rtacha yoshni hisoblash
SELECT AVG(Age) 
FROM Employees;

-- 7. Har bir bo‘limdagi xodimlar sonini hisoblash
SELECT DeptID, COUNT(*)
FROM Employees 
GROUP BY DeptID;

-- 8. Kategoriya bo‘yicha mahsulotlarning minimal va maksimal narxlarini ko‘rsatish
SELECT Category, MIN(Price), MAX(Price)
FROM Products
GROUP BY Category;

-- 9. Har bir mijoz uchun umumiy savdoni hisoblash
SELECT CustomerID, SUM(SalesAmount)
FROM Sales 
GROUP BY CustomerID;

-- 10. 5 tadan ortiq xodim ishlaydigan bo‘limlarni ko‘rsatish
SELECT DeptID, COUNT(*) 
FROM Employees 
GROUP BY DeptID
HAVING COUNT(*) > 5;

-- 11. Har bir mahsulot kategoriyasi uchun umumiy va o‘rtacha savdoni hisoblash
SELECT Category, SUM(SalesAmount) AVG(SalesAmount)
FROM Sales 
GROUP BY Category;

-- 12. HR bo‘limidagi xodimlar sonini hisoblash
SELECT COUNT(EmployeeID)
FROM Employees
WHERE Department = 'HR';

-- 13. Har bir bo‘lim uchun maksimal va minimal maoshni topish
SELECT DeptID, MAX(Salary) MIN(Salary)
FROM Employees 
GROUP BY DeptID;

-- 14. Har bir bo‘lim uchun o‘rtacha maoshni hisoblash
SELECT DeptID, AVG(Salary)
FROM Employees 
GROUP BY DeptID;

-- 15. Har bir bo‘lim uchun o‘rtacha maosh va xodimlar sonini hisoblash
SELECT DeptID, AVG(Salary) COUNT(*) 
FROM Employees
GROUP BY DeptID;

-- 16. O‘rtacha narxi 400 dan yuqori bo‘lgan mahsulot kategoriyalarini ko‘rsatish
SELECT Category, AVG(Price)
FROM Products
GROUP BY Category 
HAVING AVG(Price) > 400;

-- 17. Har bir yil uchun umumiy savdoni hisoblash
SELECT YEAR(SaleDate) SUM(SalesAmount)
FROM Sales 
GROUP BY YEAR(SaleDate);

-- 18. Kamida 3 ta buyurtma bergan mijozlar sonini ko‘rsatish
SELECT CustomerID, COUNT(*)
FROM Sales 
GROUP BY CustomerID 
HAVING COUNT(*) >= 3;

-- 19. Umumiy maosh xarajatlari 500000 dan ortiq bo‘lgan bo‘limlarni ko‘rsatish
SELECT DeptID, SUM(Salary)
FROM Employees 
GROUP BY DeptID 
HAVING SUM(Salary) > 500000;

-- 20. O‘rtacha savdosi 200 dan yuqori bo‘lgan mahsulot kategoriyalarini ko‘rsatish
SELECT Category, AVG(SalesAmount)
FROM Sales 
GROUP BY Category 
HAVING AVG(SalesAmount) > 200;

-- 21. Umumiy savdosi 1500 dan yuqori bo‘lgan mijozlarni ko‘rsatish
SELECT CustomerID, SUM(SalesAmount)
FROM Sales 
GROUP BY CustomerID 
HAVING SUM(SalesAmount) > 1500;

-- 22. O‘rtacha maoshi 65000 dan yuqori bo‘lgan bo‘limlar uchun umumiy va o‘rtacha maoshni ko‘rsatish
SELECT DeptID, SUM(Salary) AVG(Salary) 
FROM Employees 
GROUP BY DeptID 
HAVING AVG(Salary) > 65000;

-- 23. Buyurtma qiymati 50 dan kichik bo‘lgan mijozlarni chiqarib tashlab, qolganlar uchun eng katta va eng kichik buyurtma qiymatini ko‘rsatish
SELECT CustomerID, MAX(OrderValue) MIN(OrderValue)
FROM Orders 
GROUP BY CustomerID 
HAVING MIN(OrderValue) >= 50;

-- 24. Har bir oy uchun umumiy savdo va noyob mahsulotlar sonini hisoblash, 8 dan ortiq mahsulot sotilgan oylarni ko‘rsatish
SELECT MONTH(SaleDate) SUM(SalesAmount) COUNT(DISTINCT ProductID)
FROM Sales 
GROUP BY MONTH(SaleDate) 
HAVING COUNT(DISTINCT ProductID) > 8;

-- 25. Har bir yil uchun minimal va maksimal buyurtma miqdorini ko‘rsatish
SELECT YEAR(OrderDate) MIN(OrderQuantity) MAX(OrderQuantity)
FROM Orders 
GROUP BY YEAR(OrderDate);
