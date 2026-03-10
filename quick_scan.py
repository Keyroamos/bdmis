
import psycopg2
import socket

REF = 'ouwwhqebjrkojesuyfvv'
PW = '9260@Keyro20'
REGIONS = ['eu-central-1', 'eu-west-1', 'eu-west-2', 'eu-west-3', 'us-east-1', 'us-east-2', 'us-west-1', 'us-west-2', 'ap-southeast-1', 'ap-southeast-2']

def scan():
    for r in REGIONS:
        host = f"aws-0-{r}.pooler.supabase.com"
        try:
            # Check DNS
            socket.gethostbyname(host)
            print(f"Testing {r}...")
            conn = psycopg2.connect(
                host=host,
                port=6543,
                user=f"postgres.{REF}",
                password=PW,
                dbname="postgres",
                sslmode="require",
                connect_timeout=3
            )
            print(f"✅ FOUND REGION: {r}")
            conn.close()
            return host
        except Exception as e:
            if "Tenant or user not found" in str(e):
                continue
            print(f"  {r}: {e}")
    return None

if __name__ == "__main__":
    scan()
