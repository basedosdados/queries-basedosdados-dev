{{
  config(
    alias='bpc',    
    schema='br_cgu_beneficios_cidadao',
    materialized='incremental',
     partition_by={
      "field": "ano",
      "data_type": "int64",
      "range": {
        "start": 2023,
        "end": 2024,
        "interval": 1}
    },
    cluster_by = ["mes", "sigla_uf"] )
}}
with bpc as (
SELECT 
SAFE_CAST(SUBSTR(mes_competencia, 1, 4) AS INT64) ano,
SAFE_CAST(SUBSTR(mes_competencia, 5, 2) AS INT64) mes,
SAFE_CAST(mes_referencia AS STRING) data_referencia,
SAFE_CAST(PARSE_DATE('%Y%m',mes_referencia) AS DATE) data,
t2.id_municipio,
t2.nome as nome_municipio,
SAFE_CAST(t1.sigla_uf AS STRING) sigla_uf,
SAFE_CAST(nis AS STRING) nis_favorecido,
SAFE_CAST(cpf AS STRING) cpf_favorecido,
SAFE_CAST(t1.nome AS STRING) nome_favorecido,
SAFE_CAST(nis_representante AS STRING) nis_representante,
SAFE_CAST(cpf_representante AS STRING) cpf_representante,
SAFE_CAST(t1.nome_representante AS STRING) nome_representante,
SAFE_CAST(numero AS STRING) numero_beneficio,
SAFE_CAST(concedido_judicialmente AS STRING) concedido_judicialmente,
SAFE_CAST(valor AS FLOAT64) valor_parcela,
FROM `basedosdados-dev.br_cgu_beneficios_cidadao_staging.bpc` t1
left join `basedosdados.br_bd_diretorios_brasil.municipio` t2
on SAFE_CAST(t1.id_municipio_siafi AS INT64) = SAFE_CAST(t2.id_municipio_rf AS INT64))
select * except(data) from bpc
{% if is_incremental() %} 
WHERE data > (SELECT MAX(data) FROM {{ this }} )
{% endif %}