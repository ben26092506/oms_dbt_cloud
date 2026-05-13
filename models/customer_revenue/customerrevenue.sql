{{ config(materialized='table') }}

SELECT
    os.customerid,
    c.fullname AS customername,
    SUM(os.ordercount) AS OrderCount,
    SUM(os.revenue) AS Revenue
FROM
    {{ ref('orders_fact') }} os
JOIN
    {{ ref('customers_stg') }} c ON os.customerid = c.customerid
GROUP BY
    os.customerid,
    c.fullname