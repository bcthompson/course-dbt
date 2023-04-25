{{
    config(
        MATERIALIZED='view'
    )
}}

SELECT
    EVENT_DATE,
    PAGE_URL,
    PRODUCT_ID,
    NAME,
    count(distinct EVENT_ID) as unique_events,
    sum(CASE WHEN event_type = 'checkout' then 1 else 0 end) as count_checkout,
    sum(CASE WHEN event_type = 'package_shipped' then 1 else 0 end) as count_package_shipped,
    sum(CASE WHEN event_type = 'add_to_cart' then 1 else 0 end) as count_add_cart,
    sum(CASE WHEN event_type = 'page_view' then 1 else 0 end) as count_page_view,
    --case event type for count on each type 
    count(distinct ORDER_ID) AS unique_orders,
    COUNT(DISTINCT SESSION_ID) AS unique_sessions,
    COUNT(DISTINCT USER_ID) as unique_users,
    SUM(PRICE) AS total_price
from {{ref('int_page_views')}}
group by 1,2,3,4