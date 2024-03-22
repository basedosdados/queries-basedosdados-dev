{{
    config(
        alias="uf",
        schema="br_mme_consumo_energia_eletrica",
        materialized="table",
    )
}}
select
    safe_cast(ano as int64) ano,
    safe_cast(mes as int64) mes,
    safe_cast(sigla_uf as string) sigla_uf,
    safe_cast(tipo_consumo as string) tipo_consumo,
    safe_cast(replace(numero_consumidores, ".0", '') as int64) numero_consumidores,
    safe_cast(consumo as int64) consumo

from `basedosdados-dev.br_mme_consumo_energia_eletrica_staging.uf` as t
