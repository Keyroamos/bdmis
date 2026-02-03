from django.db import models
from django.contrib.auth.models import User
from datetime import date
from django.db.models import Sum, Count, Avg, Q, F, Value, DecimalField
from django.db.models.functions import Coalesce
from django.utils import timezone
from datetime import datetime
from decimal import Decimal
from django.templatetags.static import static
from django.core.validators import FileExtensionValidator
from django.contrib.auth.models import Group
from django.urls import reverse
from django.core.exceptions import ValidationError

# Define choices at module level
TERM_CHOICES = [
    (1, 'Term 1'),
    (2, 'Term 2'),
    (3, 'Term 3'),
]

LOCATION_CHOICES = [
    ('MAIN', 'Main School'),
    ('ANNEX', 'Annex School'),
]

def student_profile_path(instance, filename):
    # Get file extension
    ext = filename.split('.')[-1]
    # File will be uploaded to MEDIA_ROOT/student_profiles/admission_number/photo.ext
    return f'student_profiles/{instance.admission_number}/photo.{ext}'

def teacher_profile_path(instance, filename):
    # File will be uploaded to MEDIA_ROOT/teacher_profiles/national_id/photo.ext
    ext = filename.split('.')[-1]
    return f'teacher_profiles/{instance.national_id}/photo.{ext}'

class Grade(models.Model):
    GRADE_CHOICES = [
        ('PG', 'Playgroup'),
        ('PP1', 'PP1'),
        ('PP2', 'PP2'),
        ('G1', 'Grade 1'),
        ('G2', 'Grade 2'),
        ('G3', 'Grade 3'),
        ('G4', 'Grade 4'),
        ('G5', 'Grade 5'),
        ('G6', 'Grade 6'),
        ('G7', 'Grade 7'),
        ('G8', 'Grade 8'),
        ('G9', 'Grade 9'),
        ('G10', 'Grade 10'),
        ('G11', 'Grade 11'),
        ('G12', 'Grade 12'),
    ]
    
    name = models.CharField(max_length=20, choices=GRADE_CHOICES)
    description = models.TextField(blank=True, default='')
    term1_fees = models.DecimalField(
        max_digits=10, 
        decimal_places=2, 
        help_text="Term 1 fees", 
        default=0
    )
    term2_fees = models.DecimalField(
        max_digits=10, 
        decimal_places=2, 
        help_text="Term 2 fees", 
        default=0
    )
    term3_fees = models.DecimalField(
        max_digits=10, 
        decimal_places=2, 
        help_text="Term 3 fees", 
        default=0
    )
    is_active = models.BooleanField(default=True)
    class_teacher = models.OneToOneField(
        'Teacher',
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='grade_assigned'
    )

    def __str__(self):
        return self.get_name_display()

    class Meta:
        ordering = ['name']

    def get_total_fees(self):
        return self.term1_fees + self.term2_fees + self.term3_fees

class Subject(models.Model):
    SUBJECT_CHOICES = [
        ('MATH', 'Mathematics'),
        ('ENG', 'English'),
        ('KIS', 'Kiswahili'),
        ('SCI', 'Science & Technology'),
        ('SST', 'Social Studies'),
        ('CRE', 'Christian Religious Education'),
        ('IRE', 'Islamic Religious Education'),
        ('HRE', 'Hindu Religious Education'),
        ('PHE', 'Physical & Health Education'),
        ('ART', 'Art & Craft'),
        ('MUS', 'Music'),
        ('AGR', 'Agriculture')
    ]
    
    name = models.CharField(max_length=100)
    code = models.CharField(max_length=10, choices=SUBJECT_CHOICES, unique=True)
    description = models.TextField(blank=True, null=True)
    
    class Meta:
        ordering = ['name']
    
    def __str__(self):
        return self.name

class Branch(models.Model):
    name = models.CharField(max_length=100, unique=True)
    address = models.TextField(blank=True, null=True)
    contact_phone = models.CharField(max_length=20, blank=True, null=True)
    is_active = models.BooleanField(default=True)
    slug = models.SlugField(max_length=100, unique=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def save(self, *args, **kwargs):
        if not self.slug:
            from django.utils.text import slugify
            self.slug = slugify(self.name)
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name

    class Meta:
        ordering = ['name']
        verbose_name_plural = "Branches"

class Department(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField(blank=True)
    head = models.ForeignKey(
        'Employee', 
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='headed_department'
    )
    branch = models.ForeignKey(Branch, on_delete=models.SET_NULL, null=True, blank=True, related_name='departments')
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    is_active = models.BooleanField(default=True)

    def __str__(self):
        return self.name

    class Meta:
        ordering = ['name']

class Employee(models.Model):
    POSITION_CHOICES = [
        ('TEACHER', 'Teacher'),
        ('HOD', 'Head of Department'),
        ('DEPUTY', 'Deputy Principal'),
        ('PRINCIPAL', 'Principal'),
        ('ADMIN', 'Administrative Staff'),
        ('SUPPORT', 'Support Staff')
    ]
    
    STATUS_CHOICES = [
        ('ACTIVE', 'Active'),
        ('INACTIVE', 'Inactive'),
        ('ON_LEAVE', 'On Leave')
    ]
    
    GENDER_CHOICES = [
        ('M', 'Male'),
        ('F', 'Female'),
        ('O', 'Other')
    ]
    
    RELIGION_CHOICES = [
        ('CHRISTIAN', 'Christian'),
        ('MUSLIM', 'Muslim'),
        ('HINDU', 'Hindu'),
        ('BUDDHIST', 'Buddhist'),
        ('OTHER', 'Other')
    ]
    
    MARITAL_STATUS_CHOICES = [
        ('SINGLE', 'Single'),
        ('MARRIED', 'Married'),
        ('DIVORCED', 'Divorced'),
        ('WIDOWED', 'Widowed')
    ]
    
    # Personal Information
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    email = models.EmailField(unique=True)
    phone = models.CharField(max_length=20)
    national_id = models.CharField(max_length=20, unique=True)
    position = models.CharField(max_length=20, choices=POSITION_CHOICES)
    date_of_birth = models.DateField()
    date_joined = models.DateField(default=timezone.now)
    address = models.TextField(blank=True)
    profile_picture = models.ImageField(upload_to='employee_profiles/', blank=True, null=True)
    basic_salary = models.DecimalField(max_digits=10, decimal_places=2, default=0)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='ACTIVE')
    
    # Add default values for new required fields
    gender = models.CharField(max_length=1, choices=GENDER_CHOICES, default='M')
    religion = models.CharField(max_length=20, choices=RELIGION_CHOICES, default='CHRISTIAN')
    location = models.CharField(
        max_length=10,
        choices=LOCATION_CHOICES,
        default='MAIN',
        help_text="School location: Main or Annex"
    )
    marital_status = models.CharField(max_length=20, choices=MARITAL_STATUS_CHOICES, default='SINGLE')
    nationality = models.CharField(max_length=100, default='Kenyan')
    department = models.ForeignKey(
        Department,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='employees'
    )
    branch = models.ForeignKey(
        Branch,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='employees'
    )

    class Meta:
        ordering = ['first_name', 'last_name']

    def __str__(self):
        return self.get_full_name()
    
    def get_full_name(self):
        return f"{self.first_name} {self.last_name}"

    def teacher_profile(self):
        """Get associated teacher profile if exists"""
        if hasattr(self, '_teacher_profile'):
            return self._teacher_profile
        if self.position == 'TEACHER':
            try:
                return Teacher.objects.get(employee_ptr=self)
            except Teacher.DoesNotExist:
                return None
        return None

class Teacher(Employee):
    user = models.OneToOneField(User, on_delete=models.SET_NULL, null=True, blank=True)
    QUALIFICATION_CHOICES = [
        ('CERT', 'Certificate'),
        ('DIP', 'Diploma'),
        ('DEG', 'Degree'),
        ('MAST', 'Masters'),
        ('PHD', 'PhD')
    ]
    
    SUBJECT_CHOICES = [
        ('MATH', 'Mathematics'),
        ('ENG', 'English'),
        ('KIS', 'Kiswahili'),
        ('SCI', 'Science & Technology'),
        ('SST', 'Social Studies'),
        ('CRE', 'Christian Religious Education'),
        ('IRE', 'Islamic Religious Education'),
        ('HRE', 'Hindu Religious Education'),
        ('PHE', 'Physical & Health Education'),
        ('ART', 'Art & Craft'),
        ('MUS', 'Music'),
        ('AGR', 'Agriculture')
    ]
    
    GENDER_CHOICES = [
        ('M', 'Male'),
        ('F', 'Female')
    ]
    
    MARITAL_STATUS_CHOICES = [
        ('SINGLE', 'Single'),
        ('MARRIED', 'Married'),
        ('DIVORCED', 'Divorced'),
        ('WIDOWED', 'Widowed')
    ]
    
    RELIGION_CHOICES = [
        ('CHRISTIAN', 'Christian'),
        ('MUSLIM', 'Muslim'),
        ('HINDU', 'Hindu'),
        ('OTHER', 'Other')
    ]
    
    STATUS_CHOICES = [
        ('ACTIVE', 'Active'),
        ('ON_LEAVE', 'On Leave'),
        ('INACTIVE', 'Inactive')
    ]

    # Teacher specific fields
    tsc_number = models.CharField(max_length=20, unique=True, null=True, blank=True)
    years_of_experience = models.PositiveIntegerField(default=0)
    qualifications = models.CharField(
        max_length=10, 
        choices=QUALIFICATION_CHOICES,
        verbose_name="Highest Qualification"
    )
    certificate = models.FileField(
        upload_to='teacher_certificates/',
        help_text='Upload your highest qualification certificate (PDF or image)',
        validators=[
            FileExtensionValidator(
                allowed_extensions=['pdf', 'jpg', 'jpeg', 'png']
            )
        ],
        null=True,
        blank=True
    )
    subjects = models.ManyToManyField(
        Subject,
        related_name='teachers',
        limit_choices_to={'code__in': [code for code, _ in SUBJECT_CHOICES]}
    )
    is_class_teacher = models.BooleanField(default=False)
    grade = models.ForeignKey(
        Grade, 
        on_delete=models.SET_NULL, 
        null=True, 
        blank=True,
        related_name='teachers'
    )

    class Meta:
        verbose_name = 'Teacher'
        verbose_name_plural = 'Teachers'

    def __str__(self):
        return self.get_full_name()

    def get_absolute_url(self):
        return reverse('teacher_detail', kwargs={'pk': self.pk})

    @property
    def age(self):
        today = date.today()
        return today.year - self.date_of_birth.year - (
            (today.month, today.day) < (self.date_of_birth.month, self.date_of_birth.day)
        )

    @property
    def gross_salary(self):
        return self.basic_salary

    @property
    def total_deductions(self):
        """Calculate total deductions from the latest salary record"""
        latest_salary = self.salaries.order_by('-month').first()
        if latest_salary:
            return latest_salary.deduction_items.aggregate(
                total=models.Sum('amount')
            )['total'] or 0
        return 0

    @property
    def net_salary(self):
        return self.gross_salary - self.total_deductions

    class Meta:
        ordering = ['first_name', 'last_name']

    def save(self, *args, **kwargs):
        if not self.position:
            self.position = 'TEACHER'
        
        # Create user account if email exists and no user is linked
        if not hasattr(self, 'user') and self.email:
            # Create user account
            user = User.objects.create_user(
                username=self.email,
                email=self.email,
                password='Bdmis@7878',
                first_name=self.first_name,
                last_name=self.last_name
            )
            # Add user to Teachers group
            teachers_group = Group.objects.get_or_create(name='Teachers')[0]
            user.groups.add(teachers_group)
        
        super().save(*args, **kwargs)
        
        # Update grade's class teacher after saving
        if self.is_class_teacher and self.grade:
            self.grade.class_teacher = self
            self.grade.save()

    def get_initials(self):
        """Return the teacher's initials"""
        return f"{self.first_name[0]}{self.last_name[0]}".upper()

    def get_full_name(self):
        """Return the teacher's full name"""
        return f"{self.first_name} {self.last_name}"

class Student(models.Model):
    user = models.OneToOneField(
        User,
        on_delete=models.CASCADE,
        null=True,
        blank=True,
        related_name='student_profile'
    )
    GENDER_CHOICES = [
        ('M', 'Male'),
        ('F', 'Female'),
        ('O', 'Other')
    ]
    
    TERM_CHOICES = [
        (1, 'Term 1'),
        (2, 'Term 2'),
        (3, 'Term 3')
    ]
    
    # Basic Information
    admission_number = models.CharField(max_length=50, unique=True)
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    date_of_birth = models.DateField()
    gender = models.CharField(max_length=1, choices=GENDER_CHOICES)
    location = models.CharField(
        max_length=10,
        choices=LOCATION_CHOICES,
        default='MAIN',
        help_text="School location: Main or Annex"
    )
    grade = models.ForeignKey(
        'Grade', 
        on_delete=models.SET_NULL, 
        null=True,
        related_name='students'
    )
    branch = models.ForeignKey(
        Branch,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='students'
    )
    
    # Parent Information
    parent_name = models.CharField(max_length=100, blank=True, null=True)
    parent_phone = models.CharField(max_length=20, blank=True, null=True)
    parent_email = models.EmailField(blank=True, null=True)
    parent_occupation = models.CharField(max_length=100, blank=True, null=True)
    parent_id_number = models.CharField(max_length=20, blank=True, null=True, verbose_name="Parent ID Number")
    
    # Guardian Information
    guardian_name = models.CharField(max_length=100, blank=True, null=True)
    guardian_phone = models.CharField(max_length=20, blank=True, null=True)
    guardian_email = models.EmailField(blank=True, null=True)
    guardian_occupation = models.CharField(max_length=100, blank=True, null=True)
    guardian_id_number = models.CharField(max_length=20, blank=True, null=True, verbose_name="Guardian ID Number")
    
    # Academic Information
    previous_grade = models.ForeignKey('Grade', on_delete=models.SET_NULL, null=True, blank=True, related_name='previous_students')
    academic_year = models.CharField(
        max_length=9, 
        help_text="Format: YYYY-YYYY",
        null=True,  # Make it nullable
        blank=True  # Allow blank in forms
    )
    
    # System fields
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    photo = models.ImageField(
        upload_to='student_photos/',
        null=True,
        blank=True,
        verbose_name='Profile Photo',
        help_text='Upload a profile photo (optional)'
    )
    term_fees = models.DecimalField(max_digits=10, decimal_places=2, default=15000)
    current_term = models.IntegerField(choices=TERM_CHOICES, default=1)
    birth_certificate_no = models.CharField(max_length=50, blank=True, null=True, verbose_name="Birth Certificate Number")
    
    # New fee fields
    term1_fees = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        help_text="Term 1 fees",
        default=0
    )
    term2_fees = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        help_text="Term 2 fees",
        default=0
    )
    term3_fees = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        help_text="Term 3 fees",
        default=0
    )
    
    def get_term_fees(self, term=None):
        """Get fees for specific term or current term"""
        term = term or self.current_term
        if term == 1:
            return self.term1_fees
        elif term == 2:
            return self.term2_fees
        elif term == 3:
            return self.term3_fees
        return 0

    def get_previous_balance(self):
        """Get balance from previous terms"""
        current_term = self.current_term
        total_previous = 0
        if current_term > 1:
            for term in range(1, current_term):
                term_fee = self.get_term_fees(term)
                term_paid = self.payments.filter(term=term).aggregate(
                    total=Sum('amount')
                )['total'] or 0
                total_previous += term_fee - term_paid
        return total_previous

    def get_total_due(self):
        """Get total amount due including current term and previous balance"""
        return self.get_term_fees() + self.get_previous_balance()

    def get_balance(self):
        """Get current overall balance"""
        # Calculate total fees applicable up to current term
        owed = 0
        if self.current_term >= 1: owed += self.term1_fees
        if self.current_term >= 2: owed += self.term2_fees
        if self.current_term >= 3: owed += self.term3_fees
        
        paid = self.get_total_paid()
        return owed - paid

    def get_total_fees(self):
        """Get total fees for current academic year"""
        return self.term1_fees + self.term2_fees + self.term3_fees
    
    def get_paid_amount(self):
        """Get total amount paid for current academic year"""
        current_year = timezone.now().year
        return self.payments.filter(
            date__year=current_year
        ).aggregate(
            total=Sum('amount')
        )['total'] or 0
    
    def get_pending_amount(self):
        """Get pending fee amount"""
        return self.get_total_fees() - self.get_paid_amount()
    
    def is_fully_paid(self):
        """Check if all fees are paid"""
        return self.get_pending_amount() <= 0
    
    def get_term_paid_amount(self, term):
        """Get total amount paid for specific term"""
        return self.payments.filter(term=term).aggregate(
            total=Sum('amount')
        )['total'] or 0

    def get_term_balance(self, term):
        """Get balance for specific term"""
        if term == 1:
            term_fee = self.term1_fees
        elif term == 2:
            term_fee = self.term2_fees
        else:
            term_fee = self.term3_fees
        
        term_paid = self.get_term_paid_amount(term)
        return term_fee - term_paid
    
    def get_total_balance(self):
        """Get total balance across all terms"""
        total_fees = self.get_total_fees()
        total_paid = self.get_total_paid()
        return total_fees - total_paid
    
    def get_total_paid(self):
        """Calculate total amount paid by student"""
        total = self.payments.aggregate(
            total=Sum('amount')
        )['total'] or 0
        return total
    
    def get_payment_status(self):
        """Get payment status"""
        balance = self.get_balance()
        if balance <= 0:
            return 'Paid'
        elif balance < self.term_fees:
            return 'Partial'
        return 'Unpaid'

    def get_term_payment_status(self, term):
        """Get payment status for specific term"""
        balance = self.get_term_balance(term)
        if balance <= 0:
            return 'PAID'
        elif self.get_term_paid_amount(term) > 0:
            return 'PARTIAL'
        return 'UNPAID'

    def get_formatted_balance(self):
        """Get formatted balance"""
        return f"KES {self.get_balance():,}"

    def get_formatted_total_paid(self):
        """Get formatted total paid"""
        return f"KES {self.get_total_paid():,}"

    def get_formatted_total_fees(self):
        """Get formatted total fees"""
        return f"KES {self.get_total_fees():,}"

    def __str__(self):
        return f"{self.first_name} {self.last_name} ({self.admission_number})"

    def save(self, *args, **kwargs):
        # Update term fees from grade if grade is set
        if self.grade:
            self.term1_fees = self.grade.term1_fees
            self.term2_fees = self.grade.term2_fees
            self.term3_fees = self.grade.term3_fees
            
        # Handle photo deletion if needed
        if self.pk:
            old_instance = Student.objects.get(pk=self.pk)
            if old_instance.photo and self.photo != old_instance.photo:
                old_instance.photo.delete(save=False)
                
        super().save(*args, **kwargs)

    def delete(self, *args, **kwargs):
        # Update delete method to handle photo
        if self.photo:
            self.photo.delete(save=False)
        super(Student, self).delete(*args, **kwargs)

    @classmethod
    def get_total_count(cls):
        return cls.objects.count()
    
    @classmethod
    def get_by_grade_level(cls):
        return cls.objects.values('grade__level', 'grade__name').annotate(count=Count('id'))

    @classmethod
    def get_recent(cls, limit=5):
        return cls.objects.select_related('grade').order_by('-created_at')[:limit]

    @property
    def age(self):
        today = date.today()
        born = self.date_of_birth
        age = today.year - born.year
        # Adjust age if birthday hasn't occurred this year
        if today.month < born.month or (today.month == born.month and today.day < born.day):
            age -= 1
        return age

    @property
    def assessments(self):
        """Get all assessment results for the student"""
        return AssessmentResult.objects.filter(assessment__student=self)

    def get_assessment_counts(self):
        """Get counts of assessment results by performance level"""
        assessments = self.assessments
        counts = {
            'exceeding': 0,
            'meeting': 0,
            'approaching': 0,
            'below': 0
        }
        
        for assessment in assessments:
            level = assessment.performance_level
            if level == '4':
                counts['exceeding'] += 1
            elif level == '3':
                counts['meeting'] += 1
            elif level == '2':
                counts['approaching'] += 1
            elif level == '1':
                counts['below'] += 1
                
        return counts

    def get_performance_level(self, score):
        """Helper method to determine performance level"""
        if score >= 4:
            return 'EXCEEDING'
        elif score >= 3:
            return 'MEETING'
        elif score >= 2:
            return 'APPROACHING'
        else:
            return 'BELOW'

    def get_full_name(self):
        """Returns the student's full name."""
        return f"{self.first_name} {self.last_name}"

    # Alternative as a property if you prefer
    @property
    def full_name(self):
        """Returns the student's full name."""
        return f"{self.first_name} {self.last_name}"

    def get_payment_icon(self):
        """Return the appropriate Bootstrap icon class for payment methods"""
        icons = {
            'CASH': 'cash',
            'BANK_TRANSFER': 'bank',
            'MPESA': 'phone',
            'CARD': 'credit-card',
            'CHEQUE': 'file-text',
            'OTHER': 'wallet2'
        }
        return icons.get(self.method, 'wallet2')

    def get_class_position(self):
        """Get student's position in class based on average score"""
        try:
            # Get all students in the same grade ordered by average score
            students = Student.objects.filter(grade=self.grade)\
                              .annotate(avg_score=Avg('assessments__score'))\
                              .order_by('-avg_score')
            
            # Find this student's position
            for i, student in enumerate(students, 1):
                if student.id == self.id:
                    return i
            return None
        except Exception:
            return None

    def get_attendance_stats(self, start_date=None, end_date=None):
        """Get attendance statistics for the student"""
        records = self.attendance_records.all()
        
        if start_date:
            records = records.filter(date__gte=start_date)
        if end_date:
            records = records.filter(date__lte=end_date)

        total = records.count()
        present = records.filter(status='PRESENT').count()
        absent = records.filter(status='ABSENT').count()
        late = records.filter(status='LATE').count()

        return {
            'total_days': total,
            'present_count': present + late,  # Count late as present
            'present_days': present + late,  # Count late as present
            'absent_count': absent,
            'absent_days': absent,
            'late_days': late,
            'present_percentage': round((present + late) * 100 / total if total > 0 else 0, 1),
            'absent_percentage': round(absent * 100 / total if total > 0 else 0, 1),
            'attendance_rate': round((present + late) * 100 / total if total > 0 else 0, 1)
        }

    def get_recent_attendance(self, days=10):
        """Get recent attendance records"""
        return self.attendance_records.all()[:days]

    def get_initials(self):
        """Get student's initials for avatar placeholder"""
        return f"{self.first_name[0]}{self.last_name[0]}".upper()

    @property
    def recent_payments(self):
        """Get recent payments"""
        return self.payments.all().order_by('-created_at')[:5]

    def get_pending_fees(self):
        """Get pending fees for current term"""
        total_fees = self.term_fees
        paid_amount = self.get_total_paid()
        return max(total_fees - paid_amount, 0)  # Don't return negative values

    def get_photo_url(self):
        """Return the photo URL or None"""
        if self.photo:
            return self.photo.url
        return None

    def get_term_paid_amount(self, term):
        """Get the total amount paid for a specific term"""
        try:
            term_payments = self.payments.filter(term=int(term))
            return term_payments.aggregate(Sum('amount'))['amount__sum'] or 0
        except (ValueError, AttributeError):
            return 0

    def get_term_payment_status(self, term):
        """Get payment status for specific term"""
        balance = self.get_term_balance(term)
        if balance <= 0:
            return 'PAID'
        elif self.get_term_paid_amount(term) > 0:
            return 'PARTIAL'
        return 'UNPAID'

class School(models.Model):
    CATEGORY_CHOICES = [
        ('PUB', 'Public'),
        ('PRI', 'Private'),
        ('INT', 'International')
    ]
    
    name = models.CharField(max_length=200)
    category = models.CharField(max_length=3, choices=CATEGORY_CHOICES, default='PRI')
    address = models.TextField()
    phone = models.CharField(max_length=20)
    email = models.EmailField()
    website = models.URLField(blank=True)
    motto = models.CharField(max_length=200, blank=True)
    logo = models.ImageField(
        upload_to='school_logos/',
        null=True,
        blank=True,
        help_text='School logo (optional)'
    )
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

    class Meta:
        ordering = ['name']

class Assessment(models.Model):
    ASSESSMENT_TYPES = [
        ('weekly', 'Weekly Assessment'),
        ('opener', 'Opener Assessment'),
        ('mid-term', 'Mid-Term Assessment'),
        ('end-term', 'End-Term Assessment'),
    ]

    student = models.ForeignKey(Student, on_delete=models.CASCADE, related_name='assessments')
    assessment_type = models.CharField(max_length=20, choices=ASSESSMENT_TYPES)
    term = models.IntegerField()
    date = models.DateField()
    recorded_by = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    remarks = models.TextField(blank=True, null=True)
    # For weekly assessments, capture week number (e.g., 1-14)
    week_number = models.IntegerField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def get_assessment_type_display(self):
        # Convert to lowercase for comparison
        assessment_type = self.assessment_type.lower()
        # Create a dictionary with lowercase keys
        type_dict = {k.lower(): v for k, v in dict(self.ASSESSMENT_TYPES).items()}
        return type_dict.get(assessment_type, self.assessment_type)

    def get_score(self, subject):
        result = self.results.filter(subject=subject).first()
        if not result:
            return None
        
        if self.assessment_type == 'weekly':
            return result.weekly_score
        elif self.assessment_type == 'opener':
            return result.opener_score
        elif self.assessment_type == 'mid-term':
            return result.midpoint_score
        elif self.assessment_type == 'end-term':
            return result.endpoint_score
        return None

    def get_average_performance(self):
        results = self.results.all()
        if not results:
            return 0
        
        total = 0
        count = 0
        for result in results:
            score = self.get_score(result.subject)
            if score is not None:
                total += score
                count += 1
        
        return round((total / count) * 100) if count > 0 else 0

    def get_average_score(self):
        """Alias for get_average_performance for backward compatibility"""
        return self.get_average_performance()

    def __str__(self):
        return f"{self.student.get_full_name()} - {self.get_assessment_type_display()} - Term {self.term}"

    class Meta:
        ordering = ['-date']
        constraints = [
            # For non-weekly assessments (opener, mid-term, end-term): one per term
            models.UniqueConstraint(
                fields=['student', 'assessment_type', 'term'],
                condition=~Q(assessment_type='weekly'),
                name='unique_non_weekly_assessment_per_term'
            ),
            # For weekly assessments: one per student/term/week
            models.UniqueConstraint(
                fields=['student', 'assessment_type', 'term', 'week_number'],
                condition=Q(assessment_type='weekly'),
                name='unique_weekly_assessment_per_week'
            ),
        ]

class AssessmentResult(models.Model):
    PERFORMANCE_LEVELS = [
        ('1', 'Below Expectations'),
        ('2', 'Approaching Expectations'),
        ('3', 'Meets Expectations'),
        ('4', 'Exceeds Expectations')
    ]

    assessment = models.ForeignKey(Assessment, on_delete=models.CASCADE, related_name='results')
    subject = models.ForeignKey(Subject, on_delete=models.CASCADE)
    performance_level = models.CharField(max_length=1, choices=PERFORMANCE_LEVELS)
    remarks = models.TextField(blank=True, null=True)
    marks = models.DecimalField(max_digits=5, decimal_places=2, null=True, blank=True)
    weekly_score = models.DecimalField(max_digits=5, decimal_places=2, null=True, blank=True)
    opener_score = models.DecimalField(max_digits=5, decimal_places=2, null=True, blank=True)
    midpoint_score = models.DecimalField(max_digits=5, decimal_places=2, null=True, blank=True)
    endpoint_score = models.DecimalField(max_digits=5, decimal_places=2, null=True, blank=True)
    
    class Meta:
        unique_together = ['assessment', 'subject']

    def save(self, *args, **kwargs):
        # Calculate performance level based on marks if provided
        if self.marks is not None:
            marks_float = float(self.marks)
            if marks_float >= 80:
                self.performance_level = '4'
            elif marks_float >= 60:
                self.performance_level = '3'
            elif marks_float >= 40:
                self.performance_level = '2'
            else:
                self.performance_level = '1'
        super().save(*args, **kwargs)

    def get_score(self):
        """Get the appropriate score based on assessment type"""
        if self.assessment.assessment_type == 'weekly':
            return self.weekly_score
        elif self.assessment.assessment_type == 'opener':
            return self.opener_score
        elif self.assessment.assessment_type == 'mid-term':
            return self.midpoint_score
        elif self.assessment.assessment_type == 'end-term':
            return self.endpoint_score
        return None

    def get_performance_level_display(self):
        """Get the display text for the performance level"""
        return dict(self.PERFORMANCE_LEVELS).get(self.performance_level, '')

class Term(models.Model):
    TERM_CHOICES = [
        (1, 'Term 1'),
        (2, 'Term 2'),
        (3, 'Term 3'),
    ]
    
    number = models.IntegerField(choices=TERM_CHOICES)
    year = models.IntegerField()
    start_date = models.DateTimeField()
    end_date = models.DateTimeField()
    is_current = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"Term {self.number} - {self.year}"

    class Meta:
        unique_together = ['number', 'year']
        ordering = ['-year', 'number']

    def save(self, *args, **kwargs):
        if self.is_current:
            # Set all other terms to not current
            Term.objects.filter(is_current=True).update(is_current=False)
        super().save(*args, **kwargs)

class Payment(models.Model):
    PAYMENT_STATUS = (
        ('PENDING', 'Pending'),
        ('COMPLETED', 'Completed'),
        ('FAILED', 'Failed')
    )
    
    PAYMENT_METHODS = (
        ('CASH', 'Cash'),
        ('MPESA', 'M-Pesa'),
        ('BANK', 'Bank Transfer')
    )
    
    student = models.ForeignKey(
        Student, 
        on_delete=models.CASCADE,
        related_name='payments'
    )
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    payment_method = models.CharField(max_length=10, choices=PAYMENT_METHODS, default='CASH')
    phone_number = models.CharField(max_length=15, blank=True, null=True)
    transaction_id = models.CharField(max_length=50, blank=True, null=True)
    reference_number = models.CharField(max_length=20, unique=True)
    status = models.CharField(max_length=10, choices=PAYMENT_STATUS, default='COMPLETED')
    date = models.DateTimeField(default=timezone.now)
    term = models.IntegerField(choices=TERM_CHOICES)
    checkout_request_id = models.CharField(max_length=100, blank=True, null=True)

    def __str__(self):
        return f"{self.student.get_full_name()} - {self.amount} ({self.date})"

    def save(self, *args, **kwargs):
        from django.utils import timezone
        if self.date and timezone.is_naive(self.date):
            self.date = timezone.make_aware(self.date)
        super().save(*args, **kwargs)

    class Meta:
        ordering = ['-date']

class Salary(models.Model):
    employee = models.ForeignKey(
        Employee,
        on_delete=models.CASCADE,
        related_name='salaries'
    )
    month = models.DateField()
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    status = models.CharField(
        max_length=20,
        choices=[
            ('PENDING', 'Pending'),
            ('PAID', 'Paid'),
            ('CANCELLED', 'Cancelled')
        ],
        default='PENDING'
    )
    payment_date = models.DateField(null=True, blank=True)
    remarks = models.TextField(blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        unique_together = ['employee', 'month']
        ordering = ['-month', '-payment_date']

    def __str__(self):
        month_str = self.month.strftime('%B %Y') if self.month else 'No Date'
        return f"{self.employee.get_full_name()} - {month_str}"

class Allowance(models.Model):
    ALLOWANCE_TYPES = [
        ('HOUSE', 'House Allowance'),
        ('TRANSPORT', 'Transport Allowance'),
        ('MEDICAL', 'Medical Allowance'),
        ('OVERTIME', 'Overtime'),
        ('OTHER', 'Other')
    ]

    salary = models.ForeignKey(Salary, on_delete=models.CASCADE, related_name='allowance_items')
    type = models.CharField(max_length=20, choices=ALLOWANCE_TYPES)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    description = models.CharField(max_length=200, blank=True)

    def __str__(self):
        return f"{self.get_type_display()} - {self.amount}"

class Deduction(models.Model):
    DEDUCTION_TYPES = [
        ('NSSF', 'NSSF'),
        ('NHIF', 'NHIF'),
        ('PAYE', 'PAYE'),
        ('ADVANCE', 'Salary Advance'),
        ('LOAN', 'Loan'),
        ('OTHER', 'Other')
    ]

    salary = models.ForeignKey(Salary, on_delete=models.CASCADE, related_name='deduction_items')
    type = models.CharField(max_length=20, choices=DEDUCTION_TYPES)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    description = models.CharField(max_length=200, blank=True)

    def __str__(self):
        return f"{self.get_type_display()} - {self.amount}"

class Leave(models.Model):
    LEAVE_TYPES = [
        ('SICK', 'Sick Leave'),
        ('ANNUAL', 'Annual Leave'),
        ('MATERNITY', 'Maternity Leave'),
        ('PATERNITY', 'Paternity Leave'),
        ('OTHER', 'Other')
    ]
    
    LEAVE_STATUS = [
        ('PENDING', 'Pending'),
        ('APPROVED', 'Approved'),
        ('REJECTED', 'Rejected'),
        ('CANCELLED', 'Cancelled')
    ]
    
    employee = models.ForeignKey(
        Employee,
        on_delete=models.CASCADE,
        related_name='leaves'
    )
    leave_type = models.CharField(max_length=20, choices=LEAVE_TYPES)
    start_date = models.DateField()
    end_date = models.DateField()
    reason = models.TextField()
    status = models.CharField(
        max_length=20,
        choices=LEAVE_STATUS,
        default='PENDING'
    )
    approved_by = models.ForeignKey(
        User,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='approved_leaves'
    )
    approved_date = models.DateTimeField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ['-created_at']

    def __str__(self):
        return f"{self.employee.get_full_name()} - {self.get_leave_type_display()}"

    def get_duration(self):
        return (self.end_date - self.start_date).days + 1

class Attendance(models.Model):
    ATTENDANCE_STATUS = (
        ('PRESENT', 'Present'),
        ('ABSENT', 'Absent'),
        ('LATE', 'Late'),
    )
    
    TERM_CHOICES = [
        ('1', 'Term 1'),
        ('2', 'Term 2'),
        ('3', 'Term 3'),
    ]
    
    student = models.ForeignKey('Student', on_delete=models.CASCADE, related_name='attendance_records')
    date = models.DateField()
    status = models.CharField(max_length=10, choices=ATTENDANCE_STATUS)
    remarks = models.TextField(blank=True, null=True)
    recorded_by = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    term = models.CharField(max_length=1, choices=TERM_CHOICES, default='1')
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    class Meta:
        unique_together = ['student', 'date']
        ordering = ['-date']
    
    def __str__(self):
        return f"{self.student.get_full_name()} - {self.date} - {self.get_status_display()}"

class Schedule(models.Model):
    DAY_CHOICES = [
        ('MONDAY', 'Monday'),
        ('TUESDAY', 'Tuesday'),
        ('WEDNESDAY', 'Wednesday'),
        ('THURSDAY', 'Thursday'),
        ('FRIDAY', 'Friday'),
        ('SATURDAY', 'Saturday'),
        ('SUNDAY', 'Sunday'),
    ]
    
    teacher = models.ForeignKey(Teacher, on_delete=models.CASCADE)
    subject = models.ForeignKey(Subject, on_delete=models.CASCADE)
    grade = models.ForeignKey(Grade, on_delete=models.CASCADE)
    day = models.CharField(max_length=10, choices=DAY_CHOICES)
    start_time = models.TimeField()
    end_time = models.TimeField()
    term = models.CharField(max_length=20, choices=TERM_CHOICES, null=True, blank=True)
    
    class Meta:
        ordering = ['day', 'start_time']
        
    def __str__(self):
        return f"{self.teacher.get_full_name()} - {self.subject.name} ({self.get_day_display()})"

class SMSMessage(models.Model):
    RECIPIENT_TYPES = [
        ('ALL_STUDENTS', 'All Students (Parents)'),
        ('GRADE', 'Students of Specific Grade/Class'),
        ('LOCATION_MAIN', 'Students of Main School'),
        ('LOCATION_ANNEX', 'Students of Annex School'),
        ('FEES_REMINDER', 'All Students with Fees Reminders'),
        ('ALL_TEACHERS', 'All Teachers'),
        ('INDIVIDUAL', 'Individual Student'),
    ]
    
    STATUS_CHOICES = [
        ('PENDING', 'Pending'),
        ('SENT', 'Sent'),
        ('FAILED', 'Failed'),
    ]
    
    message = models.TextField()
    recipient_type = models.CharField(max_length=20, choices=RECIPIENT_TYPES)
    specific_grade = models.ForeignKey(
        Grade, 
        on_delete=models.SET_NULL,
        null=True, 
        blank=True,
        help_text="Required for grade-specific messages"
    )
    specific_student = models.ForeignKey(
        Student,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        help_text="Required for individual student messages"
    )
    location = models.CharField(
        max_length=10,
        choices=LOCATION_CHOICES,
        null=True,
        blank=True,
        help_text="School location filter"
    )
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='PENDING')
    sent_at = models.DateTimeField(null=True, blank=True)
    sent_by = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    response_data = models.JSONField(null=True, blank=True)
    recipients_count = models.IntegerField(default=0, help_text="Number of recipients")
    created_at = models.DateTimeField(auto_now_add=True)
    
    class Meta:
        ordering = ['-created_at']
    
    def send(self):
        from .utils.sms import send_bulk_sms, format_phone_number
        
        # Get recipient phone numbers based on type
        phone_numbers = []
        
        if self.recipient_type == 'ALL_STUDENTS':
            # All students - get parent or guardian phone (prefer parent, fallback to guardian)
            students = Student.objects.exclude(
                Q(parent_phone__isnull=True) | Q(parent_phone='')
            ).exclude(
                Q(guardian_phone__isnull=True) | Q(guardian_phone='')
            )
            
            for student in students:
                # Prefer parent phone, fallback to guardian phone
                phone = student.parent_phone or student.guardian_phone
                if phone:
                    phone_numbers.append(phone)
            
        elif self.recipient_type == 'GRADE' and self.specific_grade:
            # Students of specific grade/class
            students = Student.objects.filter(
                grade=self.specific_grade
            ).exclude(
                Q(parent_phone__isnull=True) | Q(parent_phone='')
            )
            
            for student in students:
                phone = student.parent_phone or student.guardian_phone
                if phone:
                    phone_numbers.append(phone)
                    
        elif self.recipient_type == 'LOCATION_MAIN':
            # Students of Main School
            students = Student.objects.filter(
                location='MAIN'
            ).exclude(
                Q(parent_phone__isnull=True) | Q(parent_phone='')
            )
            
            for student in students:
                phone = student.parent_phone or student.guardian_phone
                if phone:
                    phone_numbers.append(phone)
                    
        elif self.recipient_type == 'LOCATION_ANNEX':
            # Students of Annex School
            students = Student.objects.filter(
                location='ANNEX'
            ).exclude(
                Q(parent_phone__isnull=True) | Q(parent_phone='')
            )
            
            for student in students:
                phone = student.parent_phone or student.guardian_phone
                if phone:
                    phone_numbers.append(phone)
                    
        elif self.recipient_type == 'FEES_REMINDER':
            # All students with outstanding fees
            students = Student.objects.annotate(
                total_fees=F('term1_fees') + F('term2_fees') + F('term3_fees'),
                total_paid=Coalesce(
                    Sum('payments__amount', output_field=DecimalField(max_digits=10, decimal_places=2)),
                    Value(0),
                    output_field=DecimalField(max_digits=10, decimal_places=2)
                ),
                balance=F('total_fees') - F('total_paid')
            ).filter(
                balance__gt=0
            )
            
            for student in students:
                phone = student.parent_phone or student.guardian_phone
                if phone:
                    phone_numbers.append(phone)
                    
        elif self.recipient_type == 'ALL_TEACHERS':
            # All teachers
            teachers = Teacher.objects.filter(
                status='ACTIVE'
            ).exclude(
                Q(phone__isnull=True) | Q(phone='')
            )
            
            phone_numbers = list(teachers.values_list('phone', flat=True))
            
        elif self.recipient_type == 'INDIVIDUAL' and self.specific_student:
            # Individual student
            phone = self.specific_student.parent_phone or self.specific_student.guardian_phone
            if phone:
                phone_numbers = [phone]
        
        # Remove duplicates and empty values
        phone_numbers = list(set(filter(None, phone_numbers)))
        
        # Store recipient count
        self.recipients_count = len(phone_numbers)
        
        if not phone_numbers:
            self.status = 'FAILED'
            self.response_data = {'error': 'No valid phone numbers found'}
            self.save()
            return False, 'No valid phone numbers found'
        
        # Format phone numbers
        formatted_numbers = []
        for phone in phone_numbers:
            try:
                formatted = format_phone_number(phone)
                formatted_numbers.append(formatted)
            except:
                continue
        
        if not formatted_numbers:
            self.status = 'FAILED'
            self.response_data = {'error': 'No valid phone numbers after formatting'}
            self.save()
            return False, 'No valid phone numbers after formatting'
        
        # Send SMS
        success, response = send_bulk_sms(formatted_numbers, self.message)
        
        # Update status
        self.status = 'SENT' if success else 'FAILED'
        self.sent_at = timezone.now() if success else None
        self.response_data = response
        self.save()
        
        return success, response

class EmployeeAttendance(models.Model):
    STATUS_CHOICES = [
        ('PRESENT', 'Present'),
        ('ABSENT', 'Absent'),
        ('LATE', 'Late'),
        ('HALF_DAY', 'Half Day')
    ]
    
    employee = models.ForeignKey(
        'Employee',
        on_delete=models.CASCADE,
        related_name='attendance_records'
    )
    date = models.DateField()
    status = models.CharField(max_length=10, choices=STATUS_CHOICES)
    check_in = models.TimeField(null=True, blank=True)
    check_out = models.TimeField(null=True, blank=True)
    remarks = models.TextField(blank=True)
    recorded_by = models.ForeignKey(
        User,
        on_delete=models.SET_NULL,
        null=True
    )
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        unique_together = ['employee', 'date']
        ordering = ['-date', '-created_at']

    def __str__(self):
        return f"{self.employee.get_full_name()} - {self.date} ({self.get_status_display()})"

class Vehicle(models.Model):
    VEHICLE_TYPES = [
        ('BUS', 'Bus'),
        ('VAN', 'Van'),
        ('MINIBUS', 'Minibus'),
        ('CAR', 'Car'),
    ]
    
    STATUS_CHOICES = [
        ('ACTIVE', 'Active'),
        ('INACTIVE', 'Inactive'),
        ('MAINTENANCE', 'Under Maintenance'),
    ]
    
    vehicle_number = models.CharField(max_length=50, unique=True, verbose_name="Vehicle Number/Plate")
    vehicle_type = models.CharField(max_length=20, choices=VEHICLE_TYPES, default='BUS')
    make = models.CharField(max_length=100, blank=True)
    model = models.CharField(max_length=100, blank=True)
    year = models.IntegerField(null=True, blank=True)
    capacity = models.PositiveIntegerField(help_text="Maximum number of passengers")
    driver = models.ForeignKey(
        'Employee',
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='vehicles',
        limit_choices_to={'position__in': ['ADMIN', 'SUPPORT']}
    )
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='ACTIVE')
    location = models.CharField(
        max_length=10,
        choices=LOCATION_CHOICES,
        default='MAIN',
        help_text="School location: Main or Annex"
    )
    insurance_expiry = models.DateField(null=True, blank=True)
    registration_expiry = models.DateField(null=True, blank=True)
    notes = models.TextField(blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    class Meta:
        ordering = ['vehicle_number']
    
    def __str__(self):
        return f"{self.vehicle_number} - {self.get_vehicle_type_display()}"
    
    @property
    def is_available(self):
        return self.status == 'ACTIVE'
    
    def get_current_students_count(self):
        """Get current number of students assigned to this vehicle"""
        return self.student_assignments.filter(is_active=True).count()
    
    def get_available_seats(self):
        """Get available seats"""
        return self.capacity - self.get_current_students_count()

class Route(models.Model):
    name = models.CharField(max_length=200, unique=True)
    description = models.TextField(blank=True)
    start_location = models.CharField(max_length=200)
    end_location = models.CharField(max_length=200)
    # Coordinates for start location
    start_latitude = models.DecimalField(max_digits=9, decimal_places=6, null=True, blank=True, help_text="Latitude for start location")
    start_longitude = models.DecimalField(max_digits=9, decimal_places=6, null=True, blank=True, help_text="Longitude for start location")
    # Coordinates for end location
    end_latitude = models.DecimalField(max_digits=9, decimal_places=6, null=True, blank=True, help_text="Latitude for end location")
    end_longitude = models.DecimalField(max_digits=9, decimal_places=6, null=True, blank=True, help_text="Longitude for end location")
    # School coordinates (default pickup point)
    school_latitude = models.DecimalField(max_digits=9, decimal_places=6, null=True, blank=True, help_text="School latitude")
    school_longitude = models.DecimalField(max_digits=9, decimal_places=6, null=True, blank=True, help_text="School longitude")
    distance = models.DecimalField(max_digits=8, decimal_places=2, null=True, blank=True, help_text="Distance in kilometers")
    estimated_time = models.CharField(max_length=50, blank=True, help_text="e.g., '45 minutes'")
    fee_per_term = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        default=0,
        help_text="Transport fee per term for this route"
    )
    location = models.CharField(
        max_length=10,
        choices=LOCATION_CHOICES,
        default='MAIN',
        help_text="School location: Main or Annex"
    )
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    class Meta:
        ordering = ['name']
    
    def __str__(self):
        return f"{self.name} ({self.start_location} - {self.end_location})"
    
    def get_students_count(self):
        """Get number of students on this route"""
        return self.student_assignments.filter(is_active=True).count()

class StudentTransportAssignment(models.Model):
    student = models.ForeignKey(
        Student,
        on_delete=models.CASCADE,
        related_name='transport_assignments'
    )
    route = models.ForeignKey(
        Route,
        on_delete=models.CASCADE,
        related_name='student_assignments'
    )
    vehicle = models.ForeignKey(
        Vehicle,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='student_assignments'
    )
    pickup_location = models.CharField(max_length=200, blank=True, help_text="Specific pickup point")
    dropoff_location = models.CharField(max_length=200, blank=True, help_text="Specific dropoff point")
    # Coordinates for pickup location
    pickup_latitude = models.DecimalField(max_digits=9, decimal_places=6, null=True, blank=True, help_text="Latitude for pickup location")
    pickup_longitude = models.DecimalField(max_digits=9, decimal_places=6, null=True, blank=True, help_text="Longitude for pickup location")
    # Coordinates for dropoff location
    dropoff_latitude = models.DecimalField(max_digits=9, decimal_places=6, null=True, blank=True, help_text="Latitude for dropoff location")
    dropoff_longitude = models.DecimalField(max_digits=9, decimal_places=6, null=True, blank=True, help_text="Longitude for dropoff location")
    pickup_time = models.TimeField(null=True, blank=True)
    dropoff_time = models.TimeField(null=True, blank=True)
    is_active = models.BooleanField(default=True)
    start_date = models.DateField(default=timezone.now)
    end_date = models.DateField(null=True, blank=True)
    notes = models.TextField(blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    class Meta:
        unique_together = ['student', 'route']
        ordering = ['-created_at']
    
    def __str__(self):
        return f"{self.student.get_full_name()} - {self.route.name}"
    
    def clean(self):
        if self.vehicle and self.vehicle.get_current_students_count() >= self.vehicle.capacity:
            if not self.pk or (self.pk and self.is_active):  # Only check if new or reactivating
                raise ValidationError(f"Vehicle {self.vehicle.vehicle_number} is at full capacity.")

class TransportFee(models.Model):
    PAYMENT_STATUS = (
        ('PENDING', 'Pending'),
        ('COMPLETED', 'Completed'),
        ('FAILED', 'Failed')
    )
    
    PAYMENT_METHODS = (
        ('CASH', 'Cash'),
        ('MPESA', 'M-Pesa'),
        ('BANK', 'Bank Transfer')
    )
    
    student = models.ForeignKey(
        Student,
        on_delete=models.CASCADE,
        related_name='transport_fees'
    )
    route = models.ForeignKey(
        Route,
        on_delete=models.CASCADE,
        related_name='transport_fees'
    )
    term = models.IntegerField(choices=TERM_CHOICES)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    payment_method = models.CharField(max_length=10, choices=PAYMENT_METHODS, default='CASH')
    phone_number = models.CharField(max_length=15, blank=True, null=True)
    transaction_id = models.CharField(max_length=50, blank=True, null=True)
    reference_number = models.CharField(max_length=20, unique=True)
    status = models.CharField(max_length=10, choices=PAYMENT_STATUS, default='COMPLETED')
    date = models.DateTimeField(auto_now_add=True)
    notes = models.TextField(blank=True)
    
    class Meta:
        ordering = ['-date']
    
    def __str__(self):
        return f"{self.student.get_full_name()} - {self.route.name} - Term {self.term} - {self.amount}"

class FoodPlan(models.Model):
    name = models.CharField(max_length=200, unique=True)
    description = models.TextField(blank=True)
    meal_type = models.CharField(
        max_length=50,
        choices=[
            ('BREAKFAST', 'Breakfast'),
            ('LUNCH', 'Lunch'),
            ('DINNER', 'Dinner'),
            ('ALL', 'All Meals'),
            ('BREAKFAST_LUNCH', 'Breakfast & Lunch'),
            ('LUNCH_DINNER', 'Lunch & Dinner'),
        ],
        default='ALL'
    )
    fee_per_term = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        default=0,
        help_text="Food fee per term for this plan"
    )
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    class Meta:
        ordering = ['name']
    
    def __str__(self):
        return f"{self.name} ({self.get_meal_type_display()})"
    
    def get_students_count(self):
        """Get number of students on this food plan"""
        return self.student_assignments.filter(is_active=True).count()

class StudentFoodAssignment(models.Model):
    student = models.ForeignKey(
        Student,
        on_delete=models.CASCADE,
        related_name='food_assignments'
    )
    food_plan = models.ForeignKey(
        FoodPlan,
        on_delete=models.CASCADE,
        related_name='student_assignments'
    )
    is_active = models.BooleanField(default=True)
    start_date = models.DateField(default=timezone.now)
    end_date = models.DateField(null=True, blank=True)
    notes = models.TextField(blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    class Meta:
        unique_together = ['student', 'food_plan']
        ordering = ['-created_at']
    
    def __str__(self):
        return f"{self.student.get_full_name()} - {self.food_plan.name}"

class FoodFee(models.Model):
    PAYMENT_STATUS = (
        ('PENDING', 'Pending'),
        ('COMPLETED', 'Completed'),
        ('FAILED', 'Failed')
    )
    
    PAYMENT_METHODS = (
        ('CASH', 'Cash'),
        ('MPESA', 'M-Pesa'),
        ('BANK', 'Bank Transfer')
    )
    
    student = models.ForeignKey(
        Student,
        on_delete=models.CASCADE,
        related_name='food_fees'
    )
    food_plan = models.ForeignKey(
        FoodPlan,
        on_delete=models.CASCADE,
        related_name='food_fees'
    )
    term = models.IntegerField(choices=TERM_CHOICES)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    payment_method = models.CharField(max_length=10, choices=PAYMENT_METHODS, default='CASH')
    phone_number = models.CharField(max_length=15, blank=True, null=True)
    transaction_id = models.CharField(max_length=50, blank=True, null=True)
    reference_number = models.CharField(max_length=20, unique=True)
    status = models.CharField(max_length=10, choices=PAYMENT_STATUS, default='COMPLETED')
    date = models.DateTimeField(auto_now_add=True)
    notes = models.TextField(blank=True)
    
    class Meta:
        ordering = ['-date']
    
    def __str__(self):
        return f"{self.student.get_full_name()} - {self.food_plan.name} - Term {self.term} - {self.amount}"


class MealPricing(models.Model):
    """Model to store default pricing for each meal type"""
    meal_type = models.CharField(
        max_length=20,
        choices=[
            ('TEA_BREAK', 'Tea Break'),
            ('LUNCH', 'Lunch'),
            ('FRUITS', 'Fruits'),
        ],
        help_text="Type of meal"
    )
    price_per_day = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        help_text="Default price per day for this meal"
    )
    location = models.CharField(
        max_length=10,
        choices=LOCATION_CHOICES,
        default='MAIN',
        help_text="School location: Main or Annex"
    )
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    class Meta:
        ordering = ['meal_type']
        verbose_name_plural = "Meal Pricing"
        unique_together = ['meal_type', 'location']
    
    def __str__(self):
        return f"{self.get_meal_type_display()} - {self.get_location_display()} - KES {self.price_per_day} per day"


class StudentMealPayment(models.Model):
    """Model to track individual meal payments for students (Tea break, Lunch, Fruits)"""
    
    MEAL_TYPES = (
        ('TEA_BREAK', 'Tea Break'),
        ('LUNCH', 'Lunch'),
        ('FRUITS', 'Fruits'),
    )
    
    PAYMENT_FREQUENCY = (
        ('PER_DAY', 'Per Day'),
        ('MULTIPLE_DAYS', 'Multiple Days'),
        ('PER_WEEK', 'Per Week'),
        ('PER_MONTH', 'Per Month'),
        ('FULL_TERM', 'Full Term'),
    )
    
    PAYMENT_STATUS = (
        ('PENDING', 'Pending'),
        ('COMPLETED', 'Completed'),
        ('FAILED', 'Failed')
    )
    
    PAYMENT_METHODS = (
        ('CASH', 'Cash'),
        ('MPESA', 'M-Pesa'),
        ('BANK', 'Bank Transfer')
    )
    
    student = models.ForeignKey(
        Student,
        on_delete=models.CASCADE,
        related_name='meal_payments'
    )
    meal_type = models.CharField(
        max_length=20,
        choices=MEAL_TYPES,
        help_text="Type of meal: Tea Break, Lunch, or Fruits"
    )
    payment_frequency = models.CharField(
        max_length=20,
        choices=PAYMENT_FREQUENCY,
        default='MULTIPLE_DAYS',
        help_text="How often the student pays for this meal"
    )
    number_of_days = models.IntegerField(
        default=1,
        help_text="Number of days this payment covers"
    )
    amount = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        help_text="Amount paid for this meal"
    )
    payment_group = models.CharField(
        max_length=50,
        blank=True,
        null=True,
        help_text="Group identifier for payments made together (same transaction)"
    )
    payment_method = models.CharField(
        max_length=10,
        choices=PAYMENT_METHODS,
        default='CASH'
    )
    status = models.CharField(
        max_length=10,
        choices=PAYMENT_STATUS,
        default='COMPLETED'
    )
    payment_date = models.DateField(
        default=timezone.now,
        help_text="Date when payment was made"
    )
    start_date = models.DateField(
        help_text="Start date for this meal payment period"
    )
    end_date = models.DateField(
        null=True,
        blank=True,
        help_text="End date for this meal payment period (if applicable)"
    )
    phone_number = models.CharField(max_length=15, blank=True, null=True)
    transaction_id = models.CharField(max_length=50, blank=True, null=True)
    reference_number = models.CharField(
        max_length=50,
        unique=True,
        help_text="Unique reference number for this payment"
    )
    location = models.CharField(
        max_length=10,
        choices=LOCATION_CHOICES,
        default='MAIN',
        help_text="School location: Main or Annex"
    )
    notes = models.TextField(
        blank=True,
        help_text="Additional notes about this payment"
    )
    is_active = models.BooleanField(
        default=True,
        help_text="Whether this payment record is currently active"
    )
    days_consumed = models.IntegerField(
        default=0,
        help_text="Number of days already consumed from this payment"
    )
    days_remaining = models.IntegerField(
        default=0,
        help_text="Number of days remaining for this payment"
    )
    balance = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        default=0,
        help_text="Remaining balance for this payment"
    )
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    class Meta:
        ordering = ['-payment_date', '-created_at']
        indexes = [
            models.Index(fields=['student', 'meal_type', 'is_active']),
            models.Index(fields=['payment_date']),
        ]
    
    def __str__(self):
        return f"{self.student.get_full_name()} - {self.get_meal_type_display()} - {self.number_of_days} days - {self.amount}"
    
    def get_price_per_day(self):
        """Calculate price per day for this meal"""
        from decimal import ROUND_HALF_UP
        if self.number_of_days > 0:
            price = Decimal(str(self.amount)) / Decimal(str(self.number_of_days))
            return price.quantize(Decimal('0.01'), rounding=ROUND_HALF_UP)
        return Decimal(str(self.amount))
    
    def clean(self):
        """Validate the model"""
        if self.end_date and self.start_date and self.end_date < self.start_date:
            raise ValidationError("End date cannot be before start date.")
    
    def save(self, *args, **kwargs):
        """Override save to generate reference number if not provided"""
        if not self.reference_number:
            import uuid
            self.reference_number = f"MEAL-{uuid.uuid4().hex[:12].upper()}"
        
        # Fix invalid payment_frequency if it exists
        valid_frequencies = [choice[0] for choice in self.PAYMENT_FREQUENCY]
        if self.payment_frequency not in valid_frequencies:
            self.payment_frequency = 'MULTIPLE_DAYS'
        
        # Initialize days_remaining if not set
        if self.days_remaining == 0 and self.days_consumed == 0:
            self.days_remaining = self.number_of_days
        
        # Calculate days remaining and balance only if needed
        from decimal import ROUND_HALF_UP
        if not self.pk or 'days_consumed' in kwargs.get('update_fields', []) or 'number_of_days' in kwargs.get('update_fields', []):
            self.days_remaining = max(0, self.number_of_days - self.days_consumed)
            # Only recalculate balance if it's not already set (for new records) or if days_consumed changed
            if not self.pk or self.days_consumed > 0:
                price_per_day = self.get_price_per_day()
                # Calculate balance and round to 2 decimal places
                balance_calc = Decimal(str(self.amount)) - (Decimal(str(price_per_day)) * Decimal(str(self.days_consumed)))
                self.balance = max(Decimal('0.00'), balance_calc).quantize(Decimal('0.01'), rounding=ROUND_HALF_UP)
            elif not self.pk and self.balance is None:
                # For new records, set balance equal to amount if not already set
                self.balance = Decimal(str(self.amount)).quantize(Decimal('0.01'), rounding=ROUND_HALF_UP)
        
        # Ensure balance is always rounded to 2 decimal places
        if self.balance is not None:
            self.balance = Decimal(str(self.balance)).quantize(Decimal('0.01'), rounding=ROUND_HALF_UP)
        
        # Skip validation when only updating specific fields to avoid errors on old data
        update_fields = kwargs.get('update_fields', [])
        if update_fields and 'payment_frequency' not in update_fields and 'status' not in update_fields:
            # Skip validation when only updating days/balance fields
            super().save(*args, **kwargs)
        else:
            # Full validation for new records or when payment_frequency/status is being updated
            self.full_clean()
            super().save(*args, **kwargs)
    
    def consume_day(self):
        """Consume one day from this payment"""
        from decimal import ROUND_HALF_UP
        if self.days_remaining > 0:
            self.days_consumed += 1
            self.days_remaining = max(0, self.number_of_days - self.days_consumed)
            price_per_day = self.get_price_per_day()
            # Calculate balance and round to 2 decimal places
            balance_calc = Decimal(str(self.amount)) - (Decimal(str(price_per_day)) * Decimal(str(self.days_consumed)))
            self.balance = max(Decimal('0.00'), balance_calc).quantize(Decimal('0.01'), rounding=ROUND_HALF_UP)
            self.save(update_fields=['days_consumed', 'days_remaining', 'balance'])
            return True
        return False
    
    def get_remaining_balance(self):
        """Get remaining balance"""
        price_per_day = self.get_price_per_day()
        return max(Decimal('0.00'), Decimal(str(self.amount)) - (Decimal(str(price_per_day)) * Decimal(str(self.days_consumed))))


class MealConsumption(models.Model):
    """Model to track daily meal consumption for students"""
    
    student = models.ForeignKey(
        Student,
        on_delete=models.CASCADE,
        related_name='meal_consumptions'
    )
    meal_payment = models.ForeignKey(
        StudentMealPayment,
        on_delete=models.CASCADE,
        related_name='consumptions',
        help_text="The payment record this consumption is deducted from"
    )
    meal_type = models.CharField(
        max_length=20,
        choices=StudentMealPayment.MEAL_TYPES,
        help_text="Type of meal consumed"
    )
    consumption_date = models.DateField(
        default=timezone.now,
        help_text="Date when the meal was served"
    )
    served_by = models.ForeignKey(
        User,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='meals_served',
        help_text="User who marked the meal as served"
    )
    notes = models.TextField(
        blank=True,
        help_text="Additional notes about this meal serving"
    )
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    class Meta:
        ordering = ['-consumption_date', '-created_at']
        indexes = [
            models.Index(fields=['student', 'meal_type', 'consumption_date']),
            models.Index(fields=['consumption_date']),
        ]
        unique_together = ['student', 'meal_type', 'consumption_date']
    
    def __str__(self):
        return f"{self.student.get_full_name()} - {self.get_meal_type_display()} - {self.consumption_date}"


class SyncQueue(models.Model):
    """Model to track operations that need to be synced to the server when online"""
    
    OPERATION_TYPES = [
        ('CREATE', 'Create'),
        ('UPDATE', 'Update'),
        ('DELETE', 'Delete'),
    ]
    
    STATUS_CHOICES = [
        ('PENDING', 'Pending'),
        ('SYNCING', 'Syncing'),
        ('SYNCED', 'Synced'),
        ('FAILED', 'Failed'),
    ]
    
    # Operation details
    operation_type = models.CharField(max_length=10, choices=OPERATION_TYPES)
    model_name = models.CharField(max_length=100, help_text="Name of the model (e.g., 'Payment', 'Student')")
    model_id = models.IntegerField(help_text="ID of the model instance")
    local_id = models.IntegerField(help_text="Local database ID before sync")
    
    # Data to sync (stored as JSON)
    data = models.JSONField(help_text="Serialized model data")
    
    # Status tracking
    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default='PENDING')
    retry_count = models.IntegerField(default=0)
    last_error = models.TextField(blank=True, null=True)
    
    # Timestamps
    created_at = models.DateTimeField(auto_now_add=True)
    synced_at = models.DateTimeField(null=True, blank=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    # Metadata
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True)
    notes = models.TextField(blank=True, help_text="Additional notes about this sync operation")
    
    class Meta:
        ordering = ['-created_at']
        indexes = [
            models.Index(fields=['status', 'created_at']),
            models.Index(fields=['model_name', 'model_id']),
        ]
    
    def __str__(self):
        return f"{self.operation_type} {self.model_name} #{self.model_id} - {self.status}"
    
    def mark_synced(self):
        """Mark this queue item as successfully synced"""
        self.status = 'SYNCED'
        self.synced_at = timezone.now()
        self.save(update_fields=['status', 'synced_at'])
    
    def mark_failed(self, error_message):
        """Mark this queue item as failed and increment retry count"""
        self.status = 'FAILED'
        self.retry_count += 1
        self.last_error = str(error_message)[:500]  # Limit error message length
        self.save(update_fields=['status', 'retry_count', 'last_error'])
    
    def reset_for_retry(self):
        """Reset status to pending for retry"""
        self.status = 'PENDING'
        self.save(update_fields=['status'])


class SyncStatus(models.Model):
    """Model to track overall sync status and settings"""
    
    is_online = models.BooleanField(default=True)
    last_sync_attempt = models.DateTimeField(null=True, blank=True)
    last_successful_sync = models.DateTimeField(null=True, blank=True)
    pending_count = models.IntegerField(default=0)
    failed_count = models.IntegerField(default=0)
    auto_sync_enabled = models.BooleanField(default=True)
    sync_interval_minutes = models.IntegerField(default=5, help_text="Minutes between auto-sync attempts")
    
    # Settings
    max_retry_attempts = models.IntegerField(default=3)
    sync_on_startup = models.BooleanField(default=True)
    
    class Meta:
        verbose_name = "Sync Status"
        verbose_name_plural = "Sync Status"
    
    def __str__(self):
        return f"Online: {self.is_online}, Pending: {self.pending_count}, Failed: {self.failed_count}"
    
    @classmethod
    def get_instance(cls):
        """Get or create the singleton sync status instance"""
        instance, created = cls.objects.get_or_create(pk=1)
        return instance
    
    def update_counts(self):
        """Update pending and failed counts from SyncQueue"""
        self.pending_count = SyncQueue.objects.filter(status='PENDING').count()
        self.failed_count = SyncQueue.objects.filter(status='FAILED').count()
        self.save(update_fields=['pending_count', 'failed_count'])

from django.utils import timezone
# from .models import Employee # redundant if in same file, but Circular import check needed. 


class SalaryAdvance(models.Model):
    STATUS_CHOICES = [
        ('PENDING', 'Pending'),
        ('APPROVED', 'Approved'),
        ('REJECTED', 'Rejected'),
        ('DEDUCTED', 'Recouped/Deducted'),
    ]

    employee = models.ForeignKey(
        Employee,
        on_delete=models.CASCADE,
        related_name='salary_advances'
    )
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    reason = models.TextField()
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='PENDING')
    date_requested = models.DateTimeField(auto_now_add=True)
    date_approved = models.DateTimeField(null=True, blank=True)
    approved_by = models.ForeignKey(
        'auth.User',
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='approved_advances'
    )
    remarks = models.TextField(blank=True, help_text="Admin remarks")

    def __str__(self):
        return f"{self.employee.get_full_name()} - {self.amount} ({self.status})"

    class Meta:
        ordering = ['-date_requested']


# ============================================
# HR MODULE MODELS
# ============================================

class NonTeachingStaff(Employee):
    """
    Non-teaching staff model extending Employee
    Includes support staff, admin staff, etc.
    """
    user = models.OneToOneField(User, on_delete=models.SET_NULL, null=True, blank=True, related_name='staff_profile')
    STAFF_TYPE_CHOICES = [
        ('ADMIN', 'Administrative Staff'),
        ('SUPPORT', 'Support Staff'),
        ('SECURITY', 'Security Personnel'),
        ('MAINTENANCE', 'Maintenance Staff'),
        ('KITCHEN', 'Kitchen Staff'),
        ('LIBRARIAN', 'Librarian'),
        ('LAB_TECH', 'Lab Technician'),
        ('NURSE', 'School Nurse'),
        ('DRIVER', 'Driver'),
        ('CLEANER', 'Cleaner'),
        ('OTHER', 'Other'),
    ]
    
    staff_type = models.CharField(
        max_length=20,
        choices=STAFF_TYPE_CHOICES,
        default='SUPPORT'
    )
    job_description = models.TextField(blank=True)
    supervisor = models.ForeignKey(
        Employee,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='supervised_staff',
        help_text="Direct supervisor (usually head teacher or department head)"
    )
    emergency_contact_name = models.CharField(max_length=100, blank=True)
    emergency_contact_phone = models.CharField(max_length=20, blank=True)
    
    class Meta:
        verbose_name = "Non-Teaching Staff"
        verbose_name_plural = "Non-Teaching Staff"
        ordering = ['first_name', 'last_name']
    
    def __str__(self):
        return f"{self.get_full_name()} - {self.get_staff_type_display()}"

    def save(self, *args, **kwargs):
        # Create user account if email exists and no user is linked
        if not self.user and self.email:
            try:
                user, created = User.objects.get_or_create(
                    username=self.email,
                    email=self.email,
                    defaults={
                        'first_name': self.first_name,
                        'last_name': self.last_name,
                    }
                )
                if created:
                    user.set_password('Bdmis@7878')
                    user.save()
                self.user = user
                
                # Add to Staff group
                staff_group, _ = Group.objects.get_or_create(name='Staff')
                user.groups.add(staff_group)
            except Exception as e:
                print(f"Error creating user for {self.email}: {e}")
        
        super().save(*args, **kwargs)


class LeaveApproval(models.Model):
    """
    Tracks approval workflow for leave requests
    Supervisor -> HR/Admin
    """
    APPROVAL_LEVEL_CHOICES = [
        ('SUPERVISOR', 'Supervisor'),
        ('HR', 'HR/Admin'),
    ]
    
    APPROVAL_STATUS_CHOICES = [
        ('PENDING', 'Pending'),
        ('APPROVED', 'Approved'),
        ('REJECTED', 'Rejected'),
    ]
    
    leave = models.ForeignKey(
        Leave,
        on_delete=models.CASCADE,
        related_name='approvals'
    )
    approval_level = models.CharField(max_length=20, choices=APPROVAL_LEVEL_CHOICES)
    status = models.CharField(max_length=20, choices=APPROVAL_STATUS_CHOICES, default='PENDING')
    approver = models.ForeignKey(
        User,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='leave_approvals_given'
    )
    comments = models.TextField(blank=True)
    approved_date = models.DateTimeField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    
    class Meta:
        ordering = ['approval_level', '-created_at']
        unique_together = ['leave', 'approval_level']
    
    def __str__(self):
        return f"{self.leave} - {self.approval_level} - {self.status}"


class AdvanceApproval(models.Model):
    """
    Tracks approval workflow for salary advance requests
    Supervisor -> HR/Admin
    """
    APPROVAL_LEVEL_CHOICES = [
        ('SUPERVISOR', 'Supervisor'),
        ('HR', 'HR/Admin'),
    ]
    
    APPROVAL_STATUS_CHOICES = [
        ('PENDING', 'Pending'),
        ('APPROVED', 'Approved'),
        ('REJECTED', 'Rejected'),
    ]
    
    advance = models.ForeignKey(
        SalaryAdvance,
        on_delete=models.CASCADE,
        related_name='approvals'
    )
    approval_level = models.CharField(max_length=20, choices=APPROVAL_LEVEL_CHOICES)
    status = models.CharField(max_length=20, choices=APPROVAL_STATUS_CHOICES, default='PENDING')
    approver = models.ForeignKey(
        User,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='advance_approvals_given'
    )
    comments = models.TextField(blank=True)
    approved_date = models.DateTimeField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    
    class Meta:
        ordering = ['approval_level', '-created_at']
        unique_together = ['advance', 'approval_level']
    
    def __str__(self):
        return f"{self.advance} - {self.approval_level} - {self.status}"


class StaffDocument(models.Model):
    """
    Store important staff documents
    """
    DOCUMENT_TYPE_CHOICES = [
        ('ID', 'National ID'),
        ('CERTIFICATE', 'Certificate'),
        ('CONTRACT', 'Employment Contract'),
        ('MEDICAL', 'Medical Report'),
        ('CLEARANCE', 'Police Clearance'),
        ('OTHER', 'Other'),
    ]
    
    employee = models.ForeignKey(
        Employee,
        on_delete=models.CASCADE,
        related_name='documents'
    )
    document_type = models.CharField(max_length=20, choices=DOCUMENT_TYPE_CHOICES)
    title = models.CharField(max_length=200)
    file = models.FileField(upload_to='staff_documents/')
    uploaded_by = models.ForeignKey(
        User,
        on_delete=models.SET_NULL,
        null=True
    )
    uploaded_at = models.DateTimeField(auto_now_add=True)
    notes = models.TextField(blank=True)
    
    class Meta:
        ordering = ['-uploaded_at']
    
    def __str__(self):
        return f"{self.employee.get_full_name()} - {self.title}"


class Expense(models.Model):
    """Model for tracking school expenses"""
    CATEGORY_CHOICES = [
        ('utilities', 'Utilities'),
        ('salaries', 'Salaries'),
        ('supplies', 'Supplies'),
        ('maintenance', 'Maintenance'),
        ('transport', 'Transport'),
        ('food', 'Food'),
        ('other', 'Other'),
    ]
    
    PAYMENT_METHOD_CHOICES = [
        ('cash', 'Cash'),
        ('bank_transfer', 'Bank Transfer'),
        ('cheque', 'Cheque'),
        ('mobile_money', 'Mobile Money'),
    ]
    
    title = models.CharField(max_length=200)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    category = models.CharField(max_length=20, choices=CATEGORY_CHOICES)
    description = models.TextField(blank=True)
    date = models.DateField()
    vendor = models.CharField(max_length=200, blank=True)
    payment_method = models.CharField(max_length=20, choices=PAYMENT_METHOD_CHOICES)
    receipt_number = models.CharField(max_length=100, blank=True)
    created_by = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, related_name='expenses_created')
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    class Meta:
        ordering = ['-date', '-created_at']
    
    def __str__(self):
        return f"{self.title} - KES {self.amount}"
