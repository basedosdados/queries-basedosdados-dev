select
    safe_cast(ano as int64) ano,
    safe_cast(mes as int64) mes,
    safe_cast(id_cisp as string) id_cisp,
    safe_cast(
        quantidade_policial_militar_morto_servico as int64
    ) quantidade_policial_militar_morto_servico,
    safe_cast(
        quantidade_policial_civil_morto_servico as int64
    ) quantidade_policial_civil_morto_servico
from
    `basedosdados-dev.br_rj_isp_estatisticas_seguranca_staging.evolucao_policial_morto_servico_mensal`
    as t
