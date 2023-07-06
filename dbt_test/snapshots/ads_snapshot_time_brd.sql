{% snapshot ads_snapshot_time_brd %}

{{
        config(
          target_schema='snapshots',
          unique_key='id',
          strategy='timestamp',
          updated_at='updated_date'
        )
}}


-- select * from {{ source ('src','brd')}}
select * from {{ ref ('stg_test')}}
{% endsnapshot %}