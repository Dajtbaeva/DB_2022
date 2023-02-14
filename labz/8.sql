-- Assignment 8

-- 1. Create a function that:

-- a. Increments given values by 1 and returns it.
create function incr(inout a integer)
as $$
begin
    a := a + 1;
end;
$$
language plpgsql;

select incr(4);

-- b. Returns cube of number
create function cube(a integer)
returns integer as $$
begin
    return power(a, 3);
end;
$$
language plpgsql;

select cube(4);

-- c. Returns sum of 2 numbers.
create function sumi(a integer, b integer)
returns integer as $$
begin
    return a + b;
end;
$$
language plpgsql;

select sumi(4, 5);

-- d. Returns true or false if numbers are divisible by 2.
create function div_by_two(a integer)
returns boolean as $$
begin
    return case
        when a % 2 = 0 then true
        else false
    end;
end;
$$
language plpgsql;

select div_by_two(4);

-- e. Average sum of numbers.
create function average(variadic list integer[], out av integer)
as $$
begin
    select into av avg(list[i]) from generate_subscripts(list, 1) g(i);
end;
$$
language plpgsql;

select average(4, 5, 6);

-- f. Returns count of numbers.
create function count_numbers(variadic list integer[], out cnt integer)
as $$
begin
    select into cnt count(list[i]) from generate_subscripts(list, 1) g(i);
end;
$$
language plpgsql;

select count_numbers(4, 5, 6);

-- g. Checks some password for validity.
create or replace function check_password(password varchar)
returns boolean as $$
begin
    return case
        when password similar to '%[a-z]%'
            and password similar to '%[A-Z]%'
            and password similar to '%[0-9]%'
            and length(password) = 8
            then true
        else false
    end;
end;
$$
language plpgsql;

select check_password('rujso');
select check_password('impdirfv');
select check_password('getW37fj');

-- h. Returns two outputs, but has one input.
create or replace function sqrt_vs_square(a integer,
out root float, out kvadrat integer)
as $$
begin
    root = sqrt(a);
    kvadrat = power(a, 2);
end;
$$
language plpgsql;

select sqrt_vs_square(4);

-- 2. Create a trigger that:
create table test(
    id integer primary key,
    name varchar,
    price1 numeric,
    price2 numeric
);

create table person(
    id integer primary key,
    name varchar,
    lname varchar,
    date_of_birth date,
    age integer,
    insertion_time timestamp
);

-- a. Return timestamp of the occured action within the database.
create function A_f()
returns trigger
as $$
begin
    new.insertion_time = now();
    return new;
end;
$$
language plpgsql;

create trigger A_t
    before insert or update
    on person
    for each row
    execute procedure A_f();
insert into person values(1, 'Aiyazhan', 'AAA', '2003-04-08');
select * from person;

-- b. Computes the age of a person when persons’ date of birth is inserted.

create function B_f()
returns trigger
as $$
begin
    new.age = date_part('year', age(new.date_of_birth));
    return new;
end;
$$
language plpgsql;

create trigger B
    before insert
    on person
    for each row
    execute procedure B_f();

insert into person values(2, 'Nariman', 'DDD', '2006-08-09');
select * from person;

-- c. Adds 12% tax on the price of the inserted item.

create function C_f()
returns trigger
as $$
begin
    new.price2 = new.price1 * 1.12;
    return new;
end;
$$
language plpgsql;

create trigger C
    before insert
    on test
    for each row
    execute procedure C_f();
insert into test values(1, 'item', 800);
select * from test;

-- d. Prevents deletion of any row from only one table.

create function D_f()
returns trigger
as $$
begin
    raise exception 'DELETION CANCELED!';
end;
$$
language plpgsql;

create trigger D_t
    before delete on test
    for each row
    execute procedure D_f();

delete from test where id = 1;

-- e. Launches functions 1.d and 1.e.
create table sandar(
  n1 integer,
  n2 integer,
  n3 integer
);

create or replace function E_f4()
returns trigger
as $$
    declare av integer;
    begin
        av = average(new.n1, new.n2, new.n3);
        if div_by_two(av)
            then return new;
        else raise exception 'Error';
        end if;
    end;
$$
language plpgsql;

create trigger E_t4
    after insert
    on sandar
    for each row
    execute procedure E_f4();

insert into sandar values(2.0, 4.0, 6.0);
insert into sandar values(1.0, 20, 4.0);
insert into sandar values(1, 2, 4);
insert into sandar values(1, 2, 2);
select * from sandar;

-- 3.Create procedures that:
-- a) Increases salary by 10% for every 2 years of work experience and provides
-- 10% discount and after 5 years adds 1% to the discount.
create table employee(
    employee_id integer primary key,
    employee_name varchar,
    date_of_birth date,
    age INT,
    salary NUMERIC,
    work_experience INT,
    discount INT
);

create procedure benefits()
as $$
begin
    update employee set salary = salary * 0.1 * floor(work_experience / 2) + salary;
    update employee set discount = 10 + (1 * (work_experience - 5)) where work_experience > 5;
    update employee set discount = (1 * floor(work_experience - 5) / 2) + discount where work_experience > 5;
end;
$$
language plpgsql;

-- b) After reaching 40 years, increase salary by 15%. If work experience is more
-- than 8 years, increase salary for 15% of the already increased value for work
-- experience and provide a constant 20% discount.

create procedure forty_benefits()
as $$
begin
    update employee set salary = salary * 1.15 where age >= 40;
    update employee set salary = salary * 1.15, discount =
        20  where work_experience > 8;
end;
$$
language plpgsql;

insert into employee VALUES(1,'Darina','2003-08-04', 100, 5, 18);
insert into employee VALUES(2,'Amira','2002-03-08', 200, 3, 19);
insert into employee VALUES(3,'Aigerim','2002-07-12', 200, 3, 20);

call benefits();
call forty_benefits();
select * from employee;

