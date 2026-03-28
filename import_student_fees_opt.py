import os
import django
import csv
from decimal import Decimal

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'school.settings')
django.setup()

from finance.models import StudentFinanceAccount, Transaction, FeeStructure, FeeCategory
from schools.models import Student, Grade
from django.db import transaction

def import_fees():
    print("Starting optimized fee import from CSV...")
    
    csv_file = 'schools_student_export.csv'
    if not os.path.exists(csv_file):
        print(f"File {csv_file} not found.")
        return

    year = "2024"
    try:
        tuition_cat = FeeCategory.objects.get(name='Tuition')
    except:
        tuition_cat = FeeCategory.objects.get(id=1)
        
    print("Loading existing data...")
    # Load all students
    all_students = {s.admission_number: s for s in Student.objects.select_related('grade').all()}
    
    # Ensure all have finance accounts
    existing_accounts = {a.student_id: a for a in StudentFinanceAccount.objects.all()}
    missing_accounts = []
    for s in all_students.values():
        if s.id not in existing_accounts:
            missing_accounts.append(StudentFinanceAccount(student=s))
    
    if missing_accounts:
        StudentFinanceAccount.objects.bulk_create(missing_accounts)
        existing_accounts = {a.student_id: a for a in StudentFinanceAccount.objects.all()}
        
    print(f"Accounts loaded: {len(existing_accounts)}")
    
    # Preload structures
    structures = {(fs.grade_id, fs.term): fs.amount for fs in FeeStructure.objects.filter(category=tuition_cat, academic_year=year)}
    
    # Process rows
    transactions_to_create = []
    accounts_to_update = []
    processed_adm = set()
    
    with open(csv_file, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            adm = row['admission_number']
            if not adm or adm in processed_adm:
                continue
                
            processed_adm.add(adm)
            
            student = all_students.get(adm)
            if not student:
                continue
                
            account = existing_accounts[student.id]
            
            terms = [
                (1, row.get('term1_fees')),
                (2, row.get('term2_fees')),
                (3, row.get('term3_fees'))
            ]
            
            new_billed = Decimal('0')
            new_paid = Decimal('0')
            
            for term_no, paid_str in terms:
                if not paid_str or paid_str == 'None':
                    paid_str = '0'
                
                paid_amt = Decimal(paid_str)
                
                # Invoice
                term_fee = structures.get((student.grade_id, term_no))
                if term_fee is None:
                    if student.grade.name in ['PG', 'PP1', 'PP2', 'G1', 'G2', 'G3']:
                        term_fee = Decimal('5500')
                    elif student.grade.name in ['G4', 'G5', 'G6']:
                        term_fee = Decimal('6500')
                    else:
                        term_fee = Decimal('0')
                        
                if term_fee > 0:
                    transactions_to_create.append(Transaction(
                        account=account,
                        type='INVOICE',
                        amount=term_fee,
                        description=f"Tuition Fee - Term {term_no} {year}",
                        term=term_no,
                        academic_year=year,
                        payment_method='SYSTEM'
                    ))
                    new_billed += term_fee
                
                if paid_amt > 0:
                    transactions_to_create.append(Transaction(
                        account=account,
                        type='PAYMENT',
                        amount=paid_amt,
                        description=f"Paid: Tuition Fee - Term {term_no} {year}",
                        term=term_no,
                        academic_year=year,
                        payment_method='CASH'
                    ))
                    new_paid += paid_amt
                    
    print(f"Prepared {len(transactions_to_create)} transactions.")
    
    with transaction.atomic():
        print("Clearing existing tuition transactions...")
        Transaction.objects.filter(description__icontains="Tuition Fee").delete()
        
        print("Bulk creating new transactions...")
        Transaction.objects.bulk_create(transactions_to_create, batch_size=500)
        
        print("Updating account balances...")
        # Since we deleted ALL tuition transactions, we need to recalculate ALL balances
        # Doing this safely but efficiently:
        # Get all transactions aggregated by account
        from django.db.models import Sum
        
        credits = dict(Transaction.objects.filter(type='PAYMENT').values_list('account_id').annotate(sum=Sum('amount')))
        debits = dict(Transaction.objects.filter(type='INVOICE').values_list('account_id').annotate(sum=Sum('amount')))
        
        for acc in existing_accounts.values():
            c_val = credits.get(acc.id) or Decimal('0')
            d_val = debits.get(acc.id) or Decimal('0')
            acc.total_paid = c_val
            acc.total_billed = d_val
            acc.balance = d_val - c_val
            
        StudentFinanceAccount.objects.bulk_update(
            existing_accounts.values(), 
            ['total_paid', 'total_billed', 'balance'], 
            batch_size=500
        )
        
    print("Done!")

if __name__ == '__main__':
    import_fees()
