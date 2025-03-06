{{
    config(
        alias="event",
        schema="br_bd_analises",
        materialized="table",
    )
}}
with
    flat_and_filtered_table as (
        select
            user_pseudo_id,
            event_name,
            event_date,
            event_timestamp,
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
                r'https:\/\/basedosdados.org.?\/(\w+)'
            ) as page_type,
            regexp_extract(
                (
                    select (value.string_value)
                    from unnest(event_params)
                    where key = 'page_location'
                ),
                r'.+dataset\/(.{36})'
            ) as dataset_id,
            trim(
                regexp_extract(
                    (
                        select (value.string_value)
                        from unnest(event_params)
                        where key = 'page_title'
                    ),
                    '(.+)– Base dos Dados'
                )
            ) as page_name,
            (
                select value.string_value
                from unnest(event_params)
                where key = 'link_domain'
            ) as link_domain,
            (
                select value.string_value
                from unnest(event_params)
                where key = 'page_location'
            ) as page_url,
            regexp_extract(
                (
                    select (value.string_value)
                    from unnest(event_params)
                    where key = 'page_referrer'
                ),
                r'https:\/\/basedosdados.org.?\/(\w+)'
            ) as page_referrer_type,
            (
                select value.string_value
                from unnest(event_params)
                where key = 'page_referrer'
            ) as page_referrer,
            (
                select value.string_value
                from unnest(event_params)
                where key in ('search_term', 'search')
            ) as search_term,
            (
                select value.string_value
                from unnest(event_params)
                where key in ('user_register')
            ) as user_register,
            (
                select value.string_value
                from unnest(event_params)
                where key = 'session_engaged'
            ) as session_engaged,
            (
                select value.string_value
                from unnest(event_params)
                where key in ('category_click')
            ) as category_click,
            case
                when
                    concat(user_pseudo_id, event_date) in (
                        select distinct concat(user_pseudo_id, event_date)
                        from `basedosdados.analytics_295884852.events_*`
                        where event_name = 'user_login'
                    )
                then true
                else false
            end as logged_user
        from `basedosdados.analytics_295884852.events_*`
        where is_active_user = true
    )

select
    user_pseudo_id,
    event_name,
    parse_date("%Y%m%d", event_date) as event_date,
    event_timestamp,
    session_id,
    session_engaged,
    case
        when regexp_contains(page_url, r'https:\/\/basedosdados.org\/(\w+)\?')
        then 'dataset_search'
        when page_url = 'https://basedosdados.org/dataset'
        then 'dataset_page'
        when
            page_url = 'https://basedosdados.org/'
            or regexp_contains(page_url, r'https:\/\/basedosdados.org\/[\?|)].+')
        then 'home_page'
        else page_type
    end as page_type,
    page_url,
    page_name,
    dataset_id,
    link_domain,
    case
        when regexp_contains(page_referrer, r'https:\/\/basedosdados.org\/(\w+)\?')
        then 'dataset_search'
        when page_referrer = 'https://basedosdados.org/dataset'
        then 'dataset_page'
        when
            page_referrer = 'https://basedosdados.org/'
            or regexp_contains(
                page_referrer, r'https:\/\/basedosdados.org\/\?utm_term.+'
            )
        then 'home_page'
        else page_referrer_type
    end as page_referrer_type,
    page_referrer,
    search_term,
    user_register,
    logged_user,
    category_click
from flat_and_filtered_table
where page_url like "https://basedosdados.org%"
