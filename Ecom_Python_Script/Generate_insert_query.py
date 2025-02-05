import random
from faker import Faker

# Initialize Faker
fake = Faker()

# Dictionary mapping Indian states to their major cities
indian_states_cities = {
    'Andhra Pradesh': ['Visakhapatnam', 'Vijayawada', 'Guntur'],
    'Arunachal Pradesh': ['Itanagar'],
    'Assam': ['Guwahati', 'Dibrugarh'],
    'Bihar': ['Patna', 'Gaya'],
    'Chhattisgarh': ['Raipur', 'Bilaspur'],
    'Goa': ['Panaji', 'Vasco da Gama'],
    'Gujarat': ['Ahmedabad', 'Surat', 'Vadodara'],
    'Haryana': ['Gurgaon', 'Faridabad'],
    'Himachal Pradesh': ['Shimla', 'Manali'],
    'Jharkhand': ['Ranchi', 'Jamshedpur'],
    'Karnataka': ['Bangalore', 'Mysore'],
    'Kerala': ['Kochi', 'Thiruvananthapuram'],
    'Madhya Pradesh': ['Bhopal', 'Indore'],
    'Maharashtra': ['Mumbai', 'Pune', 'Nagpur'],
    'Manipur': ['Imphal'],
    'Meghalaya': ['Shillong'],
    'Mizoram': ['Aizawl'],
    'Nagaland': ['Kohima'],
    'Odisha': ['Bhubaneswar', 'Cuttack'],
    'Punjab': ['Ludhiana', 'Amritsar'],
    'Rajasthan': ['Jaipur', 'Udaipur'],
    'Sikkim': ['Gangtok'],
    'Tamil Nadu': ['Chennai', 'Coimbatore', 'Madurai'],
    'Telangana': ['Hyderabad', 'Warangal'],
    'Tripura': ['Agartala'],
    'Uttar Pradesh': ['Lucknow', 'Kanpur', 'Varanasi'],
    'Uttarakhand': ['Dehradun', 'Haridwar'],
    'West Bengal': ['Kolkata', 'Darjeeling']
}

# Function to generate a random insert statement
def generate_insert_query():
    order_id = f"407-{random.randint(1000000, 9999999)}-{random.randint(1000000, 9999999)}"
    order_date = fake.date_this_decade()
    order_status = random.choice(['Shipped', 'Pending', 'Delivered', 'Cancelled'])
    fulfilment = random.choice(['Amazon', 'Merchant'])
    sales_channel = random.choice(['Amazon.in', 'Amazon.com'])
    ship_service_level = random.choice(['Standard', 'Expedited', 'Two-Day'])
    
    # Generate random Style
    style = fake.bothify(text="JNE####")
    
    # Select random state and city
    ship_state = random.choice(list(indian_states_cities.keys()))
    ship_city = random.choice(indian_states_cities[ship_state])

    # Generate SKU with state abbreviation
    state_abbreviation = ''.join(word[0] for word in ship_state.split()).upper()  # Get initials of the state
    sku = f"{style}-{state_abbreviation}-XXXL"
    
    # Generate random ASIN (Amazon Standard Identification Number)
    asin = fake.bothify(text="B0########")  # Generates ASIN like "B09K3WFS32"

    # Random category
    category = random.choice(['Clothing', 'Electronics', 'Home', 'Books', 'Toys'])
    
    # Size is only applicable for "Clothing" category
    size = random.choice(['S', 'M', 'L', 'XL', 'XXL']) if category == 'Clothing' else 'NULL'
    
    courier_status = random.choice(['Shipped', 'In Transit', 'Delivered'])
    qty = random.randint(1, 10)
    currency = "INR"  # Since the country is India, currency is INR
    amount = round(random.uniform(100, 5000), 2)
    ship_country = "India"  # Fixed value
    
    promotion_ids = 'NULL'
    b2b = random.choice([True, False])
    fulfilled_by = random.choice(['Easy Ship', 'Amazon', 'Merchant'])
    unnamed_22 = 'NULL'
    stock = random.randint(1, 100)
    customer_name = fake.name()
    email = fake.email()

    query = f"""
    INSERT INTO amazon_sale (
        order_id, Order_date, Order_status, Fulfilment, Sales_Channel,
        ship_service_level, Style, SKU, Category, Size, ASIN, Courier_Status,
        Qty, currency, Amount, ship_city, ship_state, ship_country,
        promotion_ids, B2B, fulfilled_by, Unnamed_22, Stock, customer_name, email
    ) VALUES (
        '{order_id}', '{order_date}', '{order_status}', '{fulfilment}', '{sales_channel}',
        '{ship_service_level}', '{style}', '{sku}', '{category}', '{size}', '{asin}',
        '{courier_status}', {qty}, '{currency}', {amount}, '{ship_city}', '{ship_state}', '{ship_country}',
        {promotion_ids}, {b2b}, '{fulfilled_by}', {unnamed_22}, {stock}, '{customer_name}', '{email}'
    );
    """
    
    return query

# Generate 10 random insert queries
for _ in range(10):
    print(generate_insert_query())
