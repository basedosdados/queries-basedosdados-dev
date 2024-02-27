{{ config(alias='domicilio_esgotamento_sanitario_municipio',schema='br_ibge_censo_2022') }}
select
safe_cast(ano as int64) ano,
safe_cast(id_municipio as string) id_municipio,
safe_cast(tipo_esgotamento_sanitario as string) tipo_esgotamento_sanitario,
safe_cast(domicilios as int64) domicilios,
from `basedosdados-dev.br_ibge_censo_2022_staging.domicilio_esgotamento_sanitario_municipio` as t

