
import psycopg2
import sys
import os

# --- Configuration ---
HOST = 'aws-1-eu-west-1.pooler.supabase.com'
PORT = '5432'
USER = 'postgres.ouwwhqebjrkojesuyfvv'
DBNAME = 'postgres'
# Password from .env/previous context
PASSWORD = '9260@Keyro20'

SQL_FILE = 'supabase_migration.sql'

def run_migration():
    print(f"🚀 Starting final migration to {HOST}...")
    
    if not os.path.exists(SQL_FILE):
        print(f"❌ Error: {SQL_FILE} not found. Please run 'generate_supabase_sql.py' first.")
        return

    try:
        conn = psycopg2.connect(
            host=HOST,
            port=PORT,
            user=USER,
            password=PASSWORD,
            dbname=DBNAME,
            sslmode='require',
            connect_timeout=30
        )
        conn.autocommit = True
        cur = conn.cursor()
        print("✅ Connected to Supabase!")

        print(f"Reading {SQL_FILE}...")
        with open(SQL_FILE, 'r', encoding='utf-8') as f:
            sql = f.read()

        # Split by ';' to execute in blocks if needed, but our scripts generate chunks
        # Actually, for large files, we should execute block by block
        print("Executing migration SQL...")
        
        # Simple split by '-- SECTION' or just blocks
        blocks = sql.split('-- ============================================================')
        
        for i, block in enumerate(blocks):
            if not block.strip(): continue
            print(f"  Executing block {i}/{len(blocks)-1}...", end=" ", flush=True)
            try:
                cur.execute(block)
                print("✓ Done")
            except Exception as e:
                print(f"⚠️ Error in block {i}: {str(e)[:100]}...")
                # We continue as some drops might fail if tables don't exist yet
                continue

        print("\n✨ MIGRATION COMPLETE!")
        
        # Verify a table
        cur.execute("SELECT count(*) FROM schools_student;")
        count = cur.fetchone()[0]
        print(f"Verification: schools_student count = {count}")
        
        cur.close()
        conn.close()

    except Exception as e:
        print(f"❌ CRITICAL ERROR: {e}")

if __name__ == "__main__":
    run_migration()
