{{
    config(
        alias="taxa_alfabetizacao_cor_raca_grupo_idade_municipio",
        schema="br_ibge_censo_2022",
    )
}}
select
    safe_cast(id_municipio as string) id_municipio,
    safe_cast(cor_raca as string) cor_raca,
    safe_cast(sexo as string) sexo,
    safe_cast(grupo_idade as string) grupo_idade,
    safe_cast(taxa_alfabetizacao as string) taxa_alfabetizacao,
from
    `basedosdados-dev.br_ibge_censo_2022_staging.taxa_alfabetizacao_cor_raca_grupo_idade_municipio`
    as t
