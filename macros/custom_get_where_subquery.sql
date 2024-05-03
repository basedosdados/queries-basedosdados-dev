-- This macro is used to get a subquery with a where clause that can be used in a test
-- to filter the data to be tested. The macro looks for a where clause in the model's
-- config (schema.yml) and replaces the placeholder "__most_recent_year_month__" with
-- the maximum
-- year and month found in the relation. The macro returns a subquery with the where
-- thats used
-- to filter the data to be tested
{% macro get_where_subquery(relation) %}
    {% set where = config.get("where", "") %}

    {% if where %}
        {% set max_year_query = "" %}
        {% set max_date_query = "" %}
        {% set max_year = "" %}
        {% set max_date = "" %}

        {# This block looks for __most_recent_year__  placeholder #}
        {% if "__most_recent_year__" in where %}
            {% set max_year_query = (
                "select max(cast(ano as int64)) as max_year from " ~ relation
            ) %}
            {% set max_year_result = run_query(max_year_query) %}
            {% if execute and max_year_result.rows[0][0] %}
                {% set max_year = max_year_result.rows[0][0] %}
                {% set where = where | replace(
                    "__most_recent_year__", "ano = '" ~ max_year ~ "'"
                ) %}
                {% do log(
                    "The test will filter by the most recent year: "
                    ~ max_year,
                    info=True,
                ) %}
            {% endif %}
        {% endif %}

        {# This block looks for __most_recent_date__  placeholder #}
        {% if "__most_recent_date__" in where %}
            {% set max_date_query = "select max(data) as max_date from " ~ relation %}
            {% set max_date_result = run_query(max_date_query) %}
            {% if execute and max_date_result.rows[0][0] %}
                {% set max_date = max_date_result.rows[0][0] %}
                {% set where = where | replace(
                    "__most_recent_date__", "data = '" ~ max_date ~ "'"
                ) %}
                {% do log(
                    "The test will filter by the most recent date: "
                    ~ max_date,
                    info=True,
                ) %}
            {% endif %}
        {% endif %}

        {# This block looks for __most_recent_year_month__  placeholder #}
        {% if "__most_recent_year_month__" in where %}
            {% set max_date_query = (
                "select format('%Y-%m', max(date(cast(ano as int64), cast(mes as int64), 1))) as max_date from "
                ~ relation
            ) %}
            {% set max_date_result = run_query(max_date_query) %}
            {% if execute and max_date_result.rows[0][0] %}
                {% set max_date = max_date_result.rows[0][0] %}
                {% set where = where | replace(
                    "__most_recent_year_month__",
                    "ano = '"
                    ~ max_date[:4]
                    ~ "' and mes = '"
                    ~ max_date[5:7]
                    ~ "'",
                ) %}
                {% do log(
                    "The test will filter by the most recent year and month: "
                    ~ max_date,
                    info=True,
                ) %}
            {% endif %}
        {% endif %}

        {# Return the filtered subquery #}
        {% set filtered = (
            "(select * from "
            ~ relation
            ~ " where "
            ~ where
            ~ ") dbt_subquery"
        ) %}
        {% do return(filtered) %}
    {% else %} {% do return(relation) %}
    {% endif %}
{% endmacro %}
