
import os
from dotenv import load_dotenv

# Try to load .env
loaded = load_dotenv()
print(f".env loaded: {loaded}")
print(f"Current Dir: {os.getcwd()}")
print(f"Files here: {os.listdir('.')[:5]}")

pw = os.environ.get('SUPABASE_DB_PASSWORD')
if pw:
    print(f"Password found: {pw[:2]}...")
else:
    print("Password NOT found in environment.")

# Check if maybe it's partially loaded or has hidden chars
for k, v in os.environ.items():
    if 'SUPABASE' in k:
        print(f"  {k} = {v[:5]}...")
