-- Consulta para a primeira coluna
-- segmentacao_beneficiario,
-- testar tamanho da tabela com e sem dicionario
-- padronizar cm primeira letra maiuscula
SELECT
  ROW_NUMBER() OVER(ORDER BY modalidade_operadora) AS chave,
  modalidade_operadora AS valor,
  'modalidade_operadora' AS coluna
FROM
  `basedosdados-dev.br_ans_beneficiario.microdados`
GROUP BY
  modalidade_operadora

UNION ALL

-- Consulta para a segunda coluna
SELECT
  ROW_NUMBER() OVER(ORDER BY faixa_etaria) AS chave,
  faixa_etaria AS valor,
  'faixa_etaria' AS coluna
FROM
  `basedosdados-dev.br_ans_beneficiario.microdados`
GROUP BY
  faixa_etaria

UNION ALL

-- Consulta para a terceira coluna
SELECT
  ROW_NUMBER() OVER(ORDER BY contratacao_beneficiario) AS chave,
  contratacao_beneficiario AS valor,
  'contratacao_beneficiario' AS coluna
FROM
  `basedosdados-dev.br_ans_beneficiario.microdados`
GROUP BY
  contratacao_beneficiario

UNION ALL

-- Consulta para a quarta coluna
SELECT
  ROW_NUMBER() OVER(ORDER BY segmentacao_beneficiario) AS chave,
  segmentacao_beneficiario AS valor,
  'segmentacao_beneficiario' AS coluna
FROM
  `basedosdados-dev.br_ans_beneficiario.microdados`
GROUP BY
  segmentacao_beneficiario  

UNION ALL

-- Consulta para a quarta coluna
SELECT
  ROW_NUMBER() OVER(ORDER BY abrangencia_beneficiario) AS chave,
  abrangencia_beneficiario AS valor,
  'abrangencia_beneficiario' AS coluna
FROM
  `basedosdados-dev.br_ans_beneficiario.microdados`
GROUP BY
  abrangencia_beneficiario

UNION ALL

-- Consulta para a quinta coluna
SELECT
  ROW_NUMBER() OVER(ORDER BY cobertura_assistencia_beneficiario) AS chave,
  cobertura_assistencia_beneficiario AS valor,
  'cobertura_assistencia_beneficiario' AS coluna
FROM
  `basedosdados-dev.br_ans_beneficiario.microdados`
GROUP BY
  cobertura_assistencia_beneficiario  

UNION ALL

-- Consulta para a sexta coluna
SELECT
  ROW_NUMBER() OVER(ORDER BY tipo_vinculo) AS chave,
  tipo_vinculo AS valor,
  'tipo_vinculo' AS coluna
FROM
  `basedosdados-dev.br_ans_beneficiario.microdados`
GROUP BY
  tipo_vinculo    