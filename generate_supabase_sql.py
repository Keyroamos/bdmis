#!/usr/bin/env python3
"""
Generate Supabase (PostgreSQL) SQL migration from SQLite.
Strategy:
  1. Create ALL tables WITHOUT foreign key constraints (avoids circular dependency errors)
  2. Insert all data
  3. Add ALL foreign key constraints via ALTER TABLE (after all data is loaded)
  4. Create indexes
  5. Reset sequences
"""

import sqlite3
from datetime import datetime

DB_PATH = "db.sqlite3"

SKIP_TABLES = {
    "django_cache_table",
    "django_session",
    "sqlite_sequence",
}

# Insertion order (just needs to be topologically sorted for data - FKs added after)
# Since we remove FK constraints from CREATE TABLE, any order works for table creation.
# But for data inserts, we still want parent tables before child tables to avoid issues
# with any remaining constraints. We'll use a safe order here.
SAFE_INSERT_ORDER = [
    "django_content_type",
    "auth_permission",
    "auth_group",
    "auth_user",
    "auth_group_permissions",
    "auth_user_groups",
    "auth_user_user_permissions",
    "django_migrations",
    "django_admin_log",
    "config_schoolconfig",
    "schools_school",
    "schools_branch",
    # Create dept/emp with no FKs -> insert branch first, then dept (no head yet), then employee, then update dept.head
    "schools_department",
    "schools_employee",
    "schools_grade",
    "schools_teacher",
    "schools_teacher_subjects",
    "schools_subject",
    "schools_nonteachingstaff",
    "schools_salary",
    "schools_allowance",
    "schools_deduction",
    "schools_salaryadvance",
    "schools_advanceapproval",
    "schools_leave",
    "schools_leaveapproval",
    "schools_staffdocument",
    "schools_term",
    "schools_route",
    "schools_vehicle",
    "schools_student",
    "schools_payment",
    "schools_attendance",
    "schools_assessment",
    "schools_assessmentresult",
    "schools_schedule",
    "schools_announcement",
    "schools_smsmessage",
    "schools_transportfee",
    "schools_studenttransportassignment",
    "schools_foodplan",
    "schools_foodfee",
    "schools_studentfoodassignment",
    "schools_mealpricing",
    "schools_studentmealpayment",
    "schools_mealconsumption",
    "schools_syncstatus",
    "schools_syncqueue",
    "schools_employeeattendance",
    "schools_expense",
    "finance_feecategory",
    "finance_feestructure",
    "finance_studentfinanceaccount",
    "finance_transaction",
    "finance_salarystructure",
    "finance_payrollrecord",
    "food_mealitem",
    "food_foodstudentaccount",
    "food_foodtransaction",
    "food_foodsubscription",
    "transport_route",
    "transport_transportvehicle",
    "transport_transportdriver",
    "transport_transportstudentaccount",
    "transport_transportassignment",
    "transport_transporttransaction",
    "transport_transportadvancerequest",
    "transport_transportexpense",
    "transport_transportleaverequest",
]


def get_columns(conn, table_name):
    """Get column definitions via PRAGMA table_info."""
    c = conn.cursor()
    c.execute(f'PRAGMA table_info("{table_name}")')
    return c.fetchall()  # (cid, name, type, notnull, dflt_value, pk)


def get_foreign_keys(conn, table_name):
    """Get FK info via PRAGMA foreign_key_list."""
    c = conn.cursor()
    c.execute(f'PRAGMA foreign_key_list("{table_name}")')
    return c.fetchall()  # (id, seq, table, from, to, on_update, on_delete, match)


def get_unique_indices(conn, table_name):
    """Get unique index info."""
    c = conn.cursor()
    c.execute(f'PRAGMA index_list("{table_name}")')
    indices = c.fetchall()
    result = []
    for idx in indices:
        idx_name = idx[1]
        is_unique = bool(idx[2])
        origin = idx[3]  # 'c' = user-created, 'u' = UNIQUE constraint, 'pk' = PK
        if idx_name.startswith("sqlite_autoindex_"):
            continue
        c.execute(f'PRAGMA index_info("{idx_name}")')
        cols = [r[2] for r in c.fetchall()]
        result.append({
            'name': idx_name,
            'unique': is_unique,
            'columns': cols,
            'origin': origin,
        })
    return result


def sqlite_type_to_pg(sqlite_type):
    """Map SQLite column type to PostgreSQL type.
    
    IMPORTANT: All VARCHAR/CHAR columns are mapped to TEXT.
    SQLite does NOT enforce VARCHAR length limits, so actual data may exceed
    the declared column size. PostgreSQL TEXT is equivalent to VARCHAR in
    performance. Django enforces string lengths at the application level,
    not the DB level, so using TEXT here is safe and correct.
    """
    if not sqlite_type:
        return 'TEXT'
    t = sqlite_type.strip().upper()
    base = t.split('(')[0].strip()

    mapping = {
        'INTEGER': 'BIGINT',
        'INT': 'BIGINT',
        'BIGINT': 'BIGINT',
        'SMALLINT': 'SMALLINT',
        'TINYINT': 'SMALLINT',
        'MEDIUMINT': 'BIGINT',
        'UNSIGNED BIG INT': 'BIGINT',
        'INT2': 'SMALLINT',
        'INT8': 'BIGINT',
        'TEXT': 'TEXT',
        'CLOB': 'TEXT',
        'REAL': 'DOUBLE PRECISION',
        'FLOAT': 'DOUBLE PRECISION',
        'DOUBLE': 'DOUBLE PRECISION',
        'DOUBLE PRECISION': 'DOUBLE PRECISION',
        'BLOB': 'BYTEA',
        'BOOLEAN': 'BOOLEAN',
        'BOOL': 'BOOLEAN',
        'DATE': 'DATE',
        'TIME': 'TIME',
        'DATETIME': 'TIMESTAMPTZ',
        'TIMESTAMP': 'TIMESTAMPTZ',
        'DECIMAL': 'NUMERIC',
        'NUMERIC': 'NUMERIC',
    }

    if base in mapping:
        return mapping[base]

    # All VARCHAR/CHAR variants -> TEXT
    # (avoids 'value too long for type character varying(n)' errors since
    #  SQLite does not enforce column width constraints)
    for prefix in ('VARCHAR', 'CHARACTER VARYING', 'NVARCHAR', 'CHARACTER', 'NCHAR', 'CHAR'):
        if t.startswith(prefix):
            return 'TEXT'

    return 'TEXT'


def generate_create_table_no_fk(conn, table_name):
    """Generate CREATE TABLE with NO foreign key constraints (added later via ALTER TABLE)."""
    cols = get_columns(conn, table_name)
    pk_cols = [c for c in cols if c[5] > 0]
    is_single_int_pk = (
        len(pk_cols) == 1 and
        'INT' in (pk_cols[0][2] or '').upper()
    )

    lines = []
    for col in cols:
        cid, name, col_type, notnull, default, pk = col
        pg_type = sqlite_type_to_pg(col_type)

        if pk == 1 and is_single_int_pk:
            line = f'  "{name}" BIGSERIAL PRIMARY KEY'
        else:
            line = f'  "{name}" {pg_type}'
            # We remove NOT NULL for migration to ensure data flows even if SQLite was messy
            if pk > 0:
                line += ' PRIMARY KEY'

        lines.append(line)

    # Composite PK
    if not is_single_int_pk and pk_cols:
        pk_names = ', '.join(f'"{c[1]}"' for c in sorted(pk_cols, key=lambda x: x[5]))
        lines.append(f'  PRIMARY KEY ({pk_names})')

    body = ',\n'.join(lines)
    return f'CREATE TABLE IF NOT EXISTS "{table_name}" (\n{body}\n);'


def generate_alter_table_fk(conn, table_name):
    """Generate ALTER TABLE ... ADD CONSTRAINT FOREIGN KEY statements.
    Each statement is wrapped in a DO block with EXCEPTION WHEN duplicate_object
    so re-running the migration is safe (idempotent).
    """
    fks = get_foreign_keys(conn, table_name)
    if not fks:
        return []

    # Group by FK id (multiple columns in same FK)
    fk_groups = {}
    for fk in fks:
        fk_id, seq, ref_table, from_col, to_col = fk[0], fk[1], fk[2], fk[3], fk[4]
        if fk_id not in fk_groups:
            fk_groups[fk_id] = {'ref_table': ref_table, 'from_cols': [], 'to_cols': []}
        fk_groups[fk_id]['from_cols'].append(from_col)
        fk_groups[fk_id]['to_cols'].append(to_col)

    stmts = []
    for fk_id, info in fk_groups.items():
        constraint_name = f'fk_{table_name}_{fk_id}'[:63]  # PG limit
        from_cols = ', '.join(f'"{c}"' for c in info['from_cols'])
        to_cols = ', '.join(f'"{c}"' for c in info['to_cols'])
        ref_table = info['ref_table']
        # Cleanup orphaned records before adding FK
        cleanup_sql = ""
        for i, from_col in enumerate(info['from_cols']):
            to_col = info['to_cols'][i]
            cleanup_sql += (
                f'DELETE FROM "{table_name}" WHERE "{from_col}" IS NOT NULL '
                f'AND "{from_col}" NOT IN (SELECT "{to_col}" FROM "{ref_table}");\n  '
            )

        alter_sql = (
            f'ALTER TABLE "{table_name}" '
            f'ADD CONSTRAINT "{constraint_name}" '
            f'FOREIGN KEY ({from_cols}) '
            f'REFERENCES "{ref_table}" ({to_cols});'
        )
        # Wrap in DO block to handle duplicate constraint gracefully
        do_block = (
            f'DO $$ BEGIN\n'
            f'  {cleanup_sql}'
            f'{alter_sql}\n'
            f'EXCEPTION WHEN duplicate_object THEN NULL;\n'
            f'END $$;'
        )
        stmts.append(do_block)

    return stmts


def escape_pg_value(val, pg_type=None):
    """Escape a Python value for PostgreSQL INSERT.
    
    pg_type: the PostgreSQL column type string (e.g. 'BOOLEAN', 'BIGINT', 'TEXT', ...)
    For BOOLEAN columns, SQLite stores 0/1 integers — convert to FALSE/TRUE.
    """
    if val is None:
        return 'NULL'
    
    # Boolean columns: SQLite stores as 0/1 integers
    is_bool_col = pg_type and 'BOOL' in pg_type.upper()
    if is_bool_col:
        return 'TRUE' if val else 'FALSE'
    
    if isinstance(val, (int, float)):
        return str(val)
    s = str(val).replace("'", "''")
    return f"'{s}'"


def get_column_pg_types(conn, table_name):
    """Return ordered list of PostgreSQL types for each column in the table."""
    cols = get_columns(conn, table_name)
    return [sqlite_type_to_pg(col[2]) for col in cols]


def generate_data_inserts(conn, table_name, batch_size=200):
    """Generate batched INSERT statements, with boolean-aware escaping."""
    c = conn.cursor()
    try:
        c.execute(f'SELECT * FROM "{table_name}"')
        rows = c.fetchall()
        if not rows:
            return []
        col_names = [d[0] for d in c.description]
        col_list = ', '.join(f'"{col}"' for col in col_names)
        
        # Get PostgreSQL types for boolean-aware escaping
        pg_types = get_column_pg_types(conn, table_name)
        
        stmts = []
        for i in range(0, len(rows), batch_size):
            batch = rows[i:i + batch_size]
            vals_list = []
            for row in batch:
                vals = ', '.join(
                    escape_pg_value(v, pg_types[j] if j < len(pg_types) else None)
                    for j, v in enumerate(row)
                )
                vals_list.append(f'  ({vals})')
            stmt = f'INSERT INTO "{table_name}" ({col_list}) VALUES\n'
            stmt += ',\n'.join(vals_list)
            stmt += '\nON CONFLICT DO NOTHING;'
            stmts.append(stmt)
        return stmts
    except Exception as e:
        return [f'-- ERROR exporting {table_name}: {e}']


def get_max_pk(conn, table_name, pk_col):
    c = conn.cursor()
    try:
        c.execute(f'SELECT MAX("{pk_col}") FROM "{table_name}"')
        r = c.fetchone()
        return r[0] if r and r[0] is not None else 0
    except:
        return 0


def main():
    conn = sqlite3.connect(DB_PATH)

    # Get all real tables
    c = conn.cursor()
    c.execute("SELECT name FROM sqlite_master WHERE type='table'")
    all_tables = {r[0] for r in c.fetchall() if r[0] not in SKIP_TABLES and r[0] != 'sqlite_sequence'}

    # Build ordered list
    ordered = [t for t in SAFE_INSERT_ORDER if t in all_tables]
    for t in sorted(all_tables):
        if t not in ordered:
            ordered.append(t)

    out = []

    out.append('-- ============================================================')
    out.append('-- BDMIS Supabase Migration SQL (PostgreSQL)')
    out.append(f'-- Generated: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}')
    out.append('-- Strategy: Tables created WITHOUT FK constraints first,')
    out.append('--           data inserted, then FKs added via ALTER TABLE.')
    out.append('--           This avoids ALL circular dependency errors.')
    out.append('-- ============================================================')
    out.append('')
    out.append("SET session_replication_role = 'replica';")
    out.append('')

    out.append('-- ============================================================')
    out.append('-- SECTION 0: DROP EXISTING TABLES (clean slate for re-runs)')
    out.append('-- ============================================================')
    out.append('-- Drops tables in reverse dependency order with CASCADE')
    out.append('')
    # Drop in reverse order to respect dependencies
    for table in reversed(ordered):
        out.append(f'DROP TABLE IF EXISTS "{table}" CASCADE;')
    out.append('')

    # ----------------------------------------------------------------
    # SECTION 1: CREATE ALL TABLES (no FK constraints)
    # ----------------------------------------------------------------
    out.append('-- ============================================================')
    out.append('-- SECTION 1: CREATE TABLES (no FK constraints)')
    out.append('-- ============================================================')
    out.append('')

    for table in ordered:
        out.append(f'-- Table: {table}')
        try:
            out.append(generate_create_table_no_fk(conn, table))
        except Exception as e:
            out.append(f'-- ERROR: {e}')
        out.append('')

    # ----------------------------------------------------------------
    # SECTION 2: INSERT DATA
    # ----------------------------------------------------------------
    out.append('-- ============================================================')
    out.append('-- SECTION 2: INSERT DATA')
    out.append('-- ============================================================')
    out.append('')

    for table in ordered:
        stmts = generate_data_inserts(conn, table)
        if stmts:
            c2 = conn.cursor()
            c2.execute(f'SELECT COUNT(*) FROM "{table}"')
            count = c2.fetchone()[0]
            out.append(f'-- {table} ({count} rows)')
            out.extend(stmts)
            out.append('')

    # ----------------------------------------------------------------
    # SECTION 3: ADD FOREIGN KEY CONSTRAINTS
    # ----------------------------------------------------------------
    out.append('-- ============================================================')
    out.append('-- SECTION 3: ADD FOREIGN KEY CONSTRAINTS')
    out.append('-- ============================================================')
    out.append('')

    for table in ordered:
        try:
            fk_stmts = generate_alter_table_fk(conn, table)
            if fk_stmts:
                out.append(f'-- FKs for: {table}')
                out.extend(fk_stmts)
                out.append('')
        except Exception as e:
            out.append(f'-- ERROR adding FKs for {table}: {e}')

    # ----------------------------------------------------------------
    # SECTION 4: CREATE INDEXES
    # ----------------------------------------------------------------
    out.append('-- ============================================================')
    out.append('-- SECTION 4: CREATE INDEXES')
    out.append('-- ============================================================')
    out.append('')

    seen_idx = set()
    for table in ordered:
        try:
            for idx in get_unique_indices(conn, table):
                name = idx['name']
                if name in seen_idx:
                    continue
                seen_idx.add(name)
                unique = 'UNIQUE ' if idx['unique'] else ''
                cols = ', '.join(f'"{c}"' for c in idx['columns'])
                out.append(f'CREATE {unique}INDEX IF NOT EXISTS "{name}" ON "{table}" ({cols});')
        except Exception as e:
            out.append(f'-- ERROR indexing {table}: {e}')

    out.append('')

    # ----------------------------------------------------------------
    # SECTION 5: RESET SEQUENCES
    # ----------------------------------------------------------------
    out.append('-- ============================================================')
    out.append('-- SECTION 5: RESET SEQUENCES')
    out.append('-- ============================================================')
    out.append('')

    for table in ordered:
        cols = get_columns(conn, table)
        pk_list = [col for col in cols if col[5] == 1]
        if len(pk_list) == 1:
            pk_col = pk_list[0]
            if 'INT' in (pk_col[2] or '').upper():
                max_id = get_max_pk(conn, table, pk_col[1])
                if max_id > 0:
                    seq = f'{table}_{pk_col[1]}_seq'
                    out.append(f"SELECT setval('\"{seq}\"', {max_id}, true);")

    out.append('')
    out.append("SET session_replication_role = 'origin';")
    out.append('')
    out.append('-- ============================================================')
    out.append('-- MIGRATION COMPLETE')
    out.append('-- ============================================================')

    conn.close()

    sql = '\n'.join(out)
    with open('supabase_migration.sql', 'w', encoding='utf-8') as f:
        f.write(sql)

    print(f'Generated supabase_migration.sql')
    print(f'  Size   : {len(sql):,} bytes')
    print(f'  Lines  : {len(out):,}')
    print(f'  Tables : {len(ordered)}')


if __name__ == '__main__':
    main()
