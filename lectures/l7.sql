select *
from pg_constraint;


alter table film
    drop constraint film_check1;


alter table film
    add constraint film_check check (rental_rate > 0);

select *
from film;
insert into film (title, description, release_year, language_id, rental_duration, rental_rate, length,
                  replacement_cost, rating, last_update, special_features, fulltext, disconted_rental_rate)
    (select title,
            description,
            release_year,
            language_id,
            rental_duration,
            0,
            length,
            replacement_cost,
            rating,
            last_update,
            special_features,
            fulltext,
            disconted_rental_rate
     from film
     where film_id = 98);



alter table film
    drop column disconted_rental_rate;


alter table film
    add column disconted_rental_rate float check ( rental_rate > disconted_rental_rate );


update film
set disconted_rental_rate=rental_rate * 0.80
where film_id = 98;

select *
from film
where film_id = 98;



alter table film
    alter column fulltext drop not null;

alter table film
    alter column fulltext set not null;



create table order_items
(
    product_id integer references product on delete set default on update cascade
)



select *
from film;
select *
from language;

select *
from film
         cross join language;


select *
from film
         inner join language on true;


select *
from film,
     language;



select *
from film f
         inner join language l on f.language_id = l.language_id and f.other_id = l.other_id;



select *
from film f
         inner join language l using (language_id, other_id);



select *
from film
         natural join language;



select *
from employees e
         left join departments d on e.department_id = d.department_id;


select *
from employees e
         left join departments d using (department_id);


select *
from employees e
         natural left join departments d;



select *
from employees e
         right join departments d on e.department_id = d.department_id;


select *
from employees e
         full join departments d on e.department_id = d.department_id;



select *
from film f
         inner join language l on f.language_id = l.language_id and l.name != 'English';


select *
from film f
         inner join language l on f.language_id = l.language_id
where l.name != 'English'



select *
from employees e
         left join departments d on e.department_id = d.department_id and d.department_id < 3;


select *
from employees e
         left join departments d on e.department_id = d.department_id
where d.department_id < 3;


select *
from employees e
         right join departments d on e.department_id = d.department_id and d.department_id < 3;



select *
from payment p
         join customer c on p.customer_id = c.customer_id
         join staff s on p.staff_id = s.staff_id
         join rental r on p.rental_id = r.rental_id;


