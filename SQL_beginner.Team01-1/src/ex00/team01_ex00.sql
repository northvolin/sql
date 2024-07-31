-- Выборка данных из различных таблиц с агрегацией и объединением результатов

SELECT
    -- Выбор имени пользователя. Если имя отсутствует, используется строка 'not defined'.
    COALESCE(u.name, 'not defined') AS name,
    -- Выбор фамилии пользователя. Если фамилия отсутствует, используется строка 'not defined'.
    COALESCE(u.lastname, 'not defined') AS lastname,
    -- Выбор типа баланса.
    t1.type,
    -- Выбор объема денег по заданному типу баланса и валюте.
    t1.volume,
    -- Выбор имени валюты. Если валюта не указана, используется строка 'not defined'.
    COALESCE(c.name, 'not defined') AS currency_name,
    -- Выбор последнего курса обмена для заданной валюты.
    -- Если курс не указан, используется значение 1.
    COALESCE(
        (
            SELECT rate_to_usd
            FROM currency c1
            WHERE c1.id = c.id
                AND c1.updated = c.last_updated
        ),
        1
    ) AS last_rate_to_usd,
    -- Рассчет общего объема денег в долларах для заданной валюты.
    t1.volume::numeric * COALESCE(
        (
            SELECT rate_to_usd
            FROM currency c1
            WHERE c1.id = c.id
                AND c1.updated = c.last_updated
        ),
        1
    ) AS total_volume_in_usd
FROM (
    -- Подзапрос для агрегации суммы денег по типу баланса и валюте.
    SELECT
        b.user_id, -- ID пользователя
        b.type,    -- Тип баланса
        b.currency_id, -- ID валюты
        SUM(b.money) AS volume -- Сумма денег
    FROM
        balance b -- Таблица балансов
    GROUP BY
        b.user_id,     -- Группировка по ID пользователя
        b.type,        -- Группировка по типу баланса
        b.currency_id  -- Группировка по ID валюты
) AS t1
-- Полное соединение с таблицей пользователей по ID пользователя.
FULL JOIN "user" u ON u.id = t1.user_id
-- Полное соединение с подзапросом для получения последних обновленных данных о валюте.
FULL JOIN (
    -- Подзапрос для получения ID, имени и последнего обновленного времени для каждой валюты.
    SELECT
        id, -- ID валюты
        name, -- Имя валюты
        MAX(updated) AS last_updated -- Последнее обновленное время
    FROM
        currency c -- Таблица валют
    GROUP BY
        id, -- Группировка по ID валюты
        name -- Группировка по имени валюты
) AS c ON c.id = t1.currency_id
-- Сортировка результатов по имени пользователя в порядке убывания, а затем по фамилии пользователя и типу баланса в порядке возрастания.
ORDER BY
    name DESC,
    lastname,
    type;
