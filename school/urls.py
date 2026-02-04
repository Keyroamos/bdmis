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

def serve_manifest(request, filename='manifest.webmanifest'):
    """Serve manifest files (.webmanifest or .json) with correct MIME type"""
    # Determine which manifest file to serve
    if filename.endswith('.json'):
        manifest_filename = 'manifest.json'
    else:
        manifest_filename = 'manifest.webmanifest'
    
    # Try multiple locations
    possible_paths = [
        os.path.join(settings.BASE_DIR, 'staticfiles', manifest_filename),
        os.path.join(settings.BASE_DIR, 'frontend', 'dist', manifest_filename),
    ]
    
    if settings.STATIC_ROOT:
        possible_paths.append(os.path.join(settings.STATIC_ROOT, manifest_filename))
    
    manifest_path = None
    for path in possible_paths:
        if os.path.exists(path):
            manifest_path = path
            break
    
    if manifest_path:
        try:
            with open(manifest_path, 'r', encoding='utf-8') as f:
                content = f.read()
            response = HttpResponse(content, content_type='application/manifest+json')
            response['Cache-Control'] = 'public, max-age=3600'
            return response
        except Exception as e:
            return HttpResponse(f"Error reading manifest: {str(e)}", status=500)
    
    return HttpResponse(f"Manifest file '{manifest_filename}' not found", status=404)

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

# Serve manifest files with correct MIME type (MUST be before catch-all)
urlpatterns += [
    path('static/manifest.webmanifest', serve_manifest, name='manifest-webmanifest'),
    path('static/manifest.json', serve_manifest, {'filename': 'manifest.json'}, name='manifest-json'),
    re_path(r'^manifest\.webmanifest$', serve_manifest, name='manifest-webmanifest-root'),
    re_path(r'^manifest\.json$', serve_manifest, {'filename': 'manifest.json'}, name='manifest-json-root'),
]

# Catch-all for React frontend (MUST be last)
from schools.views import spa_index
urlpatterns += [
    re_path(r'^.*$', spa_index, name='frontend'),
]
