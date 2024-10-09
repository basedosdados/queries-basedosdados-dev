{{
    config(
        schema="br_tse_filiacao_partidaria",
        alias="microdados_antigos",
        materialized="table",
        cluster_by=["sigla_uf"],
    )
}}

select
    safe_cast(sigla_partido as string) sigla_partido,
    safe_cast(sigla_uf as string) sigla_uf,
    safe_cast(id_municipio as string) id_municipio,
    safe_cast(id_municipio_tse as string) id_municipio_tse,
    safe_cast(zona as int64) zona,
    safe_cast(secao as int64) secao,
    safe_cast(titulo_eleitoral as string) titulo_eleitoral,
    safe_cast(nome as string) nome,
    safe_cast(data_filiacao as date) data_filiacao,
    safe_cast(situacao_registro as string) situacao_registro,
    safe_cast(tipo_registro as string) tipo_registro,
    safe_cast(data_processamento as date) data_processamento,
    safe_cast(data_desfiliacao as date) data_desfiliacao,
    safe_cast(data_cancelamento as date) data_cancelamento,
    safe_cast(data_regularizacao as date) data_regularizacao,
    safe_cast(motivo_cancelamento as string) motivo_cancelamento,
from `basedosdados-dev.br_tse_filiacao_partidaria_staging.microdados_antigos` as t
