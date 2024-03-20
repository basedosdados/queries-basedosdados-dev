{{
    config(
        alias="search_term",
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
    (
        select ep.value.string_value
        from unnest(event_params) as ep
        where key in ('search', 'search_term')
    ) as search_term,
    count(1) as total_search,
from `basedosdados.analytics_295884852.events_*`
where
    event_name in ('search', 'view_search_results')
    and _table_suffix between '20240101' and '20240601'
group by 1, 2, 3, 4
order by total_search desc
