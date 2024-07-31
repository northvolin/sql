CREATE TABLE person_discounts(
id BIGINT primary key,
person_id BIGINT NOT NULL,
pizzeria_id BIGINT NOT NULL,
discount NUMERIC NOT NULL,
constraint fk_personal_discount_person_id foreign key (person_id) references person(id),
constraint fk_menu_pizzeria_id foreign key (pizzeria_id) references pizzeria(id))
;
