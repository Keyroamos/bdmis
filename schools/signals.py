from django.db.models.signals import post_save
from django.dispatch import receiver
from .models import Grade, Student

@receiver(post_save, sender=Grade)
def update_student_fees(sender, instance, **kwargs):
    """Update fees for all students in the grade when grade fees change"""
    # Get all students in this grade (removed is_active filter)
    students = Student.objects.filter(grade=instance)
    
    # Update each student's fees
    students.update(
        term1_fees=instance.term1_fees,
        term2_fees=instance.term2_fees,
        term3_fees=instance.term3_fees
    ) 