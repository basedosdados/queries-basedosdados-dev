{{
    config(
        alias="page_views",
        schema="br_bd_analises",
        materialized="table",
    )
}}

select
    user_pseudo_id,
    event_date,
    (
        select ep.value.int_value
        from unnest(event_params) as ep
        where key = 'ga_session_id'
    ) as session_id,
    regexp_extract(
        (
            select (value.string_value)
            from unnest(event_params)
            where key = 'page_location'
        ),
        r'https:\/\/basedosdados.org\/(\w+)'
    ) as page_type,
    regexp_extract(
        (
            select (value.string_value)
            from unnest(event_params)
            where key = 'page_location'
        ),
        '.+dataset/(.+)\\?.+'
    ) as dataset_id,
    (
        select (value.string_value)
        from unnest(event_params)
        where key = 'page_location'
    ) as page_url,
from `basedosdados.analytics_295884852.events_*`
where _table_suffix between '20240101' and '20240601' and is_active_user = true
