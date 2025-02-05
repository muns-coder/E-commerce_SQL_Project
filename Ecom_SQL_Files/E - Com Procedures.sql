-- insert Procedure : 

DELIMITER $$

CREATE PROCEDURE InsertRandomAmazonSale()
BEGIN
    INSERT INTO amazon_sale (
        order_id, Order_date, Order_status, Fulfilment, Sales_Channel,
        ship_service_level, Style, SKU, Category, Size, ASIN, Courier_Status,
        Qty, currency, Amount, ship_city, ship_state, ship_country,
        promotion_ids, B2B, fulfilled_by, Unnamed_22, Stock, customer_name, email
    ) 
    SELECT 
        CONCAT('407-', FLOOR(RAND() * 9000000) + 1000000, '-', FLOOR(RAND() * 9000000) + 1000000),
        CURDATE(), 
        ELT(FLOOR(1 + (RAND() * 4)), 'Shipped', 'Pending', 'Delivered', 'Cancelled'),
        ELT(FLOOR(1 + (RAND() * 2)), 'Amazon', 'Merchant'),
        ELT(FLOOR(1 + (RAND() * 2)), 'Amazon.in', 'Amazon.com'),
        ELT(FLOOR(1 + (RAND() * 3)), 'Standard', 'Expedited', 'Two-Day'),
        CONCAT('JNE', FLOOR(RAND() * 9999) + 1000),
        CONCAT('JNE', FLOOR(RAND() * 9999) + 1000, '-KR-XXXL'),
        ELT(FLOOR(1 + (RAND() * 5)), 'Electronics', 'Clothing', 'Home', 'Books', 'Toys'),
        IF(ELT(FLOOR(1 + (RAND() * 5)), 'Electronics', 'Clothing', 'Home', 'Books', 'Toys') = 'Clothing', 
            ELT(FLOOR(1 + (RAND() * 5)), 'S', 'M', 'L', 'XL', 'XXL'), NULL),
        CONCAT('B0', FLOOR(RAND() * 99999999) + 10000000),
        ELT(FLOOR(1 + (RAND() * 3)), 'Shipped', 'In Transit', 'Delivered'),
        FLOOR(RAND() * 10) + 1,
        'INR',
        ROUND(RAND() * 4900 + 100, 2),
        ELT(FLOOR(1 + (RAND() * 10)), 'Chennai', 'Mumbai', 'Delhi', 'Bangalore', 'Hyderabad', 'Kolkata', 'Pune', 'Ahmedabad', 'Jaipur', 'Lucknow'),
        ELT(FLOOR(1 + (RAND() * 10)), 'Tamil Nadu', 'Maharashtra', 'Delhi', 'Karnataka', 'Telangana', 'West Bengal', 'Gujarat', 'Rajasthan', 'Uttar Pradesh', 'Madhya Pradesh'),
        'India',
        NULL,
        ELT(FLOOR(1 + (RAND() * 2)), TRUE, FALSE),
        ELT(FLOOR(1 + (RAND() * 3)), 'Easy Ship', 'Amazon', 'Merchant'),
        NULL,
        FLOOR(RAND() * 100) + 1,
        CONCAT('Customer ', FLOOR(RAND() * 1000) + 1),
        CONCAT('customer', FLOOR(RAND() * 1000) + 1, '@gmail.com');

    -- After inserting the data, check if the Order_status is 'Cancelled'
    -- If yes, update Amount and Qty to 0
    
    IF EXISTS (SELECT 1 FROM amazon_sale WHERE Order_status = 'Cancelled' AND Order_date = CURDATE()) THEN
        UPDATE amazon_sale
        SET Amount = 0, Qty = 0
        WHERE Order_status = 'Cancelled' AND Order_date = CURDATE();
    END IF;

END$$

DELIMITER ;



drop procedure InsertRandomAmazonSale;

#-----------------------------------------------------------------------------------------------------------------#

-- Dailly Selling Prodcts : 

Delimiter $$

CREATE PROCEDURE dailly_selling (IN prodcut_order_date date)
BEGIN

Select * from amazon_sale 
Where order_date = prodcut_order_date;

END $$

Delimiter ;
