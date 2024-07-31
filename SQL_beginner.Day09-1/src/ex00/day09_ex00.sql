CREATE TABLE person_audit (
    created TIMESTAMP WITH TIME ZONE DEFAULT  CURRENT_TIMESTAMP NOT NULL ,
    type_event CHAR(1) DEFAULT 'I' NOT NULL,
    row_id BIGINT NOT NULL,
    name VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    gender VARCHAR NOT NULL,
    address VARCHAR(255) NOT NULL

);


ALTER TABLE person_audit ADD CONSTRAINT ch_type_event CHECK (type_event IN ('I', 'U', 'D'));

--Create the trigger function

CREATE OR REPLACE FUNCTION fnc_trg_person_insert_audit()
RETURNS TRIGGER AS $person_audit$
    BEGIN
        IF TG_OP = 'INSERT' THEN
            INSERT INTO person_audit (type_event, row_id, name, age, gender, address)
            VALUES ('I', NEW.id, NEW.name, NEW.age, NEW.gender, NEW.address);

        END IF;
        RETURN NULL;
    END;
    $person_audit$ LANGUAGE plpgsql;

CREATE TRIGGER trg_person_insert_audit
    AFTER INSERT ON person FOR EACH ROW
    EXECUTE FUNCTION fnc_trg_person_insert_audit();

INSERT INTO person(id, name, age,gender, address) VALUES (10, 'Damir', 22, 'male', 'Irkutsk');

SELECT * FROM person_audit