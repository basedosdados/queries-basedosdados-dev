{{ config(alias='densidade_municipio', schema='br_anatel_banda_larga_fixa') }}

SELECT 
SAFE_CAST(ano AS INT64) ano,
SAFE_CAST(mes AS INT64) mes,
SAFE_CAST(sigla_uf AS STRING) sigla_uf,
SAFE_CAST(id_municipio AS STRING) id_municipio,
SAFE_CAST(densidade AS FLOAT64) densidade
FROM basedosdados-dev.br_anatel_banda_larga_fixa_staging.densidade_municipio AS t

WHERE DATE_DIFF(CURRENT_DATE(),DATE(SAFE_CAST(ano AS INT64),SAFE_CAST(mes AS INT64),01),month) >= 6