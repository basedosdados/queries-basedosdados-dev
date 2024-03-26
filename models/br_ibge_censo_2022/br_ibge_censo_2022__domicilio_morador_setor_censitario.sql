{{ config(alias='domicilio_morador_setor_censitario',schema='br_ibge_censo_2022') }}
select
safe_cast(id_uf as string) id_uf,
safe_cast(id_municipio as string) id_municipio,
safe_cast(id_setor as string) id_setor,
safe_cast(area_setor as float64) area_setor,
safe_cast(id_distrito as string) id_distrito,
safe_cast(id_subdistrito as string) id_subdistrito,
safe_cast(id_microrregiao as string) id_microrregiao,
safe_cast(id_mesorregiao as string) id_mesorregiao,
safe_cast(id_regiao_imediata as string) id_regiao_imediata,
safe_cast(id_regiao_intermediaria as string) id_regiao_intermediaria,
safe_cast(id_concentracao_urbana as string) id_concentracao_urbana,
safe_cast(geometria as geography) geometria,
safe_cast(pessoas as int64) pessoas,
safe_cast(domicilios as int64) domicilios,
safe_cast(domicilios_particulares as int64) domicilios_particulares,
safe_cast(domicilios_coletivos as int64) domicilios_coletivos,
safe_cast(media_moradores_domicilios as float64) media_moradores_domicilios,
safe_cast(porcentagem_domicilios_imputados as float64) porcentagem_domicilios_imputados,
safe_cast(domcilios_particulares_ocupados as int64) domcilios_particulares_ocupados,
from `basedosdados-dev.br_ibge_censo_2022_staging.domicilio_morador_setor_censitario` as t

