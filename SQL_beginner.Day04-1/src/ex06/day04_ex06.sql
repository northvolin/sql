CREATE MATERIALIZED VIEW mv_dmitriy_visits_and_eats AS
SELECT DISTINCT  p.name AS pizzeria_name
FROM person_visits pv
JOIN menu m ON pv.pizzeria_id = m.pizzeria_id
JOIN pizzeria p ON pv.pizzeria_id = p.id
WHERE pv.person_id = (SELECT id FROM person WHERE name = 'Dmitriy')
AND pv.visit_date = '2022-01-08'
AND m.price < 800;


SELECT * FROM mv_dmitriy_visits_and_eats;