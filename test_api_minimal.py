
import requests
import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

# --- Configuration ---
SUPABASE_URL = 'https://ouwwhqebjrkojesuyfvv.supabase.co'
SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im91d3docWVianJrb2plc3V5ZnZ2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzMwODI3MDUsImV4cCI6MjA4ODY1ODcwNX0.NlcsvSsA0V-nolUnhJ1OtFpgoCQb04fdJRoWS4oaXu4'

def test_api():
    headers = {
        'apikey': SUPABASE_KEY,
        'Authorization': f'Bearer {SUPABASE_KEY}',
        'Prefer': 'count=exact'
    }
    # Check if we can get anything from rest/v1/
    try:
        print(f"Testing connectivity to {SUPABASE_URL}...")
        # Try getting the root to see available tables
        r = requests.get(f"{SUPABASE_URL}/rest/v1/", headers=headers, verify=False, timeout=15)
        print(f"Status: {r.status_code}")
        if r.status_code == 200:
            print("Successfully connected to Supabase REST API.")
            # Print first 200 chars of response
            print(f"Response snippet: {r.text[:200]}...")
        else:
            print(f"Error Details: {r.text}")
    except Exception as e:
        print(f"Request failed: {e}")

if __name__ == "__main__":
    test_api()
