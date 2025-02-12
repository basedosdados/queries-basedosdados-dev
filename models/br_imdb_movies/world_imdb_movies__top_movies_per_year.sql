{{
    config(
        alias="top_movies_per_year", schema="world_imdb_movies", materialized="table"
    )
}}
select
    safe_cast(id_movie as string) id_movie,
    safe_cast(title as string) title,
    safe_cast(link_movie as string) link_movie,
    safe_cast(year as int64) year,
    safe_cast(duration as string) duration,
    safe_cast(rating_mpa as string) rating_mpa,
    safe_cast(rating_imdb as float64) rating_imdb,
    safe_cast(vote as string) vote,
    safe_cast(budget as float64) budget,
    safe_cast(gross_world_wide as float64) gross_world_wide,
    safe_cast(eua_canada_gross as float64) eua_canada_gross,
    safe_cast(opening_weekend_gross as float64) opening_weekend_gross,
    safe_cast(director as string) director,
    safe_cast(writer as string) writer,
    safe_cast(star as string) star,
    safe_cast(genre as string) genre,
    safe_cast(country_origin as string) country_origin,
    safe_cast(filming_location as string) filming_location,
    safe_cast(production_companie as string) production_companie,
    safe_cast(language as string) language,
    safe_cast(win as int64) win,
    safe_cast(nomination as int64) nomination,
    safe_cast(oscars as int64) oscars,
from `basedosdados-dev.world_imdb_movies_staging.top_movies_per_year` as t
