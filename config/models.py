from django.db import models

class SchoolConfig(models.Model):
    """
    Singleton model to store school-wide configuration settings
    """
    # School Information
    school_name = models.CharField(max_length=200, default="EduManage Academy")
    school_code = models.CharField(max_length=20, default="EDU")
    school_email = models.EmailField(default="info@school.com")
    school_phone = models.CharField(max_length=20, default="+254700000000")
    school_address = models.TextField(default="P.O Box 123-00100, Nairobi")
    school_logo = models.ImageField(upload_to='school_logos/', null=True, blank=True)
    
    # Admission Number Configuration
    admission_number_format = models.CharField(
        max_length=100, 
        default="{SCHOOL_CODE}/{YEAR}/{COUNTER:04d}",
        help_text="Format: {SCHOOL_CODE}, {YEAR}, {COUNTER:04d}, {GRADE}. Example: EDU/2024/0001"
    )
    admission_counter = models.IntegerField(default=0, help_text="Auto-incremented counter for admission numbers")
    
    # Academic Settings
    current_term = models.CharField(max_length=20, default="TERM_1")
    current_year = models.IntegerField(default=2024)
    
    # Financial Settings
    default_currency = models.CharField(max_length=10, default="KES")
    
    class Meta:
        verbose_name = "School Configuration"
        verbose_name_plural = "School Configuration"
    
    def save(self, *args, **kwargs):
        # Ensure only one instance exists (Singleton pattern)
        self.pk = 1
        super().save(*args, **kwargs)
    
    @classmethod
    def get_config(cls):
        """Get or create the singleton configuration instance"""
        config, created = cls.objects.get_or_create(pk=1)
        return config
    
    def generate_admission_number(self, grade=None):
        """
        Generate the next admission number based on finding the logical next number 
        after the highest existing admission number.
        """
        from schools.models import Student
        import re

        # Find the student with the 'largest' admission number that looks numeric
        # We'll try to fetch all admission numbers, filter for numeric ones, find max, and add 1.
        # If your admission numbers are like "789", this works.
        # If they are alphanumeric like "ADM-001", we might need more complex logic.
        # Assuming the user wants to continue from the last simple number.

        students = Student.objects.all().only('admission_number')
        max_adm = 0
        
        for s in students:
            # Try to extract the first numeric sequence
            # This handles cases like '1234' or 'ADM/1234' depending on how loose we want to be
            # Based on user request "pick the last admission number", usually implies numeric sequence.
            match = re.search(r'(\d+)', str(s.admission_number))
            if match:
                try:
                    num = int(match.group(1))
                    if num > max_adm:
                        max_adm = num
                except ValueError:
                    continue
        
        next_adm = max_adm + 1
        
        # If format requires padding or specific style, we can adjust here.
        # But usually just the number is fine if that's what is stored.
        return str(next_adm)
    
    def __str__(self):
        return f"{self.school_name} Configuration"
