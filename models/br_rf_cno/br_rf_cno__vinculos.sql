{{ config(alias="vinculos", schema="br_rf_cno", materialized="table") }}


select
    safe_cast(data_registro as date) data_registro,
    safe_cast(data_inicio as date) data_inicio,
    safe_cast(data_fim as date) data_fim,
    safe_cast(id_cno as string) id_cno,
    safe_cast(id_responsavel as string) id_responsavel,
    safe_cast(
        ltrim(qualificacao_contribuinte, '0') as string
    ) qualificacao_contribuinte,
from `basedosdados-dev.br_rf_cno_staging.vinculos` as t
