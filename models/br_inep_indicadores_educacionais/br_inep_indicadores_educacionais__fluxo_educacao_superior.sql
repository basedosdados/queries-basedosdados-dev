{{
    config(
        alias="fluxo_educacao_superior",
        schema="br_inep_indicadores_educacionais",
        materialized="table",
    )
}}
select
    safe_cast(id_ies as string) id_ies,
    safe_cast(initcap(nome_ies) as string) nome_ies,
    case
        when tipo_categoria_administrativa = '1'
        then 'Pública federal'
        when tipo_categoria_administrativa = '2'
        then 'Pública estadual'
        when tipo_categoria_administrativa = '3'
        then 'Pública municipal'
        when tipo_categoria_administrativa = '4'
        then 'Privada com fins lucrativos'
        when tipo_categoria_administrativa = '5'
        then 'Privada sem fins lucrativos'
        when tipo_categoria_administrativa = '6'
        then 'Privada - particular em sentido estrito'
        when tipo_categoria_administrativa = '7'
        then 'Especial'
        when tipo_categoria_administrativa = '8'
        then 'Privada comunitária'
        when tipo_categoria_administrativa = '9'
        then 'Privada confessional'
    end as tipo_categoria_administrativa,
    case
        when tipo_organizacao_academica = '1'
        then 'Universidade'
        when tipo_organizacao_academica = '2'
        then 'Centro Universitário'
        when tipo_organizacao_academica = '3'
        then 'Faculdade'
        when tipo_organizacao_academica = '4'
        then 'Instituto Federal de Educação, Ciência e Tecnologia'
        when tipo_organizacao_academica = '5'
        then 'Centro Federal de Educação Tecnológica'
    end as tipo_organizacao_academica,
    safe_cast(id_curso as string) id_curso,
    safe_cast(initcap(nome_curso) as string) nome_curso,
    safe_cast(d.sigla as string) sigla_uf,
    safe_cast(id_municipio as string) id_municipio,
    case
        when tipo_grau_academico = '1'
        then 'Bacharelado'
        when tipo_grau_academico = '2'
        then 'Licenciatura'
        when tipo_grau_academico = '3'
        then 'Tecnológico'
        when tipo_grau_academico = '4'
        then 'Bacharelado e Licenciatura'
        when tipo_grau_academico = '.'
        then
            'Não aplicável (cursos com nível acadêmico igual a sequencial de formação específica ou cursos de área básica de Ingresso)'
    end as tipo_grau_academico,
    case
        when tipo_modalidade_ensino = '1'
        then 'Presencial'
        when tipo_modalidade_ensino = '2'
        then 'Curso a distância'
    end as tipo_modalidade_ensino,
    safe_cast(id_curso_cine as string) id_curso_cine,
    safe_cast(nome_curso_cine as string) nome_curso_cine,
    safe_cast(id_area_geral as string) id_area_geral,
    safe_cast(nome_area_geral as string) nome_area_geral,
    safe_cast(ano_ingresso as int64) ano_ingresso,
    safe_cast(ano_referencia as int64) ano_referencia,
    safe_cast(prazo_integralizacao as int64) prazo_integralizacao,
    safe_cast(ano_integralizacao as int64) ano_integralizacao,
    safe_cast(prazo_acompanhamento_curso as int64) prazo_acompanhamento_curso,
    safe_cast(ano_maximo_acompanhamento_curso as int64) ano_maximo_acompanhamento_curso,
    safe_cast(quantidade_ingressante as int64) quantidade_ingressante,
    safe_cast(quantidade_permanencia as int64) quantidade_permanencia,
    safe_cast(quantidade_concluinte as int64) quantidade_concluinte,
    safe_cast(quantidade_desistencia as int64) quantidade_desistencia,
    safe_cast(quantidade_falecimento as int64) quantidade_falecimento,
    round(safe_cast(taxa_permanenia as float64), 2) taxa_permanenia,
    round(safe_cast(taxa_conclusao_acumulada as float64), 2) taxa_conclusao_acumulada,
    round(
        safe_cast(taxa_desistencia_acumulada as float64), 2
    ) taxa_desistencia_acumulada,
    round(safe_cast(taxa_conclusao_anual as float64), 2) taxa_conclusao_anual,
    round(safe_cast(taxa_desistencia_anual as float64), 2) taxa_desistencia_anual,
from
    `basedosdados-dev.br_inep_indicadores_educacionais_staging.fluxo_educacao_superior`
    as t
left join {{ ref("br_bd_diretorios_brasil__uf") }} as d on t.id_uf = d.id_uf
