{{
    config(
        alias="domicilio_morador_setor_censitario",
        schema="br_ibge_censo_2022",
        cluster_by=["id_uf", "id_municipio"],
    )
}}
select
    safe_cast(cd_uf as string) id_uf,
    safe_cast(cd_mun as string) id_municipio,
    safe_cast(cd_setor as string) id_setor,
    safe_cast(area_km2 as float64) area_setor,
    safe_cast(cd_dist as string) id_distrito,
    safe_cast(cd_subdist as string) id_subdistrito,
    safe_cast(cd_micro as string) id_microrregiao,
    safe_cast(cd_meso as string) id_mesorregiao,
    safe_cast(cd_rgi as string) id_regiao_imediata,
    safe_cast(cd_rgint as string) id_regiao_intermediaria,
    safe_cast(cd_concurb as string) id_concentracao_urbana,
    safe_cast(
        st_geogfromwkb(geometry, planar => true, make_valid => true) as geography
    ) geometria,
    safe_cast(v0001 as int64) pessoas,
    safe_cast(v0002 as int64) domicilios,
    safe_cast(v0003 as int64) domicilios_particulares,
    safe_cast(v0004 as int64) domicilios_coletivos,
    safe_cast(v0005 as float64) media_moradores_domicilios,
    safe_cast(v0006 as float64) porcentagem_domicilios_imputados,
    safe_cast(v0007 as int64) domcilios_particulares_ocupados,
from
    `basedosdados-dev.br_ibge_censo_2022_staging.domicilio_morador_setor_censitario`
    as t
