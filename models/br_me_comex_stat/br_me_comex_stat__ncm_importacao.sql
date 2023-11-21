{{ config(
    alias='ncm_importacao',
    schema='br_me_comex_stat',
    materialized='incremental',
    partition_by={
        "field": "ano",
        "data_type": "int64",
            "range": {
            "start": 1997,
            "end": 2023,
            "interval": 1}
    },
    cluster_by = ["mes","sigla_uf_ncm"],
    pre_hook = "DROP ALL ROW ACCESS POLICIES ON {{ this }}",
    post_hook = [
        'CREATE OR REPLACE ROW ACCESS POLICY allusers_filter 
                    ON {{this}}
                    GRANT TO ("allUsers")
                    FILTER USING (DATE_DIFF(CURRENT_DATE(),DATE(CAST(ano AS INT64),CAST(mes AS INT64),1), MONTH) > 6 OR DATE_DIFF(DATE(2023,5,1),DATE(CAST(ano AS INT64),CAST(mes AS INT64),1), MONTH) > 0)',
        'CREATE OR REPLACE ROW ACCESS POLICY bdpro_filter 
                    ON  {{this}}
                    GRANT TO ("group:bd-pro@basedosdados.org", "group:sudo@basedosdados.org")
                    FILTER USING (DATE_DIFF(CURRENT_DATE(),DATE(CAST(ano AS INT64),CAST(mes AS INT64),1), MONTH) < 6 OR DATE_DIFF(DATE(2023,5,1),DATE(CAST(ano AS INT64),CAST(mes AS INT64),1), MONTH) < 0)']    
        )
 }}
SELECT 
SAFE_CAST(ano AS INT64) ano,
SAFE_CAST(mes AS INT64) mes,
SAFE_CAST(id_ncm AS STRING) id_ncm,
SAFE_CAST(id_unidade AS STRING) id_unidade,
SAFE_CAST(id_pais AS STRING) id_pais,
SAFE_CAST(sigla_uf_ncm AS STRING) sigla_uf_ncm,
SAFE_CAST(id_via AS STRING) id_via,
SAFE_CAST(id_urf AS STRING) id_urf,
SAFE_CAST(quantidade_estatistica AS FLOAT64) quantidade_estatistica,
SAFE_CAST(peso_liquido_kg AS FLOAT64) peso_liquido_kg,
SAFE_CAST(valor_fob_dolar AS FLOAT64) valor_fob_dolar,
SAFE_CAST(valor_frete AS FLOAT64) valor_frete,
SAFE_CAST(valor_seguro AS FLOAT64) valor_seguro
FROM basedosdados-dev.br_me_comex_stat_staging.ncm_importacao AS t
{% if is_incremental() %} 
WHERE DATE(CAST(ano AS INT64),CAST(mes AS INT64),1) > (SELECT MAX(DATE(CAST(ano AS INT64),CAST(mes AS INT64),1)) FROM {{ this }} )
{% endif %}
