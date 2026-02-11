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

select top 2 customername,
sum(case when category = 'Electronics' THEN quantity * unitprice else 0 end) as electronics,
sum(case when category = 'Furniture' THEN quantity * unitprice else 0 end) as furnitutre_spending
from retailsales group by customername 
 having
 sum(case when category = 'Electronics' THEN quantity * unitprice else 0 end) >
 sum(case when category = 'Furniture' THEN quantity * unitprice else 0 end )
 order by 2 asc;

select city, max(quantity * unitprice) as highest_single_sale_amount
from RetailSales
group by city 
having max(quantity * unitprice) > 60000.00;

select customername, category, sum (quantity * unitprice) as total_spending 
from retailsales
group by customername, category
having sum(quantity * unitprice) > 50000;


--assignment
--1
select productname, sum(quantity) as total_qty from retailsales group by productname;
--2
select productname, sum(quantiy*unitprice) as total_sales from RetailSales group by productname;
--3 
select city, count(*) as no_of_records from RetailSales group by city;
--4
select customername, sum(quantity) as qty_sold from RetailSales group by customername;
--5 
select category, count(*) as no_of_records from RetailSales group by category;
--6
select category, min(unit price) as min_unit from RetailSales group by category;
--7
select productname, max(unitprice) as max_value from RetailSales group by productname;
--8
select category, avg(unitprice) as avg_value from RetailSales group by category;
--9 
select city, sum(quantity*unitprice) as total_sale from RetailSales group by city;
--10
select productname, count(*) as product_sold from RetailSales group by productname;
--11 
select productname, count(*) as product_sold from RetailSales group by productname having count(*)>3;
--12 
select customername, sum(quantity*unitprice) as total_pur from RetailSales group by customername having sum(quantity*unitprice) > 100000;
--13
select city, sum(quantity*unitprice) as total_sales from RetailSales group by city 
having sum(quantity*unitprice) > 150000;
--14
select category, sum(quantity) as total_items from RetailSales group by category having sum(quantity)>5;
--15
 select productname, count(*) as sale_count from RetailSales group by productname having count(*)>2; 
 --16
 select customername, sum(quantity) as total_items from RetailSales group by customername having sum(quantity)>5;
 --17
 select category, avg(unitprice) as avgprice from RetailSales group by category having avg(unitprice)>20000;
 --18
 select city, count(*) as salescount from RetailSales group by city having count(*)>3;
 --19
 select productname, sum(quantity*unitprice) as totalsales from RetailSales group by productname having sum(quantity*unitprice)>50000;
 --20
 select customername, count(*) as qty_purchased from RetailSales group by customername having count(*)>1;
 --21
 select customername, count(distinct category) as qty_purchased from RetailSales group by CustomerName having count(distinct category)>1;
 --22
 select productname, count(distinct city) as sold_in_city from RetailSales group by productname having count(distinct city)>1;
 --23
 select city, count(distinct productname) as item_sold from RetailSales group by city having count(distinct productname)>2;
 --24
 select category, count(distinct productname) as item_sold from RetailSales group by category having count(distinct productname)>2;
 --25
 select customername, avg(quantity*unitprice) as avg_sales from RetailSales group by customername having avg(quantity*unitprice)>30000;
 --26
 select productname, avg(quantity) as avg_qty from RetailSales group by productname having avg(quantity)>2;
 --27
 select customername, count(distinct saledate) as date_records from RetailSales group by customername having count(distinct saledate)>1;
--28 
select productname, count(distinct saledate) as data_records from RetailSales group by productname having count(distinct saledate)>3;
--29
select city, count(distinct category) as category_purchased from RetailSales group by city having count(distinct category)=2;
--30
select customername, productname from RetailSales group by customername, productname having count(*)>1;


