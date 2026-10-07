-- =========================================
-- EXPERT REVIEW SQL
-- This file creates and cleans the expert review data
-- Import the CSV into expert_review_raw after creating the raw table
-- =========================================


-- Create the raw expert review table
-- I first store all columns as TEXT so the original data can be imported safely

CREATE TABLE expert_review_raw (
    url TEXT,
    idvscore TEXT,
    reviewer TEXT,
    datep TEXT,
    rev TEXT,
    liwc_wc TEXT,
    liwc_analytic TEXT,
    liwc_clout TEXT,
    liwc_authentic TEXT,
    liwc_tone TEXT,
    liwc_wps TEXT,
    liwc_sixltr TEXT,
    liwc_dic TEXT,
    liwc_function TEXT,
    liwc_pronoun TEXT,
    liwc_ppron TEXT,
    liwc_i TEXT,
    liwc_we TEXT,
    liwc_you TEXT,
    liwc_shehe TEXT,
    liwc_they TEXT,
    liwc_ipron TEXT,
    liwc_article TEXT,
    liwc_prep TEXT,
    liwc_auxverb TEXT,
    liwc_adverb TEXT,
    liwc_conj TEXT,
    liwc_negate TEXT,
    liwc_verb TEXT,
    liwc_adj TEXT,
    liwc_compare TEXT,
    liwc_interrog TEXT,
    liwc_number TEXT,
    liwc_quant TEXT,
    liwc_affect TEXT,
    liwc_posemo TEXT,
    liwc_negemo TEXT,
    liwc_anx TEXT,
    liwc_anger TEXT,
    liwc_sad TEXT,
    liwc_social TEXT,
    liwc_family TEXT,
    liwc_friend TEXT,
    liwc_female TEXT,
    liwc_male TEXT,
    liwc_cogproc TEXT,
    liwc_insight TEXT,
    liwc_cause TEXT,
    liwc_discrep TEXT,
    liwc_tentat TEXT,
    liwc_certain TEXT,
    liwc_differ TEXT,
    liwc_percept TEXT,
    liwc_see TEXT,
    liwc_hear TEXT,
    liwc_feel TEXT,
    liwc_bio TEXT,
    liwc_body TEXT,
    liwc_health TEXT,
    liwc_sexual TEXT,
    liwc_ingest TEXT,
    liwc_drives TEXT,
    liwc_affiliation TEXT,
    liwc_achieve TEXT,
    liwc_power TEXT,
    liwc_reward TEXT,
    liwc_risk TEXT,
    liwc_focuspast TEXT,
    liwc_focuspresent TEXT,
    liwc_focusfuture TEXT,
    liwc_relativ TEXT,
    liwc_motion TEXT,
    liwc_space TEXT,
    liwc_time TEXT,
    liwc_work TEXT,
    liwc_leisure TEXT,
    liwc_home TEXT,
    liwc_money TEXT,
    liwc_relig TEXT,
    liwc_death TEXT,
    liwc_informal TEXT,
    liwc_swear TEXT,
    liwc_netspeak TEXT,
    liwc_assent TEXT,
    liwc_nonflu TEXT,
    liwc_filler TEXT,
    liwc_allpunc TEXT,
    liwc_period TEXT,
    liwc_comma TEXT,
    liwc_colon TEXT,
    liwc_semic TEXT,
    liwc_qmark TEXT,
    liwc_exclam TEXT,
    liwc_dash TEXT,
    liwc_quote TEXT,
    liwc_apostro TEXT,
    liwc_parenth TEXT,
    liwc_otherp TEXT
);


-- Change text 'None' values to SQL NULL
-- NULL is the correct SQL value for missing data

UPDATE expert_review_raw
SET reviewer = NULL
WHERE LOWER(TRIM(reviewer)) = 'none';

UPDATE expert_review_raw
SET datep = NULL
WHERE LOWER(TRIM(datep)) = 'none';

UPDATE expert_review_raw
SET rev = NULL
WHERE LOWER(TRIM(rev)) = 'none';

UPDATE expert_review_raw
SET idvscore = NULL
WHERE LOWER(TRIM(idvscore)) = 'none';


-- Create the clean expert review table without exact duplicates
-- I keep the raw table so the original data stays available

SELECT DISTINCT *
INTO expert_review
FROM expert_review_raw;


-- Give every expert review its own unique ID

ALTER TABLE expert_review
ADD COLUMN expert_review_id SERIAL PRIMARY KEY;


-- Change expert review score from TEXT to INTEGER

ALTER TABLE expert_review
ADD COLUMN idvscore_int INT;

UPDATE expert_review
SET idvscore_int = CAST(idvscore AS INT)
WHERE idvscore IS NOT NULL;

ALTER TABLE expert_review
DROP COLUMN idvscore;

ALTER TABLE expert_review
RENAME COLUMN idvscore_int TO idvscore;


-- Clean the date text before converting it
-- REPLACE removes the apostrophes and TRIM removes extra spaces

UPDATE expert_review
SET datep = TRIM(REPLACE(datep, '''', ''))
WHERE datep IS NOT NULL;


-- Change datep from TEXT to DATE

ALTER TABLE expert_review
ADD COLUMN datep_date DATE;

UPDATE expert_review
SET datep_date = CAST(datep AS DATE)
WHERE datep IS NOT NULL;

ALTER TABLE expert_review
DROP COLUMN datep;

ALTER TABLE expert_review
RENAME COLUMN datep_date TO datep;


-- Change LIWC word count from TEXT to INTEGER

ALTER TABLE expert_review
ADD COLUMN liwc_wc_int INT;

UPDATE expert_review
SET liwc_wc_int = CAST(liwc_wc AS INT)
WHERE liwc_wc IS NOT NULL;

ALTER TABLE expert_review
DROP COLUMN liwc_wc;

ALTER TABLE expert_review
RENAME COLUMN liwc_wc_int TO liwc_wc;


-- Convert all remaining LIWC variables from TEXT to REAL
-- The LIWC variables contain decimal numerical values
-- The values use a comma as decimal separator, so I first change this to a point
-- I use the same conversion for all LIWC variables because they have the same format

ALTER TABLE expert_review
ADD COLUMN liwc_analytic_real REAL,
ADD COLUMN liwc_clout_real REAL,
ADD COLUMN liwc_authentic_real REAL,
ADD COLUMN liwc_tone_real REAL,
ADD COLUMN liwc_wps_real REAL,
ADD COLUMN liwc_sixltr_real REAL,
ADD COLUMN liwc_dic_real REAL,
ADD COLUMN liwc_function_real REAL,
ADD COLUMN liwc_pronoun_real REAL,
ADD COLUMN liwc_ppron_real REAL,
ADD COLUMN liwc_i_real REAL,
ADD COLUMN liwc_we_real REAL,
ADD COLUMN liwc_you_real REAL,
ADD COLUMN liwc_shehe_real REAL,
ADD COLUMN liwc_they_real REAL,
ADD COLUMN liwc_ipron_real REAL,
ADD COLUMN liwc_article_real REAL,
ADD COLUMN liwc_prep_real REAL,
ADD COLUMN liwc_auxverb_real REAL,
ADD COLUMN liwc_adverb_real REAL,
ADD COLUMN liwc_conj_real REAL,
ADD COLUMN liwc_negate_real REAL,
ADD COLUMN liwc_verb_real REAL,
ADD COLUMN liwc_adj_real REAL,
ADD COLUMN liwc_compare_real REAL,
ADD COLUMN liwc_interrog_real REAL,
ADD COLUMN liwc_number_real REAL,
ADD COLUMN liwc_quant_real REAL,
ADD COLUMN liwc_affect_real REAL,
ADD COLUMN liwc_posemo_real REAL,
ADD COLUMN liwc_negemo_real REAL,
ADD COLUMN liwc_anx_real REAL,
ADD COLUMN liwc_anger_real REAL,
ADD COLUMN liwc_sad_real REAL,
ADD COLUMN liwc_social_real REAL,
ADD COLUMN liwc_family_real REAL,
ADD COLUMN liwc_friend_real REAL,
ADD COLUMN liwc_female_real REAL,
ADD COLUMN liwc_male_real REAL,
ADD COLUMN liwc_cogproc_real REAL,
ADD COLUMN liwc_insight_real REAL,
ADD COLUMN liwc_cause_real REAL,
ADD COLUMN liwc_discrep_real REAL,
ADD COLUMN liwc_tentat_real REAL,
ADD COLUMN liwc_certain_real REAL,
ADD COLUMN liwc_differ_real REAL,
ADD COLUMN liwc_percept_real REAL,
ADD COLUMN liwc_see_real REAL,
ADD COLUMN liwc_hear_real REAL,
ADD COLUMN liwc_feel_real REAL,
ADD COLUMN liwc_bio_real REAL,
ADD COLUMN liwc_body_real REAL,
ADD COLUMN liwc_health_real REAL,
ADD COLUMN liwc_sexual_real REAL,
ADD COLUMN liwc_ingest_real REAL,
ADD COLUMN liwc_drives_real REAL,
ADD COLUMN liwc_affiliation_real REAL,
ADD COLUMN liwc_achieve_real REAL,
ADD COLUMN liwc_power_real REAL,
ADD COLUMN liwc_reward_real REAL,
ADD COLUMN liwc_risk_real REAL,
ADD COLUMN liwc_focuspast_real REAL,
ADD COLUMN liwc_focuspresent_real REAL,
ADD COLUMN liwc_focusfuture_real REAL,
ADD COLUMN liwc_relativ_real REAL,
ADD COLUMN liwc_motion_real REAL,
ADD COLUMN liwc_space_real REAL,
ADD COLUMN liwc_time_real REAL,
ADD COLUMN liwc_work_real REAL,
ADD COLUMN liwc_leisure_real REAL,
ADD COLUMN liwc_home_real REAL,
ADD COLUMN liwc_money_real REAL,
ADD COLUMN liwc_relig_real REAL,
ADD COLUMN liwc_death_real REAL,
ADD COLUMN liwc_informal_real REAL,
ADD COLUMN liwc_swear_real REAL,
ADD COLUMN liwc_netspeak_real REAL,
ADD COLUMN liwc_assent_real REAL,
ADD COLUMN liwc_nonflu_real REAL,
ADD COLUMN liwc_filler_real REAL,
ADD COLUMN liwc_allpunc_real REAL,
ADD COLUMN liwc_period_real REAL,
ADD COLUMN liwc_comma_real REAL,
ADD COLUMN liwc_colon_real REAL,
ADD COLUMN liwc_semic_real REAL,
ADD COLUMN liwc_qmark_real REAL,
ADD COLUMN liwc_exclam_real REAL,
ADD COLUMN liwc_dash_real REAL,
ADD COLUMN liwc_quote_real REAL,
ADD COLUMN liwc_apostro_real REAL,
ADD COLUMN liwc_parenth_real REAL,
ADD COLUMN liwc_otherp_real REAL;

-- Copy the LIWC values into the new REAL columns
-- REPLACE changes the decimal comma to a point
-- CAST changes the cleaned TEXT value to REAL

UPDATE expert_review
SET
    liwc_analytic_real = CAST(REPLACE(liwc_analytic, ',', '.') AS REAL),
    liwc_clout_real = CAST(REPLACE(liwc_clout, ',', '.') AS REAL),
    liwc_authentic_real = CAST(REPLACE(liwc_authentic, ',', '.') AS REAL),
    liwc_tone_real = CAST(REPLACE(liwc_tone, ',', '.') AS REAL),
    liwc_wps_real = CAST(REPLACE(liwc_wps, ',', '.') AS REAL),
    liwc_sixltr_real = CAST(REPLACE(liwc_sixltr, ',', '.') AS REAL),
    liwc_dic_real = CAST(REPLACE(liwc_dic, ',', '.') AS REAL),
    liwc_function_real = CAST(REPLACE(liwc_function, ',', '.') AS REAL),
    liwc_pronoun_real = CAST(REPLACE(liwc_pronoun, ',', '.') AS REAL),
    liwc_ppron_real = CAST(REPLACE(liwc_ppron, ',', '.') AS REAL),
    liwc_i_real = CAST(REPLACE(liwc_i, ',', '.') AS REAL),
    liwc_we_real = CAST(REPLACE(liwc_we, ',', '.') AS REAL),
    liwc_you_real = CAST(REPLACE(liwc_you, ',', '.') AS REAL),
    liwc_shehe_real = CAST(REPLACE(liwc_shehe, ',', '.') AS REAL),
    liwc_they_real = CAST(REPLACE(liwc_they, ',', '.') AS REAL),
    liwc_ipron_real = CAST(REPLACE(liwc_ipron, ',', '.') AS REAL),
    liwc_article_real = CAST(REPLACE(liwc_article, ',', '.') AS REAL),
    liwc_prep_real = CAST(REPLACE(liwc_prep, ',', '.') AS REAL),
    liwc_auxverb_real = CAST(REPLACE(liwc_auxverb, ',', '.') AS REAL),
    liwc_adverb_real = CAST(REPLACE(liwc_adverb, ',', '.') AS REAL),
    liwc_conj_real = CAST(REPLACE(liwc_conj, ',', '.') AS REAL),
    liwc_negate_real = CAST(REPLACE(liwc_negate, ',', '.') AS REAL),
    liwc_verb_real = CAST(REPLACE(liwc_verb, ',', '.') AS REAL),
    liwc_adj_real = CAST(REPLACE(liwc_adj, ',', '.') AS REAL),
    liwc_compare_real = CAST(REPLACE(liwc_compare, ',', '.') AS REAL),
    liwc_interrog_real = CAST(REPLACE(liwc_interrog, ',', '.') AS REAL),
    liwc_number_real = CAST(REPLACE(liwc_number, ',', '.') AS REAL),
    liwc_quant_real = CAST(REPLACE(liwc_quant, ',', '.') AS REAL),
    liwc_affect_real = CAST(REPLACE(liwc_affect, ',', '.') AS REAL),
    liwc_posemo_real = CAST(REPLACE(liwc_posemo, ',', '.') AS REAL),
    liwc_negemo_real = CAST(REPLACE(liwc_negemo, ',', '.') AS REAL),
    liwc_anx_real = CAST(REPLACE(liwc_anx, ',', '.') AS REAL),
    liwc_anger_real = CAST(REPLACE(liwc_anger, ',', '.') AS REAL),
    liwc_sad_real = CAST(REPLACE(liwc_sad, ',', '.') AS REAL),
    liwc_social_real = CAST(REPLACE(liwc_social, ',', '.') AS REAL),
    liwc_family_real = CAST(REPLACE(liwc_family, ',', '.') AS REAL),
    liwc_friend_real = CAST(REPLACE(liwc_friend, ',', '.') AS REAL),
    liwc_female_real = CAST(REPLACE(liwc_female, ',', '.') AS REAL),
    liwc_male_real = CAST(REPLACE(liwc_male, ',', '.') AS REAL),
    liwc_cogproc_real = CAST(REPLACE(liwc_cogproc, ',', '.') AS REAL),
    liwc_insight_real = CAST(REPLACE(liwc_insight, ',', '.') AS REAL),
    liwc_cause_real = CAST(REPLACE(liwc_cause, ',', '.') AS REAL),
    liwc_discrep_real = CAST(REPLACE(liwc_discrep, ',', '.') AS REAL),
    liwc_tentat_real = CAST(REPLACE(liwc_tentat, ',', '.') AS REAL),
    liwc_certain_real = CAST(REPLACE(liwc_certain, ',', '.') AS REAL),
    liwc_differ_real = CAST(REPLACE(liwc_differ, ',', '.') AS REAL),
    liwc_percept_real = CAST(REPLACE(liwc_percept, ',', '.') AS REAL),
    liwc_see_real = CAST(REPLACE(liwc_see, ',', '.') AS REAL),
    liwc_hear_real = CAST(REPLACE(liwc_hear, ',', '.') AS REAL),
    liwc_feel_real = CAST(REPLACE(liwc_feel, ',', '.') AS REAL),
    liwc_bio_real = CAST(REPLACE(liwc_bio, ',', '.') AS REAL),
    liwc_body_real = CAST(REPLACE(liwc_body, ',', '.') AS REAL),
    liwc_health_real = CAST(REPLACE(liwc_health, ',', '.') AS REAL),
    liwc_sexual_real = CAST(REPLACE(liwc_sexual, ',', '.') AS REAL),
    liwc_ingest_real = CAST(REPLACE(liwc_ingest, ',', '.') AS REAL),
    liwc_drives_real = CAST(REPLACE(liwc_drives, ',', '.') AS REAL),
    liwc_affiliation_real = CAST(REPLACE(liwc_affiliation, ',', '.') AS REAL),
    liwc_achieve_real = CAST(REPLACE(liwc_achieve, ',', '.') AS REAL),
    liwc_power_real = CAST(REPLACE(liwc_power, ',', '.') AS REAL),
    liwc_reward_real = CAST(REPLACE(liwc_reward, ',', '.') AS REAL),
    liwc_risk_real = CAST(REPLACE(liwc_risk, ',', '.') AS REAL),
    liwc_focuspast_real = CAST(REPLACE(liwc_focuspast, ',', '.') AS REAL),
    liwc_focuspresent_real = CAST(REPLACE(liwc_focuspresent, ',', '.') AS REAL),
    liwc_focusfuture_real = CAST(REPLACE(liwc_focusfuture, ',', '.') AS REAL),
    liwc_relativ_real = CAST(REPLACE(liwc_relativ, ',', '.') AS REAL),
    liwc_motion_real = CAST(REPLACE(liwc_motion, ',', '.') AS REAL),
    liwc_space_real = CAST(REPLACE(liwc_space, ',', '.') AS REAL),
    liwc_time_real = CAST(REPLACE(liwc_time, ',', '.') AS REAL),
    liwc_work_real = CAST(REPLACE(liwc_work, ',', '.') AS REAL),
    liwc_leisure_real = CAST(REPLACE(liwc_leisure, ',', '.') AS REAL),
    liwc_home_real = CAST(REPLACE(liwc_home, ',', '.') AS REAL),
    liwc_money_real = CAST(REPLACE(liwc_money, ',', '.') AS REAL),
    liwc_relig_real = CAST(REPLACE(liwc_relig, ',', '.') AS REAL),
    liwc_death_real = CAST(REPLACE(liwc_death, ',', '.') AS REAL),
    liwc_informal_real = CAST(REPLACE(liwc_informal, ',', '.') AS REAL),
    liwc_swear_real = CAST(REPLACE(liwc_swear, ',', '.') AS REAL),
    liwc_netspeak_real = CAST(REPLACE(liwc_netspeak, ',', '.') AS REAL),
    liwc_assent_real = CAST(REPLACE(liwc_assent, ',', '.') AS REAL),
    liwc_nonflu_real = CAST(REPLACE(liwc_nonflu, ',', '.') AS REAL),
    liwc_filler_real = CAST(REPLACE(liwc_filler, ',', '.') AS REAL),
    liwc_allpunc_real = CAST(REPLACE(liwc_allpunc, ',', '.') AS REAL),
    liwc_period_real = CAST(REPLACE(liwc_period, ',', '.') AS REAL),
    liwc_comma_real = CAST(REPLACE(liwc_comma, ',', '.') AS REAL),
    liwc_colon_real = CAST(REPLACE(liwc_colon, ',', '.') AS REAL),
    liwc_semic_real = CAST(REPLACE(liwc_semic, ',', '.') AS REAL),
    liwc_qmark_real = CAST(REPLACE(liwc_qmark, ',', '.') AS REAL),
    liwc_exclam_real = CAST(REPLACE(liwc_exclam, ',', '.') AS REAL),
    liwc_dash_real = CAST(REPLACE(liwc_dash, ',', '.') AS REAL),
    liwc_quote_real = CAST(REPLACE(liwc_quote, ',', '.') AS REAL),
    liwc_apostro_real = CAST(REPLACE(liwc_apostro, ',', '.') AS REAL),
    liwc_parenth_real = CAST(REPLACE(liwc_parenth, ',', '.') AS REAL),
    liwc_otherp_real = CAST(REPLACE(liwc_otherp, ',', '.') AS REAL);

-- Remove the old LIWC TEXT columns after the conversion
-- The numerical values are now stored in the new REAL columns

ALTER TABLE expert_review
DROP COLUMN liwc_analytic,
DROP COLUMN liwc_clout,
DROP COLUMN liwc_authentic,
DROP COLUMN liwc_tone,
DROP COLUMN liwc_wps,
DROP COLUMN liwc_sixltr,
DROP COLUMN liwc_dic,
DROP COLUMN liwc_function,
DROP COLUMN liwc_pronoun,
DROP COLUMN liwc_ppron,
DROP COLUMN liwc_i,
DROP COLUMN liwc_we,
DROP COLUMN liwc_you,
DROP COLUMN liwc_shehe,
DROP COLUMN liwc_they,
DROP COLUMN liwc_ipron,
DROP COLUMN liwc_article,
DROP COLUMN liwc_prep,
DROP COLUMN liwc_auxverb,
DROP COLUMN liwc_adverb,
DROP COLUMN liwc_conj,
DROP COLUMN liwc_negate,
DROP COLUMN liwc_verb,
DROP COLUMN liwc_adj,
DROP COLUMN liwc_compare,
DROP COLUMN liwc_interrog,
DROP COLUMN liwc_number,
DROP COLUMN liwc_quant,
DROP COLUMN liwc_affect,
DROP COLUMN liwc_posemo,
DROP COLUMN liwc_negemo,
DROP COLUMN liwc_anx,
DROP COLUMN liwc_anger,
DROP COLUMN liwc_sad,
DROP COLUMN liwc_social,
DROP COLUMN liwc_family,
DROP COLUMN liwc_friend,
DROP COLUMN liwc_female,
DROP COLUMN liwc_male,
DROP COLUMN liwc_cogproc,
DROP COLUMN liwc_insight,
DROP COLUMN liwc_cause,
DROP COLUMN liwc_discrep,
DROP COLUMN liwc_tentat,
DROP COLUMN liwc_certain,
DROP COLUMN liwc_differ,
DROP COLUMN liwc_percept,
DROP COLUMN liwc_see,
DROP COLUMN liwc_hear,
DROP COLUMN liwc_feel,
DROP COLUMN liwc_bio,
DROP COLUMN liwc_body,
DROP COLUMN liwc_health,
DROP COLUMN liwc_sexual,
DROP COLUMN liwc_ingest,
DROP COLUMN liwc_drives,
DROP COLUMN liwc_affiliation,
DROP COLUMN liwc_achieve,
DROP COLUMN liwc_power,
DROP COLUMN liwc_reward,
DROP COLUMN liwc_risk,
DROP COLUMN liwc_focuspast,
DROP COLUMN liwc_focuspresent,
DROP COLUMN liwc_focusfuture,
DROP COLUMN liwc_relativ,
DROP COLUMN liwc_motion,
DROP COLUMN liwc_space,
DROP COLUMN liwc_time,
DROP COLUMN liwc_work,
DROP COLUMN liwc_leisure,
DROP COLUMN liwc_home,
DROP COLUMN liwc_money,
DROP COLUMN liwc_relig,
DROP COLUMN liwc_death,
DROP COLUMN liwc_informal,
DROP COLUMN liwc_swear,
DROP COLUMN liwc_netspeak,
DROP COLUMN liwc_assent,
DROP COLUMN liwc_nonflu,
DROP COLUMN liwc_filler,
DROP COLUMN liwc_allpunc,
DROP COLUMN liwc_period,
DROP COLUMN liwc_comma,
DROP COLUMN liwc_colon,
DROP COLUMN liwc_semic,
DROP COLUMN liwc_qmark,
DROP COLUMN liwc_exclam,
DROP COLUMN liwc_dash,
DROP COLUMN liwc_quote,
DROP COLUMN liwc_apostro,
DROP COLUMN liwc_parenth,
DROP COLUMN liwc_otherp;

-- Rename the new REAL columns back to the original LIWC names
-- This keeps the final table names the same as the original dataset

ALTER TABLE expert_review RENAME COLUMN liwc_analytic_real TO liwc_analytic;
ALTER TABLE expert_review RENAME COLUMN liwc_clout_real TO liwc_clout;
ALTER TABLE expert_review RENAME COLUMN liwc_authentic_real TO liwc_authentic;
ALTER TABLE expert_review RENAME COLUMN liwc_tone_real TO liwc_tone;
ALTER TABLE expert_review RENAME COLUMN liwc_wps_real TO liwc_wps;
ALTER TABLE expert_review RENAME COLUMN liwc_sixltr_real TO liwc_sixltr;
ALTER TABLE expert_review RENAME COLUMN liwc_dic_real TO liwc_dic;
ALTER TABLE expert_review RENAME COLUMN liwc_function_real TO liwc_function;
ALTER TABLE expert_review RENAME COLUMN liwc_pronoun_real TO liwc_pronoun;
ALTER TABLE expert_review RENAME COLUMN liwc_ppron_real TO liwc_ppron;
ALTER TABLE expert_review RENAME COLUMN liwc_i_real TO liwc_i;
ALTER TABLE expert_review RENAME COLUMN liwc_we_real TO liwc_we;
ALTER TABLE expert_review RENAME COLUMN liwc_you_real TO liwc_you;
ALTER TABLE expert_review RENAME COLUMN liwc_shehe_real TO liwc_shehe;
ALTER TABLE expert_review RENAME COLUMN liwc_they_real TO liwc_they;
ALTER TABLE expert_review RENAME COLUMN liwc_ipron_real TO liwc_ipron;
ALTER TABLE expert_review RENAME COLUMN liwc_article_real TO liwc_article;
ALTER TABLE expert_review RENAME COLUMN liwc_prep_real TO liwc_prep;
ALTER TABLE expert_review RENAME COLUMN liwc_auxverb_real TO liwc_auxverb;
ALTER TABLE expert_review RENAME COLUMN liwc_adverb_real TO liwc_adverb;
ALTER TABLE expert_review RENAME COLUMN liwc_conj_real TO liwc_conj;
ALTER TABLE expert_review RENAME COLUMN liwc_negate_real TO liwc_negate;
ALTER TABLE expert_review RENAME COLUMN liwc_verb_real TO liwc_verb;
ALTER TABLE expert_review RENAME COLUMN liwc_adj_real TO liwc_adj;
ALTER TABLE expert_review RENAME COLUMN liwc_compare_real TO liwc_compare;
ALTER TABLE expert_review RENAME COLUMN liwc_interrog_real TO liwc_interrog;
ALTER TABLE expert_review RENAME COLUMN liwc_number_real TO liwc_number;
ALTER TABLE expert_review RENAME COLUMN liwc_quant_real TO liwc_quant;
ALTER TABLE expert_review RENAME COLUMN liwc_affect_real TO liwc_affect;
ALTER TABLE expert_review RENAME COLUMN liwc_posemo_real TO liwc_posemo;
ALTER TABLE expert_review RENAME COLUMN liwc_negemo_real TO liwc_negemo;
ALTER TABLE expert_review RENAME COLUMN liwc_anx_real TO liwc_anx;
ALTER TABLE expert_review RENAME COLUMN liwc_anger_real TO liwc_anger;
ALTER TABLE expert_review RENAME COLUMN liwc_sad_real TO liwc_sad;
ALTER TABLE expert_review RENAME COLUMN liwc_social_real TO liwc_social;
ALTER TABLE expert_review RENAME COLUMN liwc_family_real TO liwc_family;
ALTER TABLE expert_review RENAME COLUMN liwc_friend_real TO liwc_friend;
ALTER TABLE expert_review RENAME COLUMN liwc_female_real TO liwc_female;
ALTER TABLE expert_review RENAME COLUMN liwc_male_real TO liwc_male;
ALTER TABLE expert_review RENAME COLUMN liwc_cogproc_real TO liwc_cogproc;
ALTER TABLE expert_review RENAME COLUMN liwc_insight_real TO liwc_insight;
ALTER TABLE expert_review RENAME COLUMN liwc_cause_real TO liwc_cause;
ALTER TABLE expert_review RENAME COLUMN liwc_discrep_real TO liwc_discrep;
ALTER TABLE expert_review RENAME COLUMN liwc_tentat_real TO liwc_tentat;
ALTER TABLE expert_review RENAME COLUMN liwc_certain_real TO liwc_certain;
ALTER TABLE expert_review RENAME COLUMN liwc_differ_real TO liwc_differ;
ALTER TABLE expert_review RENAME COLUMN liwc_percept_real TO liwc_percept;
ALTER TABLE expert_review RENAME COLUMN liwc_see_real TO liwc_see;
ALTER TABLE expert_review RENAME COLUMN liwc_hear_real TO liwc_hear;
ALTER TABLE expert_review RENAME COLUMN liwc_feel_real TO liwc_feel;
ALTER TABLE expert_review RENAME COLUMN liwc_bio_real TO liwc_bio;
ALTER TABLE expert_review RENAME COLUMN liwc_body_real TO liwc_body;
ALTER TABLE expert_review RENAME COLUMN liwc_health_real TO liwc_health;
ALTER TABLE expert_review RENAME COLUMN liwc_sexual_real TO liwc_sexual;
ALTER TABLE expert_review RENAME COLUMN liwc_ingest_real TO liwc_ingest;
ALTER TABLE expert_review RENAME COLUMN liwc_drives_real TO liwc_drives;
ALTER TABLE expert_review RENAME COLUMN liwc_affiliation_real TO liwc_affiliation;
ALTER TABLE expert_review RENAME COLUMN liwc_achieve_real TO liwc_achieve;
ALTER TABLE expert_review RENAME COLUMN liwc_power_real TO liwc_power;
ALTER TABLE expert_review RENAME COLUMN liwc_reward_real TO liwc_reward;
ALTER TABLE expert_review RENAME COLUMN liwc_risk_real TO liwc_risk;
ALTER TABLE expert_review RENAME COLUMN liwc_focuspast_real TO liwc_focuspast;
ALTER TABLE expert_review RENAME COLUMN liwc_focuspresent_real TO liwc_focuspresent;
ALTER TABLE expert_review RENAME COLUMN liwc_focusfuture_real TO liwc_focusfuture;
ALTER TABLE expert_review RENAME COLUMN liwc_relativ_real TO liwc_relativ;
ALTER TABLE expert_review RENAME COLUMN liwc_motion_real TO liwc_motion;
ALTER TABLE expert_review RENAME COLUMN liwc_space_real TO liwc_space;
ALTER TABLE expert_review RENAME COLUMN liwc_time_real TO liwc_time;
ALTER TABLE expert_review RENAME COLUMN liwc_work_real TO liwc_work;
ALTER TABLE expert_review RENAME COLUMN liwc_leisure_real TO liwc_leisure;
ALTER TABLE expert_review RENAME COLUMN liwc_home_real TO liwc_home;
ALTER TABLE expert_review RENAME COLUMN liwc_money_real TO liwc_money;
ALTER TABLE expert_review RENAME COLUMN liwc_relig_real TO liwc_relig;
ALTER TABLE expert_review RENAME COLUMN liwc_death_real TO liwc_death;
ALTER TABLE expert_review RENAME COLUMN liwc_informal_real TO liwc_informal;
ALTER TABLE expert_review RENAME COLUMN liwc_swear_real TO liwc_swear;
ALTER TABLE expert_review RENAME COLUMN liwc_netspeak_real TO liwc_netspeak;
ALTER TABLE expert_review RENAME COLUMN liwc_assent_real TO liwc_assent;
ALTER TABLE expert_review RENAME COLUMN liwc_nonflu_real TO liwc_nonflu;
ALTER TABLE expert_review RENAME COLUMN liwc_filler_real TO liwc_filler;
ALTER TABLE expert_review RENAME COLUMN liwc_allpunc_real TO liwc_allpunc;
ALTER TABLE expert_review RENAME COLUMN liwc_period_real TO liwc_period;
ALTER TABLE expert_review RENAME COLUMN liwc_comma_real TO liwc_comma;
ALTER TABLE expert_review RENAME COLUMN liwc_colon_real TO liwc_colon;
ALTER TABLE expert_review RENAME COLUMN liwc_semic_real TO liwc_semic;
ALTER TABLE expert_review RENAME COLUMN liwc_qmark_real TO liwc_qmark;
ALTER TABLE expert_review RENAME COLUMN liwc_exclam_real TO liwc_exclam;
ALTER TABLE expert_review RENAME COLUMN liwc_dash_real TO liwc_dash;
ALTER TABLE expert_review RENAME COLUMN liwc_quote_real TO liwc_quote;
ALTER TABLE expert_review RENAME COLUMN liwc_apostro_real TO liwc_apostro;
ALTER TABLE expert_review RENAME COLUMN liwc_parenth_real TO liwc_parenth;
ALTER TABLE expert_review RENAME COLUMN liwc_otherp_real TO liwc_otherp;


-- Connect expert_review to movie using the movie URL
-- The URL in expert_review must already exist in movie

ALTER TABLE expert_review
ADD CONSTRAINT fk_expert_review_movie
FOREIGN KEY (url)
REFERENCES movie(url);


-- Optional final check of the data types

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'expert_review'
ORDER BY ordinal_position;
