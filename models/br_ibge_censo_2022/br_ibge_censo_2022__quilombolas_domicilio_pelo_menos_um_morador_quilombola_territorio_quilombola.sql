{{ config(alias='quilombolas_domicilio_pelo_menos_um_morador_quilombola_territorio_quilombola',schema='br_ibge_censo_2022') }}
SELECT
SAFE_CAST(cod_ as STRING) id_territorio_quilombola,
SAFE_CAST(TRIM(REGEXP_EXTRACT(territorio_quilombola_por_unidade_da_federacao, r'([^\(]+)')) AS STRING) territorio_quilombola,
  CASE
    WHEN REGEXP_CONTAINS(territorio_quilombola_por_unidade_da_federacao, r'\(\w{2}\)') THEN
      SAFE_CAST(TRIM(REGEXP_EXTRACT(territorio_quilombola_por_unidade_da_federacao, r'\((\w{2})\)')) AS STRING)
    ELSE
      SAFE_CAST(TRIM(SPLIT(SPLIT(territorio_quilombola_por_unidade_da_federacao, '(')[SAFE_OFFSET(2)], ')')[SAFE_OFFSET(0)]) AS STRING)
  END AS sigla_uf,
SAFE_CAST(domicilios_particulares_permanentes_ocupados_com_pelo_menos_um_morador_quilombola_domicilios_ AS STRING) domicilios,
SAFE_CAST(moradores_em_domicilios_particulares_permanentes_ocupados_com_pelo_menos_um_morador_quilombola_pessoas_ AS INT64) moradores,
SAFE_CAST(moradores_quilombolas_em_domicilios_particulares_permanentes_ocupados_com_pelo_menos_um_morador_quilombola_pessoas_ AS INT64) moradores_quilombolas,
FROM basedosdados-dev.br_ibge_censo_2022_staging.quilombolas_domicilio_pelo_menos_um_morador_quilombola_territorio_quilombola AS t
