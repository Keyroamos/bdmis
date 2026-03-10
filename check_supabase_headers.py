
from supabase import create_client
import requests

URL = "https://ouwwhqebjrkojesuyfvv.supabase.co"
KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im91d3docWVianJrb2plc3V5ZnZ2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzMwODI3MDUsImV4cCI6MjA4ODY1ODcwNX0.NlcsvSsA0V-nolUnhJ1OtFpgoCQb04fdJRoWS4oaXu4"

def check():
    try:
        supabase = create_client(URL, KEY)
        print("Connected with Supabase Client.")
        # Try to call a rest function to see if it's alive
        res = requests.get(f"{URL}/rest/v1/", headers={"apikey": KEY, "Authorization": f"Bearer {KEY}"})
        print(f"REST Status: {res.status_code}")
        
        # Check if we can reach any common schema info
        # PostgREST usually has / which we already checked.
        
        # Now, try to find the region via the 'Via' or other headers
        print("Headers:")
        for k, v in res.headers.items():
            print(f"  {k}: {v}")
            
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    check()
