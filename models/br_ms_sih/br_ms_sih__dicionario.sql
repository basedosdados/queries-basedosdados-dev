{{ config(alias="dicionario", schema="br_ms_sih") }}
select
    safe_cast(id_tabela as string) id_tabela,
    safe_cast(nome_coluna as string) nome_coluna,
    safe_cast(chave as int64) chave,
    safe_cast(cobertura_temporal as string) cobertura_temporal,
    safe_cast(valor as string) valor
from `basedosdados-dev.br_ms_sih_staging.dicionario`
