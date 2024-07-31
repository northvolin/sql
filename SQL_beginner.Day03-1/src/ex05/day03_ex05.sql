WITH andrey_visits AS (
    SELECT pv.pizzeria_id
    FROM person_visits pv
    JOIN person p ON pv.person_id = p.id
    WHERE p.name = 'Andrey'
),
andrey_orders AS (
    SELECT m.pizzeria_id
    FROM person_order po
    JOIN menu m ON po.menu_id = m.id
    JOIN person p ON po.person_id = p.id
    WHERE p.name = 'Andrey'
)
SELECT p.name
FROM pizzeria p
JOIN andrey_visits av ON p.id = av.pizzeria_id
LEFT JOIN andrey_orders ao ON p.id = ao.pizzeria_id
WHERE ao.pizzeria_id IS NULL
ORDER BY p.name;
