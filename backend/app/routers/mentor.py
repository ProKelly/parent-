from fastapi import APIRouter, Depends, HTTPException

from app.core.security import require_user
from app.db.supabase import get_supabase
from app.models.schemas import ChildIn, ChildOut, ProgressIn

router = APIRouter(prefix="/api/mentor", tags=["mentor"])


@router.get("/cards")
def list_milestone_cards(lang: str = "en"):
    """Full content library for on-device caching. The frontend fetches
    this once (e.g. on first Wi-Fi connection at a community hotspot)
    and stores it in IndexedDB/localStorage for 100%-offline daily use,
    per the 'Initial download via community Wi-Fi' user journey."""
    supabase = get_supabase()
    result = supabase.table("milestone_cards").select("*").order("sort_order").execute()
    return result.data


@router.post("/children", response_model=ChildOut)
def add_child(payload: ChildIn, user: dict = Depends(require_user)):
    supabase = get_supabase()
    row = {**payload.model_dump(mode="json"), "parent_id": user["id"]}
    result = supabase.table("children").insert(row).execute()
    return result.data[0]


@router.get("/children")
def list_children(user: dict = Depends(require_user)):
    supabase = get_supabase()
    result = supabase.table("children").select("*").eq("parent_id", user["id"]).execute()
    return result.data


@router.post("/progress")
def sync_progress(payload: ProgressIn, user: dict = Depends(require_user)):
    """Deferred sync target: the app queues completions locally while
    offline and POSTs them here in a batch once connectivity returns."""
    supabase = get_supabase()
    child = supabase.table("children").select("id").eq("id", payload.child_id).eq("parent_id", user["id"]).execute()
    if not child.data:
        raise HTTPException(status_code=403, detail="Not your child profile")

    row = {
        "child_id": payload.child_id,
        "card_id": payload.card_id,
        "completed_at": payload.completed_at.isoformat() if payload.completed_at else None,
    }
    supabase.table("mentor_progress").upsert(row, on_conflict="child_id,card_id").execute()
    return {"status": "synced"}


@router.get("/progress/{child_id}")
def get_progress(child_id: str, user: dict = Depends(require_user)):
    supabase = get_supabase()
    result = (
        supabase.table("mentor_progress")
        .select("card_id, completed_at")
        .eq("child_id", child_id)
        .execute()
    )
    return result.data
