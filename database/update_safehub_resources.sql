-- ============================================================
-- Run this in the Supabase SQL Editor to replace the placeholder
-- Safe Hub resources (from the original seed.sql) with real,
-- researched institutions across all 5 pilot cities. See the
-- notes at the top of database/seed.sql for sourcing details —
-- phone numbers are included only where independently verified;
-- everything else is left null rather than guessed.
--
-- This clears the table first since these are placeholder rows
-- being replaced, not real historical data — if you've already
-- added your own real entries through the app (peer educators
-- submitting resources via POST /api/safehub/resources), do NOT
-- run the delete line; just run the inserts below it instead.
-- ============================================================

delete from safehub_resources;

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

-- Sanity check
select name, type, region, phone, verified from safehub_resources order by region, name;
