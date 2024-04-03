{{
    config(
        materialized='view'
    )
}}

with trip_data as 
(
  select *,
  row_number() over(partition by driver, date) as rn,
  from {{ source('staging','trip_data_external_table') }}
)

select
    -- identifiers
    {{ dbt_utils.generate_surrogate_key(['driver', 'date']) }} as tripid,
    driver,
    customer,

    -- date
    cast(date as date) as date,

    -- trip info
    {{ dbt.safe_cast("hours", api.Column.translate_type("float")) }} as hours,
    {{ dbt.safe_cast("km", api.Column.translate_type("integer")) }} as km,
    {{ get_trip_type ('km') }} as trip_type,

from trip_data
where rn = 1

-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}