create table "Department"
(
    id     serial primary key,
    "Name" varchar(200)
);


-- single comment

/*
 multi
 line
 comment
 */

select Id, "Name"
from "Department";



insert into instructor (name, salary, department_id)
values ('John', 120000, 14);

insert into instructor (name, salary, department_id)
values ('Bob', default, 10 + 5);

insert into instructor (id, name, salary, department_id)
values (default, 'Bob2', default, 10 + 5);

insert into instructor default
values;

insert into instructor (name, salary, department_id)
values ('Instructor name', (select salary from instructor where id = 297), 17);

insert into instructor (name, salary, department_id)
select name, salary, department_id
from instructor
where id < 306;

insert into instructor (name, salary, department_id)
select 'Instructor New', salary * 1.1, department_id
from instructor
where id < 306;


insert into instructor
values (default, 'Instructor name new', 50000, 10);

insert into instructor
values (default, 'Instructor name new');

insert into instructor (salary, name, department_id)
values (120000, 'John', 14);


insert into instructor (salary, name, department_id)
values (120000, 'John1', 14),
       (130000, 'John2', 14),
       (140000, 'John3', 14),
       (150000, 'John4', 14)
returning *;


update instructor
set salary=200000
where id = 306
returning id, name, salary;


update instructor
set salary=25000 * 10
where id = 306;

update instructor
set salary=salary * 1.2
where id = 306;

update instructor
set salary=salary * department_id
where id = 303;


update instructor
set salary=(select salary from instructor where id = 321)
where id = 303;

update instructor
set salary=salary * 1.2,
    department_id = 10,
    name='Instructor New Name'
where id = 306;

update instructor
set (name, salary, department_id)= ('Some new name', salary * 1.2, 11)
where id = 306;

update instructor
set (name, salary)=(select name, salary * 1.5 from instructor where id = 321)
where id = 303;

delete
from instructor;

delete
from instructor
where salary = 1100
returning *;

insert into instructor
values (327, 'Instructor New', 1100, 15);

delete
from films
where producer_id in (select id from producers where name = 'foo');

select *
from instructor
order by id;



select;
select 10;
select 10 * 10;
select 'Hello';
select 10 * 10, 'Hello';
select 10 * 10 as "Multiplication", 'Hello';
select lower('Hello') as lower_case, upper('Hello');


select *
from actor;
select distinct *
from actor;

select distinct on (first_name) *
from actor
order by first_name;

select *
from actor
where first_name = 'Adam';


select distinct on (first_name, last_name) *
from actor
order by first_name;

select distinct first_name
from actor;



select *
from payment
order by customer_id;

select customer_id, count(*), sum(amount), max(amount), min(amount), avg(amount)
from payment
group by customer_id;



select customer_id, count(*), sum(amount), max(amount), min(amount), avg(amount)
from payment
where amount > 2
group by customer_id
having sum(amount) > 25;



select *
from payment
where amount > 8
   or amount < 3;


select customer_id, staff_id
from payment
where amount > 8
union
distinct
select customer_id, staff_id
from payment
where amount < 3;


select customer_id, staff_id
from payment
where amount > 8
union all
select customer_id, staff_id
from payment
where amount < 3;



select *
from payment
where amount > 3
  and amount < 7;


select *
from payment
where amount > 3
intersect
select *
from payment
where amount < 7;



select customer_id, staff_id
from payment
where amount > 3
intersect
distinct
select customer_id, staff_id
from payment
where amount < 7;



select customer_id, staff_id
from payment
where amount > 3
intersect all
select customer_id, staff_id
from payment
where amount < 7;



select *
from payment
where amount > 3
  and not amount > 7;


select *
from payment
where amount > 3
    except
select *
from payment
where amount > 7;


select customer_id, staff_id
from payment
where amount > 3
    except distinct
select customer_id, staff_id
from payment
where amount > 7;



select customer_id, staff_id
from payment
where amount > 3
    except all
select customer_id, staff_id
from payment
where amount > 7;



select *
from payment
order by amount desc;


select *
from payment
order by amount, customer_id desc;



select *
from payment
order by amount desc nulls last;



select *
from payment
order by amount nulls first;


select *
from payment;

select *
from payment
limit 10;

select *
from payment
limit 10 offset 5;


select *
from (select *
      from payment
      limit 10 offset 5) t
order by amount;


select *
from payment
order by amount desc nulls last;

select *
from payment
where amount = (select amount
                from payment
                group by amount
                order by amount desc nulls last
                limit 1 offset 1);


select *
from payment
where amount = (select amount
                from payment
                group by amount
                order by amount nulls last
                limit 1 offset 1);

select min(amount), max(amount) from payment;
select name, last_name
from employees
where department_id in (select department_id
                        from departments
                        where budget =
                              (select min(budget)
                               from departments));