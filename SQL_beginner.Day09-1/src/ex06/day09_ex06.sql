CREATE OR REPLACE FUNCTION fnc_person_visits_and_eats_on_date(
    pperson VARCHAR DEFAULT 'Dmitriy',
    pprice NUMERIC DEFAULT 500,
    pdate DATE DEFAULT '2022-01-08'
)
RETURNS TABLE (
    pizzeria_name VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT  p.name AS pizzeria_name
    FROM person_visits pv
    INNER JOIN pizzeria p ON pv.pizzeria_id = p.id
    INNER JOIN menu m ON p.id = m.pizzeria_id
    WHERE pv.person_id = (SELECT id FROM person WHERE name = pperson)
    AND pv.visit_date = pdate
    AND m.price < pprice;
END;
$$ LANGUAGE plpgsql;


select *
from fnc_person_visits_and_eats_on_date(pprice := 800);

select *
from fnc_person_visits_and_eats_on_date(pperson := 'Anna',pprice := 1300,pdate := '2022-01-01');
