-- ============================================================
-- Run this in the Supabase SQL Editor to point the milestone
-- cards' audio_url columns at the "audio" Storage bucket
-- (project qkzlcnmhorvbgcjhwldq). Safe to re-run any time you
-- swap in a new clip — each statement is a plain UPDATE keyed
-- on the card's age range, so it never creates duplicate rows
-- the way re-running seed.sql would.
--
-- Note: this is plain SQL, not psql — the Supabase SQL Editor
-- runs statements directly and doesn't understand psql
-- meta-commands like \set, so the base URL is spelled out in
-- full on every line below rather than stored in a variable.
-- ============================================================

update milestone_cards set audio_url = jsonb_build_object(
  'en', 'https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/en/0-3-voice.mp3',
  'fr', 'https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/fr/0-3-voice.mp3',
  'pidgin', 'https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/pidgin/0-3-voice.mp3'
) where age_month_min = 0 and age_month_max = 3;

update milestone_cards set audio_url = jsonb_build_object(
  'en', 'https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/en/0-6-crying.mp3',
  'fr', 'https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/fr/0-6-crying.mp3',
  'pidgin', 'https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/pidgin/0-6-crying.mp3'
) where age_month_min = 0 and age_month_max = 6;

update milestone_cards set audio_url = jsonb_build_object(
  'en', 'https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/en/6-12-babbling.mp3',
  'fr', 'https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/fr/6-12-babbling.mp3',
  'pidgin', 'https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/pidgin/6-12-babbling.mp3'
) where age_month_min = 6 and age_month_max = 12;

update milestone_cards set audio_url = jsonb_build_object(
  'en', 'https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/en/12-24-tantrum.mp3',
  'fr', 'https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/fr/12-24-tantrum.mp3',
  'pidgin', 'https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/pidgin/12-24-tantrum.mp3'
) where age_month_min = 12 and age_month_max = 24;

update milestone_cards set audio_url = jsonb_build_object(
  'en', 'https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/en/24-36-praise.mp3',
  'fr', 'https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/fr/24-36-praise.mp3',
  'pidgin', 'https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/pidgin/24-36-praise.mp3'
) where age_month_min = 24 and age_month_max = 36;

-- Sanity check — confirm all 5 rows now show the Supabase Storage URLs
select age_month_min, age_month_max, audio_url from milestone_cards order by age_month_min;
