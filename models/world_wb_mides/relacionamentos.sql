select
    safe_cast(ano as int64) ano,
    safe_cast(sigla_uf as string) sigla_uf,
    safe_cast(id_empenho as string) id_empenho,
    safe_cast(id_licitacao as string) id_licitacao,
    safe_cast(id_municipio as string) id_municipio
from `basedosdados-staging.world_wb_mides_staging.relacionamentos` as t
