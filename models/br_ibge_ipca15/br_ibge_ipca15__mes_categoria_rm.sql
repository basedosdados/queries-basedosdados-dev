{{ 
  config(
      alias='mes_categoria_rm', 
      schema='br_ibge_ipca15',
      materialized='incremental',
  partition_by = {
    "field": "ano",
    "data_type": "int64",
    "range": {
      "start": 2020,
      "end": 2024,
      "interval": 1}
    },
  pre_hook = "DROP ALL ROW ACCESS POLICIES ON {{ this }}",
  post_hook=['CREATE OR REPLACE ROW ACCESS POLICY allusers_filter 
                  ON {{this}}
                  GRANT TO ("allUsers")
              FILTER USING (DATE_DIFF(DATE("{{ run_started_at.strftime("%Y-%m-%d") }}"),DATE(CAST(ano AS INT64),CAST(mes AS INT64),1), MONTH) > 6)',
            'CREATE OR REPLACE ROW ACCESS POLICY bdpro_filter 
                  ON  {{this}}
                  GRANT TO ("group:bd-pro@basedosdados.org", "group:sudo@basedosdados.org")
                  FILTER USING (DATE_DIFF(DATE("{{ run_started_at.strftime("%Y-%m-%d") }}"),DATE(CAST(ano AS INT64),CAST(mes AS INT64),1), MONTH) <= 6)']
  )
}}
SELECT 
SAFE_CAST(ano AS INT64) ano,
SAFE_CAST(mes AS INT64) mes,
SAFE_CAST(id_regiao_metropolitana AS STRING) id_regiao_metropolitana,
SAFE_CAST(id_categoria AS STRING) id_categoria,
SAFE_CAST(id_categoria_bd AS STRING) id_categoria_bd,
SAFE_CAST(categoria AS STRING) categoria,
SAFE_CAST(peso_mensal AS FLOAT64) peso_mensal,
SAFE_CAST(variacao_mensal AS FLOAT64) variacao_mensal,
SAFE_CAST(variacao_anual AS FLOAT64) variacao_anual,
SAFE_CAST(variacao_doze_meses AS FLOAT64) variacao_doze_meses
FROM basedosdados-dev.br_ibge_ipca15_staging.mes_categoria_rm AS t
{% if is_incremental() %}
WHERE DATE(CAST(ano AS INT64),CAST(mes AS INT64),1) > (SELECT MAX(DATE(CAST(ano AS INT64),CAST(mes AS INT64),1)) FROM {{ this }} )
{% endif %}