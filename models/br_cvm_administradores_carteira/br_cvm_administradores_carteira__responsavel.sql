{{ 
  config(
    alias = 'responsavel',
    schema='br_cvm_administradores_carteira',
    materialized='incremental', 
    )
 }}
SELECT 
SAFE_CAST(cnpj AS STRING) cnpj,
SAFE_CAST(nome AS STRING) nome,
SAFE_CAST(tipo AS STRING) tipo
FROM basedosdados-dev.br_cvm_administradores_carteira_staging.responsavel AS t