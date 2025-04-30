{{
    config(
        materialized='ephemeral'
    )
}}

with source_data as (
    select 
        order_id,
        order_date,
        amount, 
        order_status,
        to_timestamp(updated_at) as UPDATED_AT
        from 
            {{source('snowflake_source','orders')}}
)

select * from source_data