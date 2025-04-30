{% snapshot orders_hist_timestamp %}
{{
    config(
        target_schema='DBT_HIST',
        unique_key='order_id',
        strategy='timestamp',
        updated_at='UPDATED_AT'

    )
}}

select
order_id,
order_date,
amount,
order_status,
updated_at
from 
{{ref('stg_orders')}}

{% endsnapshot %}
