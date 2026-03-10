
import psycopg2
import sys

def check_db():
    params_list = [
        # Method 1: Direct Connection
        {
            'host': 'db.ouwwhqebjrkojesuyfvv.supabase.co',
            'port': '5432',
            'dbname': 'postgres',
            'user': 'postgres',
            'password': '9260@Keyro20',
            'sslmode': 'require',
            'connect_timeout': 15
        },
        # Method 2: Pooler (Session Mode)
        {
            'host': 'aws-0-eu-central-1.pooler.supabase.com',
            'port': '5432',
            'dbname': 'postgres',
            'user': 'postgres.ouwwhqebjrkojesuyfvv',
            'password': '9260@Keyro20',
            'sslmode': 'require',
            'connect_timeout': 15
        },
        # Method 3: Pooler (Transaction Mode - Port 6543)
        {
            'host': 'aws-0-eu-central-1.pooler.supabase.com',
            'port': '6543',
            'dbname': 'postgres',
            'user': 'postgres.ouwwhqebjrkojesuyfvv',
            'password': '9260@Keyro20',
            'sslmode': 'require',
            'connect_timeout': 15
        }
    ]
    
    conn = None
    for i, params in enumerate(params_list):
        try:
            print(f"Trying connection method {i+1} ({params['host']}:{params['port']})...")
            conn = psycopg2.connect(**params)
            print(f"Successfully connected using method {i+1}!")
            break
        except Exception as e:
            print(f"Method {i+1} failed: {e}")
            
    if not conn:
        print("All connection methods failed.")
        return

    try:
        conn.autocommit = True
        cur = conn.cursor()
        
        print("Successfully connected to Supabase.")
        
        # Get all tables
        cur.execute("SELECT tablename FROM pg_catalog.pg_tables WHERE schemaname = 'public';")
        tables = [t[0] for t in cur.fetchall()]
        print(f"Total tables found: {len(tables)}")
        
        results = []
        for table in sorted(tables):
            try:
                cur.execute(f'SELECT count(*) FROM "{table}";')
                count = cur.fetchone()[0]
                if count > 0:
                    results.append(f"{table}: {count}")
            except Exception as e:
                results.append(f"{table}: ERROR")
                
        print("\nPopulated Tables:")
        for res in results:
            print(res)
            
        print("\nChecking schools_student specifically...")
        try:
            cur.execute('SELECT count(*) FROM schools_student;')
            count = cur.fetchone()[0]
            print(f"schools_student count: {count}")
            if count > 0:
                cur.execute('SELECT id, admission_number, first_name, last_name FROM schools_student LIMIT 5;')
                rows = cur.fetchall()
                for row in rows:
                    print(f"Row: {row}")
        except Exception as e:
            print(f"Error checking schools_student: {e}")
            
        cur.close()
        conn.close()
    except Exception as e:
        print(f"Connection failed: {e}")

if __name__ == '__main__':
    check_db()
