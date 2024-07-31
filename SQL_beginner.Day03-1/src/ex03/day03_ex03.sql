SELECT pizzeria.name AS pizzeria_name
FROM person_visits
    INNER JOIN pizzeria ON person_visits.pizzeria_id = pizzeria.id
    INNER JOIN person ON person_visits.person_id = person.id
GROUP BY pizzeria.name
HAVING COUNT(CASE WHEN person.gender = 'female' THEN 1 END) != COUNT(CASE WHEN person.gender = 'male' THEN 1 END)
ORDER BY pizzeria_name;
