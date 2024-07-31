CREATE view v_persons_female AS
    SELECT *
FROM person
WHERE gender = 'female';

CREATE view v_persons_male AS
    SELECT *
FROM person
WHERE gender = 'male';


select *
      from v_persons_female
      order by 1