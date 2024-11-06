{{
    config(
        alias="aluno_ef_2ano",
        schema="br_inep_saeb",
        materialized="table",
        partition_by={
            "field": "ano",
            "data_type": "int64",
            "range": {"start": 1995, "end": 2023, "interval": 1},
        },
        cluster_by=["sigla_uf"],
        labels={"tema": "educacao"},
    )
}}

select
    safe_cast(ano as int64) ano,
    safe_cast(id_regiao as string) id_regiao,
    safe_cast(sigla_uf as string) sigla_uf,
    safe_cast(id_municipio as string) id_municipio,
    safe_cast(area as string) area,
    safe_cast(id_escola as string) id_escola,
    safe_cast(rede as string) rede,
    safe_cast(localizacao as string) localizacao,
    safe_cast(id_turma as string) id_turma,
    safe_cast(turno as string) turno,
    safe_cast(serie as int64) serie,
    safe_cast(id_aluno as string) id_aluno,
    safe_cast(situacao_censo as int64) situacao_censo,
    safe_cast(disciplina as string) disciplina,
    safe_cast(preenchimento_caderno as int64) preenchimento_caderno,
    safe_cast(presenca as int64) presenca,
    safe_cast(caderno as string) caderno,
    safe_cast(bloco_1 as string) bloco_1,
    safe_cast(bloco_2 as string) bloco_2,
    safe_cast(bloco_1_aberto as string) bloco_1_aberto,
    safe_cast(bloco_2_aberto as string) bloco_2_aberto,
    safe_cast(respostas_bloco_1 as string) respostas_bloco_1,
    safe_cast(respostas_bloco_2 as string) respostas_bloco_2,
    safe_cast(conceito_q1 as string) conceito_q1,
    safe_cast(conceito_q2 as string) conceito_q2,
    safe_cast(resposta_texto as string) resposta_texto,
    safe_cast(conceito_proposito as string) conceito_proposito,
    safe_cast(conceito_elemento as string) conceito_elemento,
    safe_cast(conceito_segmentacao as string) conceito_segmentacao,
    safe_cast(texto_grafia as string) texto_grafia,
    safe_cast(indicador_proficiencia as string) indicador_proficiencia,
    safe_cast(amostra as string) amostra,
    safe_cast(estrato as string) estrato,
    safe_cast(peso_aluno as float64) peso_aluno,
    safe_cast(proficiencia as float64) proficiencia,
    safe_cast(erro_padrao as float64) erro_padrao,
    safe_cast(proficiencia_saeb as float64) proficiencia_saeb,
    safe_cast(erro_padrao_saeb as float64) erro_padrao_saeb
from `basedosdados-dev.br_inep_saeb_staging.aluno_ef_2ano` as t