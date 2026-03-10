
import psycopg2
import socket
import sys

REF = 'ouwwhqebjrkojesuyfvv'
PW = '9260@Keyro20'
REGIONS = [
    'eu-central-1', 'eu-west-1', 'eu-west-2', 'eu-west-3', 
    'us-east-1', 'us-east-2', 'us-west-1', 'us-west-2',
    'ap-southeast-1', 'ap-southeast-2', 'ap-south-1'
]

def scan():
    print(f"Scanning for pooler for {REF}...")
    for r in REGIONS:
        host = f"aws-0-{r}.pooler.supabase.com"
        print(f"Checking {r}... ", end="", flush=True)
        try:
            # Check if DNS resolves to an IPv4
            ip = socket.gethostbyname(host)
            print(f"(IP: {ip})... ", end="", flush=True)
            
            # Port 6543 (Pooler)
            conn = psycopg2.connect(
                host=host,
                port=6543,
                user=f"postgres.{REF}",
                password=PW,
                dbname="postgres",
                sslmode="require",
                connect_timeout=5
            )
            print("✅ CONNECTED!")
            conn.close()
            return host
        except socket.gaierror:
            print("DNS failure.")
        except psycopg2.OperationalError as e:
            if "Tenant or user not found" in str(e):
                print("No project found.")
            elif "timeout expired" in str(e):
                print("Timeout.")
            else:
                print(f"Error: {e}")
        except Exception as e:
            print(f"Unexpected: {e}")
    return None

if __name__ == "__main__":
    scan()
