{{ config(alias="orgao_deputado", schema="br_camara_dados_abertos") }}
select distinct
    regexp_extract(uriorgao, r'/orgaos/(\d+)') as id_orgao,
    safe_cast(nomeorgao as string) nome,
    safe_cast(siglaorgao as string) sigla,
    safe_cast(nomedeputado as string) nome_deputado,
    safe_cast(cargo as string) cargo,
    safe_cast(siglauf as string) sigla_uf,
    safe_cast(datainicio as date) data_inicio,
    safe_cast(datafim as date) data_final,
    safe_cast(siglapartido as string) sigla_partido,
from `basedosdados-dev.br_camara_dados_abertos_staging.orgao_deputado` as t
