{{ 
  config(
    schema='br_ms_cnes',
    materialized='table',
     partition_by={
      "field": "ano",
      "data_type": "int64",
      "range": {
        "start": 2005,
        "end": 2023,
        "interval": 1}
     }  
    )
 }}


WITH raw_cnes_equipamento AS (
  -- 1. Retirar linhas com id_estabelecimento_cnes nulo
  SELECT *
  FROM `basedosdados-dev.br_ms_cnes_staging.equipamento`
  WHERE CNES IS NOT NULL),
cnes_add_muni AS (
  -- 3. Adicionar id_municipio 
  SELECT *
  FROM raw_cnes_equipamento  
  LEFT JOIN (SELECT id_municipio, id_municipio_6,
  FROM `basedosdados-dev.br_bd_diretorios_brasil.municipio`) as mun
  ON raw_cnes_equipamento.CODUFMUN = mun.id_municipio_6
)
SELECT 
SAFE_CAST(ano AS INT64),
SAFE_CAST(mes AS INT64),
SAFE_CAST(sigla_uf AS STRING),
SAFE_CAST(id_municipio AS STRING),
SAFE_CAST(CNES AS STRING) AS id_estabelecimento_cnes,
SAFE_CAST(CODEQUIP AS STRING) AS id_equipamento,
SAFE_CAST(TIPEQUIP AS STRING) AS tipo_equipamento,
SAFE_CAST(QT_EXIST AS STRING) AS quantidade_equipamentos,
SAFE_CAST(QT_USO AS STRING) AS quantidade_equipamentos_ativos,
SAFE_CAST(IND_SUS AS INT64) AS indicador_equipamento_disponivel_sus,
SAFE_CAST(IND_NSUS AS INT64) AS indicador_equipamento_indisponivel_sus
FROM cnes_add_muni 


