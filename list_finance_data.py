import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'school.settings')
django.setup()

from finance.models import FeeCategory, FeeStructure
from schools.models import Grade

def list_data():
    print("Categories:")
    for c in FeeCategory.objects.all():
        print(f" {c.id}: {c.name}")
        
    print("\nGrades:")
    for g in Grade.objects.all():
        print(f" {g.id}: {g.name}")

if __name__ == '__main__':
    list_data()
