SELECT id AS menu_id
FROM menu
WHERE id NOT IN (
    SELECT DISTINCT person_order.menu_id
    FROM person_order
    )
ORDER BY id;