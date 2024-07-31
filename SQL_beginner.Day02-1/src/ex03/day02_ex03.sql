WITH g AS (
    SELECT generate_series('2022-01-01'::date, '2022-01-10'::date, interval '1 day') AS g_date
)
SELECT g_date::date AS missing_date
FROM g
LEFT JOIN (
    SELECT DISTINCT visit_date::date
    FROM person_visits
    WHERE person_id IN (1, 2)
) AS po ON g_date::date = po.visit_date
WHERE po.visit_date IS NULL
ORDER BY missing_date;
