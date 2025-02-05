-- Categories :

CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,                                      -- Primary Key
    category_name VARCHAR(255) NOT NULL          
);

-- Products :

CREATE TABLE Products (
	Product_id INT auto_increment primary key ,                                       -- Primary Key
    Style TEXT,
    SKU TEXT,
    category_id INT ,                                                                 -- Foreign Key for Category
    Stock INT,
    
    -- Foreign Key constraint
    
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)               
    
);

-- customer : 

CREATE TABLE customer (

    customer_id INT AUTO_INCREMENT PRIMARY KEY,                                      -- Primary Key: 
    `Customer name` TEXT,        
	Email Varchar(200),                                   
    Product_id INT,                      
    
    -- Foreign Key Constraints
    
    FOREIGN KEY (Product_id) REFERENCES Products(Product_id)                          -- FK to Product_id
    
);


-- Customer_Transaction :

CREATE TABLE Customer_Transactions (

    transaction_id INT AUTO_INCREMENT PRIMARY KEY,                                   -- Primary Key
    Pcs INT,                                     
    Currenct TEXT,                                        
    amount INT,                               
    Product_id INT,
    customer_id INT,
    
        -- Foreign Key Constraints

    FOREIGN KEY (Product_id) REFERENCES products(Product_id),            -- Foreign Key constraint (Product_id)
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)           -- Foreign Key constraint (customer_id)
                                             
);

-- Orders Table :

create table Orders 
(
  serial_no INT auto_increment primary key,
  Order_ID varchar(225),
  Order_Date TEXT,
  Order_Status TEXT,
  Amount Double,
  Product_Id INT,
  customer_id int,
  Qty INT,

  -- Foreign Key Constraints
  
FOREIGN KEY (Product_id) REFERENCES products(Product_id),            -- Foreign Key constraint (Product_id)
FOREIGN KEY (customer_id) REFERENCES customer(customer_id)           -- Foreign Key constraint (customer_id)
  
);

-- ProductSKU :

CREATE TABLE shiped_status (

    shiped_id INT auto_increment PRIMARY KEY,    
    ship_city TEXT,                     
    ship_state TEXT,   
    ship_country TEXT, -- 
    product_id INT,                    
    
	-- Foreign Key Constraints
     
    FOREIGN KEY (Product_id) REFERENCES products(Product_id)            -- Foreign Key constraint (Product_id)
    
);

-- other_status table 

Create Table other_status (

	status_id INT auto_increment primary key,
    promotion_ids TEXT,
    B2B TEXT,
    fulfilled_by TEXT,
    Unnamed_22 TEXT,
    Product_id INT,
    
	-- Foreign Key Constraints

	FOREIGN KEY (Product_id) REFERENCES products(Product_id)            -- Foreign Key constraint (Product_id)

);

#----------------------------------------------------------------------------------------------------#









