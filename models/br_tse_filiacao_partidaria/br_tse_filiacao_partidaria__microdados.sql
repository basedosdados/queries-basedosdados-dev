{{
    config(
        schema="br_tse_filiacao_partidaria",
        alias="microdados",
        materialized="table",
        cluster_by=["sigla_uf"],
    )
}}

select
    safe_cast(sqregistrofiliacao as string) registro_filiacao,
    safe_cast(sgpartido as string) sigla_partido,
    safe_cast(sigla_uf as string) sigla_uf,
    safe_cast(id_municipio as string) id_municipio,
    safe_cast(codlocalidadetse as string) id_municipio_tse,
    safe_cast(numzona as string) zona,
    safe_cast(numsecao as string) secao,
    safe_cast(nrtituloeleitor as string) titulo_eleitor,
    safe_cast(numcpf as string) cpf,
    safe_cast(nmeleitor as string) nome,
    safe_cast(nmsocialeleitor as string) nome_social,
    safe_cast(tpsexo as string) sexo,
    safe_cast(dessituacaoeleitor as string) situacao_registro,
    safe_cast(cdmotivodesfiliacao as string) id_motivo_desfiliacao,
    safe_cast(cdmotivocancelamento as string) id_motivo_cancelamento,
    safe_cast(indorigem as string) ind_origem,
    safe_cast(dtfiliacao as date) data_filiacao,
    safe_cast(dtdesfiliacao as date) data_desfiliacao,
    safe_cast(tscadastrodesfiliacao as date) data_cadastro_desfiliacao,
    safe_cast(dtcancelamento as date) data_cancelamento,
    safe_cast(dtexclusao as date) data_exclusao,
    safe_cast(data_extracao as date) data_extracao,
from `basedosdados-dev.br_tse_filiacao_partidaria_staging.microdados` as t
