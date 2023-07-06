{{ config(

    materialized="table"
) }}

with select_students as (
    select 
        id,
        student_name,
        {{ dbt_privacy.mask("student_name") }} as default_mask,
        {{ dbt_privacy.mask("student_name", mask_char="/") }} as slash_mask,
        {{ dbt_privacy.mask("student_name", keep_n=4) }} as keep_4_mask,
        {{ dbt_privacy.mask("student_name", keep_n=6, keep_dir="left") }} as keep_6_left_mask,
        {{ dbt_privacy.mask("student_name") }} as null_mask,
        email,
        {{ dbt_privacy.mask("email") }} as default_mask_email,
        {{ dbt_privacy.safe_mask("email",keep_n=4) }} as email_safe_mask,
        {{ dbt_privacy.mask("email", mask_char="/") }} as slash_mask_email,
        {{ dbt_privacy.mask("email", keep_n=4) }} as keep_4_maskEmail,
        {{ dbt_privacy.mask("email", keep_n=6, keep_dir="left") }} as keep_6_left_mask_email,
        {{ dbt_privacy.mask_email("email") }} as default_mask_e,
        {{ dbt_privacy.mask_email("email", mask_char="/", n=2) }} as slash_2_mask,
        {{ dbt_privacy.mask_email("email", domain_n=20) }} as domain_n_20,
        {{ dbt_privacy.mask_email("email", domain_n=2, lowercase=False) }} as domain_n_20_case_sensitive,
        {{ dbt_privacy.hash("district", salt_expr="id") }},
        {{ dbt_privacy.hash_unique("district",salt_expr="id") }},
        {{ dbt_privacy.redact_unique("email") }} as redact_email
    from {{source('src','student')}}
    )

    select * from select_students