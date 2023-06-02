SELECT
SAFE_CAST(data AS DATE) data,
SAFE_CAST(ano AS INT64) ano,
SAFE_CAST(mes AS INT64) mes,
SAFE_CAST(reservatorio AS STRING) reservatorio,
SAFE_CAST(id_reservatorio AS STRING) id_reservatorio,
SAFE_CAST(tipo_reservatorio AS STRING) tipo_reservatorio,
SAFE_CAST(id_subsistema AS STRING) id_subsistema,
SAFE_CAST(subsistema AS STRING) subsistema,
SAFE_CAST(bacia AS STRING) bacia,
SAFE_CAST(reservatorio_equivalente_energia AS STRING) reservatorio_equivalente_energia,
SAFE_CAST(energia_natural_afluente_bruta AS FLOAT64) energia_natural_afluente_bruta,
SAFE_CAST(energia_natural_afluente_armazenavel AS FLOAT64) energia_natural_afluente_armazenavel,
SAFE_CAST(energia_natural_afluente_longo_termo AS FLOAT64) energia_natural_afluente_longo_termo,
SAFE_CAST(energia_natural_afluente_queda AS FLOAT64) energia_natural_afluente_queda,
SAFE_CAST(proporcao_energia_natural_afluente_bruta AS FLOAT64) proporcao_energia_natural_afluente_bruta,
SAFE_CAST(proporcao_energia_natural_afluente_armazenavel AS FLOAT64) proporcao_energia_natural_afluente_armazenavel
FROM basedosdados-dev.br_ons_avalicao_operacao_staging.energia_natural_afluente AS t