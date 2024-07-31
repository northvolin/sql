SELECT object_name
FROM (
    SELECT name AS object_name, 'person' AS source
    FROM person
    UNION ALL
    SELECT pizza_name AS object_name, 'menu' AS source
    FROM menu
) AS combined_data
ORDER BY CASE
    WHEN source = 'menu' THEN 2
    ELSE 1
  END,
  object_name;
