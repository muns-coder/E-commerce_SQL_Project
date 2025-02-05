-- Sales & Revenue Analysis :
 
-- Q1 : What are the total sales and revenue generated over time?

Select sum(amount) from Orders;

-- Q2 : Which products contribute the most revenue :

SELECT c.category_name,max(o.amount) as maxmum_sale
FROM categories as c
JOIN Orders as o
ON c.category_id= o.serial_no
Group By category_name
order by maxmum_sale DESC 
limit 1; 

-- Q3 : What is the average order value per customer :

SELECT c.`customer name` , avg(o.amount) as average_order_values 
FROM customer as c
JOIN Orders as o
ON c.customer_id= o.product_id
group by `customer name`;

-- Q4 : What is the impact of promotions on total revenue?

select promotion_ids , sum(o.amount)
from other_status as s
JOIN orders as o
on s.status_id= o.serial_no
group by  promotion_ids
having promotion_ids is NOT NULL;

-- Order & Fulfillment Efficiency

-- Which fulfillment method (e.g., fulfilled by Amazon or third-party) is the most efficient?

SELECT s.fulfilled_by,count(o.order_id)as counted_orders
FROM other_status as s
JOIN Orders as o
ON s.status_id=o.serial_no
group by fulfilled_by
order by counted_orders desc;

-- so amazon have a more orders or amazon if effecient !

-- Q4 : What is the most common shipping service level chosen by customers?

SELECT s.fulfilled_by,count(o.order_id)as counted_orders
FROM other_status as s
JOIN Orders as o
ON s.status_id=o.serial_no
group by fulfilled_by
order by counted_orders desc;

-- Customer Insights : 

-- Q5 : What are the top cities, states, and countries contributing to sales? 

SELECT s.ship_city ,max(o.amount)as city,s.ship_state,max(o.amount)as state,s.ship_country , max(o.amount)as country 
FROM shiped_status as s
JOIN orders as o
on s.product_id= o.product_id
GROUP BY s.ship_city,s.ship_state,s.ship_country
ORDER BY city desc;

-- How often do customers place repeat orders?

SELECT 
c.`customer name`, 
COUNT(o.order_id) AS total_orders, 
ROUND(COUNT(o.order_id) / COUNT(DISTINCT order_date)) AS avg_orders_per_day
FROM customer as c
JOIN orders as o
ON c.customer_id=o.serial_no
GROUP BY `customer name`
HAVING COUNT(o.order_id) > 1
ORDER BY total_orders DESC;

-- Which customers generate the highest revenue?

SELECT c.`customer name` , sum(t.amount)as Top_most_order_customer 
FROM customer as c
JOIN customer_transactions as t 
ON c.customer_id= t.customer_id
group by  `customer name`
order by Top_most_order_customer desc
LIMIT 1; 

-- Inventory & Stock Management : 

-- How often does stock run out for top-selling products?

SELECT 
c.category_name, 
SUM(o.amount) AS total_sales, 
SUM(p.stock) AS total_stock, 
SUM(CASE WHEN p.stock = 0 THEN 1 ELSE 0 END) AS stock_out_count
FROM categories AS c
LEFT JOIN products AS p ON c.category_id = p.product_id
LEFT JOIN orders AS o ON p.product_id = o.product_id
GROUP BY c.category_name
ORDER BY total_sales DESC;

-- What is the relationship between stock levels and order volume?

SELECT 
p.product_id,
c.Category_name,
SUM(o.Qty) AS total_orders, 
SUM(p.Stock) AS total_stock,
(SUM(p.Stock) - SUM(o.Qty)) AS stock_remaining,
    CASE 
        WHEN SUM(o.Qty) > SUM(p.Stock) THEN 'Stock Shortage'
        WHEN SUM(o.Qty) = SUM(p.Stock) THEN 'Balanced'
        ELSE 'Stock Available'
    END AS stock_status
FROM products AS p
LEFT JOIN orders AS o 
ON p.product_id = o.product_id
JOIN categories as c
ON c.category_id=p.product_id
GROUP BY p.product_id, c.Category_name
ORDER BY product_id DESC;

-- 	

SELECT 
    p.product_id, 
    c.Category_name, 
    p.Stock AS current_stock, 
    COALESCE(SUM(o.Qty), 0) AS total_sold, 
    CASE 
        WHEN COALESCE(SUM(o.Qty), 0) = 0 THEN 'No Sales'
        WHEN p.Stock > SUM(o.Qty) THEN 'Low Sales, High Stock'
        ELSE 'Healthy Sales'
    END AS stock_status
FROM products AS p
LEFT JOIN categories AS c 
    ON p.product_id = c.category_id
join orders as o
on  c.category_id = o.serial_no
GROUP BY p.product_id, c.Category_name, p.Stock
HAVING p.Stock > 0  
ORDER BY total_sold desc, p.Stock DESC;

-- E-commerce Channel Performance : 

-- How do sales differ across different sales channels?

SELECT distinct s.sales_channel,
COUNT(distinct o.order_id)as order_id,o.qty,
ROUND(avg(o.amount),2) as rounded 
FROM sales_channel as s
JOIN orders as o
ON s.Sales_channel_id = o.product_id
GROUP BY sales_channel , qty;

-- Which sales channel has the highest conversion rate?

SELECT s.sales_channel , Sum(o.amount) as  highest_conversion_rate
FROM sales_channel as s
JOIN orders as o
ON s.Sales_channel_id = o.product_id
GROUP BY sales_channel;


-- Other Tasks : 

select * from products;
select * from categories;
select * from customer;
select * from customer_Transactions;
select * from orders;
select * from shiped_status;
select * from other_status;

-- Q1 : group the category_name :

SELECT category_name,Count(category_name)as Counted_category_name from categories
GROUP BY category_name;

-- Q2 : count_Customers 

SELECT Count(Distinct `Customer name`) as Counted_Customer from Customer;      -- 24628

-- Q3 : average sales 

SELECT AVG(amount) as Average_Sale from orders;                    -- 609.363365329447

-- Q4 : Total_Sales  

SELECT SUM(Amount) as Total_sale from orders ;                     -- 78592030.6800001

-- Q4 : Maximum Sale 

SELECT Max(Amount) as "Maximum Sale" from orders;                             -- 5584

-- Q4 : Minumum Customer_transaction 

SELECT Min(Amount) as "Maximum Transaction" from orders;                       -- 0

-- Q4 : Total Orders  

SELECT COUNT(Order_id) as `Order` from orders;                              -- 128974

-- Q4 : Order on Different Cities Count it  

Select `ship-city`,count( amount) as "Total_sales" from amazon_sale group by `ship-city`  order by Total_sales desc;

-- Q4 : Find Maximum Sales by different state & City using Order & shiped_status 

SELECT s.ship_state,s.ship_city,SUM(o.amount) as Max_Sale from shiped_status as s
join Orders as o
on s.product_id=o.product_id
group by s.ship_city,s.ship_state
order by Max_Sale Desc limit 1;

-- 	ship_state	ship_city	Max_Sale
--	KARNATAKA	BENGALURU	7257748.800000003

-- Q4 : Find The Total sales for Different Categories (orders & Categories)

SELECT c.Category_name , SUM(o.amount) as "Amount"
FROM Categories as c
JOIN Orders as o
ON c.category_id=o.serial_no
Group by  c.Category_name;

-- Q5 : Find the product_detail and Total spend Amount for "Kayla Hutchinson" customer : 

Select c.`customer name`,p.style,p.sku,o.Qty,o.amount
FROM Customer as c
JOIN Products as p
ON c.product_id= p.product_id
JOIN Orders as o
ON o.serial_no= p.product_id
where `customer name`='Kayla Hutchinson';

-- Q6 : Find the Total Orders in China ;

Select s.ship_country , count(o.order_id) as counted_orders
FROM shiped_status as s
JOIN orders as o
ON s.product_id=o.product_id
group by s.ship_country
having ship_country='CN';

-- Q7 : Find the Cancel Transaction And also show the Cancel Order_id & Prodcuct :

SELECT p.product_id,o.order_id,c.category_name,o.Order_Status
FROM  products as p
JOIN Categories as c 
ON p.product_id=c.category_id
join Orders as o
ON p.product_id=o.product_id
where Order_Status='Cancelled';

-- Q8 : Find the Courier Status and Count the all Courier_Status

SELECT order_status , Count(order_status) as "Counted_Status"
FROM Orders
Group BY order_status; 

-- Q9 : Find the Damaged Order and Field order_id , Category and Status has been included 

SELECT o.order_id , c.`Category_name` , o.order_status 
FROM Orders as o
JOIN Categories as c
ON c.category_id=o.product_id
where order_status LIKE "%Damaged%";