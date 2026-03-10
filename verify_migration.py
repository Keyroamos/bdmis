
import sqlite3
import psycopg2
import os

# --- Configuration ---
SQLITE_DB = 'db.sqlite3'
PG_PASSWORD = '9260@Keyro20'
PROJECT_REF = 'ouwwhqebjrkojesuyfvv'

CONN_STRATEGIES = [
    {
        'name': 'Direct (Port 5432)',
        'params': {
            'host': f'db.{PROJECT_REF}.supabase.co',
            'port': '5432',
            'user': 'postgres',
            'dbname': 'postgres',
            'password': PG_PASSWORD,
            'sslmode': 'require',
            'connect_timeout': 15
        }
    },
    {
        'name': 'Pooler (Session - Port 5432)',
        'params': {
            'host': 'aws-0-eu-central-1.pooler.supabase.com',
            'port': '5432',
            'user': f'postgres.{PROJECT_REF}',
            'dbname': 'postgres',
            'password': PG_PASSWORD,
            'sslmode': 'require',
            'connect_timeout': 15
        }
    },
    {
        'name': 'Pooler (Transaction - Port 6543)',
        'params': {
            'host': 'aws-0-eu-central-1.pooler.supabase.com',
            'port': '6543',
            'user': f'postgres.{PROJECT_REF}',
            'dbname': 'postgres',
            'password': PG_PASSWORD,
            'sslmode': 'require',
            'connect_timeout': 15
        }
    }
]

def verify():
    print("Connecting to SQLite...")
    if not os.path.exists(SQLITE_DB):
        print(f"Error: {SQLITE_DB} not found.")
        return
    sq_conn = sqlite3.connect(SQLITE_DB)
    sc = sq_conn.cursor()

    print("Connecting to Supabase...")
    pg_conn = None
    for strategy in CONN_STRATEGIES:
        try:
            print(f"Trying {strategy['name']}...")
            pg_conn = psycopg2.connect(**strategy['params'])
            print(f"✓ Connected via {strategy['name']}!")
            break
        except Exception as e:
            print(f"  FAILED: {e}")

    if not pg_conn:
        print("❌ CRITICAL: Could not connect to Supabase.")
        return
    pc = pg_conn.cursor()

    # 1. Get SQLite tables
    sc.execute("SELECT name FROM sqlite_master WHERE type='table'")
    sqlite_tables = {r[0] for r in sc.fetchall() if r[0] not in SKIP_TABLES}

    # 2. Get Supabase tables
    pc.execute("SELECT tablename FROM pg_catalog.pg_tables WHERE schemaname = 'public';")
    supabase_tables = {r[0] for r in pc.fetchall()}

    print(f"\nTables in SQLite: {len(sqlite_tables)}")
    print(f"Tables in Supabase: {len(supabase_tables)}")

    missing_in_supabase = sqlite_tables - supabase_tables
    if missing_in_supabase:
        print(f"\n❌ Missing in Supabase ({len(missing_in_supabase)} tables):")
        for t in sorted(missing_in_supabase):
            print(f"  - {t}")
    else:
        print("\n✅ All SQLite tables exist in Supabase.")

    extra_in_supabase = supabase_tables - sqlite_tables
    if extra_in_supabase:
        print(f"\n⚠️ Extra in Supabase ({len(extra_in_supabase)} tables):")
        for t in sorted(extra_in_supabase):
            print(f"  - {t}")

    # 3. Compare Row Counts
    print("\nComparing Row Counts:")
    print(f"{'Table Name':<40} | {'SQLite':>10} | {'Supabase':>10} | {'Status':<10}")
    print("-" * 80)

    common_tables = sorted(sqlite_tables & supabase_tables)
    discrepancies = []

    for table in common_tables:
        try:
            sc.execute(f'SELECT count(*) FROM "{table}"')
            sq_count = sc.fetchone()[0]
        except Exception as e:
            sq_count = f"ERR:{e}"

        try:
            pc.execute(f'SELECT count(*) FROM "{table}"')
            pg_count = pc.fetchone()[0]
        except Exception as e:
            pg_count = f"ERR:{e}"

        status = "✅ OK" if sq_count == pg_count else "❌ DIFF"
        print(f"{table:<40} | {str(sq_count):>10} | {str(pg_count):>10} | {status}")
        
        if sq_count != pg_count:
            discrepancies.append((table, sq_count, pg_count))

    if discrepancies:
        print(f"\nFound {len(discrepancies)} discrepancies in row counts.")
    else:
        print("\nAll common tables have matching row counts.")

    sq_conn.close()
    pg_conn.close()

if __name__ == "__main__":
    verify()
