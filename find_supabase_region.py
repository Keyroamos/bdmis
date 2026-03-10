
import socket
import psycopg2

PROJECT_REF = 'ouwwhqebjrkojesuyfvv'
PASSWORD = '9260@Keyro20'

REGIONS = [
    'eu-central-1',
    'eu-west-1',
    'eu-west-2',
    'eu-west-3',
    'us-east-1',
    'us-east-2',
    'us-west-1',
    'us-west-2',
    'ap-southeast-1',
    'ap-southeast-2',
    'ap-northeast-1',
    'ap-northeast-2',
    'ap-south-1',
    'sa-east-1',
    'ca-central-1',
    'me-south-1',
    'af-south-1'
]

def find_region():
    for region in REGIONS:
        host = f'aws-0-{region}.pooler.supabase.com'
        try:
            # Check if DNS resolves first
            ip = socket.gethostbyname(host)
            print(f"Testing {region} ({ip})...")
            
            # Try connecting
            conn = psycopg2.connect(
                host=host,
                port=6543,
                user=f'postgres.{PROJECT_REF}',
                password=PASSWORD,
                dbname='postgres',
                sslmode='require',
                connect_timeout=3
            )
            print(f"✅ FOUND! Region is {region}")
            conn.close()
            return host
        except socket.gaierror:
            # DNS failed, skip
            continue
        except psycopg2.OperationalError as e:
            if "Tenant or user not found" in str(e):
                # Host exists but project not there
                continue
            else:
                print(f"  {region} error: {e}")
        except Exception as e:
            print(f"  {region} unexpected error: {e}")
    return None

if __name__ == "__main__":
    find_region()
