{{
    config(
        alias="populacao_instrucao_grupo_idade_sexo_raca_cor",
        schema="br_ibge_censo_2022",
    )
}}

with t1 as (
select
ano,
id_municipio,
variavel_nome,
nivel_de_instrucao_categoria as nivel_instrucao,
grupo_de_idade_categoria as grupo_idade,
sexo_categoria as sexo,
cor_ou_raca_categoria as cor_raca,
valor as pessoas,
from
    `basedosdados-dev.br_ibge_censo_2022_staging.populacao_instrucao_grupo_idade_sexo_raca_cor`
where 
  (nivel_de_instrucao_categoria != 'Total' 
  and grupo_de_idade_categoria != 'Total' 
  and sexo_categoria != 'Total' 
  and cor_ou_raca_categoria != 'Total') and variavel_nome = "Pessoas de 18 anos ou mais de idade"
)

select
safe_cast(ano as int64) as ano,
safe_cast(id_municipio as string) as id_municipio,
safe_cast(nivel_instrucao as string) as nivel_instrucao,
safe_cast(grupo_idade as string) as grupo_idade,
safe_cast(sexo as string) as sexo,
safe_cast(cor_raca as string) as cor_raca,
safe_cast(pessoas as int64) as pessoas,
from t1
