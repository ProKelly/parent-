-- ============================================================
-- YouthParent+ | Seed data
-- Run after schema.sql
-- ============================================================
-- Audio is hosted in the Supabase Storage "audio" bucket (project
-- qkzlcnmhorvbgcjhwldq). Images are free-license photos hosted on
-- Pexels' CDN (images.pexels.com) — see the credits block at the
-- bottom of this file for photographer attribution.

insert into milestone_cards (age_month_min, age_month_max, title, body, audio_url, image_url, category, sort_order) values
(0, 3,
 '{"en": "Your newborn is learning your voice", "fr": "Votre nouveau-né apprend votre voix", "pidgin": "Ya small pikin di learn ya voice"}',
 '{"en": "Talk and sing to your baby often — it calms them and builds trust, even before they understand words.", "fr": "Parlez et chantez souvent à votre bébé — cela le calme et crée la confiance, même avant qu''il comprenne les mots.", "pidgin": "Talk and sing for ya baby plenty — e go calm am and build trust, even before e sabi word."}',
 '{"en": "https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/en/0-3-voice.mp3", "fr": "https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/fr/0-3-voice.mp3", "pidgin": "https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/pidgin/0-3-voice.mp3"}',
 'https://images.pexels.com/photos/7282403/pexels-photo-7282403.jpeg?auto=compress&cs=tinysrgb&w=800',
 'development', 1),
(0, 6,
 '{"en": "Crying is communication, not defiance", "fr": "Pleurer, c''est communiquer, pas défier", "pidgin": "Cry na message, e no be say pikin di provoke you"}',
 '{"en": "A crying baby is not trying to upset you. Take a breath, check hunger/sleep/comfort, and hold them close.", "fr": "Un bébé qui pleure n''essaie pas de vous contrarier. Respirez, vérifiez faim/sommeil/confort, et serrez-le contre vous.", "pidgin": "When pikin di cry, e no di try vex you. Breathe, check if e hungry, sleepy or uncomfortable, hold am close."}',
 '{"en": "https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/en/0-6-crying.mp3", "fr": "https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/fr/0-6-crying.mp3", "pidgin": "https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/pidgin/0-6-crying.mp3"}',
 'https://images.pexels.com/photos/9705912/pexels-photo-9705912.jpeg?auto=compress&cs=tinysrgb&w=800',
 'discipline', 2),
(6, 12,
 '{"en": "Babbling is the first step to talking", "fr": "Babiller est la première étape pour parler", "pidgin": "Baby-talk na di first step to real talk"}',
 '{"en": "Repeat sounds your baby makes back to them. This simple game builds language skills fast.", "fr": "Répétez les sons que fait votre bébé. Ce jeu simple développe rapidement le langage.", "pidgin": "Repeat di sound wey ya baby di make. Dis simple game go build im language fast."}',
 '{"en": "https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/en/6-12-babbling.mp3", "fr": "https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/fr/6-12-babbling.mp3", "pidgin": "https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/pidgin/6-12-babbling.mp3"}',
 'https://images.pexels.com/photos/37529274/pexels-photo-37529274.jpeg?auto=compress&cs=tinysrgb&w=800',
 'development', 3),
(12, 24,
 '{"en": "Tantrums are a stage, not a character flaw", "fr": "Les crises sont une étape, pas un défaut de caractère", "pidgin": "Tantrum na stage, e no mean say pikin bad"}',
 '{"en": "When your toddler melts down, get to their eye level, stay calm, and name the feeling: \"You are angry.\" Discipline works better after they''re calm.", "fr": "Quand votre enfant craque, mettez-vous à sa hauteur, restez calme, nommez le sentiment : « Tu es fâché ». La discipline fonctionne mieux une fois calmé.", "pidgin": "When ya pikin di tantrum, kneel down for im level, stay calm, call di feeling: \"You dey vex.\" Discipline di work better once e don calm."}',
 '{"en": "https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/en/12-24-tantrum.mp3", "fr": "https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/fr/12-24-tantrum.mp3", "pidgin": "https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/pidgin/12-24-tantrum.mp3"}',
 'https://images.pexels.com/photos/6624317/pexels-photo-6624317.jpeg?auto=compress&cs=tinysrgb&w=800',
 'discipline', 4),
(24, 36,
 '{"en": "Praise the effort, not just the result", "fr": "Félicitez l''effort, pas seulement le résultat", "pidgin": "Praise di effort, no be only di result"}',
 '{"en": "\"You tried so hard!\" builds more confidence than punishment ever will. Praise often, correct gently.", "fr": "« Tu as fait de ton mieux ! » construit plus de confiance que n''importe quelle punition. Félicitez souvent, corrigez doucement.", "pidgin": "\"You try well well!\" di build confidence pass any kind beating. Praise am often, correct am softly."}',
 '{"en": "https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/en/24-36-praise.mp3", "fr": "https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/fr/24-36-praise.mp3", "pidgin": "https://qkzlcnmhorvbgcjhwldq.supabase.co/storage/v1/object/public/audio/pidgin/24-36-praise.mp3"}',
 'https://images.pexels.com/photos/13019957/pexels-photo-13019957.jpeg?auto=compress&cs=tinysrgb&w=800',
 'discipline', 5);

-- Photo credits (Pexels License — free to use, no attribution legally
-- required, credited here anyway as good practice):
--   0-3:   Photo by Sarah Chai
--   0-6:   Photo by Greta Hoffman
--   6-12:  Photo by King Shooter
--   12-24: Photo by Keira Burton
--   24-36: Photo by dboyag

-- ------------------------------------------------------------
-- Community Safe Hub: real, researched resources across the
-- five pilot cities (Bamenda, Yaoundé, Douala, Limbe, Buea).
--
-- Every entry below is a real, named institution found via public
-- web search. Coordinates marked "approx" are town/district-level
-- estimates, not the exact building GPS pin — replace with a precise
-- pin (dropped via Google Maps at the actual entrance) as each city
-- is onboarded. Phone numbers are included only where independently
-- confirmed from an official or well-established source; where none
-- could be verified, the field is left null rather than guessed —
-- never present an unverified number as if it were confirmed.
--
-- peer_educator_point entries are intentionally NOT seeded with real
-- data here: those are YouthParent+'s own future in-person network,
-- to be added once real peer educators are recruited in each city
-- (see the Scale-Up Plan in the pitch deck), not existing external
-- organizations.
-- ------------------------------------------------------------

insert into safehub_resources (name, type, description, phone, location, region, is_youth_friendly, verified) values

-- BAMENDA
('Bamenda Regional Hospital', 'health_center',
 'Regional reference hospital for the North West, opened 1956. Public Ministry of Health facility with pediatrics and maternity wards.', null,
 ST_SetSRID(ST_MakePoint(10.1590, 5.9631), 4326), 'Bamenda', true, true),
('Nkwen Baptist Hospital', 'health_center',
 'CBC Health Services facility at Finance Junction, Bamenda. 207 beds, operates 24/7, full maternity and pediatric admissions.', '+237 675 205 729',
 ST_SetSRID(ST_MakePoint(10.1667, 5.9833), 4326), 'Bamenda', true, true),

-- YAOUNDÉ
('Centre Mère et Enfant — Fondation Chantal Biya', 'health_center',
 'Major pediatric and maternal-child reference hospital, 205 beds. Neonatology, pediatrics, and maternal outpatient care. Adjacent to Hôpital Central.', null,
 ST_SetSRID(ST_MakePoint(11.5104, 3.8714), 4326), 'Yaoundé', true, true),
('CAMNAFAW Centre Médical de Mimboman', 'support_network',
 'Youth-friendly sexual and reproductive health service point run by CAMNAFAW (IPPF member association), with dedicated youth sites and volunteer peer counselors.', '+237 677 72 28 97',
 ST_SetSRID(ST_MakePoint(11.5495601, 3.869285), 4326), 'Yaoundé', true, true),

-- DOUALA
('Hôpital Laquintinie de Douala', 'health_center',
 'Second-category reference hospital in Akwa, founded 1931. Pediatrics department houses a reference kangaroo-care neonatal unit for Central Africa.', '+237 688 824 844',
 ST_SetSRID(ST_MakePoint(9.7000, 4.0500), 4326), 'Douala', true, true),
('Clinique CAMNAFAW Douala', 'support_network',
 'CAMNAFAW youth-friendly reproductive health clinic, Douala 5e (Littoral, Wouri).', '+237 677 16 53 64',
 ST_SetSRID(ST_MakePoint(9.7350, 4.0650), 4326), 'Douala', true, true),

-- LIMBE
('Regional Hospital Limbe (Mile 1)', 'health_center',
 'Principal referral hospital for the South West region, 200 beds. Pediatrics, maternity, gynaecology and obstetrics units; teaching hospital for University of Buea medical students.', null,
 ST_SetSRID(ST_MakePoint(9.2186, 4.0219), 4326), 'Limbe', true, true),

-- BUEA
('Buea Regional Hospital', 'health_center',
 'Regional hospital near Mile 17, Fako Division. Dedicated paediatrics and maternity units, each headed by a specialist doctor.', null,
 ST_SetSRID(ST_MakePoint(9.2427, 4.1560), 4326), 'Buea', true, true);
