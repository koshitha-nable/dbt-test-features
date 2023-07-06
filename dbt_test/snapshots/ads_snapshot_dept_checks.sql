{% snapshot ads_snapshot_check_dept %}

{{
        config(
          target_schema='snapshots',
          strategy='check',
          unique_key='id',
          check_cols=['travel_required','location']
        )
}}


select * from {{ source ('src','dept')}}

{% endsnapshot %}