--Session1

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

BEGIN;

SELECT * FROM pizzeria WHERE name = 'Pizza Hut';


UPDATE pizzeria SET rating = 4 WHERE name = 'Pizza Hut';

COMMIT;

SELECT * FROM pizzeria where name = 'Pizza Hut';

--Session2


SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

BEGIN;

SELECT * FROM pizzeria WHERE name = 'Pizza Hut';


UPDATE pizzeria SET rating = 3.6 WHERE name = 'Pizza Hut';

COMMIT;

SELECT * FROM pizzeria WHERE name = 'Pizza Hut';



