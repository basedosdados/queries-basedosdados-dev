{% macro pns_macro(column_list) %}
    {% set treated_columns = [] %}

    {% for column in column_list %}
        {% set new_column = (
            "CASE                               WHEN "
            ~ column
            ~ " = '1' THEN 'sim'                               WHEN "
            ~ column
            ~ " = '2' THEN 'não'                               ELSE COALESCE(NULLIF(TRIM("
            ~ column
            ~ "), ''), 'Não informado')                             END AS "
            ~ column
        ) %}
        {% set treated_columns = treated_columns.append(new_column) %}
    {% endfor %}

    {{ return(treated_columns | join(", ")) }}
{% endmacro %}
