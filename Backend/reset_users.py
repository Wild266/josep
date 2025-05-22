import psycopg2

# Replace these with your actual AWS RDS credentials
DB_HOST = "planitdb.c30c2ai28fyz.us-east-2.rds.amazonaws.com"
DB_NAME = "postgres"

DB_USER = "PlanItDB"
DB_PASSWORD = "dixie123"
DB_PORT = 5432  # default PostgreSQL port

# SQL commands
WIPE_USERS_SQL = "DELETE FROM users;"

INSERT_USERS_SQL = """
INSERT INTO users (id, username, password, email, rating, role)
VALUES 
    (0, 'akshan1', 'pass', 'akshan@email.com', 0, 'admin'),
    (1, 'joseph1', 'pass2', 'joseph@email.com', 0, 'admin');
"""

def main():
    try:
        # Connect to the PostgreSQL database
        conn = psycopg2.connect(
            host=DB_HOST,
            dbname=DB_NAME,
            user=DB_USER,
            password=DB_PASSWORD,
            port=DB_PORT
        )
        conn.autocommit = True
        cur = conn.cursor()

        # Wipe the users table
        cur.execute(WIPE_USERS_SQL)
        print("Users table wiped.")

        # Insert new users
        cur.execute(INSERT_USERS_SQL)
        print("Users inserted successfully.")

        cur.close()
        conn.close()

    except Exception as e:
        print("Error:", e)

if __name__ == "__main__":
    main()
