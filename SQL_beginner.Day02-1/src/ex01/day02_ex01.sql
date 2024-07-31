SELECT missing_date::date
FROM generate_series('2022-01-01'::date, '2022-01-10'::date, '1 day')
AS missing_date
LEFT JOIN person_visits
ON missing_date::date = person_visits.visit_date
AND person_id IN (1, 2)
WHERE person_visits.visit_date IS NULL
ORDER BY missing_date::date;
