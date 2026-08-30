from functools import lru_cache

from supabase import Client, create_client

from app.core.config import get_settings


@lru_cache
def get_supabase() -> Client:
    """Service-role client. Used server-side only — never expose this key
    to the frontend. Row Level Security still applies to anon/user
    clients on the frontend; this client bypasses RLS for trusted
    backend operations like aggregate metrics and admin content writes.
    """
    settings = get_settings()
    return create_client(settings.supabase_url, settings.supabase_service_role_key)
