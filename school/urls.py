"""
URL configuration for school project.
"""
from django.contrib import admin
from django.urls import path, include, re_path
from django.conf import settings
from django.conf.urls.static import static
from django.views.static import serve
from django.http import FileResponse, Http404
import os
import logging

logger = logging.getLogger(__name__)

# Safe static file serving view
def serve_static_safe(request, path):
    """Safely serve static files without raising 500 errors"""
    try:
        document_root = settings.STATIC_ROOT
        if not document_root:
            document_root = os.path.join(str(settings.BASE_DIR), 'staticfiles')
        
        file_path = os.path.join(document_root, path)
        
        if os.path.exists(file_path) and os.path.isfile(file_path):
            return FileResponse(open(file_path, 'rb'))
        else:
            logger.warning(f"Static file not found: {file_path}")
            raise Http404("Static file not found")
    except Http404:
        raise
    except Exception as e:
        # Log the error but return 404 instead of 500
        logger.error(f"Error serving static file {path}: {str(e)}")
        raise Http404("Static file error")

urlpatterns = [
    path('admin/', admin.site.urls),
    
    # API routes (must come before catch-all)
    path('', include('schools.urls')),
    path('api/finance/', include('finance.urls')),
    path('api/food/', include('food.urls')),
    path('api/transport/', include('transport.urls')),
]

# Serve static and media files (MUST come before catch-all)
urlpatterns += [
    re_path(r'^static/(?P<path>.*)$', serve_static_safe, name='static'),
    re_path(r'^media/(?P<path>.*)$', serve, {'document_root': settings.MEDIA_ROOT}),
]

# Add standard static/media serving in DEBUG mode
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)

# Catch-all for React frontend (MUST be last)
from schools.views import spa_index
urlpatterns += [
    re_path(r'^.*$', spa_index, name='frontend'),
]
