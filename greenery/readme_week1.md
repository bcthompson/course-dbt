Week 1 Answers: 

1>How many users do we have? 130 unique users

2>On average, how many orders do we receive per hour? > 7.68 orders per hour

3>On average, how long does an order take from being placed to being delivered? 3.89 days

4>How many users have only made one purchase? 25 users have made 1 purchase.
    -Two purchases? 28 users have made 2 purchases.
    -Three+ purchases? 71 users have made 3 or more purchases

5>On average, how many unique sessions do we have per hour? 10.14 unique sessions per hours

SQL queries included below for the number associated with each question:

1> select count (distinct user_id)
from stg_postgres_users

2>select count(distinct order_id) / datediff(hour,min(CREATED_AT),max(CREATED_AT)) as orders_per_hour
from stg_postgres_orders

3>select avg(datediff(day,created_at,delivered_at)) as avg_delivery_days
from stg_postgres_orders
where delivered_at is not null

4> WHERE changes to find the three different answers:
select count (user_id)
from (select user_id, count(user_id) as count_user_id from stg_postgres_orders group by user_id)
where count_user_id > 2

5>
select count(distinct session_id) / datediff(hour,min(CREATED_AT),max(CREATED_AT)) as unique_sessions_per_hour
from stg_postgres_events