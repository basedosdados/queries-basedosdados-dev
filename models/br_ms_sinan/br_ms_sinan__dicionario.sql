{{
    config(
        alias="dicionario",
        schema="br_ms_sinan",
    )
}}
select
    safe_cast(id_tabela as string) id_tabela,
    safe_cast(coluna as string) nome_coluna,
    safe_cast(chave as string) chave,
    safe_cast(replace(cobertura_temporal, '-1', '(1)') as string) cobertura_temporal,
    safe_cast(valor as string) valor
from `basedosdados-dev.br_ms_sinan_staging.dicionario` as t
