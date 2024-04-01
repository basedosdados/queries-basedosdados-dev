{{
    config(
        schema='br_tse_eleicoes',
        alias = 'resultados_candidato_municipio_zona',
        materialized='table',
        partition_by={
            "field": "ano",
            "data_type": "int64",
            "range": {
                "start": 1998,
                "end": 2022,
                "interval": 2
            }
        },
        cluster_by=["sigla_uf"],
    )
}}

SELECT 
SAFE_CAST(ano AS INT64) ano,
SAFE_CAST(turno AS INT64) turno,
SAFE_CAST(tipo_eleicao AS STRING) tipo_eleicao,
SAFE_CAST(sigla_uf AS STRING) sigla_uf,
SAFE_CAST(id_municipio AS STRING) id_municipio,
SAFE_CAST(id_municipio_tse AS STRING) id_municipio_tse,
SAFE_CAST(zona AS STRING) zona,
SAFE_CAST(cargo AS STRING) cargo,
SAFE_CAST(numero_partido AS STRING) numero_partido,
SAFE_CAST(sigla_partido AS STRING) sigla_partido,
SAFE_CAST(numero_candidato AS STRING) numero_candidato,
SAFE_CAST(sequencial_candidato AS STRING) sequencial_candidato,
SAFE_CAST(id_candidato_bd AS STRING) id_candidato_bd,
SAFE_CAST(resultado AS STRING) resultado,
SAFE_CAST(votos AS INT64) votos
FROM basedosdados-dev.br_tse_eleicoes_staging.resultados_candidato_municipio_zona AS t