{{
    config(
        alias="indigenas_indice_envelhecimento_terras_indigenas",
        schema="br_ibge_censo_2022",
    )
}}
select
    safe_cast(ano as int64) ano,
    safe_cast(terra_indigena as string) terra_indigena,
    safe_cast(sigla_uf as string) sigla_uf,
    safe_cast(indice_envelhecimento as float64) indice_envelhecimento,
    safe_cast(idade_mediana as int64) idade_mediana,
    safe_cast(razao_sexo as float64) razao_sexo,
    safe_cast(
        indice_envelhecimento_populacao_quilombola as float64
    ) indice_envelhecimento_populacao_quilombola,
    safe_cast(
        idade_mediana_populacao_quilombola as int64
    ) idade_mediana_populacao_quilombola,
    safe_cast(razao_sexo_quilombola as float64) razao_sexo_quilombola,
from
    `basedosdados-dev.br_ibge_censo_2022_staging.indigenas_indice_envelhecimento_terras_indigenas`
    as t
