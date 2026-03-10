
import psycopg
import socket

# Try IPv6 resolution/connection
REF = 'ouwwhqebjrkojesuyfvv'
PW = '9260@Keyro20'
HOST = f'db.{REF}.supabase.co'

def test_v3():
    print(f"Testing connectivity to {HOST} via psycopg v3...")
    try:
        # Check IP
        info = socket.getaddrinfo(HOST, 5432)
        print(f"Address info: {info}")
        
        conn_str = f"host={HOST} port=5432 dbname=postgres user=postgres password={PW} sslmode=require"
        with psycopg.connect(conn_str, timeout=10) as conn:
            print("✅ SUCCESS! Connected to direct DB (Port 5432)")
            with conn.cursor() as cur:
                cur.execute("SELECT version();")
                print(f"Version: {cur.fetchone()[0]}")
    except Exception as e:
        print(f"❌ Direct failed: {e}")
        
    print("\nTesting Pooler (6543) via psycopg v3...")
    POOLER = "aws-0-eu-central-1.pooler.supabase.com"
    try:
        conn_str = f"host={POOLER} port=6543 dbname=postgres user=postgres.{REF} password={PW} sslmode=require"
        with psycopg.connect(conn_str, timeout=10) as conn:
            print("✅ SUCCESS! Connected to Pooler (Port 6543)")
    except Exception as e:
        print(f"❌ Pooler failed: {e}")

if __name__ == "__main__":
    test_v3()
