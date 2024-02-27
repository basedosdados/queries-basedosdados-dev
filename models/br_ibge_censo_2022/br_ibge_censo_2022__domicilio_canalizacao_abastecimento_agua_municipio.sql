{{ config(alias='domicilio_canalizacao_abastecimento_agua_municipio',schema='br_ibge_censo_2022') }}
select
safe_cast(ano as int64) ano,
safe_cast(id_municipio as string) id_municipio,
safe_cast(tipo_abastecimento_agua as string) tipo_abastecimento_agua,
safe_cast(tipo_canalizacao_agua as string) tipo_canalizacao_agua,
safe_cast(domicilios as int64) domicilios,
from `basedosdados-dev.br_ibge_censo_2022_staging.domicilio_canalizacao_abastecimento_agua_municipio` as t

