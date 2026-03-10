
import psycopg2
import os
from dotenv import load_dotenv

load_dotenv()

def fix_infra():
    conn = psycopg2.connect(
        host=os.environ.get('SUPABASE_DB_HOST', 'aws-1-eu-west-1.pooler.supabase.com'),
        port=5432,
        user=os.environ.get('SUPABASE_DB_USER', 'postgres.ouwwhqebjrkojesuyfvv'),
        password=os.environ.get('SUPABASE_DB_PASSWORD', '9260@Keyro20'),
        dbname='postgres',
        sslmode='require'
    )
    conn.autocommit = True
    cur = conn.cursor()
    
    print("Creating core Django infrastructure tables...")
    
    # django_session
    try:
        cur.execute("""
        CREATE TABLE IF NOT EXISTS "django_session" (
            "session_key" varchar(40) NOT NULL PRIMARY KEY,
            "session_data" text NOT NULL,
            "expire_date" timestamptz NOT NULL
        );
        CREATE INDEX IF NOT EXISTS "django_session_expire_date_idx" ON "django_session" ("expire_date");
        """)
        print("✅ django_session created.")
    except Exception as e:
        print(f"❌ django_session error: {e}")

    # django_cache_table (if used)
    try:
        cur.execute("""
        CREATE TABLE IF NOT EXISTS "django_cache_table" (
            "cache_key" varchar(255) NOT NULL PRIMARY KEY,
            "value" text NOT NULL,
            "expires" timestamptz NOT NULL
        );
        """)
        print("✅ django_cache_table created.")
    except Exception as e:
        print(f"❌ django_cache_table error: {e}")

    cur.close()
    conn.close()

if __name__ == "__main__":
    fix_infra()
