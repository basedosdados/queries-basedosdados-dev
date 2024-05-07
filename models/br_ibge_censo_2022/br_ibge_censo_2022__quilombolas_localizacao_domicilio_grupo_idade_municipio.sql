{{
    config(
        alias="quilombolas_localizacao_domicilio_grupo_idade_municipio",
        schema="br_ibge_censo_2022",
    )
}}
select
    safe_cast(ano as int64) ano,
    safe_cast(id_municipio as string) id_municipio,
    safe_cast(localizacao_domicilio as string) localizacao_domicilio,
    safe_cast(grupo_idade as string) grupo_idade,
    safe_cast(sexo as string) sexo,
    safe_cast(pessoas as int64) pessoas,
from
    `basedosdados-dev.br_ibge_censo_2022_staging.quilombolas_localizacao_domicilio_grupo_idade_municipio`
    as t
