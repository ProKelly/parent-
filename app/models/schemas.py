from datetime import date, datetime
from enum import Enum
from typing import Optional

from pydantic import BaseModel, Field


# ---------- Emergency / De-escalation Button ----------

class EmergencyOutcome(str, Enum):
    self_resolved = "self_resolved"
    requested_handoff = "requested_handoff"
    handoff_completed = "handoff_completed"


class EmergencyTriggerIn(BaseModel):
    region: Optional[str] = Field(None, description="Coarse region only, e.g. 'Bamenda'")
    lang: str = Field("en", description="'en' | 'fr' | 'pidgin'")


class EmergencyTriggerOut(BaseModel):
    event_id: str
    audio_url: str
    message: str


class EmergencyResolveIn(BaseModel):
    event_id: str
    outcome: EmergencyOutcome
    duration_seconds: Optional[int] = None


# ---------- Offline Pocket Mentor ----------

class ChildIn(BaseModel):
    nickname: str = "Baby"
    birth_month: date
    avatar_emoji: str = "👶"


class ChildOut(ChildIn):
    id: str


class ProgressIn(BaseModel):
    child_id: str
    card_id: str
    completed_at: Optional[datetime] = None


class MilestoneCardOut(BaseModel):
    id: str
    age_month_min: int
    age_month_max: int
    title: dict
    body: dict
    audio_url: dict
    category: str


# ---------- Community Safe Hub ----------

class ResourceType(str, Enum):
    health_center = "health_center"
    safe_space = "safe_space"
    support_network = "support_network"
    peer_educator_point = "peer_educator_point"


class ResourceIn(BaseModel):
    name: str
    type: ResourceType
    description: Optional[str] = None
    phone: Optional[str] = None
    lat: float
    lng: float
    region: str
    is_youth_friendly: bool = True


class ResourceOut(BaseModel):
    id: str
    name: str
    type: str
    description: Optional[str]
    phone: Optional[str]
    lat: float
    lng: float
    region: str
    is_youth_friendly: bool
    verified: bool
    distance_km: Optional[float] = None
