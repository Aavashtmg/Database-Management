-- Create Database
CREATE DATABASE RetailLabDB;
GO

USE RetailLabDB;
GO

-- Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20),
    City VARCHAR(50) DEFAULT 'Kathmandu',
    RegistrationDate DATE DEFAULT GETDATE()
);

-- Employees Table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FullName VARCHAR(100) NOT NULL,
    Position VARCHAR(50),
    Salary DECIMAL(10,2) CHECK (Salary > 10000),
    HireDate DATE
);

-- Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10,2) CHECK (Price > 0),
    StockQuantity INT CHECK (StockQuantity >= 0)
);

-- Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    EmployeeID INT,
    OrderDate DATE DEFAULT GETDATE(),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT,
    ProductID INT,
    Quantity INT CHECK (Quantity > 0),
    UnitPrice DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


-- Insert Customers
INSERT INTO Customers (FullName, Email, Phone, City)
VALUES 
('Aarav Sharma', 'aarav@gmail.com', '9800000001', 'Kathmandu'),
('Sita Rai', 'sita@gmail.com', '9800000002', 'Lalitpur'),
('Ram Thapa', 'ram@gmail.com', '9800000003', 'Bhaktapur'),
('Nabin Karki', 'nabin@gmail.com', '9800000004', 'Kathmandu'),
('Priya Shrestha', 'priya@gmail.com', '9800000005', 'Pokhara');

-- Insert Employees
INSERT INTO Employees (FullName, Position, Salary, HireDate)
VALUES
('Ramesh Adhikari', 'Manager', 60000, '2021-01-10'),
('Sunita Lama', 'Sales Executive', 35000, '2022-05-12'),
('Bikash Gurung', 'Sales Executive', 32000, '2023-02-15'),
('Anita KC', 'Cashier', 25000, '2024-01-01');

-- Insert Products
INSERT INTO Products (ProductName, Category, Price, StockQuantity)
VALUES
('Laptop', 'Electronics', 80000, 10),
('Mobile', 'Electronics', 30000, 25),
('Headphones', 'Electronics', 2000, 50),
('Office Chair', 'Furniture', 7000, 15),
('Desk', 'Furniture', 12000, 5),
('Notebook', 'Stationery', 100, 200);

-- Insert Orders
INSERT INTO Orders (CustomerID, EmployeeID, OrderDate)
VALUES
(1, 2, '2025-01-10'),
(2, 3, '2025-01-12'),
(3, 2, '2025-02-01'),
(1, 1, '2025-02-10');

-- Insert OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice)
VALUES
(1, 1, 1, 80000),
(1, 3, 2, 2000),
(2, 2, 1, 30000),
(3, 4, 2, 7000),
(4, 6, 10, 100);


--1
select fullname, city, registrationDate
from customers;

--2
select 
o.OrderID,
c.FullName AS CustomerName,
e.FullName AS EmployeeName,
o.OrderDate
from Orders o 
join Customers c ON o.CustomerID = c.CustomerID
join Employees e ON o.EmployeeID = e.EmployeeID;

--3
select 
p.ProductName,
p.Category,
od.Quantity,
od.UnitPrice,
od.Quantity * od.UnitPrice AS TotalPrice
from OrderDetails od
join Products p ON od.ProductID = p.ProductID;

--4
select c.FullName 
from Customers c
left join Orders o on c.CustomerID = o.CustomerID
where o.OrderID is null;

--5 
select p.productname
from Products p 
left join OrderDetails od on p.ProductID = od.ProductID
where od.OrderDetailID is null;

--6 
select o.orderid,
sum(od.quantity*od.unitprice) as totalsales
from Orders o
join OrderDetails od on o.OrderID = od.OrderID
group by o.OrderID;

--7
select e.fullname,
sum(quantity*unitprice) as totalrevenue
from Employees e
join Orders o on e.EmployeeID = e.EmployeeID
join OrderDetails od on o.OrderID = o.OrderID
group by e.fullname;

--8
SELECT
    p.ProductName,
    SUM(od.Quantity) AS TotalQuantitySold
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY TotalQuantitySold DESC;

--9
SELECT Position, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY Position;

--10
SELECT
    c.City,
    SUM(od.Quantity * od.UnitPrice) AS TotalSales
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY c.City;

--11
SELECT
    e.FullName,
    SUM(od.Quantity * od.UnitPrice) AS TotalSales
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY e.FullName
HAVING SUM(od.Quantity * od.UnitPrice) > 50000;

--12
SELECT
    p.ProductName,
    SUM(od.Quantity) AS TotalQuantity
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
HAVING SUM(od.Quantity) > 10;

--13
SELECT ProductName, Price
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);

--14
SELECT c.FullName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FullName
HAVING COUNT(o.OrderID) >
(
    SELECT AVG(OrderCount)
    FROM (
        SELECT COUNT(OrderID) AS OrderCount
        FROM Orders
        GROUP BY CustomerID
    ) t
);

--15
SELECT FullName
FROM Employees
WHERE EmployeeID =
(
    SELECT TOP 1 o.EmployeeID
    FROM Orders o
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    GROUP BY o.EmployeeID
    ORDER BY SUM(od.Quantity * od.UnitPrice) DESC
);

--16
select 
upper(fullname) as uppername,
left(fullname, 3) as firstthreechars
from customers;

--17
select left(fullname, charindex('', fullname + '')-1) as firstname
from Employees;

--18
select fullname from Customers where fullname like 'A%';

--19
select* from Orders where month(orderdate) = month(getdate())
and  year (orderdate) = year(getdate());
 
 --20 
 select 
 orderid,
 datediff(day, orderdate, getdate()) as daysSinceorder from Orders;

 --21
 select * from Employees where hiredate >= dateadd(year, -2, getdate());

 --22
 select 
 year(o.orderdate) as year,
month(o.orderdate) as month,
sum ( quantity * unitprice) as totalsales
from Orders o 
join OrderDetails od on o.OrderID = od.OrderID
group by year (o.orderdate), month(o.orderdate)
order by year, month;

--23
create view vw_ordersummary as 
select 
o.OrderID,
c.FullName as CustomeNname,
sum(quantity*unitprice) as totalorderamount,
o.OrderDate
from Orders o 
join Customers c on o.customerid = c.customerid
join orderdetails od on o.orderid = od.orderid
group by o.orderid, c.fullname, o.orderdate;

--24
CREATE view vw_Employeeales AS
SELECT
    e.FullName AS EmployeeName,
    SUM(od.Quantity * od.UnitPrice) AS TotalSales
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY e.FullName;

--25
create view vw_ProductSalesReport AS
select
    p.ProductName,
    p.Category,
    SUM(od.Quantity) AS TotalQuantitySold,
    SUM(od.Quantity * od.UnitPrice) AS TotalRevenue
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductName, p.Category;

--26
select * from vw_ordersummary
order by totalorderamount desc;

--27
select *
from vw_Employeeales
where totalsales > 100000;

--28
select* 
from vw_ProductSalesReport 
where TotalRevenue > 20000

--29
select 
c.FullName as CustomerName, 
count(o.orderid) as totalorders,
sum(od.quantity * od.unitprice) AS totalamountspent,
max(o.orderdate) as lastorderdate,
e.FullName as lasthandby
from Customers c
join Orders o on c.CustomerID = o.CustomerID
join OrderDetails od on o.OrderID = od.OrderID
join Employees e on o.EmployeeID = e.EmployeeID
group by c.FullName, e.FullName order by totalamountspent desc;

