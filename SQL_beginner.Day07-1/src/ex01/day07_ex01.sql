SELECT p.name, COUNT(*) AS count_of_visits

FROM person_visits
INNER JOIN person p ON p.id = person_visits.person_id
GROUP BY p.name
ORDER BY 2 DESC, 1 ASC
LIMIT 4;