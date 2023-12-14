{{ config(alias='area_territorial_densidade_demografica_municipio',schema='br_ibge_censo_2022') }}
WITH ibge as (
SELECT
SAFE_CAST(TRIM(REGEXP_EXTRACT(municipio, r'([^\(]+)')) AS STRING) nome_municipio,
SAFE_CAST(TRIM(REGEXP_EXTRACT(municipio, r'\(([^)]+)\)')) AS STRING) sigla_uf,
SAFE_CAST(populacao_residente_pessoas_ AS INT64) populacao_residente,
SAFE_CAST(area_da_unidade_territorial_quilometros_quadrados_ AS INT64) area_unidade_territorial,
SAFE_CAST(REPLACE(densidade_demografica_habitante_por_quilometro_quadrado_, ",", ".") AS FLOAT64) densidade_demografica,
FROM basedosdados-dev.br_ibge_censo_2022_staging.area_territorial_densidade_demografica_municipio AS t)
select t2.id_municipio, ibge.* except(nome_municipio,sigla_uf) 
from ibge
left join `basedosdados.br_bd_diretorios_brasil.municipio` t2
on ibge.nome_municipio = t2.nome and ibge.sigla_uf = t2.sigla_uf
