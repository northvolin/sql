SELECT t1.name, COALESCE(t1.count, 0) + COALESCE(t2.count, 0) AS total_count
FROM (
    SELECT p.name, COUNT(*) AS count
    FROM person_visits pv
    INNER JOIN pizzeria p ON pv.pizzeria_id = p.id
    GROUP BY p.name
) AS t1
FULL JOIN (
    SELECT p.name, COUNT(*) AS count
    FROM person_order po
    INNER JOIN menu m ON po.menu_id = m.id
    INNER JOIN pizzeria p ON m.pizzeria_id = p.id
    GROUP BY p.name
) AS t2 ON t1.name = t2.name
ORDER BY 2 DESC, 1 ASC;
