"""
Supabase client utility for BDMIS.

Usage in views.py or utils.py:
    from schools.supabase_client import get_supabase_client
    supabase = get_supabase_client()
    data = supabase.table('schools_student').select('*').execute()
"""

from django.conf import settings

_client = None


def get_supabase_client():
    """Return a shared Supabase Python client instance."""
    global _client
    if _client is None:
        try:
            from supabase import create_client, Client
            url: str = settings.SUPABASE_URL
            key: str = settings.SUPABASE_ANON_KEY
            _client = create_client(url, key)
        except ImportError:
            raise ImportError(
                "supabase package is not installed. "
                "Run: pip install supabase"
            )
        except Exception as e:
            raise RuntimeError(f"Failed to initialize Supabase client: {e}")
    return _client
