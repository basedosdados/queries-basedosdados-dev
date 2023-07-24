{{ config(
    materialized='table',
    partition_by={
      "field": "data_consulta",
      "data_type": "date",
      "granularity": "day"
    }
)}}

WITH tabela_ordenada as (
SELECT
  dia AS data_consulta,
  FORMAT('%02d:%02d:%02d', EXTRACT(HOUR
    FROM
      PARSE_DATETIME('%Y-%m-%d %H:%M:%S', data_hora)), EXTRACT(MINUTE
    FROM
      PARSE_DATETIME('%Y-%m-%d %H:%M:%S', data_hora)), EXTRACT(SECOND
    FROM
      PARSE_DATETIME('%Y-%m-%d %H:%M:%S', data_hora))) AS hora_consulta,
  secao_site,
  LPAD(item_id, 12, '0') AS id_item,
  CASE
    WHEN vendedor='None' THEN NULL
    ELSE vendedor
  END vendedor,
  titulo,
  CASE 
    WHEN categorias = '[]' THEN null
    ELSE TRIM(JSON_EXTRACT_ARRAY(categorias)[OFFSET(0)], '"')  
  END as categoria_principal,
  CASE 
    WHEN categorias = '[]' THEN null
    ELSE ARRAY_TO_STRING(ARRAY(SELECT x FROM UNNEST(JSON_EXTRACT_ARRAY(categorias)) AS x WITH OFFSET
                              WHERE OFFSET > 0), ', ')
  END as outras_categorias,
  CASE
    WHEN caracteristicas = '{}' THEN NULL
    ELSE caracteristicas
  END caracteristicas,
  SAFE_CAST(envio_pais AS BOOL) envio_nacional,
  SAFE_CAST(quantidade_avaliacoes AS INT64) quantidade_avaliacao,
  SAFE_CAST(estrelas AS FLOAT64) avaliacao,
  SAFE_CAST(CASE 
    WHEN preco_original = 'nan' THEN null 
    WHEN preco > preco_original THEN preco
    ELSE preco_original
  END AS FLOAT64) AS preco_original,
  SAFE_CAST(desconto AS INT64) desconto,
  SAFE_CAST (CASE
    WHEN preco > preco_original THEN preco_original
    WHEN preco = preco_original THEN  null
    ELSE preco
  END AS FLOAT64) AS preco_final,
FROM
  `basedosdados-dev.br_mercadolivre_ofertas_staging.item`)

SELECT 
  data_consulta,
  hora_consulta,
  secao_site,
  id_item,
  titulo,
  id_vendor as id_vendedor,
  vendedor,
  categoria_principal,
  REGEXP_REPLACE(
    TRIM(outras_categorias, '"'),
    r'("([^"]+)")',
    r'\2'
  ) as outras_categorias,
  caracteristicas,
  envio_nacional,
  quantidade_avaliacao,
  avaliacao, 
  ROUND(
    CASE 
      WHEN preco_original IS NULL THEN preco_final * 100 / (100 - desconto)
      ELSE preco_original
    END, 2
  ) AS preco_original,
  CAST(
    CASE
      WHEN desconto IS NULL THEN 100 - (preco_final * 100 / preco_original)
      ELSE desconto
    END AS INT
  ) AS desconto,
  ROUND(
    CASE
      WHEN preco_final IS NULL THEN preco_original * (100 - desconto) / 100
      ELSE preco_final
    END, 2
  ) AS preco_final
FROM  tabela_ordenada a
LEFT JOIN
(SELECT
  DISTINCT
    dia,
    id_vendor,
    nome
FROM
    `basedosdados-dev.br_mercadolivre_ofertas_staging.vendedor`)  b
ON a.vendedor = b.nome and data_consulta = dia
WHERE NOT (preco_original IS NULL AND preco_final IS NULL)
  AND NOT (preco_final IS NULL AND desconto IS NULL)
  AND NOT (preco_original IS NULL AND desconto IS NULL)