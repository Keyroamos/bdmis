
import sqlite3
import pandas as pd
import os

def export_to_csv():
    db_path = 'db.sqlite3'
    if not os.path.exists(db_path):
        print(f"Error: {db_path} not found.")
        return

    table_name = 'schools_student'
    output_file = 'schools_student_export.csv'

    print(f"Exporting {table_name} to {output_file}...")
    
    conn = sqlite3.connect(db_path)
    try:
        df = pd.read_sql_query(f'SELECT * FROM {table_name}', conn)
        
        # Ensure boolean columns are readable by Supabase CSV importer
        # (Though most are null/0/1 in SQLite)
        
        df.to_csv(output_file, index=False)
        print(f"✓ Success! File saved as: {os.path.abspath(output_file)}")
        print("You can now upload this file directly to Supabase Table Editor.")
    except Exception as e:
        print(f"Error: {e}")
    finally:
        conn.close()

if __name__ == '__main__':
    export_to_csv()
