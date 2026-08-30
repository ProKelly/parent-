-- ============================================================
-- YouthParent+ | Seed data for the pilot (Bamenda + peri-urban)
-- Run after schema.sql
-- ============================================================

-- Offline Pocket Mentor: a starter set of milestone cards.
-- Each has EN / FR / Pidgin text so the app can localize without
-- another network round-trip. Audio URLs are placeholders —
-- swap in real <500KB compressed clips recorded with peer educators.

insert into milestone_cards (age_month_min, age_month_max, title, body, audio_url, category, sort_order) values
(0, 3,
 '{"en": "Your newborn is learning your voice", "fr": "Votre nouveau-né apprend votre voix", "pidgin": "Ya small pikin di learn ya voice"}',
 '{"en": "Talk and sing to your baby often — it calms them and builds trust, even before they understand words.", "fr": "Parlez et chantez souvent à votre bébé — cela le calme et crée la confiance, même avant qu''il comprenne les mots.", "pidgin": "Talk and sing for ya baby plenty — e go calm am and build trust, even before e sabi word."}',
 '{"en": "https://parentplus-bay.vercel.app/audio/en/0-3-voice.mp3", "fr": "https://parentplus-bay.vercel.app/audio/fr/0-3-voice.mp3", "pidgin": "https://parentplus-bay.vercel.app/audio/pidgin/0-3-voice.mp3"}',
 'development', 1),
(0, 6,
 '{"en": "Crying is communication, not defiance", "fr": "Pleurer, c''est communiquer, pas défier", "pidgin": "Cry na message, e no be say pikin di provoke you"}',
 '{"en": "A crying baby is not trying to upset you. Take a breath, check hunger/sleep/comfort, and hold them close.", "fr": "Un bébé qui pleure n''essaie pas de vous contrarier. Respirez, vérifiez faim/sommeil/confort, et serrez-le contre vous.", "pidgin": "When pikin di cry, e no di try vex you. Breathe, check if e hungry, sleepy or uncomfortable, hold am close."}',
 '{"en": "https://parentplus-bay.vercel.app/audio/en/0-6-crying.mp3"}',
 'discipline', 2),
(6, 12,
 '{"en": "Babbling is the first step to talking", "fr": "Babiller est la première étape pour parler", "pidgin": "Baby-talk na di first step to real talk"}',
 '{"en": "Repeat sounds your baby makes back to them. This simple game builds language skills fast.", "fr": "Répétez les sons que fait votre bébé. Ce jeu simple développe rapidement le langage.", "pidgin": "Repeat di sound wey ya baby di make. Dis simple game go build im language fast."}',
 '{}', 'development', 3),
(12, 24,
 '{"en": "Tantrums are a stage, not a character flaw", "fr": "Les crises sont une étape, pas un défaut de caractère", "pidgin": "Tantrum na stage, e no mean say pikin bad"}',
 '{"en": "When your toddler melts down, get to their eye level, stay calm, and name the feeling: \"You are angry.\" Discipline works better after they''re calm.", "fr": "Quand votre enfant craque, mettez-vous à sa hauteur, restez calme, nommez le sentiment : « Tu es fâché ». La discipline fonctionne mieux une fois calmé.", "pidgin": "When ya pikin di tantrum, kneel down for im level, stay calm, call di feeling: \"You dey vex.\" Discipline di work better once e don calm."}',
 '{"en": "https://parentplus-bay.vercel.app/audio/en/12-24-tantrum.mp3"}',
 'discipline', 4),
(24, 36,
 '{"en": "Praise the effort, not just the result", "fr": "Félicitez l''effort, pas seulement le résultat", "pidgin": "Praise di effort, no be only di result"}',
 '{"en": "\"You tried so hard!\" builds more confidence than punishment ever will. Praise often, correct gently.", "fr": "« Tu as fait de ton mieux ! » construit plus de confiance que n''importe quelle punition. Félicitez souvent, corrigez doucement.", "pidgin": "\"You try well well!\" di build confidence pass any kind beating. Praise am often, correct am softly."}',
 '{}', 'discipline', 5);

-- Community Safe Hub: sample resources around Bamenda (pilot region).
-- Coordinates are approximate town-center points — replace with
-- verified GPS from peer educators during onboarding.

insert into safehub_resources (name, type, description, phone, location, region, is_youth_friendly, verified) values
('Bamenda Regional Hospital — Youth-Friendly Corner', 'health_center',
 'Free consultations for adolescent parents, confidential and stigma-free.', '+237 6XX XXX XXX',
 ST_SetSRID(ST_MakePoint(10.1590, 5.9631), 4326), 'Bamenda', true, true),
('Nkwen Health Center', 'health_center',
 'Maternal & child health services, walk-ins welcome.', '+237 6XX XXX XXX',
 ST_SetSRID(ST_MakePoint(10.1667, 5.9833), 4326), 'Bamenda', true, true),
('Mankon Youth Safe Space', 'safe_space',
 'Drop-in center for young parents — counseling, rest area, childcare corner.', '+237 6XX XXX XXX',
 ST_SetSRID(ST_MakePoint(10.1420, 5.9700), 4326), 'Bamenda', true, false),
('DsmartCity Peer Educator Point — Bamenda', 'peer_educator_point',
 'Meet a trained peer educator in person, Tue/Thu afternoons.', '+237 6XX XXX XXX',
 ST_SetSRID(ST_MakePoint(10.1500, 5.9600), 4326), 'Bamenda', true, true);
