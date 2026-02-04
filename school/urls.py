"""
URL configuration for school project.
Simplified to let WhiteNoise handle static files in production.
"""
from django.contrib import admin
from django.urls import path, include, re_path
from django.conf import settings
from django.conf.urls.static import static

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

# Catch-all for React frontend (MUST be last)
from schools.views import spa_index
urlpatterns += [
    re_path(r'^.*$', spa_index, name='frontend'),
]
