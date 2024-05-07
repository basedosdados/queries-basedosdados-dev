{{
    config(
        alias="indigenas_indice_envelhecimento_localizacao_domicilio_municipio",
        schema="br_ibge_censo_2022",
    )
}}
select
    safe_cast(ano as int64) ano,
    safe_cast(id_municipio as string) id_municipio,
    safe_cast(localizacao_domicilio as string) localizacao_domicilio,
    safe_cast(quesito_declaracao_indigena as string) quesito_declaracao_indigena,
    safe_cast(indice_envelhecimento as float64) indice_envelhecimento,
    safe_cast(idade_mediana as int64) idade_mediana,
    safe_cast(razao_sexo as float64) razao_sexo,
from
    `basedosdados-dev.br_ibge_censo_2022_staging.indigenas_indice_envelhecimento_localizacao_domicilio_municipio`
    as t
