import random
import mysql.connector
from faker import Faker
from datetime import datetime

# Initialize Faker
fake = Faker()

# Dictionary mapping Indian states to their major cities
indian_states_cities = {
    'Andhra Pradesh': ['Visakhapatnam', 'Vijayawada'],
    'Bihar': ['Patna', 'Gaya'],
    'Goa': ['Panaji', 'Vasco da Gama'],
    'Gujarat': ['Ahmedabad', 'Surat'],
    'Karnataka': ['Bangalore', 'Mysore'],
    'Kerala': ['Kochi', 'Thiruvananthapuram'],
    'Maharashtra': ['Mumbai', 'Pune'],
    'Rajasthan': ['Jaipur', 'Udaipur'],
    'Tamil Nadu': ['Chennai', 'Coimbatore'],
    'Uttar Pradesh': ['Lucknow', 'Kanpur'],
    'West Bengal': ['Kolkata', 'Darjeeling']
}

# MySQL Database Connection
db = mysql.connector.connect(
    host="localhost",            # Change this if MySQL is on another server
    user="root",                 # Your MySQL username
    password="Muns@1204",        # Your MySQL password
    database="ecom"              # Your database name
)

cursor = db.cursor()

# Function to generate random data and insert into MySQL
def insert_random_record():
    order_id = f"407-{random.randint(1000000, 9999999)}-{random.randint(1000000, 9999999)}"
    
    # Set the current date as order_date
    order_date = datetime.now().strftime('%Y-%m-%d')  # Get the current date
    
    order_status = random.choice(['Shipped', 'Pending', 'Delivered', 'Cancelled'])
    fulfilment = random.choice(['Amazon', 'Merchant'])
    sales_channel = random.choice(['Amazon.in', 'Amazon.com'])
    ship_service_level = random.choice(['Standard', 'Expedited', 'Two-Day'])

    # Generate random Style and ASIN
    style = fake.bothify(text="JNE####")
    asin = fake.bothify(text="B0########")

    # Select a random Indian state and corresponding city
    ship_state = random.choice(list(indian_states_cities.keys()))
    ship_city = random.choice(indian_states_cities[ship_state])

    # Generate SKU based on state abbreviation
    state_abbreviation = ''.join(word[0] for word in ship_state.split()).upper()
    sku = f"{style}-{state_abbreviation}-XXXL"

    # Random category and size logic
    category = random.choice(['Clothing', 'Electronics', 'Home', 'Books', 'Toys'])
    size = random.choice(['S', 'M', 'L', 'XL', 'XXL']) if category == 'Clothing' else None

    courier_status = random.choice(['Shipped', 'In Transit', 'Delivered'])
    qty = random.randint(1, 10)
    currency = "INR"
    
    # If order status is 'Cancelled', set amount and qty to 0
    if order_status == 'Cancelled':
        amount = 0
        qty = 0
    else:
        amount = round(random.uniform(100, 5000), 2)
        amount = amount * qty  # Multiply amount by qty if order is not 'Cancelled'

    ship_country = "India"

    promotion_ids = None
    b2b = random.choice([True, False])
    fulfilled_by = random.choice(['Easy Ship', 'Amazon', 'Merchant'])
    unnamed_22 = None
    stock = random.randint(1, 100)
    customer_name = fake.name()
    email = fake.email()

    # MySQL Insert Query
    query = """
    INSERT INTO amazon_sale (
        order_id, Order_date, Order_status, Fulfilment, Sales_Channel,
        ship_service_level, Style, SKU, Category, Size, ASIN, Courier_Status,
        Qty, currency, Amount, ship_city, ship_state, ship_country,
        promotion_ids, B2B, fulfilled_by, Unnamed_22, Stock, customer_name, email
    ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);
    """

    values = (
        order_id, order_date, order_status, fulfilment, sales_channel, ship_service_level,
        style, sku, category, size, asin, courier_status, qty, currency, amount,
        ship_city, ship_state, ship_country, promotion_ids, b2b, fulfilled_by, unnamed_22,
        stock, customer_name, email
    )

    cursor.execute(query, values)
    db.commit()  # Save changes

    print(f"Inserted record: {order_id}")

# Insert 13 random records
for _ in range(13):
    insert_random_record()

# Close database connection
cursor.close()
db.close()
