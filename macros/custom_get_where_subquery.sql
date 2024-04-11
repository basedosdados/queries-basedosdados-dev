-- A materilização incremental finaliza antes do teste
-- Supondo que só um ano,mes sera atualizado por vez
-- Preciso de uma macro que selecione o ano mes mais recentes
{% macro get_where_subquery(relation) -%}
    {% set where = config.get("where", "") %}

    {% if where %}
        {% if "__most_recent__" in where %}
            {# Construct a query to find the maximum date using ano and mes columns #}
            {% set max_date_query = (
                "select format_date('%Y-%m', max(date(cast(ano as int64), cast(mes as int64), 1))) as max_date from "
                ~ relation
            ) %}
            {% set max_date_result = run_query(max_date_query) %}

            {% if execute %}
                {% do log(max_date_query, info=True) %}
                {% do log(max_date_result, info=True) %}
                {% do log(max_date_result.rows, info=True) %}
                {% do log(max_date_result.rows[0], info=True) %}
                {% do log(max_date_result.rows[0][0], info=True) %}

                {% if max_date_result and max_date_result.success %}
                    {# Extract the maximum year and month from the max_date #}
                    {% set max_date = max_date_result.rows[0][0] %}
                    {% set max_year = max_date[:4] %}
                    {% set max_month = max_date[5:7] %}

                    {# Replace placeholder in the where config with actual maximum year and month #}
                    {% set where = where | replace(
                        "__most_recent__",
                        "ano = " ~ max_year ~ " and mes = " ~ max_month,
                    ) %}
                {% else %} {% do log("max_date query failed", info=True) %}
                {% endif %}
            {% endif %}
        {% endif %}

        {%- set filtered -%}
            (select * from {{ relation }} where {{ where }}) dbt_subquery
        {%- endset -%}

        {% do return(filtered) %}
    {% else %} {% do return(relation) %}
    {% endif %}
{%- endmacro %}
