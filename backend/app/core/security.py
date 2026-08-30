from typing import Optional

from fastapi import Header, HTTPException, status
from jose import JWTError, jwt

from app.core.config import get_settings


def _decode(token: str) -> dict:
    settings = get_settings()
    try:
        return jwt.decode(
            token,
            settings.supabase_jwt_secret,
            algorithms=["HS256"],
            audience="authenticated",
        )
    except JWTError as exc:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid or expired token") from exc


async def require_user(authorization: str = Header(...)) -> dict:
    """Use on endpoints that must know who the caller is (mentor progress,
    resource submission, handoff claiming)."""
    if not authorization.startswith("Bearer "):
        raise HTTPException(status_code=401, detail="Missing bearer token")
    payload = _decode(authorization.removeprefix("Bearer "))
    return {"id": payload["sub"], "role": payload.get("user_role", "parent")}


async def optional_user(authorization: Optional[str] = Header(default=None)) -> Optional[dict]:
    """Use on endpoints that work anonymously but personalize when logged in
    — e.g. the emergency button, which must work even mid-crisis with no
    login friction."""
    if not authorization or not authorization.startswith("Bearer "):
        return None
    try:
        payload = _decode(authorization.removeprefix("Bearer "))
        return {"id": payload["sub"], "role": payload.get("user_role", "parent")}
    except HTTPException:
        return None
