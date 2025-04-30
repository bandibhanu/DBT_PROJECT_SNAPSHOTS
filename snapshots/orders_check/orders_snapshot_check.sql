{% snapshot orders_hist_check %}
{{
    config(
        target_schema='DBT_HIST',
        unique_key='order_id',
        strategy='check',
        check_cols=[
            'order_id',
            'order_date',
            'amount',
            'order_status'
        ]

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
