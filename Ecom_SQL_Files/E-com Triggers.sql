DELIMITER $$

CREATE TRIGGER after_insert_main_table
AFTER INSERT ON amazon_sale
FOR EACH ROW
BEGIN

    -- Insert into first_table (Product details)
    
    INSERT INTO products (product_id, Style, SKU, Size, category_id, Stock)
    VALUES (NEW.product_id, NEW.Style, NEW.SKU, NEW.Size, 
            (SELECT category_id FROM categories WHERE category_name = NEW.Category LIMIT 1), NEW.Stock);

    -- Insert into table-2 (category details)
    -- This assumes you want to insert a new category if it doesn't already exist
    
    INSERT IGNORE INTO categories (category_name)
    VALUES (NEW.Category);

    -- Insert into table-3 (customer details)
    
    INSERT INTO customer (`customer name`, email, customer_id, product_id)
    VALUES (NEW.customer_name, NEW.email, NEW.product_id, NEW.product_id);

    -- Insert into table-4 (transaction details)
    
    INSERT INTO customer_transactions (PCS, currency, amount, product_id, customer_id)
    VALUES (NEW.Qty, NEW.currency, NEW.Amount, NEW.product_id, NEW.product_id);

    -- Insert into table-5 (order details)
    
    INSERT INTO orders (Order_ID, Order_Date, Order_Status, Amount, Product_Id, customer_id, Qty)
    VALUES (NEW.Order_id, NEW.Order_date, NEW.Order_status, NEW.Amount, NEW.product_id, NEW.product_id, NEW.Qty);

    -- Insert into table-6 (shipping details
    
    INSERT INTO shiped_status (ship_city, ship_state, ship_country, product_id)
    VALUES (NEW.ship_city, NEW.ship_state, NEW.ship_country, NEW.product_id);

    -- Insert into table-7 (status details)
    
    INSERT INTO other_status (promotion_ids, B2B, fulfilled_by, Unnamed_22, Product_id)
    VALUES (NEW.promotion_ids, NEW.B2B, NEW.fulfilled_by, NEW.Unnamed_22, NEW.product_id);

    -- Insert into table-8 (sales channel details)
    
    INSERT INTO sales_channel (Order_ID, ASIN_NO, Sales_channel, Fulfilment, Sales_channel_id)
    VALUES (NEW.Order_id, NEW.ASIN, NEW.Sales_Channel, NEW.Fulfilment, NEW.product_id);

END$$

DELIMITER ;


#-----------------------------------------------------------------------------------------------------------------#

-- Create a trigger for Before Update for Amount and Qty : 

Delimiter $$

Create TRIGGER update_amount
After Update ON Amazon_sale
FOR EACH ROW

BEGIN

update amazon_sale
set new.amount = new.qty * new.amount;

END $$

delimiter ;

#------------------------------------------------------------------------------------------------#



