import os
import django
import csv
from decimal import Decimal

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'school.settings')
django.setup()

from finance.models import StudentFinanceAccount, Transaction, FeeStructure, FeeCategory
from schools.models import Student, Grade

def import_fees():
    print("Starting fee import from CSV...")
    
    csv_file = 'schools_student_export.csv'
    if not os.path.exists(csv_file):
        print(f"File {csv_file} not found.")
        return

    # Cache category and year
    year = "2024"
    try:
        tuition_cat = FeeCategory.objects.get(name='Tuition')
    except:
        tuition_cat = FeeCategory.objects.get(id=1)
        
    with open(csv_file, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        count = 0
        for row in reader:
            adm = row['admission_number']
            if not adm:
                continue
                
            try:
                student = Student.objects.get(admission_number=adm)
                # Ensure Finance Account exists
                account, _ = StudentFinanceAccount.objects.get_or_create(student=student)
                
                # Clear existing tuition transactions for this student to avoid double counting
                # (Optional, but safer for re-running)
                account.transactions.filter(description__icontains="Tuition").delete()

                # Terms to process
                terms = [
                    (1, row.get('term1_fees')),
                    (2, row.get('term2_fees')),
                    (3, row.get('term3_fees'))
                ]
                
                for term_no, paid_str in terms:
                    if not paid_str or paid_str == 'None':
                        paid_str = '0'
                    
                    paid_amt = Decimal(paid_str)
                    
                    # 1. Create Invoice for the full Term Fee
                    try:
                        structure = FeeStructure.objects.get(
                            grade=student.grade, 
                            term=term_no, 
                            academic_year=year,
                            category=tuition_cat
                        )
                        term_fee = structure.amount
                    except FeeStructure.DoesNotExist:
                        # Fallback to group values if not found (PG-G3: 5500, G4-G6: 6500)
                        if student.grade.name in ['PG', 'PP1', 'PP2', 'G1', 'G2', 'G3']:
                            term_fee = Decimal('5500')
                        elif student.grade.name in ['G4', 'G5', 'G6']:
                            term_fee = Decimal('6500')
                        else:
                            term_fee = Decimal('0')
                    
                    # Record Invoice (Billed)
                    if term_fee > 0:
                        Transaction.objects.create(
                            account=account,
                            type='INVOICE',
                            amount=term_fee,
                            description=f"Tuition Fee - Term {term_no} {year}",
                            term=term_no,
                            academic_year=year,
                            payment_method='SYSTEM'
                        )
                    
                    # Record Payment (if any)
                    if paid_amt > 0:
                        Transaction.objects.create(
                            account=account,
                            type='PAYMENT',
                            amount=paid_amt,
                            description=f"Paid: Tuition Fee - Term {term_no} {year}",
                            term=term_no,
                            academic_year=year,
                            payment_method='CASH' # Assumption
                        )
                
                # Calculate and update account balance
                account.update_balance()
                count += 1
                if count % 10 == 0:
                    print(f"Processed {count} students...")
                    
            except Student.DoesNotExist:
                print(f"Skipping: Student adm {adm} not found in DB.")
            except Exception as e:
                print(f"Error processing adm {adm}: {str(e)}")

    print(f"\nImport completed! Total students updated: {count}")

if __name__ == '__main__':
    import_fees()
