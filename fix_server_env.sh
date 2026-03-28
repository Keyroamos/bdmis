#!/bin/bash
# Run this script on the cPanel server terminal to fix the database connection
# Location: ~/public_html/nedbdmis/ (or wherever your Django app lives)
#
# Usage: bash fix_server_env.sh

SERVER_DIR="${HOME}/public_html/nedbdmis"

echo "=== Fixing BDMIS Database Connection ==="
echo ""

# Step 1: Show current .env DB settings
echo "--- Current .env DB settings ---"
grep -E "SUPABASE_DB_HOST|SUPABASE_DB_PORT" "${SERVER_DIR}/.env"

# Step 2: Fix the port from 5432 (session mode, BLOCKED) to 6543 (transaction mode, OPEN)
echo ""
echo "--- Applying fix: port 5432 → 6543, host → aws-0-eu-west-1 ---"
sed -i 's/SUPABASE_DB_HOST=aws-[0-9]-eu-west-1\.pooler\.supabase\.com/SUPABASE_DB_HOST=aws-0-eu-west-1.pooler.supabase.com/' "${SERVER_DIR}/.env"
sed -i 's/SUPABASE_DB_PORT=5432/SUPABASE_DB_PORT=6543/' "${SERVER_DIR}/.env"

# Step 3: Verify the fix
echo ""
echo "--- New .env DB settings ---"
grep -E "SUPABASE_DB_HOST|SUPABASE_DB_PORT" "${SERVER_DIR}/.env"

# Step 4: Test connectivity on port 6543
echo ""
echo "--- Testing Supabase connection on port 6543 ---"
timeout 5 bash -c "echo >/dev/tcp/aws-0-eu-west-1.pooler.supabase.com/6543" 2>/dev/null \
  && echo "✅ Port 6543 is REACHABLE" \
  || echo "❌ Port 6543 is NOT reachable - contact hosting support"

# Step 5: Clear Python cache and restart Passenger
echo ""
echo "--- Clearing cache and restarting app ---"
find "${SERVER_DIR}" -name "*.pyc" -delete 2>/dev/null
rm -rf "${SERVER_DIR}/django_cache/"* 2>/dev/null
touch "${SERVER_DIR}/tmp/restart.txt" 2>/dev/null \
  || touch "${SERVER_DIR}/passenger_wsgi.py"

echo ""
echo "=== Done! Wait 10 seconds then test: curl https://auth-system.bdmis.co.ke/api/login/ ==="
