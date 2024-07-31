SELECT
    DISTINCT p.name
FROM person p
JOIN person_order po ON p.id = po.person_id
JOIN menu m ON po.menu_id = m.id
JOIN pizzeria pz ON m.pizzeria_id = pz.id
WHERE p.gender = 'female'
AND m.pizza_name IN ('cheese pizza', 'pepperoni pizza')
GROUP BY p.name
HAVING COUNT(DISTINCT CASE WHEN m.pizza_name = 'cheese pizza' THEN m.id END) > 0
AND COUNT(DISTINCT CASE WHEN m.pizza_name = 'pepperoni pizza' THEN m.id END) > 0
ORDER BY p.name;
