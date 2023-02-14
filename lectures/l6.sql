select *
from payment
where staff_id <> 2;



select *
from payment
where amount between 4 and 7;


select *
from payment
where amount >= 4
  and amount <= 7;

select *
from payment
where amount not between 4 and 7;


select *
from payment
where amount < 4
   or amount > 7;


select *
from payment
where amount between symmetric 7 and 4;



select num_nonnulls(1, 5, 'Hello', null),
       num_nulls(1, 5, 'Hello', null);


select amount,
       customer_id,
       staff_id,
       num_nonnulls(amount, customer_id, staff_id),
       num_nulls(amount, customer_id, staff_id)
from payment
order by amount desc;



select ceil(4.1),
       floor(4.9),
       ceil(-4.1),
       floor(-4.9),
       round(4.5),
       trunc(4.123123),
       trunc(4.12341234, 3);



select ((10.06 - 0.024) / 5) * 2, ((10.06 - 0.024) / 5) * 3;


select random();
select setseed(0.5);



select 'Hello' || ' World';


select last_name || ' ' || first_name
from actor;

select last_name || ' ' || first_name || ' ID: ' || actor_id
from actor;



select char_length(last_name),
       bit_length(last_name),
       octet_length(last_name)
from actor;



select last_name,
       substring(last_name from 2 for 3),
       substr(last_name, 2, 3)
from actor;



select format('The fullname of actor is %s %s', last_name, first_name)
from actor;


select format('INSERT INTO %I VALUES (%L)', 'locations', E'O\'Reilly');



select 'Hello' like 'Hello';


select *
from actor
where last_name like 'C_as_';


select *
from actor
where last_name like '%as%';



select *
from actor
where last_name like 'L_l%d_';



select to_char(-123123.5, 'S999G999D999');



select amount,
       case
           when amount < 2 then 'First range'
           when amount between 3 and 5 then 'Second range'
           else 'Third range'
           end
from payment;



select amount,
       case amount
           when 1.99 then 'First value'
           when 2.99 then 'Second value'
           when 3.99 then 'Third value'
           else 'Other value'
           end
from payment;



select coalesce(null, 2, null, 4);


select amount,
       customer_id,
       staff_id,
       coalesce(amount, customer_id, staff_id)
from payment
order by amount desc;



select greatest(5, 3, 4, 7),
       least(5, 3, 4, 7);


select amount,
       customer_id,
       staff_id,
       greatest(amount, customer_id, staff_id),
       least(amount, customer_id, staff_id)
from payment;



select array [1, 2 ,3];


select unnest(array [1, 2, 3]);


select *
from unnest(array [1, 2, 3], array ['a', 'b']);



select *
from film;
select *
from category
where category_id = 6;
select *
from film_category;


select *
from film f
where exists(select *
             from film_category fc
             where category_id = 6
               and f.film_id = fc.film_id);



select *
from film
where film_id in (select film_id
                  from film_category
                  where category_id = 6);



select *
from film
where film_id > ANY (select film_id
                     from film_category
                     where category_id = 6);



select *
from film
where film_id > ALL (select film_id
                     from film_category
                     where category_id = 6);


select film_id
from film_category
where category_id = 6
order by film_id desc;





