import sys
import os

# INTERP is the path to the python interpreter in your virtualenv
# Derived from: /home/bdmiscok/virtualenv/public_html/nedbdmis/3.9/bin/activate
INTERP = "/home/bdmiscok/virtualenv/public_html/nedbdmis/3.9/bin/python"

# Check if we are running the correct interpreter, if not, restart with the correct one
if sys.executable != INTERP:
    os.execl(INTERP, INTERP, *sys.argv)

# Add the project directory to the sys.path
sys.path.insert(0, os.path.dirname(__file__))

# Set the Django settings module
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'school.settings')

from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()
