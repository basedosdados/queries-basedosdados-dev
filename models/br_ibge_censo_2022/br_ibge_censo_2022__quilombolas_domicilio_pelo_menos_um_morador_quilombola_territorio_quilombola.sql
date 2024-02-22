{{
    config(
        alias="quilombolas_domicilio_pelo_menos_um_morador_quilombola_territorio_quilombola",
        schema="br_ibge_censo_2022",
    )
}}
select
    safe_cast(cod_ as string) id_territorio_quilombola,
    safe_cast(
        trim(
            regexp_extract(territorio_quilombola_por_unidade_da_federacao, r'([^\(]+)')
        ) as string
    ) territorio_quilombola,
    case
        when
            regexp_contains(
                territorio_quilombola_por_unidade_da_federacao, r'\(\w{2}\)'
            )
        then
            safe_cast(
                trim(
                    regexp_extract(
                        territorio_quilombola_por_unidade_da_federacao, r'\((\w{2})\)'
                    )
                ) as string
            )
        else
            safe_cast(
                trim(
                    split(
                        split(territorio_quilombola_por_unidade_da_federacao, '(')[
                            safe_offset(2)
                        ],
                        ')'
                    )[safe_offset(0)]
                ) as string
            )
    end as sigla_uf,
    safe_cast(
        domicilios_particulares_permanentes_ocupados_com_pelo_menos_um_morador_quilombola_domicilios_
        as string
    ) domicilios,
    safe_cast(
        moradores_em_domicilios_particulares_permanentes_ocupados_com_pelo_menos_um_morador_quilombola_pessoas_
        as int64
    ) moradores,
    safe_cast(
        moradores_quilombolas_em_domicilios_particulares_permanentes_ocupados_com_pelo_menos_um_morador_quilombola_pessoas_
        as int64
    ) moradores_quilombolas,
from
    `basedosdados-dev.br_ibge_censo_2022_staging.quilombolas_domicilio_pelo_menos_um_morador_quilombola_territorio_quilombola`
    as t
    {{
        config(
            alias="quilombolas_domicilio_pelo_menos_um_morador_quilombola_territorio_quilombola",
            schema="br_ibge_censo_2022",
        )
    }}
select
    safe_cast(cod_ as string) id_territorio_quilombola,
    safe_cast(
        trim(
            regexp_extract(territorio_quilombola_por_unidade_da_federacao, r'([^\(]+)')
        ) as string
    ) territorio_quilombola,
    safe_cast(
        trim(
            regexp_extract(
                territorio_quilombola_por_unidade_da_federacao, r'\(([^)]+)\)'
            )
        ) as string
    ) sigla_uf,
    safe_cast(
        domicilios_particulares_permanentes_ocupados_com_pelo_menos_um_morador_quilombola_domicilios_
        as string
    ) domicilios,
    safe_cast(
        moradores_em_domicilios_particulares_permanentes_ocupados_com_pelo_menos_um_morador_quilombola_pessoas_
        as int64
    ) moradores,
    safe_cast(
        moradores_quilombolas_em_domicilios_particulares_permanentes_ocupados_com_pelo_menos_um_morador_quilombola_pessoas_
        as int64
    ) moradores_quilombolas,
from
    `basedosdados-dev.br_ibge_censo_2022_staging.quilombolas_domicilio_pelo_menos_um_morador_quilombola_territorio_quilombola`
    as t
