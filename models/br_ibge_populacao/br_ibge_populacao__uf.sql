{{ config(alias="uf", schema="br_ibge_populacao") }}

select
    safe_cast(sigla_uf as string) sigla_uf,
    safe_cast(ano as int64) ano,
    safe_cast(populacao as int64) populacao
from basedosdados - staging.br_ibge_populacao_staging.uf as t

union all

select sigla_uf, ano, sum(populacao) as populacao
from basedosdados.br_ibge_populacao.municipio
where ano = 2022
group by 1, 2
