# YouthParent+

**A digital shield to prevent parental burnout and protect vulnerable
young families in Cameroon.**
UNICEF Cameroon Digital Innovation Competition submission — Togettech team.

Stack: **Nuxt 3 + Tailwind** (frontend, installable offline-first PWA) ·
**FastAPI** (backend) · **Supabase** (Postgres + PostGIS + Auth).

## The three pillars, and where they live

| Pillar | Frontend | Backend | Data |
|---|---|---|---|
| 🤲 De-escalation Button | `frontend/pages/emergency.vue` | `backend/app/routers/emergency.py` | `emergency_events`, `handoff_requests` |
| 🧸 Offline Pocket Mentor | `frontend/pages/mentor.vue` | `backend/app/routers/mentor.py` | `milestone_cards`, `children`, `mentor_progress` |
| 📍 Community Safe Hub | `frontend/pages/safehub.vue` | `backend/app/routers/safehub.py` | `safehub_resources` (PostGIS) |
| Anonymized M&E metrics | — | `backend/app/routers/metrics.py` | `metrics_weekly` view |

## Repo structure & deployment branches

This is a monorepo — `main` holds everything (docs, database, both apps)
and is the source of truth you keep working on. Two generated branches
carry only what each host needs:

- **`frontend-deploy`** — just `/frontend`'s contents, at branch root. Vercel's
  Production Branch points here.
- **`backend-deploy`** — just `/backend`'s contents, at branch root (so
  `Procfile` is where Heroku expects it). Heroku's GitHub auto-deploy
  points here.

After committing changes to `main` as normal, run:

```bash
./scripts/deploy-split.sh
```

This regenerates both branches from whatever's currently on `main` and
force-pushes them, which triggers a Vercel and/or Heroku redeploy
automatically. You never push to `frontend-deploy` or `backend-deploy`
by hand — the script owns them.

First-time setup for each platform is in `frontend/README.md` and
`backend/README.md`.



1. **Supabase**: create a free project at supabase.com. In the SQL
   editor, run `database/schema.sql` then `database/seed.sql`. Copy
   your project URL, anon key, service-role key, and JWT secret from
   Project Settings → API.
2. **Backend**:
   ```bash
   cd backend
   cp .env.example .env   # paste your Supabase keys
   python3 -m venv venv && source venv/bin/activate
   pip install -r requirements.txt
   uvicorn app.main:app --reload --port 8000
   ```
3. **Frontend**:
   ```bash
   cd frontend
   cp .env.example .env   # paste your Supabase URL + anon key
   npm install
   npm run dev
   ```
4. Open http://localhost:3000 — tap through the home screen, try the
   emergency breathing flow, browse Pocket Mentor cards, and check
   Safe Hub (it'll show the seeded Bamenda pilot resources).

## What's built vs. what's next before the Aug 31 deadline

**Built and working end-to-end:**
- Full data model with row-level security (parents only see their
  own children/progress; peer educators/admins get elevated read/write)
- All three pillar flows, wired frontend-to-backend-to-database
- Offline-first Pocket Mentor (localStorage cache + sync queue + PWA
  service-worker caching)
- Anonymous-by-default emergency flow — works without login, coarse
  region only, no free-text or precise GPS ever stored
- Geospatial "nearest resource" lookup for the Safe Hub via PostGIS
- Anonymized weekly metrics view for the UNICEF M&E dashboard

**Worth doing before the live pitch, in priority order:**
1. Record real compressed (<500KB) audio clips in French/Pidgin/local
   languages with peer educators — swap into `milestone_cards.audio_url`
   and `emergency.py`'s `GROUNDING_AUDIO_URL`.
2. Add the two PNG app icons to `frontend/public/icons/` so the PWA
   install prompt looks right on a phone.
3. Deploy: frontend to any Node/static host, backend to Render/Fly.io/
   a small VPS, Supabase is already hosted. Update the two `.env` files
   with the live URLs and redeploy.
4. Recruit and onboard the first 2–3 real peer educators as
   `peer_educator` role accounts so the handoff queue and Safe Hub
   directory have real people behind them for the pilot demo.

## Privacy by design

Every table is deliberately minimal: no child names (nicknames +
birth-month only), no precise home addresses (region only), no
free-text in emergency logs, and the emergency flow works fully
anonymously if a parent never logs in. This mirrors the motivation
letter's commitment to "prioritizing confidentiality, the safety of
minors' and young users' data."
