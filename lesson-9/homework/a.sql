drop table if exists employees ;
create TABLE employees(
    mpiID int primary key identity (1,1),
    name varchar(200)not null,
    salary decimal(10,2)not null,
    depID int
);
drop table if exists products;
create table products(
    productsID int primary key identity(1,1),
    productsname varchar(200) not null,
    category varchar(200) not null,
    price decimal(10,2) not null
);
drop table if exists sales;
create table sales(
    salesID int primary key identity(1,1),
    productID int not null,
    saleamount decimal(10,2)not null ,
    saledata data not null
);
drop table if exists customers ;
create table customers(
    customersID int primary key identity(1,1),
    custumersname varchar(200)not null,
    customersage int,
);
drop table if exists orders;
create table orders(
    ordersID int primary key identity(1,1),
    customerID int not NULL,
    orderdata data not null,
    orderquantity int not null
);
insert into employees (name, salary, deptID) value
('John Doe', 50000.00, 1),
('Jane Smith', 60000.00, 1),
('Bob Johnson', 70000.00, 2),
('Alice Brown', 80000.00, 2),
('Mike Davis', 90000.00, 3),
('Sarah Wilson', 100000.00, 3),
('David Garcia', 110000.00, 4),
('Linda Rodriguez', 120000.00, 4),
('Christopher Williams', 130000.00, 5),
('Angela Garcia', 140000.00, 5);

insert into products(productID, productsname, category, price) value
('Laptop', 'Electronics', 1200.00),
('Smartphone', 'Electronics', 800.00),
('T-Shirt', 'Clothing', 25.00),
('Jeans', 'Clothing', 50.00),
('Book', 'Books', 15.00),
('Notebook', 'Books', 10.00),
('TV', 'Electronics', 1000.00),
('Dress', 'Clothing', 75.00),
('Pen', 'Stationery', 5.00),
('Pencil', 'Stationery', 3.00);

insert into sales(salesID, productID, saleamount, saledata) VALUE
(1, 1, 1200.00, '2023-01-15'),
(2, 2, 800.00, '2023-02-20'),
(3, 3, 25.00, '2023-03-10'),
(4, 4, 50.00, '2023-04-05'),
(5, 5, 15.00, '2023-05-12'),
(1, 2, 1200.00, '2023-06-18'),
(2, 3, 800.00, '2023-07-22'),
(3, 4, 25.00, '2023-08-01'),
(4, 5, 50.00, '2023-09-15'),
(5, 1, 15.00, '2023-10-20'),
(6, 1, 10.00, '2024-01-05'),
(7, 2, 1000.00, '2024-02-10'),
(8, 3, 75.00, '2024-03-15'),
(9, 4, 5.00, '2024-04-20'),
(10, 5, 3.00, '2024-05-25'),
(6, 5, 10.00, '2024-06-30'),
(7, 4, 1000.00, '2024-07-01'),
(8, 3, 75.00, '2024-08-02'),
(9, 2, 5.00, '2024-09-03'),
(10, 1, 3.00, '2024-10-04');

insert into Customers (CustomerName, CustomerAge) VALUES
('Alice Smith', 25),
('Bob Johnson', 30),
('Charlie Brown', 35),
('Diana Miller', 40),
('Ethan Davis', 45);

INSERT INTO Orders (CustomerID, OrderDate, OrderQuantity) VALUES
(1, '2023-01-10', 2),
(2, '2023-02-15', 1),
(3, '2023-03-20', 3),
(4, '2023-04-25', 1),
(5, '2023-05-30', 2),
(1, '2023-06-05', 1),
(2, '2023-07-10', 3),
(3, '2023-08-15', 2),
(4, '2023-09-20', 1),
(5, '2023-10-25', 2);

-- Yangi jadval: Products_Discounted
CREATE TABLE Products_Discounted (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2),
    Category VARCHAR(50),
    StockQuantity INT
);
INSERT INTO Products_Discounted VALUES
(1, 'Gaming Laptop', 950.00, 'Electronics', 25),
(2, 'Smartphone', 750.00, 'Electronics', 45),
(3, 'Convertible Tablet', 350.00, 'Electronics', 35),
(4, 'Ultra-Wide Monitor', 220.00, 'Electronics', 55),
(5, 'Mechanical Keyboard', 45.00, 'Accessories', 90),
(6, 'Wireless Mouse', 25.00, 'Accessories', 110),
(7, 'Chair', 130.00, 'Furniture', 75),
(8, 'Standing Desk', 190.00, 'Furniture', 70),
(9, 'Luxury Pen', 4.50, 'Stationery', 280),
(10, 'Leather Notebook', 9.00, 'Stationery', 480),
(11, 'Laser Printer', 160.00, 'Electronics', 20),
(12, 'DSLR Camera', 480.00, 'Electronics', 35),
(13, 'LED Flashlight', 20.00, 'Tools', 190),
(14, 'Designer Shirt', 28.00, 'Clothing', 140),
(15, 'Jeans', 40.00, 'Clothing', 110),
(16, 'Winter Jacket', 70.00, 'Clothing', 60),
(17, 'Running Shoes', 55.00, 'Clothing', 90),
(18, 'Wool Hat', 18.00, 'Accessories', 45);

select min(price) from products;

select max(salary) from employees;

select count(*) from customer;

select count(distinct category) from products;

select sum(SaleAmount) from sales 
where productID =7;

select avg(employees) from employees;

select  deptId count(*) from employees
group by deptID;

select category, min(price), max(price) from product
group by category;

select customerID, sum(saleamount) from sales
group by customerID;

select deptID, count(*) from saleamount
group by deptID
having count(*) < 5;
 
select category, sun(saleamount), avg(saleamount) from sales
group by category;

select uount(empID) from employees
having deptID = 1;

select deptID, min(salary), max(salary) from employees
group by deptId

select deptID, avg(salary) from employees 
group by deptID;

select deptID, avg(salary) count(*) from employees
group by deptID

select category, avg(price) from product
group by category
having avg(price) > 400;

select year(saledate) from sales
group by year(saledate);

select customerID, count(*) from orders
group by customerID
HAVING count(*) >= 3;

select deptID, sum(salary) from employees
group by deptId
having sum(salary) > 500000;

select category, avg(saleamount) from sales
group by category
having avg(saleamount) > 200;

select category, sum(saleamount) from sales
group by category
having sum(saleamount) > 1500;

select deptID, sum(salary) from employees
group by deptId
having sum(salary) > 6500;

select custmerID, max(saleamount), min(saleamount) from sales
group by customerID
having min(saleamount) > =50;

select month(saledata), sum(saleamount), count(distinct productID) from sales
group by month(saledata)
having count(distinct productID) > 8;

select year(ordersdata), min(quantity), max(quantity) FROM orders
order by year(ordersdata) 
