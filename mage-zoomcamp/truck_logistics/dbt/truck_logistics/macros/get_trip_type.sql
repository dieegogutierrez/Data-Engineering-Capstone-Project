{#
    This macro returns the type of the trip based on the distance traveled (in kilometers).
#}

{% macro get_trip_type(km) -%}

    CASE 
        WHEN {{ km }} BETWEEN 0 AND 249 THEN 'CITY'
        WHEN {{ km }} BETWEEN 250 AND 499 THEN 'REGULAR'
        WHEN {{ km }} >= 500 THEN 'HIGHWAY'
        ELSE 'EMPTY'
    END

{%- endmacro %}
