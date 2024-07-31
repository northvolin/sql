INSERT INTO menu (id, pizzeria_id, pizza_name, price)
VALUES (
    (SELECT MAX(id) + 1 FROM menu), -- новый идентификатор пиццы
    (SELECT id FROM pizzeria WHERE name = 'Dominos'), -- идентификатор пиццерии "Dominos"
    'sicilian pizza', -- название новой пиццы
    900 -- цена новой пиццы
);
