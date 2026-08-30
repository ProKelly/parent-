-- ============================================================
-- Run this AFTER uploading audio-ready/ to a public Supabase
-- Storage bucket called "audio", preserving the en/fr/pidgin
-- folder structure. Supabase Storage public URLs follow this
-- pattern:
--
--   {SUPABASE_URL}/storage/v1/object/public/audio/en/grounding-90s.mp3
--
-- Replace YOUR-PROJECT-REF below, then run this whole file in
-- the Supabase SQL editor.
-- ============================================================

\set base 'https://YOUR-PROJECT-REF.supabase.co/storage/v1/object/public/audio'

update milestone_cards set audio_url = jsonb_build_object(
  'en', :'base' || '/en/0-3-voice.mp3',
  'fr', :'base' || '/fr/0-3-voice.mp3',
  'pidgin', :'base' || '/pidgin/0-3-voice.mp3'
) where age_month_min = 0 and age_month_max = 3;

update milestone_cards set audio_url = jsonb_build_object(
  'en', :'base' || '/en/0-6-crying.mp3',
  'fr', :'base' || '/fr/0-6-crying.mp3',
  'pidgin', :'base' || '/pidgin/0-6-crying.mp3'
) where age_month_min = 0 and age_month_max = 6;

update milestone_cards set audio_url = jsonb_build_object(
  'en', :'base' || '/en/6-12-babbling.mp3',
  'fr', :'base' || '/fr/6-12-babbling.mp3',
  'pidgin', :'base' || '/pidgin/6-12-babbling.mp3'
) where age_month_min = 6 and age_month_max = 12;

update milestone_cards set audio_url = jsonb_build_object(
  'en', :'base' || '/en/12-24-tantrum.mp3',
  'fr', :'base' || '/fr/12-24-tantrum.mp3',
  'pidgin', :'base' || '/pidgin/12-24-tantrum.mp3'
) where age_month_min = 12 and age_month_max = 24;

update milestone_cards set audio_url = jsonb_build_object(
  'en', :'base' || '/en/24-36-praise.mp3',
  'fr', :'base' || '/fr/24-36-praise.mp3',
  'pidgin', :'base' || '/pidgin/24-36-praise.mp3'
) where age_month_min = 24 and age_month_max = 36;

-- Sanity check
select age_month_min, age_month_max, audio_url from milestone_cards order by age_month_min;

-- Note: if the Supabase SQL editor doesn't like \set (psql-only syntax),
-- just find-and-replace YOUR-PROJECT-REF by hand in each line below
-- and drop the :'base' variable, e.g.:
--
-- update milestone_cards set audio_url = jsonb_build_object(
--   'en', 'https://YOUR-PROJECT-REF.supabase.co/storage/v1/object/public/audio/en/0-3-voice.mp3',
--   ...
-- ) where age_month_min = 0 and age_month_max = 3;
