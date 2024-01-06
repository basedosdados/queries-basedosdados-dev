{{
  config(
    alias = 'proposicao_microdados',
    schema='br_camara_dados_abertos',
    materialized='table',
    partition_by={
      "field": "ano",
      "data_type": "int64",
      "range": {
        "start": 1935,
        "end": 2022,
        "interval": 1}
    },    
    post_hook = ['CREATE OR REPLACE ROW ACCESS POLICY allusers_filter 
                    ON {{this}}
                    GRANT TO ("allUsers")
                    FILTER USING (DATE_DIFF(DATE("{{ run_started_at.strftime("%Y-%m-%d") }}"), DATE(data), week) > 6)',
          'CREATE OR REPLACE ROW ACCESS POLICY bdpro_filter 
                ON  {{this}}
                GRANT TO ("group:bd-pro@basedosdados.org", "group:sudo@basedosdados.org")
                FILTER USING (True)' ]
    )
}}


SELECT 
    SAFE_CAST(ano AS STRING) ano,
    SAFE_CAST(SPLIT(FORMAT_TIMESTAMP('%Y-%m-%dT%H:%M:%E*S', TIMESTAMP(dataApresentacao)), 'T')[OFFSET(0)] AS DATE) data,
    SAFE_CAST(SPLIT(FORMAT_TIMESTAMP('%Y-%m-%dT%H:%M:%E*S', TIMESTAMP(dataApresentacao)), 'T')[OFFSET(1)] AS TIME) horario,
    SAFE_CAST(id AS STRING) id_proposicao,
    SAFE_CAST(uri AS STRING) uri,
    SAFE_CAST(sigla_tipo AS STRING) siglaTipo,
    SAFE_CAST(numero AS STRING) numero,
    SAFE_CAST(tipo_descricao AS STRING) descricaoTipo,
    SAFE_CAST(ementa AS STRING) ementa,
    SAFE_CAST(ementaDetalhada AS STRING) ementa_detalhada,
    SAFE_CAST(keywords AS STRING) palavras_chave,
    SAFE_CAST(uriOrgaoNumerador AS STRING) url_orgao_numerador,
    SAFE_CAST(uriPropAnterior AS STRING) url_proposta_anterior,
    SAFE_CAST(uriPropPrincipal AS STRING) url_proposta_principal,
    SAFE_CAST(uriPropPosterior AS STRING) url_proposta_posterior,
    SAFE_CAST(urlInteiroTeor AS STRING) url_teor_proposicao,
    SAFE_CAST(ultimoStatus_dataHora AS STRING) data_hora_ultimo_status,
    SAFE_CAST(ultimoStatus_uriRelator AS STRING) url_relator_ultimo_status,
    SAFE_CAST(ultimoStatus_idOrgao AS STRING) id_orgao_ultimo_status,
    SAFE_CAST(ultimoStatus_siglaOrgao AS STRING) sigla_orgao_ultimo_status,
    SAFE_CAST(ultimoStatus_uriOrgao AS STRING) url_orgao_ultimo_status,
    SAFE_CAST(ultimoStatus_regime AS STRING) regime_ultimo_status,
    SAFE_CAST(ultimoStatus_idTipoTramitacao AS STRING) id_tipo_tramitacao_ultimo_status,
    SAFE_CAST(ultimoStatus_descricaoTramitacao AS STRING) descricao_tramitacao_ultimo_status,
    SAFE_CAST(ultimoStatus_idSituacao AS STRING) id_situacao_ultimo_status,
    SAFE_CAST(ultimoStatus_descricaoSituacao AS STRING) descricao_situacao_ultimo_status,
    SAFE_CAST(ultimoStatus_despacho AS STRING) despacho_ultimo_status,
    SAFE_CAST(ultimoStatus_apreciacao AS STRING) apreciacao_ultimo_status,
    SAFE_CAST(ultimoStatus_sequencia AS STRING) sequencia_ultimo_status,
    SAFE_CAST(ultimoStatus_url AS STRING) url_ultimo_status,
FROM basedosdados-dev.br_camara_dados_abertos_staging.proposicao_microdados AS t

