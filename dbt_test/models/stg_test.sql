
{{ config(

    materialized="table"
) }}


select 
    id,
    port_name,
    state,
    port_code,
    border,
    TO_TIMESTAMP(date::text, 'MM/DD/YYYY') AS updated_date,
    measure
    
from {{ source ('src', 'brd')}}