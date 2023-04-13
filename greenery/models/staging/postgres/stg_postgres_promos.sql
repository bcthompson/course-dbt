{{
    config(
        MATERIALIZED='view'
    )
}}

SELECT
    PROMO_ID,
    DISCOUNT,
    STATUS AS PROMO_STATUS
FROM {{ source('postgres', 'PROMOS')}}