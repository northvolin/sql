SELECT
    po.order_date,
    p.name || ' (age:' || p.age || ')' AS person_information
FROM
    person_order po
NATURAL JOIN
   ( SELECT p.id AS person_id, name, age
     FROM person p ) AS p
ORDER BY
    po.order_date,
    p.name ;
