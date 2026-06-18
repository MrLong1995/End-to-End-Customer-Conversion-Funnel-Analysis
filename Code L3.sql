WITH
L3 AS (
    SELECT customer_id, created_at
    FROM (
        SELECT
            customer_id,
            created_at,
            ROW_NUMBER() OVER (
                PARTITION BY customer_id
                ORDER BY created_at ASC
            ) rn
        FROM mkt.customers_progress
        WHERE level_to LIKE '%L3%'
    ) t
    WHERE rn = 1
),

L4 AS (
    SELECT customer_id, created_at
    FROM (
        SELECT
            customer_id,
            created_at,
            ROW_NUMBER() OVER (
                PARTITION BY customer_id
                ORDER BY created_at ASC
            ) rn
        FROM mkt.customers_progress
        WHERE level_to LIKE '%L4%'
    ) t
    WHERE rn = 1
),

L5_1 AS (
    SELECT customer_id, created_at
    FROM (
        SELECT
            customer_id,
            created_at,
            ROW_NUMBER() OVER (
                PARTITION BY customer_id
                ORDER BY created_at ASC
            ) rn
        FROM mkt.customers_progress
        WHERE level_to LIKE '%L5%'
    ) t
    WHERE rn = 1
),

L6_1 AS (
    SELECT customer_id, created_at
    FROM (
        SELECT
            customer_id,
            created_at,
            ROW_NUMBER() OVER (
                PARTITION BY customer_id
                ORDER BY created_at ASC
            ) rn
        FROM mkt.customers_progress
        WHERE level_to LIKE '%L6%'
    ) t
    WHERE rn = 1
),

L8 AS (
    SELECT customer_id, created_at
    FROM (
        SELECT
            customer_id,
            created_at,
            ROW_NUMBER() OVER (
                PARTITION BY customer_id
                ORDER BY created_at ASC
            ) rn
        FROM mkt.customers_progress
        WHERE level_to LIKE '%L7%'
           OR level_to LIKE '%L8%'
    ) t
    WHERE rn = 1
)

SELECT
    c.customer_id,
    c.phone,
    COALESCE(
        l3.created_at,
        l4.created_at,
        l5_1.created_at,
        l6_1.created_at,
        l8.created_at
    ) AS L3_Date
FROM mkt.customers c
LEFT JOIN L3 l3 ON c.customer_id = l3.customer_id
LEFT JOIN L4 l4 ON c.customer_id = l4.customer_id
LEFT JOIN L5_1 l5_1 ON c.customer_id = l5_1.customer_id
LEFT JOIN L6_1 l6_1 ON c.customer_id = l6_1.customer_id
LEFT JOIN L8 l8 ON c.customer_id = l8.customer_id
WHERE c.status = 'MOL'
  AND COALESCE(
        l3.created_at,
        l4.created_at,
        l5_1.created_at,
        l6_1.created_at,
        l8.created_at
      ) >= '2026-06-01'
  AND COALESCE(
        l3.created_at,
        l4.created_at,
        l5_1.created_at,
        l6_1.created_at,
        l8.created_at
      ) < '2026-07-01';