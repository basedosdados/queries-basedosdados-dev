{{ config(
    alias='microdados',
    schema='br_anp_precos_combustiveis',
    materialized='table',
    partition_by={
      "field": "data_coleta",
      "data_type": "date",
      "granularity": "day"
    },
    cluster_by = ["ano", "sigla_uf", "id_municipio"],
    labels = {'project_id': 'basedosdados-dev'})
}}
SELECT
SAFE_CAST(ano AS INT64) ano,
SAFE_CAST(sigla_uf AS STRING) sigla_uf,
SAFE_CAST(id_municipio AS STRING) id_municipio,
SAFE_CAST(bairro_revenda AS STRING) bairro_revenda,
SAFE_CAST(cep_revenda AS STRING) cep_revenda,
SAFE_CAST(endereco_revenda AS STRING) endereco_revenda,
SAFE_CAST(cnpj_revenda AS STRING) cnpj_revenda,
SAFE_CAST(nome_estabelecimento AS STRING) nome_estabelecimento,
SAFE_CAST(bandeira_revenda AS STRING) bandeira_revenda,
SAFE_CAST(data_coleta AS DATE) data_coleta,
SAFE_CAST(produto AS STRING) produto,
SAFE_CAST(unidade_medida AS STRING) unidade_medida,
SAFE_CAST(preco_compra AS FLOAT64) preco_compra,
SAFE_CAST(preco_venda AS FLOAT64) preco_venda
FROM basedosdados-dev.br_anp_precos_combustiveis_staging.microdados AS t
WHERE DATE_DIFF(CURRENT_DATE(),DATE(CAST(ano AS INT64),CAST(mes AS INT64),1), MONTH) > 6