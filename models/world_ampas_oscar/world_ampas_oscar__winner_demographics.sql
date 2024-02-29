{{ 
  config(
    alias='winner_demographics',    
    schema='world_ampas_oscar',
    materialized='table',
)
}}
-- 
SELECT DISTINCT
safe_cast(name AS STRING) name,
safe_cast(birth_date AS DATE) birth_date,
safe_cast(birthplace AS STRING) birthplace,
safe_cast(race_ethnicity AS STRING) race_ethnicity,
safe_cast(religion AS STRING) religion,
safe_cast(sexual_orientation AS STRING) sexual_orientation,
safe_cast(year_edition AS INT64) year_edition,
safe_cast(category AS STRING) category,
safe_cast(movie AS STRING) movie,
FROM basedosdados-dev.world_ampas_oscar_staging.winner_demographics AS t