{{
    config(
        schema="br_ans_beneficiario",
        materialized="table",
        partition_by={
            "field": "ano",
            "data_type": "int64",
            "range": {"start": 2014, "end": 2023, "interval": 1},
        },
        cluster_by=["id_municipio", "mes", "sigla_uf"],
        labels={"project_id": "basedosdados-dev"},
        pre_hook="DROP ALL ROW ACCESS POLICIES ON {{ this }}",
        post_hook=[
            'CREATE OR REPLACE ROW ACCESS POLICY allusers_filter                         ON {{this}}                         GRANT TO ("allUsers")                         FILTER USING (DATE_DIFF(CURRENT_DATE(),DATE(CAST(ano AS INT64),CAST(mes AS INT64),1), MONTH) > 6)',
            'CREATE OR REPLACE ROW ACCESS POLICY bdpro_filter                         ON  {{this}}                         GRANT TO ("group:bd-pro@basedosdados.org", "group:sudo@basedosdados.org")                         FILTER USING (DATE_DIFF(CURRENT_DATE(),DATE(CAST(ano AS INT64),CAST(mes AS INT64),1), MONTH) <= 6)',
        ],
    )
}}
with
    ans as (
        select
            cast(ano as int64) ano,
            cast(mes as int64) mes,
            cast(t.sigla_uf as string) sigla_uf,
            id_municipio,
            cast(cd_operadora as string) codigo_operadora,
            cast(
                initcap(
                    translate(
                        nm_razao_social,
                        'áàâãäéèêëíìîïóòôõöúùûüçÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇ',
                        'aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC'
                    )
                ) as string
            ) razao_social,
            cast(nr_cnpj as string) cnpj,
            modalidade_operadora,
            cast(tp_sexo as string) sexo,
            cast(
                lower(
                    translate(
                        de_faixa_etaria,
                        'áàâãäéèêëíìîïóòôõöúùûüçÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇ',
                        'aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC'
                    )
                ) as string
            ) faixa_etaria,
            cast(
                lower(
                    translate(
                        de_faixa_etaria_reaj,
                        'áàâãäéèêëíìîïóòôõöúùûüçÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇ',
                        'aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC'
                    )
                ) as string
            ) faixa_etaria_reajuste,
            cast(cd_plano as string) codigo_plano,
            cast(tp_vigencia_plano as string) tipo_vigencia_plano,
            cast(
                initcap(
                    translate(
                        de_contratacao_plano,
                        'áàâãäéèêëíìîïóòôõöúùûüçÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇ',
                        'aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC'
                    )
                ) as string
            ) contratacao_beneficiario,
            cast(
                initcap(
                    translate(
                        de_segmentacao_plano,
                        'áàâãäéèêëíìîïóòôõöúùûüçÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇ',
                        'aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC'
                    )
                ) as string
            ) segmentacao_beneficiario,
            cast(
                initcap(
                    translate(
                        de_abrg_geografica_plano,
                        'áàâãäéèêëíìîïóòôõöúùûüçÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇ',
                        'aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC'
                    )
                ) as string
            ) abrangencia_beneficiario,
            cast(
                initcap(
                    translate(
                        cobertura_assist_plan,
                        'áàâãäéèêëíìîïóòôõöúùûüçÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇ',
                        'aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC'
                    )
                ) as string
            ) cobertura_assistencia_beneficiario,
            cast(
                initcap(
                    translate(
                        tipo_vinculo,
                        'áàâãäéèêëíìîïóòôõöúùûüçÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇ',
                        'aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC'
                    )
                ) as string
            ) tipo_vinculo,
            cast(qt_beneficiario_ativo as int64) quantidade_beneficiario_ativo,
            cast(qt_beneficiario_aderido as int64) quantidade_beneficiario_aderido,
            cast(qt_beneficiario_cancelado as int64) quantidade_beneficiario_cancelado,
            cast(parse_date('%d/%m/%Y', dt_carga) as date) data_carga,
        from
            `basedosdados-dev.br_ans_beneficiario_staging.informacao_consolidada_atualizado` t
        join
            `basedosdados.br_bd_diretorios_brasil.municipio` bd
            on t.cd_municipio = bd.id_municipio_6
        where ano = '2023'
    )
select *
from ans
