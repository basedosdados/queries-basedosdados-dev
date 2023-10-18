{{ 
  config(
    alias='arranjo_populacional',
    schema='br_geobr_mapas',
    materialized='table',
    )
 }}
SELECT 
SAFE_CAST(REPLACE(id_arranjo_populacional,".0","") AS STRING) id_arranjo_populacional,
SAFE_CAST(arranjo_populacional AS STRING) arranjo_populacional,
SAFE_CAST(populacao_urbana_2010 AS INT64) populacao_urbana_2010,
SAFE_CAST(populacao_rural_2010 AS INT64) populacao_rural_2010,
SAFE_CAST(REPLACE(populacao_2010,".0","") AS INT64) populacao_2010,
SAFE_CAST(REPLACE(id_municipio,".0","") AS STRING) id_municipio,
SAFE_CAST(sigla_uf AS STRING) sigla_uf,
SAFE.ST_GEOGFROMTEXT(geometria) geometria,
FROM basedosdados-dev.br_geobr_mapas_staging.arranjo_populacional as t