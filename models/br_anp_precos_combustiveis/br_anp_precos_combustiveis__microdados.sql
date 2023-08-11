{{ config(
    alias='microdados',
    schema='br_anp_precos_combustiveis',
    materialized='table',
    partition_by={
      "field": "ano",
      "data_type": "int64",
      "range": {
        "start": 2004,
        "end": 2023,
        "interval": 1}
    },
    cluster_by = ["id_municipio", "sigla_uf"],
    labels = {'project_id': 'basedosdados-dev'})
}}

SELECT
SAFE_CAST(ano AS INT64) ano,
SAFE_CAST(sigla_uf AS STRING) sigla_uf,
SAFE_CAST(id_municipio AS STRING) id_municipio,
INITCAP(bairro_revenda) AS bairro_revenda,
SAFE_CAST(cep_revenda AS STRING) cep_revenda,
INITCAP(endereco_revenda) AS endereco_revenda,
REPLACE(REPLACE(REPLACE(cnpj_revenda, "/", ""), "-", ""), ".", "") AS cnpj_revenda,
INITCAP(nome_estabelecimento) AS  nome_estabelecimento,
INITCAP(bandeira_revenda) AS bandeira_revenda,
SAFE_CAST(data_coleta AS DATE) data_coleta,
INITCAP(produto) AS produto,
SAFE_CAST(unidade_medida AS STRING) unidade_medida,
SAFE_CAST(preco_compra AS FLOAT64) preco_compra,
SAFE_CAST(preco_venda AS FLOAT64) preco_venda
FROM basedosdados-dev.br_anp_precos_combustiveis_staging.microdados AS t
WHERE DATE(data_coleta) <= DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH)