{{ config(alias='domicilio_tipo_municipio',schema='br_ibge_censo_2022') }}
select
safe_cast(ano as int64) ano,
safe_cast(id_municipio as string) id_municipio,
safe_cast(tipo_domicilio as string) tipo_domicilio,
safe_cast(domicilios as int64) domicilios,
from `basedosdados-dev.br_ibge_censo_2022_staging.domicilio_tipo_municipio` as t

