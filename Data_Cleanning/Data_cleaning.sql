use ecom;

-- 1: Find the Data Duplication : 

select * from 
(Select * , 
ROW_NUMBER() OVER(partition by product_id,order_id,Order_date,Order_status,Fulfilment,Sales_Channel,ship_service_level,Style,SKU,Category,Size,ASIN,Courier_Status,ship_city,ship_state,ship_country,customer_name,email)as rk
from amazon_sale )x
where rk > 1
order by product_id;

-- 2 : Non Duplicate values :

select * from 
(Select * , 
ROW_NUMBER() OVER(partition by product_id,order_id,Order_date,Order_status,Fulfilment,Sales_Channel,ship_service_level,Style,SKU,Category,Size,ASIN,Courier_Status,ship_city,ship_state,ship_country,customer_name,email)as rk 
from amazon_sale )x
where rk =1
order by product_id;

-- 3 : Delete Duplicate values : 

With dupticate as
(
Select * , 
ROW_NUMBER() OVER(partition by product_id,order_id,Order_date,Order_status,Fulfilment,Sales_Channel,ship_service_level,Style,SKU,Category,Size,ASIN,Courier_Status,ship_city,ship_state,ship_country,customer_name,email)as rk 
from amazon_sale 
)
delete from dupticate 
where rk > 1;

# i could not delete this row because mysql could not delete . so if you delete this duplicate then create a new table
# then insert in values

create table remove_duplicate as 
select * from 
(Select * , 
ROW_NUMBER() OVER(partition by product_id,order_id,Order_date,Order_status,Fulfilment,Sales_Channel,ship_service_level,Style,SKU,Category,Size,ASIN,Courier_Status,ship_city,ship_state,ship_country,customer_name,email)as rk 
from amazon_sale )x
where rk  > 1
order by product_id;

-- Then remove greater than 1 row then its delete a those records

delete from remove_duplicate
where rk > 1;

-- 4 : Standazied Data : 

-- Updated Shiped_counry IN --> India : 

SELECT distinct ship_country FROM AMAZON_SALE;

Update amazon_sale
set ship_country = 'India'
where ship_country = 'IN';

-- Updated Shiped_counry CN --> China : 

Update amazon_sale
set ship_country = 'China'
where ship_country = 'CN';

-- courier_status have some blank columns and also amount and qty also 0 then if courier_status have blank  values then put at 'Unshiped'

Update amazon_sale
set courier_status = 'Unshiped'
where courier_status='';

-- other updated column just use CASE statement in Mysql :(if ship_country is Inida then Put currenct at IND)

UPDATE amazon_sale 
SET currency = 
    CASE 
        WHEN ship_country = 'China' THEN 'CN'
        WHEN ship_country = 'India' THEN 'IN'
    END;

-- update home size put null  at product_id = '129017'

UPDATE amazon_sale 
SET Size = 'NULL' 
WHERE product_id = '129017';

-- cloths update at clothing : 

Update amazon_sale
set cloths = 'clothing'
where courier_status='cloths';


