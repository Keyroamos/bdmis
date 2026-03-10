
import socket
import psycopg2
from concurrent.futures import ThreadPoolExecutor

REF = 'ouwwhqebjrkojesuyfvv'
PW = '9260@Keyro20'
REGIONS = [
    'eu-central-1', 'eu-west-1', 'eu-west-2', 'eu-west-3', 'eu-north-1',
    'us-east-1', 'us-east-2', 'us-west-1', 'us-west-2',
    'ap-southeast-1', 'ap-southeast-2', 'ap-northeast-1', 'ap-northeast-2', 'ap-northeast-3', 'ap-south-1',
    'sa-east-1', 'ca-central-1', 'me-south-1', 'af-south-1'
]

def check_region(region):
    host = f"aws-0-{region}.pooler.supabase.com"
    try:
        socket.gethostbyname(host)
        conn = psycopg2.connect(
            host=host,
            port=6543,
            user=f"postgres.{REF}",
            password=PW,
            dbname="postgres",
            sslmode="require",
            connect_timeout=10
        )
        conn.close()
        return region, "CONNECTED"
    except socket.gaierror:
        return region, "DNS FAIL"
    except psycopg2.OperationalError as e:
        if "Tenant or user not found" in str(e):
            return region, "NOT HERE"
        return region, f"ERROR: {e}"
    except Exception as e:
        return region, f"EXCEPTION: {e}"

def main():
    print(f"Scanning {len(REGIONS)} regions in parallel...")
    with ThreadPoolExecutor(max_workers=10) as executor:
        results = list(executor.map(check_region, REGIONS))
    
    for r, res in sorted(results):
        if "CONNECTED" in res:
            print(f"✅ {r}: {res}")
        elif "ERROR" in res or "EXCEPTION" in res:
             print(f"⚠️ {r}: {res}")
        else:
             # Just print summary for nothing found
             pass
    
    found = [r for r, res in results if "CONNECTED" in res]
    if not found:
        print("\nNo region found. All accessible poolers returned 'Tenant or user not found'.")

if __name__ == "__main__":
    main()
