from django.test import Client
from django.contrib.auth.models import User
import json

def test_api_grades():
    client = Client(HTTP_HOST='localhost')
    # Get a user (e.g. Administration)
    user = User.objects.filter(is_superuser=True).first() or User.objects.first()
    if not user:
        print("No user found to test with.")
        return
    
    print(f"Testing api_grades with user: {user.username}")
    client.force_login(user)
    
    try:
        response = client.get('/api/grades/', secure=True)
        print(f"Status Code: {response.status_code}")
        print(f"Response Content: {response.content.decode()}")
    except Exception as e:
        print(f"Error calling API: {e}")
        import traceback
        traceback.print_exc()

test_api_grades()
