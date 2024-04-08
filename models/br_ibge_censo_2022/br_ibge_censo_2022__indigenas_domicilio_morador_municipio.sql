{{
    config(
        alias="indigenas_domicilio_morador_municipio", schema="br_ibge_censo_2022"
    )
}}
with
    ibge as (
        select
            municipio,
            safe_cast(
                trim(regexp_extract(municipio, r'([^\(]+)')) as string
            ) nome_municipio,
            safe_cast(
                trim(regexp_extract(municipio, r'\(([^)]+)\)')) as string
            ) sigla_uf,
            safe_cast(localizacao_do_domicilio as string) localizacao_domicilio,
            safe_cast(
                domicilios_particulares_permanentes_ocupados_domicilios_ as int64
            ) domicilios,
            safe_cast(
                moradores_em_domicilios_particulares_permanentes_ocupados_pessoas_
                as int64
            ) moradores,
            safe_cast(
                moradores_indigenas_em_domicilios_particulares_permanentes_ocupados_pessoas_
                as int64
            ) moradores_indigenas,
        from
            `basedosdados-dev.br_ibge_censo_2022_staging.indigenas_domicilio_morador_municipio`
            as t
    )
select t2.cod as id_municipio, ibge.* except (municipio, nome_municipio, sigla_uf)
from ibge
left join
    `basedosdados-dev.br_ibge_censo_2022_staging.auxiliary_table` t2
    on ibge.municipio = t2.municipio
