{{ 
  config(
    alias='saude',
    schema='br_geobr_mapas',
    materialized='table',
    )
 }}
SELECT 
SAFE_CAST(id_regiao_saude AS STRING) id_regiao_saude,
SAFE_CAST(id_uf AS STRING) id_uf,
SAFE_CAST(sigla_uf AS STRING) sigla_uf,
SAFE.ST_GEOGFROMTEXT(geometria) geometria
FROM basedosdados-dev.br_geobr_mapas_staging.saude AS t