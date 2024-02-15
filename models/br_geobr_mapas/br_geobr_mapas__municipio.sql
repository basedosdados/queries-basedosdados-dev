{{ 
  config(
    alias='municipio',
    schema='br_geobr_mapas',
    materialized='table',
    )
 }}

SELECT 
SAFE_CAST(id_municipio AS STRING ) id_municipio,
SAFE_CAST(sigla_uf AS STRING) sigla_uf,
SAFE.ST_GEOGFROMTEXT(geometria) geometria
FROM basedosdados-dev.br_geobr_mapas_staging.municipio AS t