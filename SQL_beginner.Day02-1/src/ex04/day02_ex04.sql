SELECT
    menu.pizza_name AS pizza_name,
    pizzeria.name AS pizzeria_name,
    menu.price
FROM menu
INNER JOIN pizzeria
ON menu.pizzeria_id = pizzeria.id
WHERE menu.pizza_name
IN ('mushroom pizza', 'pepperoni pizza')
ORDER BY menu.pizza_name, pizzeria.name;
