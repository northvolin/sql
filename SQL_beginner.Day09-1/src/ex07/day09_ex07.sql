CREATE OR REPLACE FUNCTION func_minimum(arr NUMERIC[])
RETURNS NUMERIC AS $$
    BEGIN
        RETURN (
            SELECT MIN(value)
            FROM UNNEST(arr) AS value
            );
    end;
    $$ LANGUAGE plpgsql;

SELECT func_minimum(VARIADIC arr => ARRAY[10.0, 3.0, -5.0, 4.4]);
