
import socket
import psycopg2

REF = 'ouwwhqebjrkojesuyfvv'
PW = '9260@Keyro20'
REGIONS = [
    'eu-central-1', 'eu-west-1', 'eu-west-2', 'eu-west-3', 'eu-north-1',
    'us-east-1', 'us-east-2', 'us-west-1', 'us-west-2',
    'ap-southeast-1', 'ap-southeast-2', 'ap-northeast-1', 'ap-northeast-2', 'ap-northeast-3', 'ap-south-1',
    'sa-east-1', 'ca-central-1', 'me-south-1', 'af-south-1'
]

def find_ips():
    ips = {}
    for r in REGIONS:
        host = f"aws-0-{r}.pooler.supabase.com"
        try:
            ip = socket.gethostbyname(host)
            ips[r] = ip
        except:
            pass
    return ips

def check_ip(ip, region):
    try:
        conn = psycopg2.connect(
            host=ip,
            port=6543,
            user=f"postgres.{REF}",
            password=PW,
            dbname="postgres",
            sslmode="require",
            connect_timeout=3
        )
        conn.close()
        return True
    except Exception as e:
        if "Tenant or user not found" in str(e):
            return False
        # If timeout or something else, it might be the right one but firewall blocked
        print(f"  {region} ({ip}): {e}")
        return False

def main():
    ips = find_ips()
    print(f"Found {len(ips)} pooler IPs. Scanning...")
    for r, ip in ips.items():
        if check_ip(ip, r):
            print(f"✅ FOUND! Region is {r}")
            return
    print("Done. No matching pooler found.")

if __name__ == "__main__":
    main()
