{{
    config(
        alias="quilombolas_populacao_residente_grupo_idade_territorio_quilombola",
        schema="br_ibge_censo_2022",
    )
}}
select
    safe_cast(territorio_quilombola as string) territorio_quilombola,
    safe_cast(sigla_uf as string) sigla_uf,
    safe_cast(sexo as string) sexo,
    safe_cast(idade as string) idade,
    safe_cast(pessoas_quilombolas as int64) pessoas_quilombolas,
    safe_cast(populacao_residente as int64) populacao_residente,
from
    `basedosdados-dev.br_ibge_censo_2022_staging.quilombolas_populacao_residente_grupo_idade_territorio_quilombola`
    as t
