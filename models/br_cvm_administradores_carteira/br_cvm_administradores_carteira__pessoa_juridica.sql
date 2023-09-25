{{ 
  config(
    alias = 'pessoa_juridica',
    schema='br_cvm_administradores_carteira',
    materialized='incremental',
    partition_by = {
      "field": "data_registro",
      "data_type": "date",
      "granularity": "day"
     },
     pre_hook = "DROP ALL ROW ACCESS POLICIES ON {{ this }}",
    post_hook=['CREATE OR REPLACE ROW ACCESS POLICY allusers_filter 
                    ON {{this}}
                    GRANT TO ("allUsers")
                FILTER USING (DATE_DIFF(DATE("{{ run_started_at.strftime("%Y-%m-%d") }}"),DATE(data_registro), MONTH) > 6)',
              'CREATE OR REPLACE ROW ACCESS POLICY bdpro_filter 
                    ON  {{this}}
                    GRANT TO ("group:bd-pro@basedosdados.org", "group:sudo@basedosdados.org")
                    FILTER USING (DATE_DIFF(DATE("{{ run_started_at.strftime("%Y-%m-%d") }}"),DATE(data_registro), MONTH) <= 6)' ] 
    )
 }}

WITH tabela as(SELECT 
SAFE_CAST(cnpj AS STRING) cnpj,
SAFE_CAST(denominacao_social AS STRING) denominacao_social,
SAFE_CAST(denominacao_comercial AS STRING) denominacao_comercial,
SAFE_CAST(data_registro AS DATE) data_registro,
SAFE_CAST(data_cancelamento AS DATE) data_cancelamento,
SAFE_CAST(motivo_cancelamento AS STRING) motivo_cancelamento,
SAFE_CAST(situacao AS STRING) situacao,
SAFE_CAST(data_inicio_situacao AS DATE) data_inicio_situacao,
SAFE_CAST(categoria_registro AS STRING) categoria_registro,
SAFE_CAST(subcategoria_registro AS STRING) subcategoria_registro,
SAFE_CAST(controle_acionario AS STRING) controle_acionario,
SAFE_CAST(tipo_endereco AS STRING) tipo_endereco,
SAFE_CAST(logradouro AS STRING) logradouro,
SAFE_CAST(complemento AS STRING) complemento,
SAFE_CAST(bairro AS STRING) bairro,
SAFE_CAST(municipio AS STRING) municipio,
SAFE_CAST(sigla_uf AS STRING) sigla_uf,
SAFE_CAST(cep AS STRING) cep,
SAFE_CAST(ddd AS STRING) ddd,
SAFE_CAST(telefone AS STRING) telefone,
SAFE_CAST(valor_patrimonial_liquido AS STRING) valor_patrimonial_liquido,
SAFE_CAST(data_patrimonio_liquido AS DATE) data_patrimonio_liquido,
SAFE_CAST(email AS STRING) email,
SAFE_CAST(website AS STRING) website
FROM basedosdados-dev.br_cvm_administradores_carteira_staging.pessoa_juridica AS t)
select * 
from tabela
{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  -- (uses > to include records whose timestamp occurred since the last run of this model)
  where data_registro > (select max(data_registro) from {{ this }})

{% endif %}