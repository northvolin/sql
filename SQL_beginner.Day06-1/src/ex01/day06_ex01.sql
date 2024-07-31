INSERT INTO person_discounts (id, person_id, pizzeria_id, discount)
SELECT
    ROW_NUMBER() OVER () AS id,
    person_id,
    m.pizzeria_id,
    CASE
        WHEN count(*) = 1 THEN 10.5
        WHEN count(*) = 2 THEN 22
        ELSE 30
    END AS discount
FROM person_order
INNER JOIN menu m ON m.id = person_order.menu_id
GROUP BY person_id, m.pizzeria_id;

insert into person_discounts (id, person_id, pizzeria_id, discount) select row_number()
over () as id, person_id, m.pizzeria_id, case when count(*) = 1 then 10.5 when count(*) = 2
then 22 else 30 end as discount from person_order inner join menu m on m.id = person_order.menu_id group by person_id, m.pizzeria_id;


