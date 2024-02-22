{{ config(alias="frente_deputado", schema="br_camara_dados_abertos") }}
select
    safe_cast(id as string) id,
    safe_cast(titulo as string) titulo,
    safe_cast(id_deputado as string) id_deputado,
    initcap(nome_deputado) nome_deputado,
    safe_cast(titulo_deputado as string) titulo_deputado,
    safe_cast(url_foto_deputado as string) url_foto_deputado,
from `basedosdados-dev.br_camara_dados_abertos_staging.frente_deputado` as t
