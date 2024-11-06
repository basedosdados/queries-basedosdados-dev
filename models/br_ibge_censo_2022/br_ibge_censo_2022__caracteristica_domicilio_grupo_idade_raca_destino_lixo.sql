{{
    config(
        alias="caracteristica_domicilio_grupo_idade_raca_destino_lixo",
        schema="br_ibge_censo_2022",
    )
}}
select
    safe_cast(ano as int64) ano,
    safe_cast(cod_ as string) id_municipio,
    safe_cast(destino_do_lixo as string) tipo_destino_lixo,
    safe_cast(grupo_de_idade as string) grupo_idade,
    safe_cast(cor_ou_raca as string) cor_raca,
    safe_cast(
        moradores_em_domicilios_particulares_permanentes_ocupados_pessoas_ as int64
    ) populacao,
from
    `basedosdados-dev.br_ibge_censo_2022_staging.caracteristica_domicilio_grupo_idade_raca_destino_lixo`
    as t