insert into currency values (100, 'EUR', 0.85, '2022-01-01 13:29');
insert into currency values (100, 'EUR', 0.79, '2022-01-08 13:29');

Sure, here is the SQL query with detailed comments:
SQL

-- This query retrieves user balances in USD, considering historical exchange rates.

SELECT
  -- User data with fallback values
  COALESCE(t1.name, 'not defined') AS username,
  COALESCE(t1.lastname, 'not defined') AS lastname,

  -- Currency name
  currency_name,

  -- Balance in USD calculated using historical exchange rates
  money * rate_to_usd AS currency_in_usd

FROM (
  -- Subquery to calculate balance in USD for each user and currency

  SELECT
    -- User data
    u.name AS name,
    u.lastname AS lastname,

    -- Currency name
    c.name AS currency_name,

    -- Original balance amount
    b.money AS money,

    -- Exchange rate to USD (considering historical rates)
    COALESCE(
      -- Rate before balance update
      (SELECT rate_to_usd
       FROM currency c2
       WHERE b.currency_id = c2.id AND c2.updated < b.updated
       ORDER BY c2.updated DESC
       LIMIT 1),

      -- Rate after balance update (if no before-rate found)
      (SELECT rate_to_usd
       FROM currency c2
       WHERE b.currency_id = c2.id AND c2.updated > b.updated
       ORDER BY c2.updated ASC
       LIMIT 1)
    ) AS rate_to_usd

  FROM balance b

  -- Join with currency table for currency name
  INNER JOIN (
    SELECT id, name FROM currency GROUP BY id, name
  ) AS c ON c.id = b.currency_id

  -- Left join with user table for user data (handles missing user)
  LEFT JOIN "user" u ON u.id = b.user_id
) AS t1

-- Order by username (descending), lastname, currency name
ORDER BY username DESC, lastname, currency_name;
