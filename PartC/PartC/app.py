from flask import Flask, render_template, request, redirect, url_for
import pymysql
from decimal import Decimal

app = Flask(__name__)

# Database configuration
# Defines the connection parameters for the MySQL database.
db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'test'
}

# Function to get a database connection.
# This function creates and returns a new database connection based on the db_config.
# Using DictCursor to get results as dictionaries.
def get_db_connection():
    conn = pymysql.connect(host=db_config['host'],
                           user=db_config['user'],
                           password=db_config['password'],
                           database=db_config['database'],
                           cursorclass=pymysql.cursors.DictCursor)
    return conn

# Route for the home page.
@app.route('/')
def index():
    return render_template('index.html')

# Route for the queries page.
@app.route('/queries', methods=['GET'])
def queries():
    return render_template('queries.html')

# --- Enhanced Data Entry ---
# Route to display the data entry form.
# Fetches customers and salespersons to populate dropdowns in the form.
@app.route('/data_entry', methods=['GET'])
def data_entry():
    conn = get_db_connection()
    cursor = conn.cursor()
    # Fetch customers who are part of a team for specific functionalities.
    cursor.execute("SELECT c.Customer_ID, c.Customer_Name FROM customer c JOIN team_customer tc ON c.Customer_ID = tc.Customer_ID")
    customers = cursor.fetchall()
    # Fetch all salespersons for the order creation form.
    cursor.execute("SELECT ID, Name FROM sales_person")
    sales_persons = cursor.fetchall()
    conn.close()
    return render_template('data_entry.html', customers=customers, sales_persons=sales_persons)

# --- Query Routes ---
# Route for query 1: Fetch customer details by ID or name.
@app.route('/query1', methods=['POST'])
def query1():
    customer_identifier = request.form['customer_id']
    conn = get_db_connection()
    cursor = conn.cursor()
    query = "SELECT Customer_ID, Customer_Name, email, Customer_Phone FROM customer WHERE Customer_Name = %s OR Customer_ID = %s"
    cursor.execute(query, (customer_identifier, customer_identifier))
    result = cursor.fetchall()
    conn.close()
    return render_template('queries.html', query_result=result)

# Route for query 2: Get the number of players in a team.
@app.route('/query2', methods=['POST'])
def query2():
    team_identifier = request.form['team_id']
    conn = get_db_connection()
    cursor = conn.cursor()
    query = """
    SELECT tc.Team_Name, COUNT(p.player_id) AS Player_Count
    FROM team_customer tc
    JOIN player p ON tc.Customer_ID = p.team_customer_id
    WHERE tc.Team_Name = %s OR tc.Customer_ID = %s
    GROUP BY tc.Team_Name
    """
    cursor.execute(query, (team_identifier, team_identifier))
    result = cursor.fetchall()
    conn.close()
    return render_template('queries.html', query_result=result)

# Route for query 3: Find product details by ID or name.
@app.route('/query3', methods=['POST'])
def query3():
    product_identifier = request.form['product_id']
    conn = get_db_connection()
    cursor = conn.cursor()
    query = "SELECT name, description, category FROM item WHERE name = %s OR item_id = %s"
    cursor.execute(query, (product_identifier, product_identifier))
    result = cursor.fetchall()
    conn.close()
    return render_template('queries.html', query_result=result)

# Route for query 4: List items within a specific price range.
@app.route('/query4', methods=['GET'])
def query4():
    conn = get_db_connection()
    cursor = conn.cursor()
    query = "SELECT item_id, price, availability FROM item WHERE price BETWEEN 3.00 AND 15.00"
    cursor.execute(query)
    result = cursor.fetchall()
    conn.close()
    return render_template('queries.html', query_result=result)

# Route for query 5: Find customers in specific locations.
@app.route('/query5', methods=['GET'])
def query5():
    conn = get_db_connection()
    cursor = conn.cursor()
    query = "SELECT Customer_ID, Customer_address FROM customer WHERE Customer_address LIKE '%%Starford%%' OR Customer_address LIKE '%%Liverpool%%'"
    cursor.execute(query)
    result = cursor.fetchall()
    conn.close()
    return render_template('queries.html', query_result=result)

# Route for query 6: Calculate the average sale value per salesperson, including discounts.
@app.route('/query6', methods=['GET'])
def query6():
    conn = get_db_connection()
    cursor = conn.cursor()
    query = """
        SELECT sp.Name AS Salesperson_Name,
            AVG(oi.quantity * i.price) AS Average_Sales
        FROM sales_person sp
        JOIN orders o ON sp.ID = o.sales_person_id
        JOIN order_item oi ON o.Order_ID = oi.Order_ID
        JOIN item i ON oi.item_id = i.item_id
        GROUP BY sp.Name;
    """
    cursor.execute(query)
    result = cursor.fetchall()
    conn.close()
    return render_template('queries.html', query_result=result)

# Route for query 7: Find the largest order by total value after discounts.
@app.route('/query7', methods=['GET'])
def query7():
    conn = get_db_connection()
    cursor = conn.cursor()
    # This query identifies the single largest order based on its total discounted value.
    # It uses a Common Table Expression (CTE) to first calculate the total value of each order.
    query = """
        SELECT
            sp.Name AS Salesperson_Name,
            sp.Email AS Salesperson_Email,
            sp.Phone AS Salesperson_Phone,
            c.Customer_Name,
            c.email AS Customer_Email,
            c.Customer_Phone,
            SUM(oi.quantity * i.price) AS Order_Total
        FROM orders o
        JOIN sales_person sp ON o.sales_person_id = sp.ID
        JOIN customer c ON o.Customer_ID = c.Customer_ID
        JOIN order_item oi ON o.Order_ID = oi.Order_ID
        JOIN item i ON oi.item_id = i.item_id
        GROUP BY o.Order_ID, sp.Name, sp.Email, sp.Phone, c.Customer_Name, c.email, c.Customer_Phone
        ORDER BY Order_Total DESC
        LIMIT 1;
    """
    cursor.execute(query)
    result = cursor.fetchall()
    conn.close()
    return render_template('queries.html', query_result=result)

# --- Data Insertion Routes ---
# Route to add a new customer to the database.
@app.route('/add_customer', methods=['POST'])
def add_customer():
    conn = get_db_connection()
    cursor = conn.cursor()
    query = "INSERT INTO customer (Customer_ID, Customer_Name, email, Customer_address, Customer_Phone) VALUES (%s, %s, %s, %s, %s)"
    cursor.execute(query, (request.form['Customer_ID'], request.form['Customer_Name'], request.form['email'], request.form['Customer_address'], request.form['Customer_Phone']))
    conn.commit()
    conn.close()
    return redirect(url_for('data_entry'))

# Route to add a new item to the database.
@app.route('/add_item', methods=['POST'])
def add_item():
    conn = get_db_connection()
    cursor = conn.cursor()
    query = "INSERT INTO item (name, description, price, availability, category, color, size) VALUES (%s, %s, %s, %s, %s, %s, %s)"
    cursor.execute(query, (request.form['name'], request.form['description'], request.form['price'], request.form['availability'], request.form['category'], request.form['color'], request.form['size']))
    conn.commit()
    conn.close()
    return redirect(url_for('data_entry'))

# Route to create a new order.
# This initializes an order and redirects to a page for adding items to it.
@app.route('/create_order', methods=['POST'])
def create_order():
    conn = get_db_connection()
    cursor = conn.cursor()
    query = "INSERT INTO orders (order_code, Customer_ID, sales_person_id, items_qty) VALUES (%s, %s, %s, 0)"
    cursor.execute(query, (request.form['order_code'], request.form['Customer_ID'], request.form['sales_person_id']))
    conn.commit()
    new_order_id = cursor.lastrowid
    conn.close()
    return redirect(url_for('add_items_to_order', order_id=new_order_id))

# Route to view an order and add items to it.
@app.route('/order/<int:order_id>', methods=['GET'])
def add_items_to_order(order_id):
    conn = get_db_connection()
    cursor = conn.cursor()
    
    # Get order details to display on the page.
    cursor.execute("SELECT o.*, c.Customer_Name FROM orders o JOIN customer c ON o.Customer_ID = c.Customer_ID WHERE o.Order_ID = %s", (order_id,))
    order = cursor.fetchone()
    
    # Get all available items to populate the add item dropdown.
    cursor.execute("SELECT item_id, name, price FROM item")
    items = cursor.fetchall()
    
    # Get items already added to the order, including calculating discounts.
    cursor.execute("""
        SELECT 
            i.name, 
            i.price, 
            oi.quantity,
            COALESCE(tc.Discount, 0) as discount_percent
        FROM order_item oi
        JOIN item i ON oi.item_id = i.item_id
        JOIN orders o ON oi.Order_ID = o.Order_ID
        JOIN customer c ON o.Customer_ID = c.Customer_ID
        LEFT JOIN team_customer tc ON c.Customer_ID = tc.Customer_ID
        WHERE oi.Order_ID = %s
    """, (order_id,))
    order_items_raw = cursor.fetchall()

    # Calculate total price with discounts.
    total_price = Decimal(0)
    order_items = []
    for item in order_items_raw:
        price = Decimal(item['price'])
        discount = Decimal(item['discount_percent'])
        quantity = int(item['quantity'])
        
        discounted_price = price * (1 - discount)
        subtotal = discounted_price * quantity
        item['discounted_price'] = discounted_price
        item['subtotal'] = subtotal
        order_items.append(item)
        total_price += subtotal

    conn.close()
    return render_template('add_items.html', order=order, items=items, order_items=order_items, total_price=total_price)

# Route to handle the action of adding an item to an order.
@app.route('/order/<int:order_id>/add_item', methods=['POST'])
def add_item_to_order_action(order_id):
    conn = get_db_connection()
    cursor = conn.cursor()

    item_id = request.form['item_id']
    quantity = int(request.form['quantity'])

    # Insert the new item into the order_item table.
    query = "INSERT INTO order_item (Order_ID, item_id, quantity) VALUES (%s, %s, %s)"
    cursor.execute(query, (order_id, item_id, quantity))

    # Update the total item quantity in the orders table.
    update_query = "UPDATE orders SET items_qty = items_qty + %s WHERE Order_ID = %s"
    cursor.execute(update_query, (quantity, order_id))
    
    conn.commit()
    conn.close()
    
    return redirect(url_for('add_items_to_order', order_id=order_id))

# Main entry point for the application.
if __name__ == '__main__':
    app.run(debug=True)
