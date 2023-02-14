drop view vista;


create view vista as
select 'Hello world';


select *
from vista;



create or replace view vista2 as
select f.*, a.actor_id, a.last_name, a.first_name
from film f
         join film_actor fa on f.film_id = fa.film_id
         join actor a on a.actor_id = fa.actor_id
where release_year > 2005;



select *
from vista2;



select *
from actor;



create or replace temp view vista3 as
select f.*, a.actor_id, a.last_name, a.first_name
from film f
         join film_actor fa on f.film_id = fa.film_id
         join actor a on a.actor_id = fa.actor_id
where release_year > 2005;


select *
from vista3;



create or replace view actor_view as
select *
from actor
where first_name like 'A%';


select *
from actor;

select *
from actor_view;


insert into actor_view (first_name, last_name)
values ('Some firstname', 'Some lastname');



create or replace view actor_view as
select *
from actor
where first_name like 'A%';



create or replace view child_actor_view as
select *
from actor_view
where last_name like 'B%'
with local check option;


select *
from child_actor_view;

select *
from actor;


insert into child_actor_view (first_name, last_name)
VALUES ('John', 'Bailey');



create or replace view actor_view as
select *
from actor
where first_name like 'A%';



create or replace view child_actor_view as
select *
from actor_view
where last_name like 'B%'
with cascaded check option;

insert into child_actor_view (first_name, last_name)
VALUES ('Adam', 'Bailey');



create materialized view payment_mat_view as
select p.customer_id, count(*), avg(amount), max(amount), min(amount), sum(amount)
from payment p
         join customer c on c.customer_id = p.customer_id
         join staff s on s.staff_id = p.staff_id
         join rental r on p.rental_id = r.rental_id
where amount > 3
group by p.customer_id
having count(*) > 3;


597

select *
from payment_mat_view;

select *
from payment;


create materialized view payment_mat_view2 as
select *
from payment;

14601
select count(*)
from payment_mat_view2;

14602
select count(*)
from payment;

insert into payment (customer_id, staff_id, rental_id, amount, payment_date)
select customer_id, staff_id, rental_id, amount, payment_date
from payment
where payment_id = 17503;


refresh materialized view payment_mat_view2;



create materialized view payment_mat_view3 as
select *
from payment
where amount > 2
with no data;

refresh materialized view payment_mat_view3;


select *
from payment_mat_view3;



select *
from pg_roles;


-- viewer - view data
-- author - view tables, insert/update/delete rows author is viewer
-- manager - view tables, insert/update/delete rows, create/drop/alter tables manager is author and viewer
-- admin - anything (create/drop/alter databases, view tables, insert/update/delete rows, create/drop/alter tables)
-- admin is manager, author and viewer


grant viewer to author, manager, admin;
grant author to manager, admin;
grant manager to admin;
grant admin to manager;


grant create, connect on database demo to new_user;
grant select, update on table payment to new_user;
revoke select, update on table payment from new_user;

grant all privileges on database demo to new_user;


select *
from payment;

delete
from payment
where payment_id = 17503;


update payment
set amount=amount * 1.2
where payment_id = 17503;



create or replace view parent_actor_view as
select *
from actor
where first_name like '%a';


create or replace view actor_view as
select *
from parent_actor_view
where first_name like 'A%'
with local check option;


create or replace view child_actor_view as
select *
from actor_view
where last_name like 'B%'
with cascaded check option;



insert into child_actor_view (first_name, last_name)
VALUES ('Asda', 'Basd');



