
import psycopg2
import os
from dotenv import load_dotenv

load_dotenv()

HOST = os.environ.get('SUPABASE_DB_HOST', 'aws-1-eu-west-1.pooler.supabase.com')
PORT = os.environ.get('SUPABASE_DB_PORT', '5432')
USER = os.environ.get('SUPABASE_DB_USER', 'postgres.ouwwhqebjrkojesuyfvv')
DBNAME = os.environ.get('SUPABASE_DB_NAME', 'postgres')
PASSWORD = os.environ.get('SUPABASE_DB_PASSWORD', '9260@Keyro20')

def check_login_tables():
    print(f"Connecting to {HOST}:{PORT}...")
    try:
        conn = psycopg2.connect(
            host=HOST,
            port=PORT,
            user=USER,
            password=PASSWORD,
            dbname=DBNAME,
            sslmode='require'
        )
        cur = conn.cursor()
        
        # Check auth_user
        print("Checking 'auth_user' table...")
        cur.execute("SELECT count(*) FROM auth_user;")
        user_count = cur.fetchone()[0]
        print(f"✅ auth_user count: {user_count}")
        
        # Check for first user
        cur.execute("SELECT username, is_active FROM auth_user LIMIT 1;")
        user_info = cur.fetchone()
        print(f"✅ Sample user: {user_info}")
        
        # Check sessions table
        print("Checking 'django_session' table...")
        cur.execute("SELECT count(*) FROM django_session;")
        session_count = cur.fetchone()[0]
        print(f"✅ django_session count: {session_count}")
        
        cur.close()
        conn.close()
    except Exception as e:
        print(f"❌ Error: {e}")

if __name__ == "__main__":
    check_login_tables()
