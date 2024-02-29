{{ config(alias='organizacao',schema='br_cgu_dados_abertos') }}
select
    safe_cast(nullif(o.id, "") as string) id,
    safe_cast(nullif(o.titulo, "") as string) nome,
    safe_cast(nullif(o.nome, "") as string) nome_tokenizado,
    safe_cast(nullif(o.descricao, "") as string) descricao,
    case 
        when o.organizationEsfera = "1" then "Federal"
        when o.organizationEsfera = "2" then "Estadual/Distrital"
        when o.organizationEsfera = "3" then "Municipal"
        else null
    end tipo_esfera_administrativa,
    safe_cast(nullif(o.organizationUf, "") as string) sigla_uf,
    safe_cast(m.id_municipio as string) id_municipio,
    safe_cast(o.qtdSeguidores as int64) quantidade_seguidores,
    safe_cast(o.qtdConjuntoDeDados as int64) quantidade_conjuntos
from `basedosdados-dev.br_cgu_dados_abertos_staging.organizacao` AS o
left join `basedosdados.br_bd_diretorios_brasil.municipio` AS m
    on o.organizationUf = m.sigla_uf and o.organizationMunicipio = m.nome