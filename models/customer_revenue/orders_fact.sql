{{ config(materialized='table') }}

SELECT
    o.orderid,
    o.orderdate,
    o.customerid,
    o.employeeid,
    o.storeid,
    o.statuscd,
    o.statusdesc,
    COUNT(DISTINCT o.orderid) AS OrderCount,
    SUM(oi.totalprice) As Revenue,
    o.updated_at
FROM
    {{ ref('orders_stg') }} o
JOIN
    {{ ref('orderitems_stg') }} oi ON o.orderid = oi.orderid
GROUP BY
    o.orderid,
    o.orderdate,
    o.customerid,
    o.employeeid,
    o.storeid,
    o.statuscd,
    o.statusdesc,
    o.updated_at