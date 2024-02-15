{{ config(
    alias='reservatorio', 
    schema='br_ons_avaliacao_operacao') 
}}

SELECT
SAFE_CAST(data AS DATE) data,
SAFE_CAST(id_subsistema AS STRING) id_subsistema,
SAFE_CAST(subsistema AS STRING) subsistema,
SAFE_CAST(id_empreendimento_aneel AS STRING) id_empreendimento_aneel,
SAFE_CAST(REPLACE(id_reservatorio_planejamento, 'nan', '') AS STRING) id_reservatorio_planejamento,
SAFE_CAST(REPLACE(id_posto_vazao, 'nan', '') AS STRING) id_posto_vazao,
SAFE_CAST(reservatorio_equivalente AS STRING) reservatorio_equivalente,
SAFE_CAST(reservatorio AS STRING) reservatorio,
SAFE_CAST(tipo_reservatorio AS STRING) tipo_reservatorio,
SAFE_CAST(usina AS STRING) usina,
SAFE_CAST(bacia AS STRING) bacia,
SAFE_CAST(rio AS STRING) rio,
SAFE_CAST(cota_maxima AS FLOAT64) cota_maxima,
SAFE_CAST(cota_minima AS FLOAT64) cota_minima,
SAFE_CAST(volume_maximo AS FLOAT64) volume_maximo,
SAFE_CAST(volume_minimo AS FLOAT64) volume_minimo,
SAFE_CAST(volume_util AS FLOAT64) volume_util,
SAFE_CAST(produtividade_especifica AS FLOAT64) produtividade_especifica,
SAFE_CAST(produtividade_65_volume_util AS FLOAT64) produtividade_65_volume_util,
SAFE_CAST(tipo_perda AS STRING) tipo_perda,
SAFE_CAST(perda_carga AS FLOAT64) perda_carga,
SAFE_CAST(latitude AS FLOAT64) latitude,
SAFE_CAST(longitude AS FLOAT64) longitude
FROM basedosdados-dev.br_ons_avaliacao_operacao_staging.reservatorio AS t