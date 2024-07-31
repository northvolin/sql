UPDATE menu
SET price = price - price * 0.1
WHERE pizza_name = 'greek pizza';

SELECT (800 - 800 * 0.1) = price AS check
FROM menu
WHERE pizza_name = 'greek pizza';

