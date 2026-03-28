import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'school.settings')
django.setup()

from finance.models import FeeStructure, FeeCategory
from schools.models import Grade
from decimal import Decimal

def update_fees():
    # Targets
    group_1 = ['PG', 'PP1', 'PP2', 'G1', 'G2', 'G3']
    val_1 = 5500
    
    group_2 = ['G4', 'G5', 'G6']
    val_2 = 6500
    
    terms = [1, 2, 3]
    year = "2024"
    
    try:
        tuition_cat = FeeCategory.objects.get(name='Tuition')
    except FeeCategory.DoesNotExist:
        tuition_cat = FeeCategory.objects.get(id=1) # Fallback to first
        print(f"Using category: {tuition_cat.name}")

    def apply(group, amount):
        for g_name in group:
            try:
                grade_obj = Grade.objects.get(name=g_name)
                for t in terms:
                    fs, created = FeeStructure.objects.update_or_create(
                        grade=grade_obj,
                        term=t,
                        academic_year=year,
                        category=tuition_cat,
                        defaults={'amount': Decimal(amount)}
                    )
                    status = "Created" if created else "Updated"
                    print(f"{status}: {g_name} Term {t} -> {amount}")
            except Grade.DoesNotExist:
                print(f"Skipping: Grade {g_name} not found.")

    print("Updating Group 1 (PG-G3)...")
    apply(group_1, val_1)
    
    print("\nUpdating Group 2 (G4-G6)...")
    apply(group_2, val_2)

if __name__ == '__main__':
    update_fees()
