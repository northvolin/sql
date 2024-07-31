SELECT
    p.name AS NAME
FROM
    person p
        JOIN
    person_order po
        ON
    p.id = po.person_id
WHERE
    po.menu_id
        IN
    ('13', '14', '18')
  AND
    po.order_date = '2022-01-07';
