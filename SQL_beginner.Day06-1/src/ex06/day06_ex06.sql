CREATE SEQUENCE seq_person_discount START 1;

ALTER TABLE person_discounts
ALTER COLUMN id
SET DEFAULT nextval('seq_person_discount');
SELECT setval('seq_person_discount',
              (select count(*)+1
               FROM person_discounts));
