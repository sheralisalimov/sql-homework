CREATE TABLE TALABA (
    ID INT PRIMARY KEY IDENTITY (1,1),
    NAME VARCHAR (50),
    YEAR INT,
    Salary DECIMAL(10,2)
); 

INSERT INTO TALABA (NAME, YEAR,Salary)
VALUES  
    ('SHERALI', 29, 10000 ),
    ('BAHTIYOR', 20, 15000 ),
    ('ISMOIL', 33, 20000);

SELECT * FROM TALABA ;

UPDATE TALABA
SET YEAR = 34
WHERE NAME = 'ISMOIL';

DELETE FROM TALABA 
WHERE NAME = 'BAHTIYOR';

ALTER TABLE TALABA 
ADD Department  varchar(100);
 
ALTER TABLE TALABA
ALTER COLUMN Salary FLOAT ;

CREATE TABLE DEPARTMENT (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

TRUNCATE TABLE TALABA;

INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES
  (10, 'Sales'),
  (20, 'Engineering'),
  (30, 'Finance'),
  (40, 'Support'),
  (50, 'Research');

UPDATE Employees
SET Department = 'Boshqarish'
WHERE Salary > 5000;

TRUNCATE TABLE Employees;

ALTER TABLE Employees
DROP COLUMN Department;

EXEC sp_rename 'Employees', 'StaffMembers';

DROP TABLE Departments;

CREATE TABLE Products (
    ProductsID INT PRIMARY KEY IDENTITY (1,1),
    ProductsName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2) CHECK (Price>0) ,
    Description varchar(250)
) ;

ALTER TABLE Products
add StockQuantity int DEFAULT 50;

EXEC sp_rename 'Products.Category', 'ProductCategory', 'COLUMN';
