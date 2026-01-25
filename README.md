# Football Store Management Application

This is a simple web application for managing a football store database, built with Flask and MySQL.

## Setup Instructions

### 1. Database Setup (using XAMPP)

1.  **Start XAMPP:** Ensure that Apache and MySQL services are running in your XAMPP control panel.
2.  **Access phpMyAdmin:** Open your web browser and go to `http://localhost/phpmyadmin/`.
3.  **Create Database:** In phpMyAdmin, click on "New" in the left sidebar to create a new database. Name it `test`.
4.  **Import SQL File:**
    *   Select the newly created `test` database from the left sidebar.
    *   Click on the "Import" tab at the top.
    *   Click "Choose File" and select the `Football_Store.sql` file located in the project's root directory.
    *   Scroll down and click "Go" to import the database schema and data.

### 2. Backend Setup

1.  **Navigate to Project Directory:** Open your terminal or command prompt and navigate to the project's root directory:
   
3.  **Install Python Dependencies:** Install the required Python packages using pip:
    ```bash
    pip install -r requirements.txt
    ```

### 3. Run the Application

1.  **Start Flask Application:** In the same terminal, run the Flask application:
    ```bash
    python app.py
    ```
    You should see output indicating that the Flask development server is running, usually on `http://127.0.0.1:5000`.
2.  **Access the Application:** Open your web browser and go to the following URL:
    ```
    http://127.0.0.1:5000
    ```

You can now interact with the Football Store Management Application through your web browser.

---
**Note:** The database connection in `app.py` is configured for a local MySQL instance with `user='root'` and `password=''`. If your MySQL setup has different credentials, you will need to update the `db_config` dictionary in `app.py` accordingly.
