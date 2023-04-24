{{ 
    config(
        materialized='view'
    )
}}

SELECT  
    cast(e.CREATED_AT as date) as event_date, --standardize to a specific day
    e.EVENT_ID,
    e.EVENT_TYPE,
    e.ORDER_ID,
    e.PAGE_URL,
    e.PRODUCT_ID,
    e.SESSION_ID,
    e.USER_ID,
    p.NAME, 
    p.PRICE,
    o.PROMO_ID,
    d.DISCOUNT,
    i.QUANTITY
from     {{ref('stg_postgres_events')}} as e
left join {{ ref('stg_postgres_products')}} as p using (PRODUCT_ID)
left join {{ ref('stg_postgres_orders')}} as o using (ORDER_ID)
left join {{ ref('stg_postgres_promos')}} as d using (PROMO_ID)
left join {{ ref('stg_postgres_order_items')}} as i using (ORDER_ID)
