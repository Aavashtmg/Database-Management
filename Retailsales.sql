CREATE TABLE RetailSales (
    SaleID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(50),
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    SaleDate DATE
);

INSERT INTO RetailSales VALUES
(1, 'Amit Sharma', 'Kathmandu', 'Laptop', 'Electronics', 1, 80000, '2025-01-10'),
(2, 'Amit Sharma', 'Kathmandu', 'Mobile Phone', 'Electronics', 2, 40000, '2025-01-12'),
(3, 'Rina Thapa', 'Pokhara', 'Mobile Phone', 'Electronics', 1, 40000, '2025-01-15'),
(4, 'Suman Karki', 'Kathmandu', 'Office Chair', 'Furniture', 4, 15000, '2025-01-20'),
(5, 'Suman Karki', 'Kathmandu', 'Table', 'Furniture', 1, 20000, '2025-01-22'),
(6, 'Anil Gurung', 'Butwal', 'Laptop', 'Electronics', 2, 80000, '2025-01-25'),
(7, 'Rina Thapa', 'Pokhara', 'Table', 'Furniture', 3, 20000, '2025-01-26');


INSERT INTO RetailSales VALUES
(8,  'Amit Sharma',  'Kathmandu', 'Mouse',        'Electronics', 3, 1200,  '2025-02-01'),
(9,  'Rina Thapa',   'Pokhara',   'Keyboard',     'Electronics', 2, 2500,  '2025-02-02'),
(10, 'Anil Gurung',  'Butwal',    'Office Chair', 'Furniture',   1, 15000, '2025-02-03'),
(11, 'Suman Karki',  'Kathmandu', 'Laptop',       'Electronics', 1, 80000, '2025-02-04'),
(12, 'Bikash Rana',  'Biratnagar','Mobile Phone', 'Electronics', 2, 40000, '2025-02-05'),
(13, 'Bikash Rana',  'Biratnagar','Table',        'Furniture',   1, 20000, '2025-02-06'),
(14, 'Nisha Adhikari','Kathmandu','Keyboard',     'Electronics', 3, 2500,  '2025-02-07'),
(15, 'Nisha Adhikari','Kathmandu','Mouse',        'Electronics', 5, 1200,  '2025-02-07'),
(16, 'Anil Gurung',  'Butwal',    'Table',        'Furniture',   2, 20000, '2025-02-08'),
(17, 'Rina Thapa',   'Pokhara',   'Office Chair', 'Furniture',   2, 15000, '2025-02-09'),
(18, 'Amit Sharma',  'Kathmandu', 'Table',        'Furniture',   1, 20000, '2025-02-10'),
(19, 'Bikash Rana',  'Biratnagar','Laptop',       'Electronics', 1, 80000, '2025-02-11'),
(20, 'Suman Karki',  'Kathmandu', 'Mouse',        'Electronics', 4, 1200,  '2025-02-12');


select count(*) as no_of_records from RetailSales group by City

select productname, count(*) as no_of_records from RetailSales group by ProductName

select distinct productname, customername from RetailSales
select * from RetailSales

select distinct productname, unitprice from RetailSales where UnitPrice > 5000;

select category, count(*) from retailsales group by category 

select category, sum(quantity), sum(unitprice) from RetailSales group by Category

select category, max(quantity) from RetailSales group by category   

select * from RetailSales 

select productname, sum(quantity) as unit_sold from RetailSales group by productname

select productname, sum(quantity*unitprice) as totalsales from RetailSales group by productname

select city, count(*) from RetailSales group by city

select productname, count(*) from RetailSales group by productname

select productname, count(*) totalsales from RetailSales group by productname having count(*)>3

select customername, count(*) totalsales from RetailSales group by customername having sum(quantity * unitprice) > 100000 order by totalspent desc