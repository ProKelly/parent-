-- ============================================================
-- YouthParent+ | Supabase (PostgreSQL) schema
-- UNICEF Cameroon Digital Innovation Competition submission
-- ============================================================
-- Run this in the Supabase SQL editor (or `supabase db push`).
-- Assumes Supabase Auth is enabled (auth.users table exists).

create extension if not exists "uuid-ossp";
create extension if not exists postgis;

-- ------------------------------------------------------------
-- 1. PROFILES — extends auth.users with app-specific fields.
--    Primary users (young parents) and secondary users
--    (community/peer workers) share this table, split by role.
-- ------------------------------------------------------------
create type user_role as enum ('parent', 'peer_educator', 'admin');

create table if not exists profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  role user_role not null default 'parent',
  display_name text,               -- first name / nickname only, never full legal ID
  preferred_language text default 'en', -- 'en' | 'fr' | 'pidgin' | local language code
  region text,                     -- broad region only (e.g. "Bamenda"), never precise home address
  is_anonymous boolean default true,
  created_at timestamptz default now()
);

alter table profiles enable row level security;
create policy "Users manage their own profile"
  on profiles for all
  using (auth.uid() = id)
  with check (auth.uid() = id);

-- ------------------------------------------------------------
-- 2. CHILDREN — one or more children per parent, used to
--    drive the age-appropriate Offline Pocket Mentor content.
--    No names required; a nickname/emoji avatar is enough.
-- ------------------------------------------------------------
create table if not exists children (
  id uuid primary key default uuid_generate_v4(),
  parent_id uuid not null references profiles(id) on delete cascade,
  nickname text not null default 'Baby',
  birth_month date not null,       -- month precision only, protects privacy
  avatar_emoji text default '👶',
  created_at timestamptz default now()
);

alter table children enable row level security;
create policy "Parents manage their own children"
  on children for all
  using (auth.uid() = parent_id)
  with check (auth.uid() = parent_id);

-- ------------------------------------------------------------
-- 3. MILESTONE CARDS — the Pocket Mentor content library.
--    Static reference content, readable by everyone, editable
--    only by admins/content team. Ships pre-loaded on-device
--    for offline use; this table is the source of truth that
--    the app syncs down once and caches locally.
-- ------------------------------------------------------------
create table if not exists milestone_cards (
  id uuid primary key default uuid_generate_v4(),
  age_month_min int not null,      -- inclusive
  age_month_max int not null,      -- inclusive
  title jsonb not null,            -- {"en": "...", "fr": "...", "pidgin": "..."}
  body jsonb not null,             -- short positive-parenting tip, per language
  audio_url jsonb,                 -- {"en": "https://.../clip.mp3", ...} <500KB clips
  category text not null default 'development', -- 'development' | 'discipline' | 'health'
  sort_order int default 0
);

alter table milestone_cards enable row level security;
create policy "Milestone cards are publicly readable"
  on milestone_cards for select using (true);

-- ------------------------------------------------------------
-- 4. MENTOR PROGRESS — per-child, per-card completion, written
--    by the device once connectivity returns (deferred sync).
-- ------------------------------------------------------------
create table if not exists mentor_progress (
  id uuid primary key default uuid_generate_v4(),
  child_id uuid not null references children(id) on delete cascade,
  card_id uuid not null references milestone_cards(id) on delete cascade,
  completed_at timestamptz not null default now(),
  synced_at timestamptz default now(),
  unique (child_id, card_id)
);

alter table mentor_progress enable row level security;
create policy "Parents manage their child's progress"
  on mentor_progress for all
  using (
    exists (select 1 from children c where c.id = child_id and c.parent_id = auth.uid())
  )
  with check (
    exists (select 1 from children c where c.id = child_id and c.parent_id = auth.uid())
  );

-- ------------------------------------------------------------
-- 5. SAFE HUB RESOURCES — the community map/directory:
--    health centers, safe spaces, support networks.
-- ------------------------------------------------------------
create type resource_type as enum ('health_center', 'safe_space', 'support_network', 'peer_educator_point');

create table if not exists safehub_resources (
  id uuid primary key default uuid_generate_v4(),
  name text not null,
  type resource_type not null,
  description text,
  phone text,
  location geography(point, 4326) not null, -- lon/lat
  region text not null,
  is_youth_friendly boolean default true,
  verified boolean default false,           -- verified by a peer educator/admin
  added_by uuid references profiles(id),
  created_at timestamptz default now()
);

create index if not exists safehub_resources_geo_idx on safehub_resources using gist (location);

alter table safehub_resources enable row level security;
create policy "Resources are publicly readable"
  on safehub_resources for select using (true);
create policy "Peer educators and admins can add resources"
  on safehub_resources for insert
  with check (
    exists (select 1 from profiles p where p.id = auth.uid() and p.role in ('peer_educator', 'admin'))
  );

-- ------------------------------------------------------------
-- 6. EMERGENCY EVENTS — the De-escalation Button trail.
--    Deliberately minimal + anonymized: no free text, no
--    precise GPS, no child identity. Used only for aggregate
--    M&E metrics and to route an anonymous handoff to a peer
--    counselor when the parent opts in.
-- ------------------------------------------------------------
create type emergency_outcome as enum ('self_resolved', 'requested_handoff', 'handoff_completed');

create table if not exists emergency_events (
  id uuid primary key default uuid_generate_v4(),
  parent_id uuid references profiles(id) on delete set null, -- nullable: fully anonymous mode
  region text,                     -- coarse region only
  outcome emergency_outcome not null default 'self_resolved',
  duration_seconds int,            -- how long the grounding audio ran
  created_at timestamptz default now()
);

alter table emergency_events enable row level security;
create policy "Users can log their own emergency events"
  on emergency_events for insert
  with check (auth.uid() = parent_id or parent_id is null);
create policy "Users can view their own emergency events"
  on emergency_events for select
  using (auth.uid() = parent_id);

-- ------------------------------------------------------------
-- 7. PEER COUNSELOR QUEUE — anonymous handoff routing.
--    A peer educator picks up a pending handoff; no PII
--    beyond a rotating anonymous session token is stored.
-- ------------------------------------------------------------
create table if not exists handoff_requests (
  id uuid primary key default uuid_generate_v4(),
  emergency_event_id uuid not null references emergency_events(id) on delete cascade,
  status text not null default 'pending', -- pending | claimed | closed
  claimed_by uuid references profiles(id),
  claimed_at timestamptz,
  region text,
  created_at timestamptz default now()
);

alter table handoff_requests enable row level security;
create policy "Peer educators can view and claim pending handoffs"
  on handoff_requests for select
  using (
    exists (select 1 from profiles p where p.id = auth.uid() and p.role in ('peer_educator', 'admin'))
  );
create policy "Peer educators can claim handoffs"
  on handoff_requests for update
  using (
    exists (select 1 from profiles p where p.id = auth.uid() and p.role in ('peer_educator', 'admin'))
  );

-- ------------------------------------------------------------
-- 7b. NEARBY RESOURCES RPC — used by the Community Safe Hub to
--     find the closest verified resources to a parent's location,
--     sorted by distance. Called from the backend via .rpc().
-- ------------------------------------------------------------
create or replace function nearby_resources(in_lat float, in_lng float, radius_km float default 25)
returns table (
  id uuid, name text, type resource_type, description text, phone text,
  lat float, lng float, region text, is_youth_friendly boolean, verified boolean,
  distance_km float
) as $$
  select
    r.id, r.name, r.type, r.description, r.phone,
    ST_Y(r.location::geometry) as lat, ST_X(r.location::geometry) as lng,
    r.region, r.is_youth_friendly, r.verified,
    ST_Distance(r.location, ST_SetSRID(ST_MakePoint(in_lng, in_lat), 4326)::geography) / 1000 as distance_km
  from safehub_resources r
  where ST_DWithin(r.location, ST_SetSRID(ST_MakePoint(in_lng, in_lat), 4326)::geography, radius_km * 1000)
  order by distance_km asc;
$$ language sql stable;

-- ------------------------------------------------------------
-- 8. AGGREGATE METRICS VIEW — anonymized M&E dashboard feed
--    (UNICEF pillar #3: "Monitor and evaluate remotely").
-- ------------------------------------------------------------
create or replace view metrics_weekly as
select
  date_trunc('week', created_at) as week,
  region,
  count(*) filter (where outcome = 'self_resolved') as self_resolved_count,
  count(*) filter (where outcome != 'self_resolved') as handoff_count,
  avg(duration_seconds) as avg_grounding_seconds
from emergency_events
group by 1, 2
order by 1 desc;
