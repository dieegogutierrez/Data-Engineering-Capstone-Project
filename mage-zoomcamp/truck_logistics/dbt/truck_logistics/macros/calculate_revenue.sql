{#
    This macro returns the revenue of each trip according to customer and trip type.
#}

{% macro calculate_revenue(trip_type, km, hours, hour_city, hour_regular, hour_hy, fsc_city, fsc_regular, fsc_hy, hy_mileage) -%}

    CASE 
        WHEN {{ trip_type }} = 'CITY' THEN ({{ km }} * {{ fsc_city }}) + ({{ hours }} * {{ hour_city }})
        WHEN {{ trip_type }} = 'REGULAR' THEN ({{ km }} * {{ fsc_regular }}) + ({{ hours }} * {{ hour_regular }})
        WHEN {{ trip_type }} = 'HIGHWAY' THEN ({{ km }} * {{ fsc_hy }}) + ({{ var('hours_on_stops_hy_trip') }} * {{ hour_hy }}) + ({{ km }} * {{ var('km_to_mileage_converter') }} * {{ hy_mileage }})
        ELSE 0
    END

{%- endmacro %}
