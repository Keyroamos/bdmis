import sys
import os
import gc

# Add your project directory to the sys.path
sys.path.insert(0, os.path.dirname(__file__))

# Activate virtualenv by adding its site-packages to sys.path
# This is safer than using os.execl which can cause issues with Passenger
VIRTUALENV = '/home/bdmiscok/virtualenv/public_html/nedbdmis/3.9'
activate_this = os.path.join(VIRTUALENV, 'bin', 'activate_this.py')

# Try to activate using activate_this.py if it exists
if os.path.exists(activate_this):
    with open(activate_this) as f:
        exec(f.read(), {'__file__': activate_this})
else:
    # Fallback: manually add site-packages to path
    import site
    site.addsitedir(os.path.join(VIRTUALENV, 'lib', 'python3.9', 'site-packages'))

# Set the Django settings module
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'school.settings')

# Load environment variables explicitly for Passenger/cPanel
try:
    from dotenv import load_dotenv
    project_root = os.path.dirname(__file__)
    env_path = os.path.join(project_root, '.env')
    if os.path.exists(env_path):
        load_dotenv(env_path)
except ImportError:
    pass

# Enable garbage collection optimization to reduce memory usage
# Lower thresholds = more frequent GC = less memory buildup
gc.set_threshold(700, 10, 10)

try:
    from django.core.wsgi import get_wsgi_application
    application = get_wsgi_application()
    
    # Force garbage collection after initialization
    gc.collect()
except Exception as e:
    # Log initialization errors to a visible file for debugging on cPanel
    import traceback
    with open(os.path.join(os.path.dirname(__file__), 'wsgi_init_error.log'), 'a') as f:
        f.write("\n" + "="*50 + "\n")
        f.write(f"Startup Error at {gc.get_threshold()}\n")
        f.write(f"Error: {str(e)}\n")
        f.write(traceback.format_exc())
    raise e


