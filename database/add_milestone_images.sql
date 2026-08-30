-- ============================================================
-- Run this in the Supabase SQL Editor to add photo illustrations
-- to the Pocket Mentor cards on an ALREADY-SEEDED database
-- (adds the column, then fills in each existing row — safe to
-- re-run any time you want to swap in a different photo).
-- ============================================================

alter table milestone_cards add column if not exists image_url text;

update milestone_cards set image_url =
  'https://images.pexels.com/photos/7282403/pexels-photo-7282403.jpeg?auto=compress&cs=tinysrgb&w=800'
  where age_month_min = 0 and age_month_max = 3;

update milestone_cards set image_url =
  'https://images.pexels.com/photos/9705912/pexels-photo-9705912.jpeg?auto=compress&cs=tinysrgb&w=800'
  where age_month_min = 0 and age_month_max = 6;

update milestone_cards set image_url =
  'https://images.pexels.com/photos/37529274/pexels-photo-37529274.jpeg?auto=compress&cs=tinysrgb&w=800'
  where age_month_min = 6 and age_month_max = 12;

update milestone_cards set image_url =
  'https://images.pexels.com/photos/6624317/pexels-photo-6624317.jpeg?auto=compress&cs=tinysrgb&w=800'
  where age_month_min = 12 and age_month_max = 24;

update milestone_cards set image_url =
  'https://images.pexels.com/photos/13019957/pexels-photo-13019957.jpeg?auto=compress&cs=tinysrgb&w=800'
  where age_month_min = 24 and age_month_max = 36;

-- Sanity check
select age_month_min, age_month_max, image_url from milestone_cards order by age_month_min;
