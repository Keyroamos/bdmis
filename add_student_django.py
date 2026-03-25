import os
import sys
import django
import random
from datetime import datetime, date

# Set up Django environment
sys.path.append('.')
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'school.settings')
django.setup()

from schools.models import Student, Grade

def add_student():
    # Find next admission number
    # We'll use the same logic as config.generate_admission_number if possible, 
    # but let's implement a simple numeric one for now
    import re
    students = Student.objects.all()
    max_adm = 0
    for s in students:
        match = re.search(r'(\d+)', str(s.admission_number))
        if match:
            try:
                num = int(match.group(1))
                if num > max_adm:
                    max_adm = num
            except ValueError:
                continue
    
    next_num = max_adm + 1
    if next_num < 7000:
        next_num = 7731 # Start from a reasonable point if list is empty or small
        
    # Get random grade
    grades = list(Grade.objects.filter(term1_fees__gt=0))
    if not grades:
        print("No grades with fees found.")
        return
    grade = random.choice(grades)
    
    # Random data
    first_names = ["James", "Mary", "John", "Patricia", "Robert", "Jennifer", "Michael", "Linda"]
    last_names = ["Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis"]
    
    first_name = random.choice(first_names)
    last_name = random.choice(last_names)
    gender = random.choice(['M', 'F'])
    
    # Birth date
    year = 2026 - random.randint(5, 12)
    dob = date(year, random.randint(1, 12), random.randint(1, 28))
    
    student = Student.objects.create(
        admission_number=str(next_num),
        first_name=first_name,
        last_name=last_name,
        date_of_birth=dob,
        gender=gender,
        parent_name=f"{last_name} Parent",
        parent_phone=f"+25470000{random.randint(100, 999)}",
        parent_email=f"{first_name.lower()}@example.com",
        parent_occupation="Business",
        parent_id_number="12345678",
        academic_year="2026",
        grade=grade,
        current_term=1,
        term_fees=grade.term1_fees,
        term1_fees=grade.term1_fees,
        term2_fees=grade.term2_fees,
        term3_fees=grade.term3_fees,
        location=random.choice(['MAIN', 'ANNEX'])
    )
    
    print(f"Successfully added student: {student.first_name} {student.last_name} (ADM: {student.admission_number}) to Grade {grade.name} in {os.environ.get('DJANGO_SETTINGS_MODULE')}")

if __name__ == "__main__":
    add_student()
