{{
    config(
        materialized='incremental',
        unique_key='date'
    )
}}

select
    date,
    count(distinct product_id) as daily_active_products

from {{ source ('src','ecom')}}


{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  where date >= (select max(date) from {{ this }})

{% endif %}

group by date