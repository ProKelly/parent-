# YouthParent+ API (FastAPI)

Backend for the three pillars: the De-escalation Button, the Offline
Pocket Mentor, and the Community Safe Hub — plus the anonymized
metrics feed for UNICEF's M&E pillar.

## Setup

```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
cp .env.example .env   # fill in your Supabase project keys
uvicorn app.main:app --reload --port 8000
```

Interactive docs: http://localhost:8000/docs

## Where things live

- `app/routers/emergency.py` — trigger + resolve the grounding flow, anonymous peer-counselor handoff queue
- `app/routers/mentor.py` — milestone card library, children profiles, deferred-sync progress
- `app/routers/safehub.py` — nearest verified resources (PostGIS-backed), peer-educator submissions
- `app/routers/metrics.py` — anonymized weekly aggregates for the UNICEF dashboard
- `app/core/security.py` — verifies the Supabase-issued JWT the frontend sends; `optional_user`
  is used anywhere (like the emergency button) that must never be gated behind login

## Deploying to Heroku

This directory is deployed on its own — see `/scripts/deploy-split.sh` in the
repo root, which pushes it to a dedicated `backend-deploy` branch that
contains *only* this folder's contents at its root (Heroku needs the
`Procfile` at the repo root it deploys, which is why the split exists).

```bash
heroku create youthparent-plus-api
heroku config:set SUPABASE_URL=... SUPABASE_ANON_KEY=... \
  SUPABASE_SERVICE_ROLE_KEY=... SUPABASE_JWT_SECRET=... \
  ALLOWED_ORIGINS=https://your-app.vercel.app -a youthparent-plus-api

# One-time: point Heroku's GitHub integration at the backend-deploy
# branch (Heroku dashboard → Deploy tab → GitHub → connect repo →
# choose "backend-deploy" as the branch to auto-deploy), then:
git push origin backend-deploy   # first push, or after scripts/deploy-split.sh
```

Any other ASGI host works too (Render, Fly.io, a small VPS behind Caddy/nginx)
if you'd rather not use Heroku — same env vars apply.
