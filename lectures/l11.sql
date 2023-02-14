select *
from actor;


update;

begin;
update;
delete;
cancel
insert;
save;



begin;
select balance; -- success
insert into operations; -- withdraw 100$ success
update balance = balance-100; -- (check balance >= 0) error
save;
give the money



create table test
(
    balance integer check (balance > 0)
);


insert into test (balance)
values (100);

select *
from test;



begin read write isolation level serializable;
select *
from test;
update test
set balance=balance - 99;
select *
from test;
commit;



    (max)
    (del)
    (ins)
    (min)
    3.0              3.5
-- max < min
-- Phantom read

                          2.5, 3.0 -- state of the table
(max) (del) (ins) (min) (rollback)
  3.0              3.5
-- Sally will see never existed data
-- Dirty read


-- Non repeatable read
select max(balance)
from test; -- 10

select max(balance)
from test; -- 11


begin read write;

select *
from actor;

update actor
set first_name=first_name || ' new'
where actor_id = 19;

select *
from actor
where actor_id = 19;

savepoint after_actor_update;

select count(*)
from film_actor;
delete
from film_actor
where actor_id = 100;


rollback to savepoint after_actor_update;

release savepoint after_actor_update;

rollback to savepoint after_actor_update;

commit;



begin read write;

select *
from actor;


update actor
set first_name=first_name || ' new'
where actor_id = 23;


select *
from actor
where actor_id = 23;

commit;