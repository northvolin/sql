SELECT
    po.order_date AS action_date,
    (SELECT name FROM person WHERE id = po.person_id) AS person_name
FROM
    person_order po
INTERSECT ALL
SELECT
    pv.visit_date AS action_date,
    (SELECT name FROM person WHERE id = pv.person_id) AS person_name
FROM
    person_visits pv
ORDER BY
    action_date ASC,
    person_name DESC;
