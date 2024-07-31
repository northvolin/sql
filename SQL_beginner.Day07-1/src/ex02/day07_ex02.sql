-- (SELECT p.name, COUNT(*) AS count, 'visit' AS action_type
-- FROM person_visits
-- INNER JOIN pizzeria p ON p.id = person_visits.pizzeria_id
-- GROUP BY p.name
-- ORDER BY 2 DESC
-- LIMIT 3)
-- UNION
-- (SELECT p.name, COUNT(*) AS count, 'order' AS action_type
-- FROM person_order
-- INNER JOIN menu m ON person_order.menu_id = m.id INNER JOIN pizzeria p on m.pizzeria_id = p.id
-- GROUP BY p.name
-- ORDER BY 2 DESC
-- LIMIT 3)
-- ORDER BY 3,2 DESC;

(select p.name, count(*) as "count", 'visit' as action_type
      from person_visits inner join pizzeria p on p.id = person_visits.pizzeria_id
      group by p.name
      order by 2 desc
      limit 3)
      union
      (select p.name, count(*) as "count", 'order' as action_type
      from person_order inner join menu m on person_order.menu_id = m.id
          inner join pizzeria p on m.pizzeria_id = p.id
      group by p.name
      order by 2 desc
      limit 3)
      order by 3,2 desc