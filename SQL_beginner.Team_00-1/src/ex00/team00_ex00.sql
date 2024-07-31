CREATE TABLE nodes (
    point1 VARCHAR,
    point2 VARCHAR,
    cost NUMERIC
);

INSERT INTO nodes (point1, point2, cost)
VALUES ('a', 'b', 10),
       ('b', 'a', 10),
       ('a', 'c', 15),
       ('c', 'a', 15),
       ('a', 'd', 20),
       ('d', 'a', 20),
       ('b', 'c', 35),
       ('c', 'b', 35),
       ('b', 'd', 25),
       ('d', 'b', 25),
       ('c', 'd', 30),
       ('d', 'c', 30);

-- Общее табличное выражение (CTE) для выполнения рекурсивного поиска пути с минимальной стоимостью
WITH RECURSIVE n AS (
    -- Базовый случай рекурсии: начинаем с узла 'a'
    (
        -- Выбираем начальный узел 'a' как точку отправления
        SELECT point1, point2, cost, 1 AS level,
            ARRAY[point1] AS path, -- Создаем массив, начиная с узла 'a'
            FALSE AS cycle, -- Переменная для проверки наличия циклов
            ARRAY[cost] AS costs -- Массив для сохранения стоимости пути
        FROM nodes
        WHERE point1 = 'a' -- Начинаем с узла 'a'
    )
    UNION ALL
    -- Рекурсивный шаг: добавляем следующий узел к пути, если он не создает цикл
    SELECT nodes.point1, nodes.point2, nodes.cost + n.cost AS cost, n.level + 1 AS level,
        n.path || nodes.point1 AS path, -- Продолжаем путь, добавляя следующий узел к массиву пути
        nodes.point1 = ANY(n.path) AS cycle, -- Проверяем наличие циклов в пути
        n.costs || nodes.cost AS costs -- Добавляем стоимость текущего узла к общей стоимости пути
    FROM nodes
    INNER JOIN n ON n.point2 = nodes.point1 AND NOT cycle -- Присоединяем узел к текущему пути, если он не создает цикл
),
-- CTE для определения минимальной стоимости пути
min_cost AS (
    -- Выбираем минимальную стоимость для путей, которые проходят через узлы 'a', 'b', 'c' и 'd' и возвращаются обратно в начальную точку
    SELECT MIN(cost - costs[5]) AS min_total_cost
    FROM n
    WHERE level = 5
      AND 'a' = ANY(path)
      AND 'b' = ANY(path)
      AND 'c' = ANY(path)
      AND 'd' = ANY(path)
      AND path[1] = path[5] -- Убеждаемся, что путь заканчивается там, где он начался
),
-- CTE для выбора путей с минимальной стоимостью
min_paths AS (
    -- Выбираем пути с минимальной стоимостью, удовлетворяющие нашим условиям
    SELECT
        cost - costs[5] AS total_cost, -- Вычисляем общую стоимость пути
        path AS tour, -- Формируем путь
        ROW_NUMBER() OVER (ORDER BY cost - costs[5], path) AS row_num -- Нумеруем строки в порядке возрастания стоимости и пути
    FROM n
    WHERE level = 5
      AND 'a' = ANY(path)
      AND 'b' = ANY(path)
      AND 'c' = ANY(path)
      AND 'd' = ANY(path)
      AND path[1] = path[5] -- Убеждаемся, что путь заканчивается там, где он начался
)
-- Выводим только уникальные результаты с минимальной стоимостью
SELECT DISTINCT
    total_cost::TEXT, -- Преобразуем стоимость в текст для вывода
    '(' || array_to_string(tour, ',') || ')' AS tour -- Формируем строку пути, разделяя узлы запятыми и обрамляя ее скобками
FROM min_paths
WHERE total_cost = (SELECT min_total_cost FROM min_cost) -- Выбираем только пути с минимальной стоимостью
ORDER BY total_cost, tour; -- Сортируем результаты по стоимости и пути
