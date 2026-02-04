"""
URL configuration for school project.
Simplified to let WhiteNoise handle static files in production.
"""
from django.contrib import admin
from django.urls import path, include, re_path
from django.conf import settings
from django.conf.urls.static import static
from django.http import FileResponse, HttpResponse
import os

def serve_static_file(request, filename, content_type):
    """Serve specific static files with correct MIME type"""
    possible_paths = [
        os.path.join(settings.BASE_DIR, 'staticfiles', filename),
        os.path.join(settings.BASE_DIR, 'frontend', 'dist', filename),
        os.path.join(settings.BASE_DIR, 'static', filename),
    ]
    
    if settings.STATIC_ROOT:
        possible_paths.append(os.path.join(settings.STATIC_ROOT, filename))
    
    file_path = None
    for path in possible_paths:
        if os.path.exists(path):
            file_path = path
            break
    
    if file_path:
        try:
            with open(file_path, 'rb') as f:
                content = f.read()
            response = HttpResponse(content, content_type=content_type)
            response['Cache-Control'] = 'public, max-age=3600'
            return response
        except Exception as e:
            return HttpResponse(f"Error reading file: {str(e)}", status=500)
    
    return HttpResponse(f"File '{filename}' not found", status=404)

def serve_manifest(request, filename='manifest.webmanifest'):
    return serve_static_file(request, filename, 'application/manifest+json')

def serve_sw(request):
    return serve_static_file(request, 'sw.js', 'application/javascript')

urlpatterns = [
    path('admin/', admin.site.urls),
    
    # API routes
    path('', include('schools.urls')),
    path('api/finance/', include('finance.urls')),
    path('api/food/', include('food.urls')),
    path('api/transport/', include('transport.urls')),
]

# In DEBUG mode, serve static and media files via Django
if settings.DEBUG:
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

# Serve manifest and service worker files with correct MIME type (MUST be before catch-all)
urlpatterns += [
    path('static/manifest.webmanifest', serve_manifest, name='manifest-webmanifest'),
    path('static/manifest.json', serve_manifest, {'filename': 'manifest.json'}, name='manifest-json'),
    path('static/sw.js', serve_sw, name='service-worker'),
    re_path(r'^manifest\.webmanifest$', serve_manifest, name='manifest-webmanifest-root'),
    re_path(r'^manifest\.json$', serve_manifest, {'filename': 'manifest.json'}, name='manifest-json-root'),
    re_path(r'^sw\.js$', serve_sw, name='service-worker-root'),
]

# Catch-all for React frontend (MUST be last)
from schools.views import spa_index
urlpatterns += [
    re_path(r'^.*$', spa_index, name='frontend'),
]
