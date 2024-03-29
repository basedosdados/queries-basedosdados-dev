{{
    config(
        alias="mesorregiao",
        schema="br_geobr_mapas",
        materialized="table",
    )
}}
select
    safe_cast(id_uf as string) id_uf,
    safe_cast(sigla_uf as string) sigla_uf,
    safe_cast(id_mesorregiao as string) id_mesorregiao,
    safe.st_geogfromtext(geometria) geometria
from `basedosdados-dev.br_geobr_mapas_staging.mesorregiao` as t
