{{ config(alias="dicionario", schema="br_ibge_pof") }}
select
    safe_cast(id_tabela as string) id_tabela,
    safe_cast(nome_coluna as string) nome_coluna,
    safe_cast(chave as string) chave,
    safe_cast(cobertura_temporal as string) cobertura_temporal,
    safe_cast(valor as string) valor,
from `basedosdados-dev.br_ibge_pof_staging.dicionario` as t
