SELECT 
SAFE_CAST(ano AS INT64) ano,
SAFE_CAST(id_face_quadra AS STRING) id_face_quadra,
SAFE_CAST(logradouro AS STRING) logradouro,
SAFE_CAST(metrica AS STRING) metrica,
SAFE_CAST(pavimentacao AS STRING) pavimentacao,
SAFE_CAST(indicador_agua AS BOOL) indicador_agua,
SAFE_CAST(indicador_esgoto AS BOOL) indicador_esgoto,
SAFE_CAST(indicador_galeria_pluvial AS BOOL) indicador_galeria_pluvial,
SAFE_CAST(indicador_sarjeta AS BOOL) indicador_sarjeta,
SAFE_CAST(indicador_iluminacao_publica AS BOOL) indicador_iluminacao_publica,
SAFE_CAST(indicador_arborizacao AS BOOL) indicador_arborizacao,
SAFE_CAST(geometria AS GEOGRAPHY) geometria,
SAFE_CAST(valor AS float64) valor
FROM basedosdados-dev.br_ce_fortaleza_sefin_dados_imobiliarios_staging.face_quadra AS t