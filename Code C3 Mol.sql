SELECT
    customer_id,
    phone,
    created_at,
    status
FROM mkt.customers
WHERE status = 'MOL'
  AND created_at >= '2026-06-01'
  AND created_at < '2026-07-01';