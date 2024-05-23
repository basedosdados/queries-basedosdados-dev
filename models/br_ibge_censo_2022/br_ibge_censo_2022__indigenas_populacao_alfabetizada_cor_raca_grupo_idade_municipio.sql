{{
    config(
        alias="indigenas_populacao_alfabetizada_cor_raca_grupo_idade_municipio",
        schema="br_ibge_censo_2022",
    )
}}
select
    safe_cast(id_municipio as string) id_municipio,
    safe_cast(cor_raca as string) cor_raca,
    safe_cast(sexo as string) sexo,
    safe_cast(grupo_idade as string) grupo_idade,
    safe_cast(alfabetizacao as string) alfabetizacao,
    safe_cast(populacao_indigena as int64) populacao_indigena,
from
    `basedosdados-dev.br_ibge_censo_2022_staging.indigenas_populacao_alfabetizada_cor_raca_grupo_idade_municipio`
    as t
