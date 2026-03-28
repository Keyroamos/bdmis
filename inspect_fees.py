import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'school.settings')
django.setup()

from finance.models import FeeStructure

def inspect_structures():
    structures = FeeStructure.objects.all()[:10]
    for fs in structures:
        print(f"ID: {fs.id}, Grade: {fs.grade.name}, Term: {fs.term}, Year: {fs.academic_year}, Category: {fs.category.name}, Amount: {fs.amount}")

if __name__ == '__main__':
    inspect_structures()
