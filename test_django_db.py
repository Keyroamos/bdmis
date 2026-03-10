
import os
import django
from django.db import connection

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'school.settings')
django.setup()

def check_db():
    print(f"Current DB Engine: {connection.vendor}")
    print(f"Current DB Host: {connection.settings_dict['HOST']}")
    print(f"Current DB Port: {connection.settings_dict['PORT']}")
    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT current_database(), current_user, inet_server_addr();")
            res = cursor.fetchone()
            print(f"✅ CONNECTED! Info: {res}")
            
            # Now, list tables
            cursor.execute("SELECT tablename FROM pg_catalog.pg_tables WHERE schemaname = 'public';")
            tables = [t[0] for t in cursor.fetchall()]
            print(f"Tables in public schema: {len(tables)}")
            if tables:
                print(f"Snippet: {tables[:5]}")
    except Exception as e:
        print(f"❌ FAILED to connect: {e}")

if __name__ == "__main__":
    check_db()
