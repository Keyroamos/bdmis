"""
Middleware for adding cache headers to improve performance
"""
from django.utils.cache import patch_cache_control


class CacheControlMiddleware:
    """
    Middleware to add Cache-Control headers to responses for better browser caching
    """
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        response = self.get_response(request)
        
        # Add cache headers for static files
        if request.path.startswith('/static/'):
            # Cache static files for 1 year (they have hashed filenames)
            patch_cache_control(response, public=True, max_age=31536000, immutable=True)
        
        # Add cache headers for media files
        elif request.path.startswith('/media/'):
            # Cache media files for 1 week
            patch_cache_control(response, public=True, max_age=604800)
        
        # Add cache headers for API responses (shorter cache)
        elif request.path.startswith('/api/'):
            # Don't cache API responses by default (they're dynamic)
            patch_cache_control(response, private=True, no_cache=True, no_store=True, must_revalidate=True)
        
        return response
