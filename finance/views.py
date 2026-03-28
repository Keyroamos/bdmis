from django.shortcuts import render, get_object_or_404
from django.http import JsonResponse, HttpResponse
from django.views.decorators.http import require_http_methods
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.decorators import login_required
from django.db.models import Sum, Q, Count, Value, DecimalField
from django.db.models.functions import TruncMonth, TruncDate, Coalesce
from django.utils import timezone
import datetime
import json
import logging
import traceback

logger = logging.getLogger(__name__)

from .models import StudentFinanceAccount, Transaction, FeeStructure
from schools.models import Student, Payment, Expense, TransportFee, FoodFee, StudentMealPayment
from transport.models import TransportExpense, TransportTransaction, TransportStudentAccount, Route, TransportAssignment
from food.models import FoodTransaction, FoodStudentAccount, MealItem, FoodSubscription

@login_required
def api_finance_dashboard(request):
    try:
        
        # 1. Income Breakdown
        # -------------------
        # Fees Income (General Tuition/Fees)
        # We aggregate from both the new Transaction model and the legacy schools.Payment model
        fees_income_modern = Transaction.objects.filter(type='PAYMENT').aggregate(sum=Sum('amount'))['sum'] or 0
        fees_income_legacy = Payment.objects.filter(status='COMPLETED').aggregate(sum=Sum('amount'))['sum'] or 0
        total_fees_income = float(fees_income_modern) + float(fees_income_legacy)
        
        # Transport Income
        # We check both TransportFee (Legacy/Schools model) and TransportTransaction (Transport app model)
        transport_income_tx = TransportTransaction.objects.filter(type='PAYMENT').aggregate(sum=Sum('amount'))['sum'] or 0
        transport_income_fee = TransportFee.objects.filter(status='COMPLETED').aggregate(sum=Sum('amount'))['sum'] or 0
        total_transport_income = float(transport_income_tx) + float(transport_income_fee)
        
        # Food Income
        # Include legacy models and the new food app transactions
        from food.models import FoodTransaction
        food_income_fee = FoodFee.objects.filter(status='COMPLETED').aggregate(sum=Sum('amount'))['sum'] or 0
        food_income_meal = StudentMealPayment.objects.filter(status='COMPLETED').aggregate(sum=Sum('amount'))['sum'] or 0
        food_income_modern = FoodTransaction.objects.filter(type='PAYMENT').aggregate(sum=Sum('amount'))['sum'] or 0
        
        total_food_income = float(food_income_fee) + float(food_income_meal) + float(food_income_modern)
        
        # Total Realized Revenue (Total Cash Collected)
        collected = total_fees_income + total_transport_income + total_food_income
        
        # Arrears & Expected (Mainly from Fees Account)
        total_billed = StudentFinanceAccount.objects.aggregate(sum=Sum('total_billed'))['sum'] or 0
        outstanding = StudentFinanceAccount.objects.filter(balance__gt=0).aggregate(sum=Sum('balance'))['sum'] or 0
        
        # 2. Expenses Breakdown
        # ---------------------
        transport_expenses = TransportExpense.objects.filter(status='APPROVED').aggregate(sum=Sum('amount'))['sum'] or 0
        salary_expenses = Expense.objects.filter(category='salaries').aggregate(sum=Sum('amount'))['sum'] or 0
        food_expenses = Expense.objects.filter(category='food').aggregate(sum=Sum('amount'))['sum'] or 0
        other_expenses = Expense.objects.exclude(category__in=['salaries', 'food', 'transport']).aggregate(sum=Sum('amount'))['sum'] or 0
        
        total_expenses = float(transport_expenses) + float(salary_expenses) + float(food_expenses) + float(other_expenses)
        
        # Net Profit/Balance
        net_profit = collected - total_expenses
        
        # KPIs
        # Aggregate from all financial modules for total expected
        total_fees_expected = float(total_billed) # Start with general fees
        
        transport_expected = TransportStudentAccount.objects.aggregate(
            sum=Coalesce(Sum('total_billed'), Value(0), output_field=DecimalField())
        )['sum'] or 0
        
        food_expected = FoodStudentAccount.objects.aggregate(
            sum=Coalesce(Sum('total_billed'), Value(0), output_field=DecimalField())
        )['sum'] or 0

        total_fees_expected += float(transport_expected) + float(food_expected)
        
        # Recalculate collection rate and outstanding with complete data
        # 'collected' is the total income from all sources
        outstanding = float(total_fees_expected) - collected
        collection_rate = (collected / total_fees_expected * 100) if total_fees_expected > 0 else 0
        
        # Runway (Monthly Burn Proxy)
        # Using avg expenses over known records, or fallback to fixed division
        burn_rate = total_expenses / 3 if total_expenses > 0 else 1 
        runway = round(collected / burn_rate, 1) if burn_rate > 0 else 0
        total_students = Student.objects.count()

        # 3. Chart Data (Monthly Trend)
        # -----------------------------
        six_months_ago = timezone.now() - datetime.timedelta(days=180)
        
        # Unified Revenue Trend (Fees + Transport + Food)
        monthly_fees = Transaction.objects.filter(type='PAYMENT', date__gte=six_months_ago)\
            .annotate(month=TruncMonth('date'))\
            .values('month').annotate(total=Sum('amount'))
            
        monthly_transport = TransportTransaction.objects.filter(type='PAYMENT', date__gte=six_months_ago)\
            .annotate(month=TruncMonth('date'))\
            .values('month').annotate(total=Sum('amount'))

        monthly_exp = Expense.objects.filter(date__gte=six_months_ago)\
            .annotate(month=TruncMonth('date'))\
            .values('month').annotate(total=Sum('amount'))

        monthly_food = FoodTransaction.objects.filter(type='PAYMENT', date__gte=six_months_ago)\
            .annotate(month=TruncMonth('date'))\
            .values('month').annotate(total=Sum('amount'))
        
        chart_data_map = {}
        def add_to_chart(qs, key):
            for item in qs:
                m_key = item['month'].strftime('%b')
                if m_key not in chart_data_map:
                    chart_data_map[m_key] = {'month': m_key, 'revenue': 0, 'expenses': 0}
                chart_data_map[m_key][key] += float(item['total'])

        add_to_chart(monthly_fees, 'revenue')
        add_to_chart(monthly_transport, 'revenue')
        add_to_chart(monthly_food, 'revenue')
        add_to_chart(monthly_exp, 'expenses')
        
        chart_data = sorted(list(chart_data_map.values()), key=lambda x: datetime.datetime.strptime(x['month'], '%b'))

        # 4. Recent Ledgers
        # -----------------
        recent_collections = Transaction.objects.filter(type='PAYMENT').select_related('account__student').order_by('-date')[:15]
        tx_data = [{
            'id': tx.id,
            'student': tx.account.student.get_full_name(),
            'amount': float(tx.amount),
            'date': tx.date.strftime('%Y-%m-%d'),
            'method': tx.payment_method,
            'reference': tx.reference or f"FEE-{tx.id}"
        } for tx in recent_collections]

        recent_expenses = Expense.objects.order_by('-date')[:15]
        exp_data = [{
            'id': ex.id,
            'title': ex.title,
            'amount': float(ex.amount),
            'category': ex.category,
            'date': ex.date.strftime('%Y-%m-%d'),
            'method': ex.payment_method
        } for ex in recent_expenses]

        return JsonResponse({
            'debug_counts': {
                'payment_count': Transaction.objects.filter(type='PAYMENT').count(),
                'legacy_payment_count': Payment.objects.filter(status='COMPLETED').count(),
                'student_count': Student.objects.count(),
                'account_count': StudentFinanceAccount.objects.count(),
                'billed_account_count': StudentFinanceAccount.objects.filter(total_billed__gt=0).count(),
            },
            'summary': {
                'total_revenue': collected,
                'fees_income': total_fees_income,
                'transport_income': total_transport_income,
                'food_income': total_food_income,
                'total_expenses': total_expenses,
                'net_profit': net_profit,
                'total_billed': float(total_billed),
                'outstanding': float(outstanding),
                'total_students': total_students,
                'expected_fees': total_fees_expected,
                'fees_arrears': outstanding,
                'collection_rate': collection_rate,
                'runway': runway,
                'expense_breakdown': {
                    'salaries': float(salary_expenses),
                    'transport': float(transport_expenses),
                    'food': float(food_expenses),
                    'other': float(other_expenses)
                }
            },
            'chart_data': chart_data,
            'recent_collections': tx_data,
            'recent_expenses': exp_data
        })
    except Exception as e:
        logger.error(f"Error in api_finance_dashboard: {str(e)}\n{traceback.format_exc()}")
        return JsonResponse({'error': str(e)}, status=500)

from .models import SalaryStructure, PayrollRecord
from django.contrib.auth.models import User

@login_required
def api_fee_structures(request):
    try:
        structures = FeeStructure.objects.select_related('grade', 'category').all().order_by('grade__name', 'term')
        data = []
        for fs in structures:
            data.append({
                'id': fs.id,
                'grade': fs.grade.name,
                'term': fs.term,
                'category': fs.category.name,
                'amount': float(fs.amount),
                'mandatory': fs.is_mandatory,
                'year': fs.academic_year
            })
        return JsonResponse({'fee_structures': data})
    except Exception as e:
        logger.error(f"Error in api_fee_structures: {str(e)}\n{traceback.format_exc()}")
        return JsonResponse({'error': str(e)}, status=500)

@csrf_exempt
@login_required
def api_update_fee_structure(request):
    if request.method == 'POST':
        try:
            from django.db.models import Sum
            data = json.loads(request.body)
            updates = data.get('updates', [])
            
            # Track which Grade/Term/Year combinations were touched
            affected_cohorts = set() # (grade_id, term, academic_year)

            for update in updates:
                fs_id = update.get('id')
                amount = update.get('amount')
                if fs_id and amount is not None:
                    fs = FeeStructure.objects.get(id=fs_id)
                    fs.amount = amount
                    fs.save()
                    affected_cohorts.add((fs.grade_id, fs.term, fs.academic_year))
            
            # Recalculate everything for affected cohorts
            invoice_count = 0
            student_count = 0
            for grade_id, term, year in affected_cohorts:
                # 1. Calculate new total for mandatory fees in this cohort
                mandatory_total = FeeStructure.objects.filter(
                    grade_id=grade_id, 
                    term=term, 
                    academic_year=year,
                    is_mandatory=True
                ).aggregate(total=Sum('amount'))['total'] or 0
                
                # 2. Update Grade model
                from schools.models import Grade, Student
                grade = Grade.objects.get(id=grade_id)
                if term == 1: 
                    grade.term1_fees = mandatory_total
                    # Also update the legacy term_fees field to match Term 1 as a baseline
                    grade.term_fees = mandatory_total 
                elif term == 2: 
                    grade.term2_fees = mandatory_total
                elif term == 3: 
                    grade.term3_fees = mandatory_total
                
                # If we are updating the current term, update the legacy field too
                # This helps with views that still use 'term_fees'
                grade.save()

                # 3. Update all Students in this grade
                students = Student.objects.filter(grade_id=grade_id)
                for student in students:
                    if term == 1: 
                        student.term1_fees = mandatory_total
                        if student.current_term == 1: student.term_fees = mandatory_total
                    elif term == 2: 
                        student.term2_fees = mandatory_total
                        if student.current_term == 2: student.term_fees = mandatory_total
                    elif term == 3: 
                        student.term3_fees = mandatory_total
                        if student.current_term == 3: student.term_fees = mandatory_total
                    
                    student.save()
                    student_count += 1

                # 4. Update/Create Invoices in Transaction model
                for student in students:
                    account, _ = StudentFinanceAccount.objects.get_or_create(student=student)
                    
                    tx = Transaction.objects.filter(
                        account=account,
                        type='INVOICE',
                        term=term,
                        academic_year=year
                    ).first()
                    
                    if tx:
                        tx.amount = mandatory_total
                        tx.description = f"Term {term} {year} Fees (Updated)"
                        tx.save()
                        invoice_count += 1
                    else:
                        Transaction.objects.create(
                            account=account,
                            type='INVOICE',
                            amount=mandatory_total,
                            description=f"Term {term} {year} Fees",
                            term=term,
                            academic_year=year
                        )
                        invoice_count += 1
            
            return JsonResponse({
                'message': 'Fees updated successfully.',
                'synced_invoices': invoice_count,
                'updated_students': student_count
            })
        except Exception as e:
            import traceback
            print(traceback.format_exc())
            return JsonResponse({'error': str(e)}, status=500)
    return JsonResponse({'error': 'Invalid method'}, status=405)

@login_required
def api_finance_salaries(request):
    try:
        today = timezone.now().date()
        current_month = today.replace(day=1)
        
        users = User.objects.filter(
             Q(transport_driver_profile__isnull=False) | 
             Q(teacher__isnull=False) |
             Q(salary_structure__isnull=False) |
             Q(is_staff=True)
        ).distinct()
        
        data = []
        for u in users:
            # Get or create salary structure safely
            ss, _ = SalaryStructure.objects.get_or_create(user=u)
            
            base = float(ss.base_salary)
            allowances = float(ss.allowances)
            deductions = float(ss.deductions)
            nssf = float(ss.nssf)
            loans = float(ss.loans)
            net = float(ss.net_salary())
            
            role = 'Staff'
            if hasattr(u, 'transport_driver_profile'): role = 'Driver'
            elif hasattr(u, 'teacher'): role = 'Teacher'
            elif u.is_staff: role = 'Admin'

            payroll = PayrollRecord.objects.filter(user=u, month=current_month).first()
            status = payroll.status if payroll else 'UNPROCESSED'
            
            advances = float(ss.get_advances())
            data.append({
                'id': u.id,
                'name': u.get_full_name() or u.username,
                'role': role,
                'base_salary': base,
                'allowances': allowances,
                'deductions': deductions,
                'nssf': nssf,
                'loans': loans,
                'advances': advances,
                'net_salary': net,
                'status': status,
                'slip_id': payroll.id if payroll else None
            })
            
        return JsonResponse({'employees': data, 'current_month': current_month.strftime('%B %Y')})
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

@csrf_exempt
@login_required
def api_finance_payroll_process(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            user_ids = data.get('user_ids', [])
            action = data.get('action') # 'GENERATE', 'PAY'
            
            today = timezone.now().date()
            current_month = today.replace(day=1)
            
            processed = 0
            for uid in user_ids:
                u = User.objects.get(pk=uid)
                ss, _ = SalaryStructure.objects.get_or_create(user=u) 
                
                # Defaults
                if ss.base_salary == 0:
                     if hasattr(u, 'transport_driver_profile'): ss.base_salary = 25000
                     elif hasattr(u, 'teacher'): ss.base_salary = 35000
                     else: ss.base_salary = 20000
                     ss.save()
                
                advances_amt = ss.get_advances()
                payroll, created = PayrollRecord.objects.get_or_create(
                    user=u, month=current_month,
                    defaults={
                        'base_salary': ss.base_salary,
                        'allowances': ss.allowances,
                        'deductions': ss.deductions,
                        'nssf': ss.nssf,
                        'loans': ss.loans,
                        'advances': advances_amt,
                        'net_salary': ss.net_salary()
                    }
                )

                if not created and payroll.status != 'PAID':
                    # Update advances if they changed before processing
                    payroll.advances = advances_amt
                    payroll.net_salary = ss.net_salary()
                    payroll.save()
                
                if action == 'PAY' and payroll.status != 'PAID':
                    payroll.status = 'PAID'
                    payroll.paid_at = timezone.now()
                    payroll.save()

                    # Mark approved advances as DEDUCTED
                    from schools.models import SalaryAdvance
                    from django.db.models import Q
                    SalaryAdvance.objects.filter(
                        Q(employee__teacher__user=u) | Q(employee__nonteachingstaff__user=u),
                        status='APPROVED'
                    ).update(status='DEDUCTED')
                    
                    # Create Expense record
                    Expense.objects.get_or_create(
                        title=f"Salary Payment: {u.get_full_name()} ({current_month.strftime('%B %Y')})",
                        defaults={
                            'amount': payroll.net_salary,
                            'category': 'salaries',
                            'date': timezone.now().date(),
                            'payment_method': 'bank_transfer',
                            'description': f"Payroll disbursement for {u.username} for {current_month.strftime('%B %Y')}",
                            'created_by': request.user
                        }
                    )
                elif action == 'GENERATE':
                    if payroll.status == 'PENDING':
                         payroll.status = 'PROCESSED'
                         payroll.save()
                
                processed += 1
                
            return JsonResponse({'success': True, 'processed': processed})
        except Exception as e:
            return JsonResponse({'error': str(e)}, status=500)

@csrf_exempt
@login_required
def api_finance_salary_update(request, user_id):
    """API endpoint to update an employee's salary structure"""
    if request.method == 'POST':
        try:
            u = get_object_or_404(User, pk=user_id)
            ss, _ = SalaryStructure.objects.get_or_create(user=u)
            data = json.loads(request.body)
            
            # Update fields if provided
            if 'base_salary' in data:
                ss.base_salary = data.get('base_salary')
            if 'allowances' in data:
                ss.allowances = data.get('allowances')
            if 'deductions' in data:
                ss.deductions = data.get('deductions')
            if 'nssf' in data:
                ss.nssf = data.get('nssf')
            if 'loans' in data:
                ss.loans = data.get('loans')
                
            ss.save()
            return JsonResponse({'success': True})
        except Exception as e:
            return JsonResponse({'error': str(e)}, status=500)
    return JsonResponse({'error': 'Method not allowed'}, status=405)


@login_required
def api_finance_students(request):
    """
    List of students with their financial status.
    """
    try:
        # Fetch all students to ensure comprehensive list
        students = Student.objects.select_related('grade').all()
        
        # Pre-fetch existing accounts to avoid N+1
        accounts_map = {
            acc.student_id: acc 
            for acc in StudentFinanceAccount.objects.all()
        }
        
        data = []
        for s in students:
            account = accounts_map.get(s.id)
            
            # If account missing, create it on the fly to ensure consistency
            if not account:
                account = StudentFinanceAccount.objects.create(student=s)
                # No need to add to map as we won't hit this student again in this loop
            
            data.append({
                'id': s.id,
                'account_id': account.id,
                'admission_number': s.admission_number,
                'full_name': s.get_full_name(),
                'grade': s.grade.name if s.grade else 'N/A',
                'balance': float(account.balance),
                'total_billed': float(account.total_billed),
                'total_paid': float(account.total_paid),
                'avatar': s.photo.url if s.photo else None
            })
        return JsonResponse({'students': data})
    except Exception as e:
        import traceback
        print(traceback.format_exc())
        return JsonResponse({'error': str(e)}, status=500)

@csrf_exempt
@login_required
def api_finance_student_detail(request, student_id):
    """
    Detailed ledger for a student.
    """
    try:
        student = get_object_or_404(Student, pk=student_id)
        account, _ = StudentFinanceAccount.objects.get_or_create(student=student)
        
        if request.method == 'POST':
            # Create a transaction
            data = json.loads(request.body)
            tx_type = data.get('type') # INVOICE or PAYMENT
            amount = data.get('amount')
            description = data.get('description')
            method = data.get('payment_method', 'CASH')
            reference = data.get('reference')
            
            Transaction.objects.create(
                account=account,
                type=tx_type,
                amount=amount,
                description=description,
                payment_method=method,
                reference=reference,
                recorded_by=request.user
            )
            # Balance auto-updates via model signal/save method
            return JsonResponse({'success': True})
            
        # GET: Return ledger
        transactions = account.transactions.order_by('-date')
        tx_list = []
        for t in transactions:
            tx_list.append({
                'id': t.id,
                'date': t.date.strftime('%Y-%m-%d'),
                'type': t.type,
                'amount': float(t.amount),
                'description': t.description,
                'method': t.payment_method
            })
            
        return JsonResponse({
            'student': {
                'id': student.id,
                'name': student.get_full_name(),
                'admission_number': student.admission_number,
                'grade': student.grade.name if student.grade else '',
                'balance': float(account.balance),
                'total_billed': float(account.total_billed),
                'total_paid': float(account.total_paid),
                'avatar': student.photo.url if student.photo else None
            },
            'transactions': tx_list
        })
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

@login_required
def api_finance_transaction_detail(request, transaction_id):
    """
    Get details of a specific transaction for receipt printing
    """
    try:
        transaction = get_object_or_404(Transaction.objects.select_related('account', 'account__student'), pk=transaction_id)
        student = transaction.account.student
        
        from config.models import SchoolConfig
        sc = SchoolConfig.get_config()
        
        # Calculate balance for the specific term of the transaction
        term_balance = 0
        if transaction.term and transaction.academic_year:
            # Get fees and payments for this specific term
            term_invoices = Transaction.objects.filter(
                account=transaction.account,
                term=transaction.term,
                academic_year=transaction.academic_year,
                type='INVOICE'
            ).aggregate(sum=Sum('amount'))['sum'] or 0
            
            term_payments = Transaction.objects.filter(
                account=transaction.account,
                term=transaction.term,
                academic_year=transaction.academic_year,
                type='PAYMENT'
            ).aggregate(sum=Sum('amount'))['sum'] or 0
            
            term_balance = float(term_invoices) - float(term_payments)
        else:
            # Fallback to total account balance if no term info
            term_balance = float(transaction.account.balance)

        return JsonResponse({
            'transaction': {
                'id': transaction.id,
                'date': transaction.date.strftime('%Y-%m-%d %H:%M'),
                'amount': float(transaction.amount),
                'type': transaction.type,
                'method': transaction.payment_method,
                'description': transaction.description,
                'reference': transaction.reference,
                'recorded_by': transaction.recorded_by.username if transaction.recorded_by else 'System'
            },
            'student': {
                'name': student.get_full_name(),
                'admission_number': student.admission_number,
                'grade': student.grade.name if student.grade else 'N/A',
                'balance': term_balance,
            },
            'school': {
                'name': sc.school_name,
                'address': sc.school_address,
                'phone': sc.school_phone,
                'email': sc.school_email
            }
        })
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

@login_required
def api_finance_transactions(request):
    """
    List all transactions with optional filtering
    """
    try:
        from django.core.paginator import Paginator
        
        # Base Query
        queryset = Transaction.objects.select_related('account__student', 'account__student__grade').order_by('-date')

        # Search (Student Name or Adm)
        search = request.GET.get('search', '')
        if search:
            queryset = queryset.filter(
                Q(account__student__first_name__icontains=search) |
                Q(account__student__last_name__icontains=search) |
                Q(account__student__admission_number__icontains=search) |
                Q(reference__icontains=search)
            )

        # Type Filter
        tx_type = request.GET.get('type', 'ALL')
        if tx_type != 'ALL':
            queryset = queryset.filter(type=tx_type)

        # Pagination
        page = request.GET.get('page', 1)
        paginator = Paginator(queryset, 20) # 20 per page
        transactions = paginator.get_page(page)
        
        data = []
        for t in transactions:
            data.append({
                'id': t.id,
                'date': t.date.strftime('%Y-%m-%d'),
                'student_name': t.account.student.get_full_name(),
                'student_adm': t.account.student.admission_number,
                'type': t.type,
                'amount': float(t.amount),
                'method': t.payment_method,
                'reference': t.reference or '-'
            })
            
        return JsonResponse({
            'transactions': data,
            'total_pages': paginator.num_pages,
            'current_page': transactions.number,
            'has_next': transactions.has_next(),
            'has_previous': transactions.has_previous()
        })
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

@login_required
def api_finance_reports(request):
    """
    Data for finance analytics and reports.
    """
    try:
        today = timezone.now().date()
        date_7_days_ago = today - datetime.timedelta(days=6)
        
        # 1. Collection Trend (Last 7 Days)
        daily_collection_qs = Transaction.objects.filter(
            type='PAYMENT', 
            date__date__gte=date_7_days_ago
        ).annotate(day=TruncDate('date')).values('day').annotate(total=Sum('amount')).order_by('day')
        
        daily_collection = []
        # Pre-fill last 7 days with 0 to ensure continuity
        for i in range(7):
            d = date_7_days_ago + datetime.timedelta(days=i)
            # Find matching entry in qs
            entry = next((item for item in daily_collection_qs if item['day'] == d), None)
            daily_collection.append({
                'date': d.strftime('%a, %d'), # Mon, 12
                'full_date': d.strftime('%Y-%m-%d'),
                'amount': float(entry['total']) if entry else 0
            })

        # 2. Payment Method Distribution (All Time)
        method_stats = Transaction.objects.filter(type='PAYMENT').values('payment_method').annotate(
            total=Sum('amount'), 
            count=Count('id')
        ).order_by('-total')
        
        methods_data = [{'name': m['payment_method'], 'value': float(m['total'])} for m in method_stats]

        # 3. Outstanding Balance by Grade
        grade_debt = StudentFinanceAccount.objects.filter(balance__gt=0).values(
            'student__grade__name'
        ).annotate(
            total_debt=Sum('balance')
        ).order_by('-total_debt')
        
        debt_data = [{'grade': g['student__grade__name'] or 'Unknown', 'amount': float(g['total_debt'])} for g in grade_debt]
        
        # 4. Total Revenue This Month vs Last Month
        this_month_start = today.replace(day=1)
        last_month_end = this_month_start - datetime.timedelta(days=1)
        last_month_start = last_month_end.replace(day=1)

        revenue_this_month = Transaction.objects.filter(
            type='PAYMENT', 
            date__date__gte=this_month_start
        ).aggregate(sum=Sum('amount'))['sum'] or 0

        revenue_last_month = Transaction.objects.filter(
            type='PAYMENT', 
            date__date__gte=last_month_start,
            date__date__lte=last_month_end
        ).aggregate(sum=Sum('amount'))['sum'] or 0

        return JsonResponse({
            'daily_collection': daily_collection,
            'payment_methods': methods_data,
            'debt_by_grade': debt_data,
            'comparison': {
                'this_month': float(revenue_this_month),
                'last_month': float(revenue_last_month)
            }
        })

    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

@login_required
def api_finance_all_transactions(request):
    """
    Combined view for all platform transactions (Fees, Food, Transport, Expenses)
    """
    try:
        from schools.models import TransportFee, FoodFee, StudentMealPayment
        from transport.models import TransportTransaction
        
        # 1. Fetch from different sources
        # ------------------------------
        # Fees
        fees = Transaction.objects.select_related('account__student').all()
        
        # Transport (Only PAYMENT/COMPLETED transactions)
        trans_tx = TransportTransaction.objects.filter(type='PAYMENT').select_related('account__student').all()
        trans_fee = TransportFee.objects.filter(status='COMPLETED').select_related('student').all()
        
        # Food
        from food.models import FoodTransaction
        food_fee = FoodFee.objects.filter(status='COMPLETED').select_related('student').all()
        meal_pay = StudentMealPayment.objects.filter(status='COMPLETED').select_related('student').all()
        modern_food_tx = FoodTransaction.objects.filter(type='PAYMENT').select_related('account__student').all()
        
        # Expenses
        expenses = Expense.objects.all()

        unified = []
        
        for f in fees:
            date_val = f.date.date() if hasattr(f.date, 'date') else f.date
            unified.append({
                'id': f.id, 'source': 'FEES', 'type': 'INCOME' if f.type == 'PAYMENT' else 'BILL',
                'title': f"Fee Payment: {f.account.student.get_full_name()}",
                'amount': float(f.amount), 'date': date_val, 'method': f.payment_method,
                'reference': f.reference or f"FEE-{f.id}"
            })
            
        for t in trans_tx:
            date_val = t.date.date() if hasattr(t.date, 'date') else t.date
            unified.append({
                'id': t.id, 'source': 'TRANSPORT', 'type': 'INCOME' if t.type == 'PAYMENT' else 'CHARGE',
                'title': f"Transport: {t.account.student.get_full_name()}",
                'amount': float(t.amount), 'date': date_val, 'method': t.payment_method,
                'reference': t.reference or f"TRNS-{t.id}"
            })
            
        for tf in trans_fee:
            date_val = tf.date.date() if hasattr(tf.date, 'date') else tf.date
            unified.append({
                'id': tf.id, 'source': 'TRANSPORT', 'type': 'INCOME',
                'title': f"Transport Fee: {tf.student.get_full_name()}",
                'amount': float(tf.amount), 'date': date_val, 'method': tf.payment_method,
                'reference': tf.reference_number
            })
            
        for ff in food_fee:
            date_val = ff.date.date() if hasattr(ff.date, 'date') else ff.date
            unified.append({
                'id': ff.id, 'source': 'FOOD', 'type': 'INCOME',
                'title': f"Food Fee: {ff.student.get_full_name()}",
                'amount': float(ff.amount), 'date': date_val, 'method': ff.payment_method,
                'reference': ff.reference_number
            })
            
        for mp in meal_pay:
            date_val = mp.payment_date.date() if hasattr(mp.payment_date, 'date') else mp.payment_date
            unified.append({
                'id': mp.id, 'source': 'FOOD', 'type': 'INCOME',
                'title': f"Meal Payment: {mp.student.get_full_name()}",
                'amount': float(mp.amount), 'date': date_val, 'method': mp.payment_method,
                'reference': mp.reference_number
            })
            
        for mft in modern_food_tx:
            date_val = mft.date.date() if hasattr(mft.date, 'date') else mft.date
            unified.append({
                'id': mft.id, 'source': 'FOOD', 'type': 'INCOME',
                'title': f"Food Payment: {mft.account.student.get_full_name()}",
                'amount': float(mft.amount), 'date': date_val, 'method': mft.payment_method,
                'reference': mft.reference or f"FOOD-{mft.id}"
            })
            
        for e in expenses:
            date_val = e.date.date() if hasattr(e.date, 'date') else e.date
            unified.append({
                'id': e.id, 'source': 'EXPENSE', 'type': 'OUTFLOW', 'title': e.title,
                'amount': float(e.amount), 'date': date_val, 'method': e.payment_method,
                'reference': e.receipt_number or f"EXP-{e.id}"
            })

        # Sort by date (descending)
        unified.sort(key=lambda x: str(x['date']), reverse=True)
        
        # Filter by source if requested
        source_filter = request.GET.get('source')
        if source_filter and source_filter != 'ALL':
            unified = [x for x in unified if x['source'] == source_filter]

        # Simple manual pagination
        page = int(request.GET.get('page', 1))
        page_size = 30
        start = (page - 1) * page_size
        end = start + page_size
        
        serialized = []
        for x in unified[start:end]:
            d = x.copy()
            if hasattr(d['date'], 'strftime'):
                d['date'] = d['date'].strftime('%Y-%m-%d')
            else:
                d['date'] = str(d['date'])
            serialized.append(d)

        return JsonResponse({
            'transactions': serialized,
            'total': len(unified),
            'current_page': page,
            'has_next': end < len(unified)
        })
    except Exception as e:
        import traceback
        print(traceback.format_exc())
        return JsonResponse({'error': str(e)}, status=500)

@login_required
def api_student_fee_summary(request):
    try:
        # Student Counts
        total_students = Student.objects.count()
        accounts = StudentFinanceAccount.objects.all()

        total_fees_expected = Student.objects.aggregate(
            sum=Coalesce(Sum('term1_fees'), Value(0), output_field=DecimalField()) + 
                Coalesce(Sum('term2_fees'), Value(0), output_field=DecimalField()) + 
                Coalesce(Sum('term3_fees'), Value(0), output_field=DecimalField())
        )['sum'] or 0
        debtors_count = accounts.filter(balance__gt=0).count()
        credit_count = accounts.filter(balance__lt=0).count()
        settled_count = accounts.filter(balance=0).count()
        
        # Financial Totals
        total_billed = accounts.aggregate(Sum('total_billed'))['total_billed__sum'] or 0
        total_paid = accounts.aggregate(Sum('total_paid'))['total_paid__sum'] or 0
        total_outstanding = accounts.filter(balance__gt=0).aggregate(Sum('balance'))['balance__sum'] or 0
        
        # Grade breakdown
        grade_stats = StudentFinanceAccount.objects.values('student__grade__name').annotate(
            billed=Sum('total_billed'),
            paid=Sum('total_paid'),
            balance=Sum('balance'),
            count=Count('id')
        ).order_by('student__grade__name')
        
        grade_data = []
        for g in grade_stats:
            grade_data.append({
                'grade': g['student__grade__name'] or 'N/A',
                'billed': float(g['billed']),
                'paid': float(g['paid']),
                'balance': float(g['balance']),
                'count': g['count']
            })

        return JsonResponse({
            'counts': {
                'total': total_students,
                'debtors': debtors_count,
                'credit': credit_count,
                'settled': settled_count,
            },
            'totals': {
                'billed': float(total_billed),
                'paid': float(total_paid),
                'outstanding': float(total_outstanding),
            },
            'grade_breakdown': grade_data
        })
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

@login_required
def api_transport_finance_summary(request):
    try:
        # 1. Basic Counts
        total_students = TransportStudentAccount.objects.filter(active=True).count()
        debtors_count = TransportStudentAccount.objects.filter(active=True, balance__gt=0).count()
        settled_count = TransportStudentAccount.objects.filter(active=True, balance__lte=0).count()
        
        # 2. Financial Totals
        # Revenue: Payment transactions from TransportTransaction and legacy TransportFee
        transport_income_tx = TransportTransaction.objects.filter(type='PAYMENT').aggregate(sum=Sum('amount'))['sum'] or 0
        transport_income_fee = TransportFee.objects.filter(status='COMPLETED').aggregate(sum=Sum('amount'))['sum'] or 0
        total_revenue = float(transport_income_tx) + float(transport_income_fee)
        
        # Expenses
        total_expenses = TransportExpense.objects.filter(status='APPROVED').aggregate(sum=Sum('amount'))['sum'] or 0
        
        # Arrears
        total_arrears = TransportStudentAccount.objects.filter(active=True, balance__gt=0).aggregate(sum=Sum('balance'))['sum'] or 0
        
        # 3. Route Breakdown
        routes = Route.objects.all()
        route_data = []
        for r in routes:
            count = TransportAssignment.objects.filter(route=r, active=True).count()

            route_revenue = TransportTransaction.objects.filter(
                type='PAYMENT', 
                account__assignments__route=r, 
                account__assignments__active=True
            ).distinct().aggregate(sum=Sum('amount'))['sum'] or 0
            
            route_data.append({
                'name': r.name,
                'count': count,
                'revenue': float(route_revenue),
                'cost': float(r.cost_per_term)
            })
            
        # 4. Expense Categories
        expense_stats = TransportExpense.objects.filter(status='APPROVED').values('expense_type').annotate(
            total=Sum('amount')
        ).order_by('-total')
        expense_breakdown = [{'name': e['expense_type'], 'value': float(e['total'])} for e in expense_stats]

        return JsonResponse({
            'counts': {
                'total_students': total_students,
                'debtors': debtors_count,
                'settled': settled_count,
            },
            'totals': {
                'revenue': total_revenue,
                'expenses': float(total_expenses),
                'arrears': float(total_arrears),
                'net': total_revenue - float(total_expenses)
            },
            'route_breakdown': route_data,
            'expense_breakdown': expense_breakdown
        })
    except Exception as e:
        import traceback
        print(traceback.format_exc())
        return JsonResponse({'error': str(e)}, status=500)

@login_required
def api_food_finance_summary(request):
    try:
        # 1. Accounts & Counts
        accounts = FoodStudentAccount.objects.filter(active=True)
        total_students = accounts.count()
        debtors_count = accounts.filter(balance__gt=0).count()
        settled_count = accounts.filter(balance__lte=0).count()
        
        total_arrears = accounts.filter(balance__gt=0).aggregate(sum=Sum('balance'))['sum'] or 0

        # 2. Total Revenue
        food_income_fee = FoodFee.objects.filter(status='COMPLETED').aggregate(sum=Sum('amount'))['sum'] or 0
        food_income_meal = StudentMealPayment.objects.filter(status='COMPLETED').aggregate(sum=Sum('amount'))['sum'] or 0
        food_income_modern = FoodTransaction.objects.filter(type='PAYMENT').aggregate(sum=Sum('amount'))['sum'] or 0
        
        total_revenue = float(food_income_fee) + float(food_income_meal) + float(food_income_modern)
        
        # 3. Expenses (Food related)
        food_expenses = Expense.objects.filter(category='food').aggregate(sum=Sum('amount'))['sum'] or 0
        
        # 4. Meal Breakdown (Subscriptions)
        meals = MealItem.objects.filter(active=True)
        meal_data = []
        for meal in meals:
            count = FoodSubscription.objects.filter(meal_item=meal, active=True).count()
            # Revenue from this meal (modern model)
            meal_rev = FoodTransaction.objects.filter(
                type='PAYMENT',
                account__subscriptions__meal_item=meal,
                account__active=True
            ).distinct().aggregate(sum=Sum('amount'))['sum'] or 0
            
            meal_data.append({
                'name': meal.name,
                'count': count,
                'revenue': float(meal_rev),
                'cost': float(meal.cost)
            })

        # 5. Collection Trend (Last 7 Days)
        today = timezone.now().date()
        date_7_days_ago = today - datetime.timedelta(days=6)
        daily_data = []
        for i in range(7):
            d = date_7_days_ago + datetime.timedelta(days=i)
            # Sum from all sources for this date
            sum_val = float(StudentMealPayment.objects.filter(payment_date=d, status='COMPLETED').aggregate(sum=Sum('amount'))['sum'] or 0) + \
                      float(FoodTransaction.objects.filter(date__date=d, type='PAYMENT').aggregate(sum=Sum('amount'))['sum'] or 0)
            daily_data.append({

                'date': d.strftime('%a'),
                'amount': sum_val
            })

        return JsonResponse({
            'counts': {
                'total_students': total_students,
                'debtors': debtors_count,
                'settled': settled_count,
            },
            'totals': {
                'revenue': total_revenue,
                'expenses': float(food_expenses),
                'arrears': float(total_arrears),
                'net': total_revenue - float(food_expenses)
            },
            'daily_trend': daily_data,
            'meal_breakdown': meal_data,
            'sources': [
                {'name': 'Meal Payments', 'value': float(food_income_meal) + float(food_income_modern)},
                {'name': 'Term Fees', 'value': float(food_income_fee)}
            ]
        })
    except Exception as e:
        import traceback
        err_msg = traceback.format_exc()
        with open('catering_error.log', 'w') as f:
            f.write(err_msg)
        return JsonResponse({'error': str(e), 'traceback': err_msg}, status=500)

@login_required
def api_download_transaction_pdf(request, transaction_id):
    """
    Download a transaction receipt as a high-quality PDF.
    This view uses a proxy of the Payment interface to reuse existing PDF utilities.
    """
    try:
        transaction = get_object_or_404(Transaction.objects.select_related('account', 'account__student'), pk=transaction_id)
        student = transaction.account.student
        
        from schools.utils import generate_payment_receipt
        
        # Calculate balance for the specific term of the transaction
        term_balance = 0
        if transaction.term and transaction.academic_year:
            # Get fees and payments for this specific term
            term_invoices = Transaction.objects.filter(
                account=transaction.account,
                term=transaction.term,
                academic_year=transaction.academic_year,
                type='INVOICE'
            ).aggregate(sum=Sum('amount'))['sum'] or 0
            
            term_payments = Transaction.objects.filter(
                account=transaction.account,
                term=transaction.term,
                academic_year=transaction.academic_year,
                type='PAYMENT'
            ).aggregate(sum=Sum('amount'))['sum'] or 0
            
            term_balance = float(term_invoices) - float(term_payments)
        else:
            term_balance = float(transaction.account.balance)

        # Create a proxy for Student to return the TERM SPECIFIC balance
        class StudentProxy:
            def __init__(self, original_student, balance_override):
                self.original = original_student
                self.balance_override = balance_override
                
            def get_balance(self):
                return self.balance_override
                
            def __getattr__(self, name):
                return getattr(self.original, name)

        student_proxy = StudentProxy(student, term_balance)

        # Create a proxy object to match what generate_payment_receipt expects
        class PaymentProxy:
            def __init__(self, tx, student):
                self.id = tx.id
                self.pk = tx.pk
                self.date = tx.date
                self.amount = tx.amount
                self.description = tx.description
                self.reference_number = tx.reference or f"TX-{tx.id}"
                self.payment_method = tx.get_payment_method_display() if hasattr(tx, 'get_payment_method_display') else tx.payment_method
                self.student = student
                self.term = tx.term or 1
                self.academic_year = tx.academic_year or "2024"
                # Map transaction_id for utils.py compatibility
                self.transaction_id = tx.reference

            def get_payment_method_display(self):
                return self.payment_method
        
        proxy = PaymentProxy(transaction, student_proxy)
        
        # Generate the PDF
        pdf_content = generate_payment_receipt(proxy)
        
        if not pdf_content:
            return JsonResponse({'error': 'Failed to generate PDF content'}, status=500)
            
        response = HttpResponse(content_type='application/pdf')
        filename = f"Receipt_#{transaction.id:06d}_{student.admission_number}.pdf"
        response['Content-Disposition'] = f'attachment; filename="{filename}"'
        
        # If pdf_content is BytesIO, get value
        if hasattr(pdf_content, 'getvalue'):
            response.write(pdf_content.getvalue())
        else:
            response.write(pdf_content)
            
        return response
        
    except Exception as e:
        import traceback
        traceback.print_exc()
        return JsonResponse({'error': str(e)}, status=500)
