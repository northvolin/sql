SELECT pizzeria.name AS pizzeria_name
FROM person_order
JOIN menu ON person_order.menu_id = menu.id
JOIN pizzeria ON menu.pizzeria_id = pizzeria.id
JOIN person ON person_order.person_id = person.id
GROUP BY pizzeria.name
HAVING (COUNT(CASE WHEN person.gender = 'female' THEN 1 END) > 0 AND COUNT(CASE WHEN person.gender = 'male' THEN 1 END) = 0)
    OR (COUNT(CASE WHEN person.gender = 'female' THEN 1 END) = 0 AND COUNT(CASE WHEN person.gender = 'male' THEN 1 END) > 0)
ORDER BY pizzeria_name;
