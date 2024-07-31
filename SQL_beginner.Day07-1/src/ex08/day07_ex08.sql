SELECT address, p.name, COUNT(*)
FROM person_order po
INNER JOIN menu m ON po.menu_id = m.id
INNER JOIN pizzeria p ON m.pizzeria_id = p.id
JOIN person pa ON po.person_id = pa.id
GROUP BY address, p.name
ORDER BY 1,2;
