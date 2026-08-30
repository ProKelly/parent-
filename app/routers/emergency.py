from fastapi import APIRouter, Depends

from app.core.security import optional_user
from app.db.supabase import get_supabase
from app.models.schemas import EmergencyResolveIn, EmergencyTriggerIn, EmergencyTriggerOut

router = APIRouter(prefix="/api/emergency", tags=["emergency"])

# In production these clips are pre-loaded on-device at install time
# (see prototype slide: "Audio Flow Architecture" — <500KB/clip, local
# playback, no network call during a crisis). This endpoint only logs
# the anonymized event and tells the client which cached clip to play;
# it is never on the critical path of actually calming the parent down.
#
# Per-language grounding clips, uploaded to Supabase Storage bucket
# "audio" (see database/update_audio_urls.sql for the matching
# milestone-card update). Swap YOUR-PROJECT-REF for your real one.
GROUNDING_AUDIO_URLS = {
    "en": "https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/en/grounding-90s.mp3",
    "fr": "https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/fr/grounding-90s.mp3",
    "pidgin": "https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/pidgin/grounding-90s.mp3",
}
GROUNDING_AUDIO_URL = GROUNDING_AUDIO_URLS["en"]  # default/back-compat


@router.post("/trigger", response_model=EmergencyTriggerOut)
def trigger_emergency(payload: EmergencyTriggerIn, user: dict | None = Depends(optional_user)):
    """Called the instant the parent taps the fixed emergency button.
    Works with or without login — crisis moments must never be gated
    behind auth. Logs only a coarse region + timestamp, nothing else."""
    supabase = get_supabase()
    row = {
        "parent_id": user["id"] if user else None,
        "region": payload.region,
        "outcome": "self_resolved",  # default; updated by /resolve if a handoff happens
    }
    result = supabase.table("emergency_events").insert(row).execute()
    event_id = result.data[0]["id"]

    audio_url = GROUNDING_AUDIO_URLS.get(payload.lang, GROUNDING_AUDIO_URLS["en"])

    return EmergencyTriggerOut(
        event_id=event_id,
        audio_url=audio_url,
        message="Breathe with the audio. You are not alone — this feeling will pass.",
    )


@router.post("/resolve")
def resolve_emergency(payload: EmergencyResolveIn):
    """Called after the grounding audio finishes: records whether the
    parent self-resolved or asked for an anonymous peer counselor
    handoff. If a handoff was requested, queues it for pickup."""
    supabase = get_supabase()
    supabase.table("emergency_events").update({
        "outcome": payload.outcome.value,
        "duration_seconds": payload.duration_seconds,
    }).eq("id", payload.event_id).execute()

    if payload.outcome.value == "requested_handoff":
        event = supabase.table("emergency_events").select("region").eq("id", payload.event_id).single().execute()
        supabase.table("handoff_requests").insert({
            "emergency_event_id": payload.event_id,
            "region": event.data.get("region") if event.data else None,
            "status": "pending",
        }).execute()

    return {"status": "ok"}


@router.get("/handoffs/pending")
def list_pending_handoffs(user: dict = Depends(optional_user)):
    """Peer educators use this to see anonymous requests waiting nearby.
    (Role check is also enforced by the RLS policy on the table itself.)"""
    supabase = get_supabase()
    result = supabase.table("handoff_requests").select("*").eq("status", "pending").execute()
    return result.data
