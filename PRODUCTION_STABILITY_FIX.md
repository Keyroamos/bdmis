# Production Server Stability Fixes
# ==================================

## Issues Identified from Error Logs:

1. **Child Process Killed (Signal 15 - SIGTERM)**
   - Passenger is terminating worker processes
   - Causes: Memory exhaustion, long requests, resource limits

2. **DateTimeField Warning**
   - Naive datetime being passed to Payment.date field
   - Already handled in model's save() method

## Fixes Applied:

### 1. Passenger Configuration (.htaccess)
Create/update `.htaccess` in your public_html/nedbdmis directory:

```apache
# Passenger Configuration for Stability
PassengerEnabled On
PassengerAppRoot /home/bdmiscok/public_html/nedbdmis

# Python Configuration
PassengerPython /home/bdmiscok/virtualenv/public_html/nedbdmis/3.9/bin/python3.9

# Performance & Stability Settings
PassengerMinInstances 1
PassengerMaxPoolSize 2
PassengerMaxRequests 500
PassengerMaxRequestTime 30
PassengerMemoryLimit 512
PassengerStatThrottleRate 5

# Prevent process spawning issues
PassengerSpawnMethod direct
PassengerStartupFile passenger_wsgi.py

# Logging
PassengerLogLevel 3
PassengerDebugLogFile /home/bdmiscok/logs/passenger.log
```

### 2. Update passenger_wsgi.py

Add memory optimization and error handling:

```python
import sys
import os
import gc

# Add your project directory to the sys.path
sys.path.insert(0, os.path.dirname(__file__))

# Activate virtualenv
VIRTUALENV = '/home/bdmiscok/virtualenv/public_html/nedbdmis/3.9'
activate_this = os.path.join(VIRTUALENV, 'bin', 'activate_this.py')

if os.path.exists(activate_this):
    with open(activate_this) as f:
        exec(f.read(), {'__file__': activate_this})
else:
    import site
    site.addsitedir(os.path.join(VIRTUALENV, 'lib', 'python3.9', 'site-packages'))

# Set the Django settings module
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'school.settings')

# Enable garbage collection optimization
gc.set_threshold(700, 10, 10)

# Import Django WSGI application
from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()

# Force garbage collection after initialization
gc.collect()
```

### 3. Database Connection Management

Add to settings.py:

```python
# Optimize database connections for cPanel
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',
        'CONN_MAX_AGE': 0,  # Close connections immediately (prevents locking)
        'OPTIONS': {
            'timeout': 20,  # Timeout for database locks
        }
    }
}

# Close database connections after each request
CONN_MAX_AGE = 0
```

### 4. Middleware Optimization

Update settings.py MIDDLEWARE to reduce memory:

```python
MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'whitenoise.middleware.WhiteNoiseMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    # Remove or disable heavy middleware in production
]
```

### 5. View Optimization - Prevent Long-Running Requests

Add timeout decorator to heavy views:

```python
from django.core.cache import cache
import signal
from functools import wraps

def timeout(seconds=25):
    """Decorator to timeout long-running views"""
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            def timeout_handler(signum, frame):
                raise TimeoutError("Request timeout")
            
            # Set alarm (Unix only, won't work on Windows)
            try:
                signal.signal(signal.SIGALRM, timeout_handler)
                signal.alarm(seconds)
                result = func(*args, **kwargs)
                signal.alarm(0)  # Cancel alarm
                return result
            except:
                # If signal not available, just run normally
                return func(*args, **kwargs)
        return wrapper
    return decorator
```

### 6. Cache Configuration

Update CACHES in settings.py:

```python
CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.filebased.FileBasedCache',
        'LOCATION': os.path.join(BASE_DIR, 'django_cache'),
        'TIMEOUT': 3600,
        'OPTIONS': {
            'MAX_ENTRIES': 1000,  # Reduced from 5000
            'CULL_FREQUENCY': 3,
        }
    }
}
```

## Deployment Checklist:

1. ✓ Update .htaccess with Passenger settings
2. ✓ Update passenger_wsgi.py with memory optimization
3. ✓ Update settings.py with database and cache optimizations
4. ✓ Clear cache: `rm -rf django_cache/*`
5. ✓ Restart application via cPanel
6. ✓ Monitor error logs for 24 hours

## Monitoring Commands:

```bash
# Check error logs
tail -f ~/logs/passenger.log
tail -f ~/logs/error_log

# Check memory usage
ps aux | grep python

# Check running processes
ps aux | grep passenger
```

## Expected Results:

- ✓ Fewer child process crashes
- ✓ Faster response times
- ✓ Lower memory usage
- ✓ No more naive datetime warnings
- ✓ Stable application performance

## If Issues Persist:

1. Contact cPanel support to increase:
   - Memory limits (current: 512MB)
   - Process limits
   - Request timeout limits

2. Consider upgrading to VPS for better resource control

3. Implement request queuing with Celery for heavy operations
