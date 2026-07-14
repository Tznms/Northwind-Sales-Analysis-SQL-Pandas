-- Section A: Sales & Revenue
-- Q1: Which countries generate the best reveues this year?
SELECT 
o.ShipCountry, 
sum (od.UnitPrice*od.Quantity*(1-od.Discount)) as totalRev
from "Order details" od
join Orders o on od.OrderID = o.OrderID
where strftime('%Y', o.OrderDate) = '2023'
group by o.ShipCountry 
order by totalRev desc


-- Q2: What are the top 10 best-selling products by total revenue?
select 
p.ProductName,
sum (od.UnitPrice * od.Quantity * (1- od.Discount)) as totalRev
from Products p 
join "order details" od on p.ProductID = od.ProductID
group by ProductName 
order by totalRev DESC
limit 10;

-- Q3: Which product categories are underperforming compared to others?
-- option 1: only counting the categories with the least rev
select 
c.CategoryName,
sum (od.UnitPrice * od.Quantity * (1-od.Discount)) as totalRev
from Categories c 
join Products p on c.CategoryID = p.CategoryID
join "Order details" od on p.ProductID = od.ProductID
group by c.CategoryName
order by totalRev asc

-- option 2: countimg based on rev per product, cuz some categories have little rev due to the little i=number of products in the category 
-- in addition to selecting a year <optionally>
select 
c.CategoryName,
sum (od.UnitPrice * od.Quantity * (1-od.Discount)) as totalRev,
sum (od.UnitPrice * od.Quantity * (1-od.Discount))/ count (DISTINCT p.ProductID) as revPerProduct
from Categories c 
join Products p on c.CategoryID = p.CategoryID
join "Order details" od on p.ProductID = od.ProductID
join Orders o on o.OrderID = od.OrderID
where strftime ('%Y', o.OrderDate ) = "2023"
group by c.CategoryName

-- Q4: What's our average order value, and does it differ by country?
