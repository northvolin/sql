CREATE VIEW v_symetric_union AS (
SELECT person_id
FROM person_visits
WHERE visit_date = '2022-01-02'
EXCEPT
SELECT person_id
FROM person_visits
WHERE visit_date = '22022-01-06')
UNION
(SELECT person_id
FROM person_visits
WHERE visit_date = '2022-01-06'
EXCEPT
SELECT person_id
FROM person_visits
WHERE visit_date = '22022-01-02')
ORDER BY 1;


SELECT *
FROM v_symetric_union;