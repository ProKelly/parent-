# YouthParent+ App (Nuxt 3 + Tailwind)

Mobile-first, installable PWA. Matches the wireframe spec from the
submission deck: 3-icon home screen, a fixed one-tap emergency button
reachable from any screen, and a swipeable Pocket Mentor journey.

## Setup

```bash
npm install
cp .env.example .env   # point at your Supabase project + API URL
npm run dev
```

Visit http://localhost:3000. On a phone on the same network, visit
`http://<your-computer-ip>:3000` and "Add to Home Screen" to test the
installed PWA experience.

## Offline behavior

- `composables/useOfflineSync.ts` caches the milestone-card library in
  `localStorage` on first load and queues completed-card events while
  offline, flushing them to `/api/mentor/progress` on the next
  `online` event.
- `@vite-pwa/nuxt` (see `nuxt.config.ts`) additionally service-worker–
  caches the app shell and audio clips so the Pocket Mentor and
  emergency grounding flow work with zero connectivity after first load.

## Design notes

Palette and type are pulled straight from the pitch deck (`ink`
#0B3D3F, `mint` #2ED9A3) so the shipped app and the submission
materials read as one brand. Tap targets are large and text is kept
short throughout, per the low-literacy target audience.

## Building for production

```bash
npm run build   # SSR build — deploy to any Node host
# or
npm run generate  # fully static build if you don't need SSR
```

## Deploying to Vercel

This directory is deployed on its own — see `/scripts/deploy-split.sh` in the
repo root, which pushes it to a dedicated `frontend-deploy` branch containing
*only* this folder's contents at its root. Nuxt 3 is zero-config on Vercel.

```bash
git push origin frontend-deploy   # first push, or after scripts/deploy-split.sh
```

Then in the Vercel dashboard: New Project → Import your GitHub repo →
set **Production Branch** to `frontend-deploy` → add the two env vars from
`.env.example` (`NUXT_PUBLIC_SUPABASE_URL`, `NUXT_PUBLIC_SUPABASE_ANON_KEY`)
plus `NUXT_PUBLIC_API_BASE` pointing at your Heroku backend URL → Deploy.
Every future push to `frontend-deploy` redeploys automatically.
