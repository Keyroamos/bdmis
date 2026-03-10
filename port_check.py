
import socket
from concurrent.futures import ThreadPoolExecutor

REGIONS = [
    'eu-central-1', 'eu-west-1', 'eu-west-2', 'eu-west-3', 'eu-north-1',
    'us-east-1', 'us-east-2', 'us-west-1', 'us-west-2',
    'ap-southeast-1', 'ap-southeast-2', 'ap-southeast-3', 'ap-northeast-1', 'ap-northeast-2', 'ap-northeast-3', 'ap-south-1',
    'sa-east-1', 'ca-central-1', 'me-south-1', 'af-south-1'
]

def check_port(region):
    host = f"aws-0-{region}.pooler.supabase.com"
    try:
        ip = socket.gethostbyname(host)
        # Check port 6543
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.settimeout(2)
            res = s.connect_ex((ip, 6543))
            if res == 0:
                # Connected to port 6543! Now try to find if it knows our tenant
                # (But we can only do this with psycopg)
                return region, ip, "6543 OPEN"
            else:
                return region, ip, f"6543 CLOSED ({res})"
    except:
        return region, "N/A", "DNS FAIL"

def main():
    print("Checking ports across all regions...")
    with ThreadPoolExecutor(max_workers=20) as executor:
        results = list(executor.map(check_port, REGIONS))
    
    for r, ip, status in sorted(results):
        print(f"{r:20} | {ip:15} | {status}")

if __name__ == "__main__":
    main()
