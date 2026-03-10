
import psycopg2
import sys

# Configuration from .env/settings
PROJECT_REF = 'ouwwhqebjrkojesuyfvv'
PASSWORD = '9260@Keyro20'

# List of possible connection configs
STRATEGIES = [
    {
        'name': 'Pooler Session (5432)',
        'params': {
            'host': 'aws-0-eu-central-1.pooler.supabase.com',
            'port': '5432',
            'user': f'postgres.{PROJECT_REF}',
            'dbname': 'postgres',
            'password': PASSWORD,
            'sslmode': 'require'
        }
    },
    {
        'name': 'Pooler Transaction (6543)',
        'params': {
            'host': 'aws-0-eu-central-1.pooler.supabase.com',
            'port': '6543',
            'user': f'postgres.{PROJECT_REF}',
            'dbname': 'postgres',
            'password': PASSWORD,
            'sslmode': 'require'
        }
    },
    {
        'name': 'Direct Mode (Try IP if DNS fails)',
        'params': {
            'host': '52.59.152.35', # IP of aws-0-eu-central-1.pooler.supabase.com from earlier ping
            'port': '5432',
            'user': f'postgres.{PROJECT_REF}',
            'dbname': 'postgres',
            'password': PASSWORD,
            'sslmode': 'require'
        }
    }
]

def test_connections():
    for strategy in STRATEGIES:
        print(f"Testing {strategy['name']}...")
        try:
            conn = psycopg2.connect(**strategy['params'])
            print(f"✅ SUCCESS! Strategy {strategy['name']} works.")
            conn.close()
            return strategy['params']
        except Exception as e:
            print(f"❌ FAILED: {e}")
    return None

if __name__ == "__main__":
    test_connections()
