from django.http import JsonResponse
from django.contrib.auth.decorators import login_required
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_http_methods
from django.db import transaction
from .models import Student, Grade
import json

@csrf_exempt
@login_required
@require_http_methods(["POST"])
def api_promote_students(request):
    """
    Promotes students to the next grade based on a defined sequence.
    Resets current_term to 1.
    """
    try:
        # Define the grade order logic
        grade_map = {
            'PG': 'PP1',
            'PP1': 'PP2',
            'PP2': 'G1',
            'G1': 'G2',
            'G2': 'G3',
            'G3': 'G4',
            'G4': 'G5',
            'G5': 'G6',
            'G6': 'G7',
            'G7': 'G8',
            'G8': 'G9',
            'G9': 'G10',
            'G10': 'G11',
            'G11': 'G12',
            'G12': None
        }
        
        # Processing order: Highest to Lowest to prevent overlap during updates
        processing_order = ['G12', 'G11', 'G10', 'G9', 'G8', 'G7', 'G6', 'G5', 'G4', 'G3', 'G2', 'G1', 'PP2', 'PP1', 'PG']
        
        with transaction.atomic():
            # Get all Grade objects indexed by name for quick lookup
            all_grades = {g.name: g for g in Grade.objects.all()}
            
            total_promoted = 0
            
            for current_name in processing_order:
                current_grade = all_grades.get(current_name)
                if not current_grade:
                    continue
                    
                target_name = grade_map.get(current_name)
                
                # Get students in this specific grade
                students_qs = Student.objects.filter(grade=current_grade)
                count = students_qs.count()
                
                if count > 0:
                    if target_name is None:
                        # Graduation: Remove grade, reset term
                        students_qs.update(grade=None, current_term=1)
                    else:
                        target_grade = all_grades.get(target_name)
                        if target_grade:
                            students_qs.update(grade=target_grade, current_term=1)
                    
                    total_promoted += count
            
            return JsonResponse({
                'success': True, 
                'message': f'Successfully promoted {total_promoted} students to their next class.'
            })

    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

@csrf_exempt
@login_required
@require_http_methods(["POST"])
def api_update_term(request):
    """Updates the current term for all active student accounts."""
    try:
        data = json.loads(request.body)
        new_term = data.get('term')
        
        if not new_term:
             return JsonResponse({'error': 'Term is required'}, status=400)
             
        new_term = int(new_term)
        
        if new_term not in [1, 2, 3]:
            return JsonResponse({'error': 'Invalid term. Must be 1, 2, or 3.'}, status=400)
            
        # Update all students who are assigned to a grade (active students)
        updated_count = Student.objects.filter(grade__isnull=False).update(current_term=new_term)
        
        return JsonResponse({
            'success': True, 
            'message': f'Successfully moved {updated_count} students to Term {new_term}.'
        })
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)
