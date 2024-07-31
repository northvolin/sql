SELECT m.pizza_name,
       p.name AS pizzeria_name
FROM menu m
INNER JOIN pizzeria p ON m.pizzeria_id = p.id
INNER JOIN person_order po ON m.id = po.menu_id
INNER JOIN person pe ON po.person_id = pe.id
WHERE pe.name IN ('Denis', 'Anna')
GROUP BY m.pizza_name, p.name;