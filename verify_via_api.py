
import sqlite3
import requests
import os
import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

# --- Configuration ---
SQLITE_DB = 'db.sqlite3'
SUPABASE_URL = 'https://ouwwhqebjrkojesuyfvv.supabase.co'
SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im91d3docWVianJrb2plc3V5ZnZ2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzMwODI3MDUsImV4cCI6MjA4ODY1ODcwNX0.NlcsvSsA0V-nolUnhJ1OtFpgoCQb04fdJRoWS4oaXu4'

def get_sqlite_stats():
    if not os.path.exists(SQLITE_DB):
        return None
    conn = sqlite3.connect(SQLITE_DB)
    cur = conn.cursor()
    cur.execute("SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'")
    tables = [t[0] for t in cur.fetchall()]
    stats = {}
    for t in tables:
        try:
            cur.execute(f'SELECT count(*) FROM "{t}"')
            stats[t] = cur.fetchone()[0]
        except:
            stats[t] = "Error"
    conn.close()
    return stats

def get_supabase_stats():
    headers = {
        'apikey': SUPABASE_KEY,
        'Authorization': f'Bearer {SUPABASE_KEY}',
        'Range-Unit': 'items'
    }
    
    # 1. Get available tables from root
    print("Fetching table list from Supabase...")
    try:
        r = requests.get(f"{SUPABASE_URL}/rest/v1/", headers=headers, verify=False, timeout=15)
        if r.status_code != 200:
            print(f"Failed to get table list: {r.status_code}")
            return {}
        
        swagger = r.json()
        definitions = swagger.get('definitions', {})
        sb_tables = list(definitions.keys())
        print(f"Found {len(sb_tables)} tables in Supabase.")
    except Exception as e:
        print(f"Error fetching Supabase table list: {e}")
        return {}

    stats = {}
    for t in sb_tables:
        url = f"{SUPABASE_URL}/rest/v1/{t}"
        try:
            # Use Prefer: count=exact and limit 1 to get total items via Content-Range
            r_count = requests.get(url, headers={**headers, 'Prefer': 'count=exact'}, params={'limit': 1}, verify=False, timeout=10)
            if r_count.status_code == 200 or r_count.status_code == 206:
                content_range = r_count.headers.get('Content-Range')
                if content_range and '/' in content_range:
                    stats[t] = int(content_range.split('/')[-1])
                else:
                    # If count not in header, try length of data if small or zero
                    stats[t] = len(r_count.json())
            else:
                stats[t] = f"Error:{r_count.status_code}"
        except Exception as e:
            stats[t] = f"Error:{str(e)}"
    return stats

def main():
    sq_stats = get_sqlite_stats()
    if sq_stats is None:
        print("SQLite DB not found.")
        return

    sb_stats = get_supabase_stats()

    print("\nVerification Report:")
    print("="*95)
    print(f"{'Table Name':<45} | {'SQLite':>10} | {'Supabase':>10} | {'Status'}")
    print("-" * 95)

    all_tables = sorted(set(sq_stats.keys()) | set(sb_stats.keys()))
    
    for t in all_tables:
        if t.startswith('django_') or t.startswith('auth_permission') or t.startswith('auth_group_'):
             # Skip some verbose internal tables unless they have diffs
             pass
             
        sq_count = sq_stats.get(t, "Missing")
        sb_count = sb_stats.get(t, "Missing")
        
        status = "✅ OK"
        if sq_count == "Missing":
            status = "⚠️ Extra in SB"
        elif sb_count == "Missing":
            status = "❌ MISSING in SB"
        elif isinstance(sq_count, int) and isinstance(sb_count, int):
            if sq_count == sb_count:
                status = "✅ OK"
            else:
                status = f"❌ DIFF ({sb_count - sq_count:+})"
        else:
            status = "⚠️ Error"

        # Show if it's missing, extra, or has a diff, OR if it's a main application table
        is_app_table = t.startswith(('schools_', 'finance_', 'food_', 'transport_')) or t == 'auth_user'
        if status != "✅ OK" or is_app_table:
            print(f"{t:<45} | {str(sq_count):>10} | {str(sb_count):>10} | {status}")

    print("="*95)

if __name__ == "__main__":
    main()
