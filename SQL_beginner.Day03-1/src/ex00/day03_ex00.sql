SELECT pizza_name,
       price,
       p.name AS pizzeria_name,
       pv.visit_date
FROM menu
INNER JOIN pizzeria p ON p.id = menu.pizzeria_id
INNER JOIN person_visits pv ON p.id = pv.pizzeria_id
INNER JOIN person p2 ON pv.person_id = p2.id
WHERE p2.name = 'Kate'
  AND price BETWEEN 800 AND 1000
ORDER BY pizza_name,price, p.name;
