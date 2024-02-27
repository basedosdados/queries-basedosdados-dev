{{ config(alias='morador_cor_raca_esgotamento_sanitario_municipio',schema='br_ibge_censo_2022') }}
select
safe_cast(ano as int64) ano,
safe_cast(id_municipio as string) id_municipio,
safe_cast(tipo_esgotamento_sanitario as string) tipo_esgotamento_sanitario,
safe_cast(grupo_idade as string) grupo_idade,
safe_cast(cor_raca as string) cor_raca,
safe_cast(moradores as int64) moradores,
from `basedosdados-dev.br_ibge_censo_2022_staging.morador_cor_raca_esgotamento_sanitario_municipio` as t

