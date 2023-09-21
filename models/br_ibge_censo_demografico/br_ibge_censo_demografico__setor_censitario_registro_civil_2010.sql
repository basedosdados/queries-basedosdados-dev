{{ 
  config(
    alias='setor_censitario_registro_civil_2010',
    schema='br_ibge_censo_demografico',
    materialized='table',
    )
 }}
SELECT 
    SAFE_CAST(id_setor_censitario AS STRING) id_setor_censitario,
    SAFE_CAST(sigla_uf AS STRING) sigla_uf,
    SAFE_CAST(v001 AS INT64) v001,
    SAFE_CAST(v002 AS INT64) v002,
    SAFE_CAST(v003 AS INT64) v003
from basedosdados-dev.br_ibge_censo_demografico_staging.setor_censitario_registro_civil_2010 as t