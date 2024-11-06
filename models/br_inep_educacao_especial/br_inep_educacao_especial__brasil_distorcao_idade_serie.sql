{{
    config(
        alias="brasil_distorcao_idade_serie",
        schema="br_inep_educacao_especial",
        materialized="table",
    )
}}

select
    safe_cast(ano as int64) ano,
    safe_cast(etapa_ensino as string) etapa_ensino,
    safe_cast(tdi as float64) tdi,
from
    `basedosdados-dev.br_inep_educacao_especial_staging.brasil_distorcao_idade_serie`
    as t