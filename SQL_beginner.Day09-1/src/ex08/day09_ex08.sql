CREATE OR REPLACE FUNCTION fnc_fibonacci(pstop INTEGER DEFAULT 10)
RETURNS TABLE (fibonacci INTEGER) AS $$
DECLARE
             fib1 INTEGER := 0;
             fib2 INTEGER := 1;
             temp INTEGER;
BEGIN
    IF pstop >= 0 THEN
             fibonacci := fib1;
             RETURN NEXT;
    END IF;
    fibonacci := fib2;
    RETURN NEXT;

    WHILE fib2 < pstop LOOP
             temp := fib2;
             fib2 := fib1 + fib2;
             fib1 := temp;
             fibonacci := fib2;
             RETURN NEXT;
        END LOOP;
    END;
    $$ LANGUAGE plpgsql;

select * from fnc_fibonacci(100);
select * from fnc_fibonacci();
