from fastapi import APIRouter, Depends, HTTPException

from app.core.security import require_user
from app.db.supabase import get_supabase

router = APIRouter(prefix="/api/metrics", tags=["metrics"])


@router.get("/weekly")
def weekly_metrics(user: dict = Depends(require_user)):
    """Feeds the UNICEF-facing dashboard: 'Tracks community engagement
    and stress-reduction trends safely via anonymized backend metrics.'
    Admin/peer-educator only — never exposes individual events."""
    if user["role"] not in ("admin", "peer_educator"):
        raise HTTPException(status_code=403, detail="Not authorized")
    supabase = get_supabase()
    result = supabase.table("metrics_weekly").select("*").execute()
    return result.data
