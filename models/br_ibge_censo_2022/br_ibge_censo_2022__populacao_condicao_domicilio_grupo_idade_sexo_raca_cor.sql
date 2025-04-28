{{
    config(
        alias="populacao_condicao_domicilio_grupo_idade_sexo_raca_cor",
        schema="br_ibge_censo_2022",
    )
}}


with t1 as (
select
ano,
id_municipio,
variavel_nome,
condicao_no_domicilio_categoria as condicao_domicilio,
grupos_de_idade_da_pessoa_responsavel_pelo_domicilio_categoria as grupo_idade_responsavel_domicilio,
sexo_da_pessoa_responsavel_pelo_domicilio_categoria as sexo_responsavel_domicilio,
cor_ou_raca_da_pessoa_responsavel_pelo_domicilio_categoria as cor_raca_responsavel_domicilio,
valor as pessoas,
from
    `basedosdados-dev.br_ibge_censo_2022_staging.populacao_condicao_domicilio_grupo_idade_sexo_raca_cor`
where 
  (condicao_no_domicilio_categoria != 'Total' 
  and grupos_de_idade_da_pessoa_responsavel_pelo_domicilio_categoria != 'Total' 
  and sexo_da_pessoa_responsavel_pelo_domicilio_categoria != 'Total' 
  and cor_ou_raca_da_pessoa_responsavel_pelo_domicilio_categoria != 'Total') and variavel_nome = "Moradores em domicílios particulares"
)

select
safe_cast(ano as int64) as ano,
safe_cast(id_municipio as string) as id_municipio,
safe_cast(condicao_domicilio as string) as condicao_domicilio,
safe_cast(grupo_idade_responsavel_domicilio as string) as grupo_idade_responsavel_domicilio,
safe_cast(sexo_responsavel_domicilio as string) as sexo_responsavel_domicilio,
safe_cast(cor_raca_responsavel_domicilio as string) as cor_raca_responsavel_domicilio,
safe_cast(pessoas as int64) as pessoas,
from t1

