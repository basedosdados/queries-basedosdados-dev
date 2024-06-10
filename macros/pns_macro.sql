{% macro pns_macro(column_list, table_id) %}
    {% set treated_columns = [] %}

    {% for column in column_list %}
        {% if table_id == "microdados_2013" %}
            {% set new_column = (
                "CASE WHEN "
                ~ column
                ~ " = '1' THEN 'sim' "
                ~ "WHEN "
                ~ column
                ~ " = '2' THEN 'não' "
                ~ "ELSE COALESCE(NULLIF(TRIM("
                ~ column
                ~ "), ''), 'Não informado') "
                ~ "END AS "
                ~ column
            ) %}
        {% elif table_id == "microdados_2019" %}
            {% set new_column = (
                "CASE WHEN "
                ~ column
                ~ " = '1' THEN 'sim' "
                ~ "WHEN "
                ~ column
                ~ " = '2' THEN 'não' "
                ~ "WHEN "
                ~ column
                ~ " = '9' THEN 'ignorado' "
                ~ "WHEN "
                ~ column
                ~ " = '' THEN 'não aplicável' "
                ~ "ELSE COALESCE(NULLIF(TRIM("
                ~ column
                ~ "), ''), 'Não informado') "
                ~ "END AS "
                ~ column
            ) %}
        {% endif %}
        {% set treated_columns = treated_columns.append(new_column) %}
    {% endfor %}

    {{ return(treated_columns | join(", ")) }}
{% endmacro %}
