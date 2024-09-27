{{ config(alias="municipio", schema="br_ibge_censo_2022") }}
with
    domicilio_morador as (
        select
            municipio,
            safe_cast(
                trim(regexp_extract(municipio, r'([^\(]+)')) as string
            ) nome_municipio,
            safe_cast(
                trim(regexp_extract(municipio, r'\(([^)]+)\)')) as string
            ) sigla_uf,
            safe_cast(
                domicilios_particulares_permanentes_ocupados_domicilios_ as int64
            ) domicilios,
            safe_cast(
                moradores_em_domicilios_particulares_permanentes_ocupados_pessoas_
                as int64
            ) moradores,
        from `basedosdados-dev.br_ibge_censo_2022_staging.domicilio_morador_municipio`
    ),

    area as (
        select
            municipio,
            safe_cast(
                trim(regexp_extract(municipio, r'([^\(]+)')) as string
            ) nome_municipio,
            safe_cast(
                trim(regexp_extract(municipio, r'\(([^)]+)\)')) as string
            ) sigla_uf,
            safe_cast(
                area_da_unidade_territorial_quilometros_quadrados_ as int64
            ) area_unidade_territorial,
        from
            `basedosdados-dev.br_ibge_censo_2022_staging.area_territorial_densidade_demografica_municipio`
            as t
    )

select
    t2.cod as id_municipio,
    domicilio_morador.sigla_uf
    domicilio_morador.* except (municipio, nome_municipio, sigla_uf),
    area.area_unidade_territorial
from domicilio_morador
left join
    area on domicilio_morador.municipio = area.municipio
    `basedosdados-dev.br_ibge_censo_2022_staging.auxiliary_table` t2
    on ibge.municipio = t2.municipio
