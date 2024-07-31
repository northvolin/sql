SELECT
    person.name AS person_name,
    pizzeria.name AS pizzeria_name
FROM
    person_visits AS pv
        JOIN
    person ON pv.person_id = person.id
        JOIN
    pizzeria ON pv.pizzeria_id = pizzeria.id
WHERE
    pv.visit_date BETWEEN '2022-01-07' AND '2022-01-09'
ORDER BY
    person_name ASC,
    pizzeria_name DESC;
