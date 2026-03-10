
import psycopg2
import socket

REF = 'ouwwhqebjrkojesuyfvv'
PW = '9260@Keyro20'
REGIONS = [
    'eu-central-1', 'eu-west-1', 'eu-west-2', 'eu-west-3', 'eu-north-1',
    'us-east-1', 'us-east-2', 'us-west-1', 'us-west-2',
    'ap-southeast-1', 'ap-southeast-2', 'ap-northeast-1', 'ap-northeast-2', 'ap-northeast-3', 'ap-south-1',
    'sa-east-1', 'ca-central-1', 'me-south-1', 'af-south-1'
]

def scan():
    for r in REGIONS:
        host = f"aws-0-{r}.pooler.supabase.com"
        try:
            # Check DNS
            socket.gethostbyname(host)
            print(f"Testing {r}...", end=" ", flush=True)
            conn = psycopg2.connect(
                host=host,
                port=6543,
                user=f"postgres.{REF}",
                password=PW,
                dbname="postgres",
                sslmode="require",
                connect_timeout=2
            )
            print(f"✅ FOUND!")
            conn.close()
            return host
        except socket.gaierror:
            continue
        except Exception as e:
            if "Tenant or user not found" in str(e):
                print("No project.")
                continue
            print(f"Error: {e}")
    return None

if __name__ == "__main__":
    scan()
