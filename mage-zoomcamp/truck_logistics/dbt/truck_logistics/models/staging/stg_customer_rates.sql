{{
    config(
        materialized='view'
    )
}}

select
    -- identifiers
    customer,

    -- rates info
    {{ dbt.safe_cast("hour_city", api.Column.translate_type("float")) }} as hour_city,
    {{ dbt.safe_cast("hour_regular", api.Column.translate_type("float")) }} as hour_regular,
    {{ dbt.safe_cast("hour_hy", api.Column.translate_type("float")) }} as hour_hy,
    {{ dbt.safe_cast("fsc_city", api.Column.translate_type("float")) }} as fsc_city,
    {{ dbt.safe_cast("fsc_regular", api.Column.translate_type("float")) }} as fsc_regular,
    {{ dbt.safe_cast("fsc_hy", api.Column.translate_type("float")) }} as fsc_hy,
    {{ dbt.safe_cast("hy_mileage", api.Column.translate_type("float")) }} as hy_mileage,

from {{ ref('customer_rates') }}