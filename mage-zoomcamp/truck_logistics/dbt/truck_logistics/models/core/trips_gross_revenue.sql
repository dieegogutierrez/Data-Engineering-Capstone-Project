{{
    config(
        materialized='table',
    )
}}

with trip_data as (
    select *, 
    from {{ ref('stg_trip_data') }}
), 
customer_rates as (
    select *, 
    from {{ ref('stg_customer_rates') }}
)
select
    trip_data.tripid,
    trip_data.date,
    trip_data.driver,
    trip_data.customer,
    trip_data.hours,
    trip_data.km,
    trip_data.trip_type,
    ROUND({{ calculate_revenue('trip_data.trip_type', 'trip_data.km', 'trip_data.hours', 'customer_rates.hour_city', 'customer_rates.hour_regular', 'customer_rates.hour_hy', 'customer_rates.fsc_city', 'customer_rates.fsc_regular', 'customer_rates.fsc_hy', 'customer_rates.hy_mileage') }}, 2) as total_gross_revenue
from trip_data
left join customer_rates on trip_data.customer = customer_rates.customer

-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}