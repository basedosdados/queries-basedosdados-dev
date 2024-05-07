{{
    config(
        alias="indigenas_populacao_residente_grupo_idade_terras_indigenas",
        schema="br_ibge_censo_2022",
    )
}}
select
    safe_cast(terra_indigena as string) terra_indigena,
    safe_cast(sigla_uf as string) sigla_uf,
    safe_cast(quesito_declaracao_indigena as string) quesito_declaracao_indigena,
    safe_cast(sexo as string) sexo,
    safe_cast(idade as string) idade,
    safe_cast(pessoas_indigenas as int64) pessoas_indigenas,
    safe_cast(populacao_residente as int64) populacao_residente,
from
    `basedosdados-dev.br_ibge_censo_2022_staging.indigenas_populacao_residente_grupo_idade_terras_indigenas`
    as t
