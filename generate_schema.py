import os
import django
import sys
from io import StringIO
from django.core.management import call_command

# Setup Django environment
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'school.settings')
django.setup()

# Mock settings for Postgres to get Postgres SQL
from django.conf import settings
settings.DATABASES['default'] = {
    'ENGINE': 'django.db.backends.postgresql',
    'NAME': 'postgres',
    'USER': 'postgres',
    'PASSWORD': 'password',
    'HOST': 'localhost',
    'PORT': '5432',
}

def get_all_sql():
    from django.db.migrations.loader import MigrationLoader
    from django.db import connections
    
    loader = MigrationLoader(connections['default'])
    graph = loader.graph
    targets = graph.leaf_nodes()
    
    # Sort targets to ensure stable order
    targets = sorted(targets)
    
    full_sql = []
    
    # We want to go through all migrations in order
    processed = set()
    
    # Simple way: just iterate through all apps and their migrations
    for app_label in loader.migrated_apps:
        migrations = loader.disk_migrations.get(app_label, {})
        for migration_name in sorted(migrations.keys()):
            print(f"Generating SQL for {app_label} {migration_name}...", file=sys.stderr)
            out = StringIO()
            try:
                call_command('sqlmigrate', app_label, migration_name, stdout=out)
                full_sql.append(f"-- App: {app_label}, Migration: {migration_name}")
                full_sql.append(out.getvalue())
            except Exception as e:
                print(f"Error generating SQL for {app_label} {migration_name}: {e}", file=sys.stderr)
    
    return "\n".join(full_sql)

if __name__ == "__main__":
    print(get_all_sql())
