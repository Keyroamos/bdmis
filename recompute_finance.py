import os
import django
from django.db.models import Sum
from decimal import Decimal

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'school.settings')
django.setup()

from schools.models import Student
from finance.models import StudentFinanceAccount, Transaction

def sync_finance_data():
    print("Starting optimized finance data synchronization...")
    
    # 1. Ensure every student has an account
    print("Fetching students...")
    students = Student.objects.all()
    print(f"Ensuring accounts for {len(students)} students...")
    
    # Create all missing accounts in bulk
    existing_acc_st_ids = set(StudentFinanceAccount.objects.values_list('student_id', flat=True))
    missing_accs = [
        StudentFinanceAccount(student_id=s.id) 
        for s in students if s.id not in existing_acc_st_ids
    ]
    if missing_accs:
        StudentFinanceAccount.objects.bulk_create(missing_accs)
        print(f"Created {len(missing_accs)} missing accounts.")
    else:
        print("All students already have accounts.")

    # 2. Recalculate totals in bulk
    print("Recalculating account totals...")
    all_accounts = StudentFinanceAccount.objects.all()
    
    # Batch process for performance
    count = 0
    total = len(all_accounts)
    
    for acc in all_accounts:
        # Sum of Invoices (Debt)
        billed = Transaction.objects.filter(account=acc, type='INVOICE').aggregate(Sum('amount'))['amount__sum'] or Decimal('0.00')
        # Sum of Payments (Credit)
        paid = Transaction.objects.filter(account=acc, type='PAYMENT').aggregate(Sum('amount'))['amount__sum'] or Decimal('0.00')
        
        acc.total_billed = billed
        acc.total_paid = paid
        acc.balance = billed - paid
        acc.last_updated = django.utils.timezone.now()
        
        # We'll save individually for now to simplify, or use update() directly for speed
        # Actually save() is safe enough if connection holds.
        acc.save()
        count += 1
        if count % 50 == 0:
            print(f"Processed {count}/{total} accounts...")
            
    # 3. Final Verification
    total_billed = StudentFinanceAccount.objects.aggregate(Sum('total_billed'))['total_billed__sum'] or 0
    total_paid = StudentFinanceAccount.objects.aggregate(Sum('total_paid'))['total_paid__sum'] or 0
    print(f"System Totals - Billed: {total_billed}, Paid: {total_paid}")

if __name__ == '__main__':
    sync_finance_data()
