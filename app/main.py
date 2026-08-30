from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.core.config import get_settings
from app.routers import emergency, mentor, metrics, safehub

settings = get_settings()

app = FastAPI(
    title="YouthParent+ API",
    description="Backend for YouthParent+ — a digital shield to prevent parental burnout "
                "and protect vulnerable young families in Cameroon. UNICEF Cameroon submission.",
    version="0.1.0",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.cors_origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(emergency.router)
app.include_router(mentor.router)
app.include_router(safehub.router)
app.include_router(metrics.router)


@app.get("/api/health")
def health_check():
    return {"status": "ok", "service": "youthparent-plus-api"}
