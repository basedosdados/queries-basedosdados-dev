{{ 
  config(
    alias='mesorregiao',
    schema='br_geobr_mapas',
    materialized='table',
    )
 }}
SELECT 
SAFE_CAST(id_uf AS STRING) id_uf,
SAFE_CAST(sigla_uf AS STRING) sigla_uf,
SAFE_CAST(id_mesorregiao AS STRING) id_mesorregiao,
SAFE.ST_GEOGFROMTEXT(geometria) geometria
FROM basedosdados-dev.br_geobr_mapas_staging.mesorregiao AS t