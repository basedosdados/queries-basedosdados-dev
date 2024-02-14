{{
    config(
        alias="microrregiao",
        schema="br_geobr_mapas",
        materialized="table",
    )
}}

select
    safe_cast(id_uf as string) id_uf,
    safe_cast(sigla_uf as string) sigla_uf,
    safe_cast(id_microrregiao as string) id_microrregiao,
    safe.st_geogfromtext(geometria) geometria
from `basedosdados-dev.br_geobr_mapas_staging.microrregiao` as t
