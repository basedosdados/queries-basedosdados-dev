{% macro pns_macro2(column_list) %}
    {% set treated_columns = [] %}

    {% for column in column_list %}
        {% set new_column = (
            "CASE                               WHEN "
            ~ column
            ~ " = '0' THEN '0'                               ELSE LTRIM("
            ~ column
            ~ ", '0')                             END AS "
            ~ column
        ) %}
        {% set treated_columns = treated_columns.append(new_column) %}
    {% endfor %}

    {{ return(treated_columns | join(", ")) }}
{% endmacro %}
