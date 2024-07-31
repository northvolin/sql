-- Общее табличное выражение (CTE) для выполнения рекурсивного поиска пути с минимальной стоимостью
WITH RECURSIVE _n AS (
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
    SELECT nodes.point1, nodes.point2, nodes.cost + _n.cost AS cost, _n.level + 1 AS level,
        _n.path || nodes.point1 AS path, -- Продолжаем путь, добавляя следующий узел к массиву пути
        nodes.point1 = ANY (_n.path) AS cycle, -- Проверяем наличие циклов в пути
        _n.costs || nodes.cost AS costs -- Добавляем стоимость текущего узла к общей стоимости пути
    FROM nodes
    INNER JOIN _n ON _n.point2 = nodes.point1 AND NOT cycle -- Присоединяем узел к текущему пути, если он не создает цикл
),
-- CTE для выбора уникальных путей с минимальной стоимостью
min_paths AS (
    -- Выбираем уникальные пути с минимальной стоимостью, удовлетворяющие нашим условиям
    SELECT DISTINCT
        cost - costs[5] AS total_cost, -- Вычисляем общую стоимость пути
        path AS tour -- Формируем путь
    FROM _n
    WHERE level = 5
      AND 'a' = ANY(path) AND 'b' = ANY(path) AND 'c' = ANY(path) AND 'd' = ANY(path) -- Условия прохождения через все узлы
      AND path[1] = path[5] -- Убеждаемся, что путь заканчивается там, где он начался
    ORDER BY total_cost -- Сортируем по общей стоимости пути
)
-- Выводим уникальные пути с минимальной стоимостью
SELECT
    total_cost::TEXT, -- Преобразуем общую стоимость в текст для вывода
    '(' || array_to_string(tour, ',') || ')' AS tour -- Формируем строку пути, разделяя узлы запятыми и обрамляя ее скобками
FROM min_paths; -- Выводим результаты
