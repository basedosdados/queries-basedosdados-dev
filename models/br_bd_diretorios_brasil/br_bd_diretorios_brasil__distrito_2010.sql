{{
    config(
        alias="distrito_2010",
        schema="br_bd_diretorios_brasil",
        materialized="table",
    )
}}

select
    safe_cast(as string) id_distrito,
    safe_cast(nome as string) nome,
    safe_cast(id_municipio as string) id_municipio,
    safe_cast(sigla_uf as string) sigla_uf
from `basedosdados-dev.br_bd_diretorios_brasil_staging.distrito`
where ano = '2010'
