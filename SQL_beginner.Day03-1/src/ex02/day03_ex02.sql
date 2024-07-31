SELECT m.pizza_name,
       m.price,
       p.name AS pizzeria_name
FROM menu m
JOIN pizzeria p ON m.pizzeria_id = p.id
WHERE m.id NOT IN(
    SELECT DISTINCT menu_id
    FROM person_order
    )
ORDER BY m.pizza_name, m.price;