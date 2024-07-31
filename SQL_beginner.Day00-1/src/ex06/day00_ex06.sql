SELECT
    p.name
        AS
        person_name,
    CASE
        WHEN p.name = 'Denis'
            THEN
                TRUE
        ELSE
            FALSE
    END
        AS
            check_name
FROM
    person p
        JOIN
    person_order po ON p.id = po.person_id
WHERE
    po.menu_id
        IN ('13', '14', '18')
  AND
    po.order_date = '2022-01-07';
