{{
    config(
        schema="br_ms_cnes",
        materialized="incremental",
        partition_by={
            "field": "ano",
            "data_type": "int64",
            "range": {"start": 2005, "end": 2023, "interval": 1},
        },
        pre_hook="DROP ALL ROW ACCESS POLICIES ON {{ this }}",
        post_hook=[
            'CREATE OR REPLACE ROW ACCESS POLICY allusers_filter                     ON {{this}}                     GRANT TO ("allUsers")                     FILTER USING (DATE_DIFF(CURRENT_DATE(),DATE(CAST(ano AS INT64),CAST(mes AS INT64),1), MONTH) > 6)',
            'CREATE OR REPLACE ROW ACCESS POLICY bdpro_filter        ON  {{this}}                     GRANT TO ("group:bd-pro@basedosdados.org", "group:sudo@basedosdados.org")                     FILTER USING (DATE_DIFF(CURRENT_DATE(),DATE(CAST(ano AS INT64),CAST(mes AS INT64),1), MONTH) <= 6)',
        ],
    )
}}


with
    raw_cnes_equipamento as (
        -- 1. Retirar linhas com id_estabelecimento_cnes nulo
        select *
        from `basedosdados-staging.br_ms_cnes_staging.equipamento`
        where cnes is not null
    ),
    cnes_add_muni as (
        -- 2. Adicionar id_municipio de 7 dígitos
        select *
        from raw_cnes_equipamento
        left join
            (
                select id_municipio, id_municipio_6,
                from `basedosdados-dev.br_bd_diretorios_brasil.municipio`
            ) as mun
            on raw_cnes_equipamento.codufmun = mun.id_municipio_6
    )
select
    safe_cast(ano as int64) as ano,
    safe_cast(mes as int64) as mes,
    safe_cast(sigla_uf as string) as sigla_uf,
    safe_cast(id_municipio as string) as id_municipio,
    safe_cast(cnes as string) as id_estabelecimento_cnes,
    safe_cast(codequip as string) as id_equipamento,
    safe_cast(tipequip as string) as tipo_equipamento,
    safe_cast(qt_exist as string) as quantidade_equipamentos,
    safe_cast(qt_uso as string) as quantidade_equipamentos_ativos,
    safe_cast(ind_sus as int64) as indicador_equipamento_disponivel_sus,
    safe_cast(ind_nsus as int64) as indicador_equipamento_indisponivel_sus
from cnes_add_muni
{% if is_incremental() %}
    where concat(ano, mes) > (select max(concat(ano, mes)) from {{ this }})
{% endif %}
