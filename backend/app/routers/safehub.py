from fastapi import APIRouter, Depends, HTTPException

from app.core.security import require_user
from app.db.supabase import get_supabase
from app.models.schemas import ResourceIn

router = APIRouter(prefix="/api/safehub", tags=["safehub"])


@router.get("/resources")
def nearby_resources(lat: float, lng: float, radius_km: float = 25):
    """Lightweight mapping/directory lookup — the core of the
    Community Safe Hub pillar. Falls back gracefully to a flat list
    if PostGIS RPC isn't available yet in a given environment."""
    supabase = get_supabase()
    try:
        result = supabase.rpc(
            "nearby_resources", {"in_lat": lat, "in_lng": lng, "radius_km": radius_km}
        ).execute()
        return result.data
    except Exception:
        result = supabase.table("safehub_resources").select("*").execute()
        return result.data


@router.post("/resources")
def add_resource(payload: ResourceIn, user: dict = Depends(require_user)):
    """Peer educators keep the directory current on the ground
    ('Local directory kept current with community focal points').
    RLS on the table also enforces role, this is a friendlier 403."""
    if user["role"] not in ("peer_educator", "admin"):
        raise HTTPException(status_code=403, detail="Only peer educators or admins can add resources")

    supabase = get_supabase()
    row = {
        "name": payload.name,
        "type": payload.type.value,
        "description": payload.description,
        "phone": payload.phone,
        "region": payload.region,
        "is_youth_friendly": payload.is_youth_friendly,
        "added_by": user["id"],
        "location": f"SRID=4326;POINT({payload.lng} {payload.lat})",
    }
    result = supabase.table("safehub_resources").insert(row).execute()
    return result.data[0]
