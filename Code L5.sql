SELECT
    t.customer_id,
    c.phone,
    t.level_to,
    t.dropin_date
FROM (
    SELECT
        customer_id,
        level_to,
        dropin_date,
        created_at,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY created_at DESC
        ) AS rn
    FROM mkt.customers_progress
    WHERE level_type = 'CVLH'
) t
INNER JOIN mkt.customers c
    ON t.customer_id = c.customer_id
WHERE t.rn = 1
  AND c.status = 'MOL'
  AND t.dropin_date >= '2026-06-01'
  AND t.dropin_date < '2026-07-01';