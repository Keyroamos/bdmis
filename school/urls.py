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

urlpatterns = [
    path('admin/', admin.site.urls),
    
    # API routes
    path('', include('schools.urls')),
    path('api/finance/', include('finance.urls')),
    path('api/food/', include('food.urls')),
    path('api/transport/', include('transport.urls')),
]

# Serve manifest and service worker files directly (optional fallback)
def serve_manifest(request, filename='manifest.webmanifest'):
    from django.conf import settings
    file_path = os.path.join(settings.BASE_DIR, 'staticfiles', filename)
    if os.path.exists(file_path):
        with open(file_path, 'rb') as f:
            return HttpResponse(f.read(), content_type='application/manifest+json')
    return HttpResponse(status=404)

urlpatterns += [
    path('manifest.webmanifest', serve_manifest),
    path('manifest.json', serve_manifest, {'filename': 'manifest.json'}),
]

# Catch-all for React frontend (MUST be last)
from schools.views import spa_index
urlpatterns += [
    re_path(r'^.*$', spa_index, name='frontend'),
]
