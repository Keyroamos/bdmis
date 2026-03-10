#!/usr/bin/env python3
import os
"""
Split supabase_migration.sql into 4 smaller files for easier execution in Supabase SQL Editor.
This avoids timeouts and the 1MB payload limit.
"""

SECTIONS = {
    'SECTION 0': '01_drop_tables.sql',
    'SECTION 1': '02_create_tables.sql',
    'SECTION 2': '03_insert_data.sql',
    'SECTION 3': '04_add_fk_constraints.sql',
    'SECTION 4': '05_create_indexes.sql',
    'SECTION 5': '06_reset_sequences.sql',
}

PREAMBLE = "SET session_replication_role = 'replica';\n\n"
POSTAMBLE = "\nSET session_replication_role = 'origin';\n"

def main():
    with open('supabase_migration.sql', encoding='utf-8') as f:
        lines = f.readlines()

    # Split into sections
    sections = {}
    current_section = 'PREAMBLE'
    sections[current_section] = []

    for line in lines:
        matched = False
        for sec_key, sec_file in SECTIONS.items():
            if f'-- {sec_key}:' in line or f'-- {sec_key} ' in line:
                current_section = sec_key
                sections.setdefault(current_section, [])
                matched = True
                break
        sections.setdefault(current_section, [])
        sections[current_section].append(line)

    # Write file 1: Drop + Create tables (always safe to run first)
    with open('migration_01_drop_and_create.sql', 'w', encoding='utf-8') as f:
        f.write('-- Step 1: Drop existing tables and recreate schema\n')
        f.write('-- Run this FIRST in Supabase SQL Editor\n\n')
        f.write(PREAMBLE)
        for sec in ['SECTION 0', 'SECTION 1']:
            if sec in sections:
                f.writelines(sections[sec])
    print('Created: migration_01_drop_and_create.sql')

    # Write file 2: Insert data (split into batches if needed)
    if 'SECTION 2' in sections:
        data_lines = sections['SECTION 2']
        # Split data section further by table
        chunks = []
        current_chunk = []
        table_count = 0
    # Create data directory
    data_dir = 'migration_data'
    if not os.path.exists(data_dir):
        os.makedirs(data_dir)

    # Write file 2: Insert data (one file per table)
    if 'SECTION 2' in sections:
        data_lines = sections['SECTION 2']
        current_table_lines = []
        current_table_name = "unknown"
        table_index = 0

        for line in data_lines:
            if line.startswith('-- ') and ' rows)' in line:
                # Save previous table if it exists
                if current_table_lines:
                    table_index += 1
                    fname = os.path.join(data_dir, f'part_{table_index:02d}_{current_table_name}.sql')
                    with open(fname, 'w', encoding='utf-8') as f:
                        f.write(PREAMBLE)
                        f.writelines(current_table_lines)
                
                # Start new table
                current_table_name = line.split('-- ')[1].split(' (')[0].strip()
                current_table_lines = [line]
            else:
                current_table_lines.append(line)

        # Save last table
        if current_table_lines:
            table_index += 1
            fname = os.path.join(data_dir, f'part_{table_index:02d}_{current_table_name}.sql')
            with open(fname, 'w', encoding='utf-8') as f:
                f.write(PREAMBLE)
                f.writelines(current_table_lines)

    print(f'Created {table_index} table data files in the "migration_data" folder.')

    # Write file 3: FK constraints + indexes + sequences
    with open('migration_03_constraints_and_indexes.sql', 'w', encoding='utf-8') as f:
        f.write('-- Step 3: Add FK constraints, indexes, and reset sequences\n')
        f.write('-- Run this LAST after all data is inserted\n\n')
        f.write(PREAMBLE)
        for sec in ['SECTION 3', 'SECTION 4', 'SECTION 5']:
            if sec in sections:
                f.writelines(sections[sec])
        f.write(POSTAMBLE)
    print('Created: migration_03_constraints_and_indexes.sql')

    print('\nRun order in Supabase SQL Editor:')
    print('  1. migration_01_drop_and_create.sql')
    print('  2. migration_02_data_part1.sql, migration_02_data_part2.sql, ...')
    print('  3. migration_03_constraints_and_indexes.sql')

if __name__ == '__main__':
    main()
