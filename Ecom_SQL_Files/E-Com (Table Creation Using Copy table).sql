-- Create table using (Copy Table)

-- Products :

CREATE TABLE Products AS Select `index` as Product_id ,Style,SKU,Size,`index` as category_id from amazon_sale;

-- Add New Column : 

delete from products
where product_id=0;

ALTER TABLE products modify Product_id INT auto_increment,add primary key (Product_id);
ALTER TABLE products ADD COLUMN Stock INT;

UPDATE products
SET  Stock = FLOOR(1 + (RAND() * 8));


-- Add Foreign Key:

ALTER TABLE Products 
ADD CONSTRAINT fk_cate 
FOREIGN KEY (category_id) 
REFERENCES categories(category_id);

desc products;

Select * from Products;
#----------------------------------------------------------------------------------------------#

-- Customer Table : 

Create table customer as SELECT * from customer1;

DELETE FROM customer
WHERE customer_id NOT IN (
    SELECT customer_id 
    FROM (
        SELECT customer_id 
        FROM customer 
        ORDER BY customer_id asc  -- Change to ASC to keep the oldest
        LIMIT 128975
    ) AS subquery
);

ALTER TABLE customer add column Email Varchar(200);

ALTER TABLE customer MODIFY customer_id INT auto_increment,add primary key(customer_id);

UPDATE customer

SET Email = CONCAT(LOWER(REPLACE(customer name, ' ', '')), 
                   FLOOR(1 + RAND() * 1000), 
                   '@gmail.com');


ALTER TABLE customer add column product_id INT;
ALTER TABLE customer ADD CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES products(product_id);

SET @rank = 0;
UPDATE customer 
SET product_id = (@rank := @rank + 1)
ORDER BY customer_id; 

select * from customer ;

desc customer;

select * from amazon_sale;
#----------------------------------------------------------------------------------------------#

-- Order :

CREATE TABLE ORDERS AS SELECT `index` as Serial_No,`Order ID` as  Order_ID , `Date` as Order_Date,`Status` as Order_Status,Qty,Amount,`index` as Product_Id,`index` as Customer_Id from Amazon_sale;

ALTER TABLE orders modify serial_no INT auto_increment,add primary key (serial_no);


ALTER TABLE orders 
ADD CONSTRAINT fk_prod 
FOREIGN KEY (Product_Id) 
REFERENCES products(product_id),
ADD CONSTRAINT fk_customer 
FOREIGN KEY (customer_id) 
REFERENCES customer(customer_id);

ALTER TABLE orders drop Qty;

ALTER TABLE orders add column Qty INT;

UPDATE Orders
SET  Qty = FLOOR(1 + (RAND() * 8));

UPDATE orders
SET Total = Qty * Amount
LIMIT 128974;

select count(*) from orders;

select * from orders;

#--------------------------------------------------------------------------------------------------------#

-- 	Sales_Chennel : 

CREATE TABLE Sales_channel as select `Order ID` as Order_ID ,`ASIN` as ASIN_NO,`Sales channel` as Sales_channel,Fulfilment from amazon_sale;

Alter table Sales_channel add column Sales_channel_id int auto_increment,add primary key(Sales_channel_id);

ALTER TABLE Sales_channel MODIFY Order_ID varchar(225);
ALTER TABLE Orders MODIFY Order_ID varchar(225);

Create index fk_saleschennel ON Orders(Order_ID);

ALTER TABLE Sales_channel
ADD foreign key (Order_ID)
references orders(Order_ID);

DESC Sales_channel;

SELECT * FROM Sales_channel;
#------------------------------------------------------------------------------------------------------------------#

-- Customer_Transaction : 

select * from amazon_sale;

Create table customer_transactions as SELECT `index` as Transaction_id,Qty as PCS , currency, amount , `index` as Product_id,`index` as Customer_id from Amazon_sale;

ALTER TABLE customer_transactions 
ADD CONSTRAINT fk_ct 
FOREIGN KEY (Product_Id) 
REFERENCES products(product_id),
ADD CONSTRAINT fk_ts 
FOREIGN KEY (customer_id) 
REFERENCES customer(customer_id);

alter table customer_transactions MODIFY Transaction_id INT auto_increment,add primary key(Transaction_id);

select * from customer_transactions;

desc customer_transactions;

#--------------------------------------------------------------------------------------------------------#

-- Shiped Status : 

select * from amazon_sale;	

Create Table Shiped_status AS Select `index` as shiped_id,`ship-city` as ship_city,`ship-state` as ship_state,`ship-country` as ship_country,`index` as product_id from amazon_sale;

ALTER TABLE Shiped_status modify shiped_id INT auto_increment,add primary key (shiped_id);

Alter table Shiped_status
add foreign key (product_id)
references products(product_id);

desc Shiped_status;

#----------------------------------------------------------------------------------------------#

-- Other_status :

select * from amazon_sale;

Create table other_status as select `index` as status_id , `promotion-ids`  as promotion_ids,B2B,`fulfilled-by` as fulfilled_by,`Unnamed: 22` as Unnamed_22, `index` as Product_id from amazon_sale;

ALTER TABLE other_status MODIFY status_id INT auto_increment,add primary key(status_id);

desc other_status;

ALTER TABLE other_status
ADD foreign key (Product_id)
references products(Product_id);

#----------------------------------------------------------------------------------------------#


select * from products;
select * from categories;
select * from customer;
select * from customer_Transactions;
select * from orders;
select * from shiped_status;
select * from other_status;

