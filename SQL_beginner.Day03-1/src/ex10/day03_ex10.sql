INSERT INTO person_order (id, person_id, menu_id, order_date)
VALUES (
    (SELECT MAX(id) + 1 FROM person_order), -- Новый идентификатор заказа
    (SELECT id FROM person WHERE name = 'Denis'), -- Идентификатор Дениса
    (SELECT id FROM menu WHERE pizza_name = 'sicilian pizza'), -- Идентификатор меню "Сицилийская пицца"
    '2022-02-24'
);

INSERT INTO person_order (id, person_id, menu_id, order_date)
VALUES (
    (SELECT MAX(id) + 1 FROM person_order), -- Новый идентификатор заказа
    (SELECT id FROM person WHERE name = 'Irina'), -- Идентификатор Ирины
    (SELECT id FROM menu WHERE pizza_name = 'sicilian pizza'), -- Идентификатор меню "Сицилийская пицца"
    '2022-02-24'
);
