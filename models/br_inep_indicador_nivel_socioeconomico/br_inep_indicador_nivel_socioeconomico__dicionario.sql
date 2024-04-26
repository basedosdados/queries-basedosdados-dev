{{ config(alias="dicionario", schema="br_inep_indicador_nivel_socioeconomico") }}
select
    safe_cast(id_tabela as string) id_tabela,
    safe_cast(coluna as string) nome_coluna,
    safe_cast(chave as string) chave,
    safe_cast(cobertura_temporal as string) cobertura_temporal,
    safe_cast(valor as string) valor,
from `basedosdados-dev.br_inep_indicador_nivel_socioeconomico_staging.dicionario` as t