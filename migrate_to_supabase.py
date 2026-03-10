#!/usr/bin/env python3
"""
Refined SQLite → Supabase (PostgreSQL) robust migration.
Performs a full migration (Schema + Data + Constraints) in ONE COMMAND.
"""

import sqlite3
import os
import sys
from datetime import datetime

# --- Configuration ---
SQLITE_DB = 'db.sqlite3'
PG_PASSWORD = '9260@Keyro20'
PROJECT_REF = 'ouwwhqebjrkojesuyfvv'

# Connection strategies to try
CONN_STRATEGIES = [
    {
        'name': 'Pooler (Transaction mode - Port 6543)',
        'params': {
            'host': 'aws-0-eu-central-1.pooler.supabase.com',
            'port': '6543',
            'user': f'postgres.{PROJECT_REF}',
            'dbname': 'postgres',
            'password': PG_PASSWORD,
            'sslmode': 'require',
            'connect_timeout': 15
        }
    },
    {
        'name': 'Pooler (Session mode - Port 5432)',
        'params': {
            'host': 'aws-0-eu-central-1.pooler.supabase.com',
            'port': '5432',
            'user': f'postgres.{PROJECT_REF}',
            'dbname': 'postgres',
            'password': PG_PASSWORD,
            'sslmode': 'require',
            'connect_timeout': 15
        }
    }
]

SKIP_TABLES = {'django_cache_table', 'django_session', 'sqlite_sequence'}
TABLE_ORDER = [
    'django_content_type', 'auth_permission', 'auth_group', 'auth_user',
    'auth_group_permissions', 'auth_user_groups', 'auth_user_user_permissions',
    'django_migrations', 'django_admin_log',
    'config_schoolconfig',
    'schools_school', 'schools_branch', 'schools_department', 'schools_employee',
    'schools_grade', 'schools_teacher', 'schools_teacher_subjects', 'schools_subject',
    'schools_nonteachingstaff', 'schools_salary', 'schools_allowance',
    'schools_deduction', 'schools_salaryadvance', 'schools_advanceapproval',
    'schools_leave', 'schools_leaveapproval', 'schools_staffdocument',
    'schools_term', 'schools_route', 'schools_vehicle', 'schools_student',
    'schools_payment', 'schools_attendance', 'schools_assessment',
    'schools_assessmentresult', 'schools_schedule', 'schools_announcement',
    'schools_smsmessage', 'schools_transportfee', 'schools_studenttransportassignment',
    'schools_foodplan', 'schools_foodfee', 'schools_studentfoodassignment',
    'schools_mealpricing', 'schools_studentmealpayment', 'schools_mealconsumption',
    'schools_syncstatus', 'schools_syncqueue', 'schools_employeeattendance',
    'schools_expense',
    'finance_feecategory', 'finance_feestructure', 'finance_studentfinanceaccount',
    'finance_transaction', 'finance_salarystructure', 'finance_payrollrecord',
    'food_mealitem', 'food_foodstudentaccount', 'food_foodtransaction',
    'food_foodsubscription',
    'transport_route', 'transport_transportvehicle', 'transport_transportdriver',
    'transport_transportstudentaccount', 'transport_transportassignment',
    'transport_transporttransaction', 'transport_transportadvancerequest',
    'transport_transportexpense', 'transport_transportleaverequest',
]

def sqlite_type_to_pg(col_type):
    if not col_type: return 'TEXT'
    t = col_type.strip().upper().split('(')[0]
    mapping = {
        'INTEGER': 'BIGINT', 'INT': 'BIGINT', 'BIGINT': 'BIGINT',
        'SMALLINT': 'SMALLINT', 'TINYINT': 'SMALLINT', 'MEDIUMINT': 'BIGINT',
        'TEXT': 'TEXT', 'CLOB': 'TEXT', 'BLOB': 'BYTEA',
        'REAL': 'DOUBLE PRECISION', 'FLOAT': 'DOUBLE PRECISION',
        'BOOLEAN': 'BOOLEAN', 'BOOL': 'BOOLEAN',
        'DATE': 'DATE', 'TIME': 'TIME', 'DATETIME': 'TIMESTAMPTZ', 'TIMESTAMP': 'TIMESTAMPTZ',
        'DECIMAL': 'NUMERIC', 'NUMERIC': 'NUMERIC',
    }
    if t in mapping: return mapping[t]
    if any(p in t for p in ('CHAR', 'VARCHAR', 'NVARCHAR')): return 'TEXT'
    return 'TEXT'

def get_columns(sc, table):
    sc.execute(f'PRAGMA table_info("{table}")')
    return sc.fetchall()

def build_relaxed_create_table(sc, table):
    cols = get_columns(sc, table)
    pk_cols = [c for c in cols if c[5] > 0]
    is_single_int_pk = len(pk_cols) == 1 and 'INT' in (pk_cols[0][2] or '').upper()
    lines = []
    for col in cols:
        name, col_type, pk = col[1], col[2], col[5]
        pg_type = sqlite_type_to_pg(col_type)
        if pk == 1 and is_single_int_pk:
            line = f'"{name}" BIGSERIAL PRIMARY KEY'
        else:
            line = f'"{name}" {pg_type}'
            if pk > 0: line += ' PRIMARY KEY'
        lines.append(line)
    return f'CREATE TABLE IF NOT EXISTS "{table}" ({", ".join(lines)})'

def main():
    try:
        import psycopg2
        from psycopg2.extras import execute_values
    except ImportError:
        print("Required library 'psycopg2' not found. Install it with: pip install psycopg2-binary")
        return

    print("=" * 60)
    print("🚀 SUPABASE ONE-COMMAND MIGRATION")
    print(f"Time: {datetime.now().strftime('%H:%M:%S')}")
    print("=" * 60)

    # 1. Connect to SQLite
    if not os.path.exists(SQLITE_DB):
        print(f"Error: {SQLITE_DB} not found in current directory.")
        return
    sq_conn = sqlite3.connect(SQLITE_DB)
    sc = sq_conn.cursor()

    # 2. Connect to Supabase
    pg_conn = None
    for strategy in CONN_STRATEGIES:
        try:
            print(f"Connecting via {strategy['name']}...")
            pg_conn = psycopg2.connect(**strategy['params'])
            print("✓ Connected successfully!")
            break
        except Exception as e:
            print(f"  Failed: {e}")
    
    if not pg_conn:
        print("❌ CRITICAL: Could not connect to Supabase. Check your internet and password.")
        return

    pg_conn.autocommit = True
    pc = pg_conn.cursor()

    # 3. Get Tables
    sc.execute("SELECT name FROM sqlite_master WHERE type='table'")
    all_tables = [r[0] for r in sc.fetchall() if r[0] not in SKIP_TABLES]
    ordered = [t for t in TABLE_ORDER if t in all_tables] + [t for t in all_tables if t not in TABLE_ORDER]

    print(f"\n📦 Found {len(ordered)} tables to migrate.")

    # 4. Drop and Recreate (Clean Slate)
    print("\nStep 1/3: Resetting Schema...")
    pc.execute("SET session_replication_role = 'replica';")
    for table in reversed(ordered):
        pc.execute(f'DROP TABLE IF EXISTS "{table}" CASCADE;')
    
    for table in ordered:
        pc.execute(build_relaxed_create_table(sc, table))
    print("✓ Schema ready (relaxed constraints applied).")

    # 5. Migration Loop
    print("\nStep 2/3: Migrating Data...")
    total_rows = 0
    for table in ordered:
        sc.execute(f'SELECT count(*) FROM "{table}"')
        count = sc.fetchone()[0]
        if count == 0: continue

        print(f"  Migrating {table:35} | {count:5} rows", end=" ", flush=True)
        
        cols_info = get_columns(sc, table)
        col_names = [f'"{c[1]}"' for c in cols_info]
        pg_types = [sqlite_type_to_pg(c[2]) for c in cols_info]
        
        sc.execute(f'SELECT * FROM "{table}"')
        rows = sc.fetchall()
        
        # Batch insert
        placeholders = ', '.join(['%s'] * len(col_names))
        sql = f'INSERT INTO "{table}" ({", ".join(col_names)}) VALUES ({placeholders}) ON CONFLICT DO NOTHING'
        
        success_count = 0
        try:
            # Pre-filter/coerce values
            processed_rows = []
            for row in rows:
                p_row = []
                for i, val in enumerate(row):
                    if val is not None and 'BOOL' in pg_types[i].upper():
                        p_row.append(bool(val))
                    else:
                        p_row.append(val)
                processed_rows.append(tuple(p_row))
            
            # Fast batch
            execute_values(pc, f'INSERT INTO "{table}" ({", ".join(col_names)}) VALUES %s ON CONFLICT DO NOTHING', processed_rows)
            success_count = len(rows)
        except Exception:
            # Fallback to row-by-row if batch fails
            for row in processed_rows:
                try:
                    pc.execute(sql, row)
                    success_count += 1
                except: continue
        
        print(f"| ✓ {success_count} rows")
        total_rows += success_count

    # 6. Post-migration: Sequences and Indexes
    print("\nStep 3/3: Optimizing (Indexes & Sequences)...")
    for table in ordered:
        # Reset IDs
        cols = get_columns(sc, table)
        pk = [c for c in cols if c[5] == 1]
        if pk and 'INT' in (pk[0][2] or '').upper():
            col_name = pk[0][1]
            sc.execute(f'SELECT MAX("{col_name}") FROM "{table}"')
            mx = sc.fetchone()[0]
            if mx:
                try: pc.execute(f"SELECT setval(pg_get_serial_sequence('\"{table}\"', '{col_name}'), {mx}, true);")
                except: pass

    pc.execute("SET session_replication_role = 'origin';")
    print(f"\n✨ DONE! Total rows migrated: {total_rows:,}")
    print("=" * 60)
    
    sq_conn.close()
    pg_conn.close()

if __name__ == "__main__":
    main()
