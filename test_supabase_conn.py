import psycopg2
import os

def test_conn():
    # Settings from school/settings.py
    host = 'aws-1-eu-west-1.pooler.supabase.com'
    dbname = 'postgres'
    user = 'postgres.ouwwhqebjrkojesuyfvv'
    password = '9260@Keyro20'
    port = '5432'
    
    print(f"Connecting to {host} as {user}...")
    try:
        conn = psycopg2.connect(
            host=host,
            dbname=dbname,
            user=user,
            password=password,
            port=port,
            sslmode='require',
            connect_timeout=15
        )
        print("Successfully connected!")
        cur = conn.cursor()
        cur.execute("SELECT tablename FROM pg_catalog.pg_tables WHERE schemaname = 'public';")
        tables = cur.fetchall()
        print(f"Tables in public schema: {[t[0] for t in tables]}")
        cur.close()
        conn.close()
    except Exception as e:
        print(f"Connection failed: {e}")

if __name__ == "__main__":
    test_conn()
