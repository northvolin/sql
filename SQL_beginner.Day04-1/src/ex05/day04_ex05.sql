CREATE VIEW v_price_with_discount AS
SELECT
    p.name AS name,
    m.pizza_name AS pizza_name,
    m.price AS price,
    ROUND(m.price -(m.price*0.1)):: INTEGER AS discount_price
FROM person p
JOIN person_order po ON p.id = po.person_id
JOIN menu m ON po.menu_id = m.id
ORDER BY name, pizza_name;


SELECT * FROM v_price_with_discount;