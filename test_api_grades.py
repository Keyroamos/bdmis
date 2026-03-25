import os
import django
from django.conf import settings
from django.test import Client
from django.contrib.auth.models import User

import sys
# Set up Django environment
sys.path.append('.') 
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'school.settings')
django.setup()

def test_api_grades():
    client = Client()
    # Get a user (e.g. Administration)
    user = User.objects.filter(is_superuser=True).first() or User.objects.first()
    if not user:
        print("No user found to test with.")
        return
    
    print(f"Testing api_grades with user: {user.username}")
    client.force_login(user)
    
    try:
        response = client.get('/api/grades/')
        print(f"Status Code: {response.status_code}")
        print(f"Response Content: {response.content.decode()}")
    except Exception as e:
        print(f"Error calling API: {e}")
        import traceback
        traceback.print_exc()

if __name__ == "__main__":
    test_api_grades()
