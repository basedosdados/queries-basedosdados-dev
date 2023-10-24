{{ config(
    alias='energia_armazenada_reservatorio', 
    schema='br_ons_avaliacao_operacao',
    partition_by={
      "field": "ano",
      "data_type": "int64",
      "range": {
        "start": 2000,
        "end": 2024,
        "interval": 1}
     }) 
}}

SELECT
SAFE_CAST(data AS DATE) data,
SAFE_CAST(ano AS INT64) ano,
SAFE_CAST(mes AS INT64) mes,
SAFE_CAST(reservatorio AS STRING) reservatorio,
SAFE_CAST(tipo_reservatorio AS STRING) tipo_reservatorio,
SAFE_CAST(id_reservatorio_planejamento AS STRING) id_reservatorio_planejamento,
SAFE_CAST(reservatorio_equivalente_energia AS STRING) reservatorio_equivalente_energia,
SAFE_CAST(id_subsistema AS STRING) id_subsistema,
SAFE_CAST(subsistema AS STRING) subsistema,
SAFE_CAST(id_subsistema_jusante AS STRING) id_subsistema_jusante,
SAFE_CAST(subsistema_jusante AS STRING) subsistema_jusante,
SAFE_CAST(bacia AS STRING) bacia,
SAFE_CAST(energia_armazenada_subsistema AS FLOAT64) energia_armazenada_subsistema,
SAFE_CAST(energia_armazenada_jusante_subsistema AS FLOAT64) energia_armazenada_jusante_subsistema,
SAFE_CAST(energia_maxima_armazenada_subsistema AS FLOAT64) energia_maxima_armazenada_subsistema,
SAFE_CAST(energia_maxima_armazenada_jusante_subsistema AS FLOAT64) energia_maxima_armazenada_jusante_subsistema,
SAFE_CAST(energia_armazenada_total AS FLOAT64) energia_armazenada_total,
SAFE_CAST(energia_maxima_armazenada_total AS FLOAT64) energia_maxima_armazenada_total,
SAFE_CAST(proporcao_energia_armazenada AS FLOAT64) proporcao_energia_armazenada,
SAFE_CAST(proporcao_contribuicao_energia_armazenada_bacia AS FLOAT64) proporcao_contribuicao_energia_armazenada_bacia,
SAFE_CAST(proporcao_contribuicao_energia_maxima_armazenada_bacia AS FLOAT64) proporcao_contribuicao_energia_maxima_armazenada_bacia,
SAFE_CAST(proporcao_contribuicao_energia_armazenada_subsistema AS FLOAT64) proporcao_contribuicao_energia_armazenada_subsistema,
SAFE_CAST(proporcao_contribuicao_energia_maxima_armazenada_subsistema AS FLOAT64) proporcao_contribuicao_energia_maxima_armazenada_subsistema,
SAFE_CAST(proporcao_contribuicao_energia_armazenada_subsistema_jusante AS FLOAT64) proporcao_contribuicao_energia_armazenada_subsistema_jusante,
SAFE_CAST(proporcao_contribuicao_energia_maxima_armazenada_subsistema_jusante AS FLOAT64) proporcao_contribuicao_energia_maxima_armazenada_subsistema_jusante,
SAFE_CAST(proporcao_contribuicao_energia_armazenada_sin AS FLOAT64) proporcao_contribuicao_energia_armazenada_sin,
SAFE_CAST(proporcao_contribuicao_energia_armazenada_maxima_sin AS FLOAT64) proporcao_contribuicao_energia_armazenada_maxima_sin
FROM basedosdados-dev.br_ons_avaliacao_operacao_staging.energia_armazenada_reservatorio AS t