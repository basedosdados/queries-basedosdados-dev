with main as (
  select lpad(id_vendor, 12, '0') as vendedor_id,
  dia,
  nome,
  SAFE_CAST(experiencia AS INT64) experiencia,
  reputacao,
  case
  when classificacao='None' then null
  else classificacao end as classificacao,
  id_municipio,
  from `basedosdados-dev.br_mercadolivre_ofertas_staging.vendedor`
),

predata as (
  select
    lpad(id_vendor, 12, '0') as vendedor_id,
    struct(
    json_extract_scalar(opinioes, '$.Bom') as Bom,
    json_extract_scalar(opinioes, '$.Regular') as Regular,
    json_extract_scalar(opinioes, '$.Ruim') as Ruim
  ) as opinioes
  from `basedosdados-dev.br_mercadolivre_ofertas_staging.vendedor`
)

select 
  dia,
  main.vendedor_id,
  nome,
  experiencia,
  reputacao,
  classificacao,
  id_municipio,
  predata.opinioes as opinioes,
from main
left join predata 
on main.vendedor_id=predata.vendedor_id

