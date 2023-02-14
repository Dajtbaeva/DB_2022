select *
from actor;


select *
from film_actor;



select lower(first_name)
from actor;



create or replace function my_sum(a integer, b integer)
    returns integer
as
$$
begin
    return a + b;
end;
$$
    language plpgsql;



select my_sum(4, 6);



CREATE or replace FUNCTION inc(val integer) RETURNS integer AS
$$
BEGIN
    RETURN val + 1;
END;
$$
    LANGUAGE PLPGSQL;



select inc(inc(5));



CREATE OR REPLACE FUNCTION get_sum(IN a NUMERIC,
                                   IN b NUMERIC)
    RETURNS NUMERIC AS
$$
BEGIN
    RETURN a + b;
END;
$$
    LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION hi_lo(a NUMERIC,
                                 b NUMERIC,
                                 c NUMERIC,
                                 OUT hi NUMERIC, OUT lo NUMERIC)
AS
$$
BEGIN
    hi := GREATEST(a, b, c);
    lo := LEAST(a, b, c);
END;
$$
    LANGUAGE plpgsql;



select *
from hi_lo(5, 3, 8);



create or replace function square(inout a integer)
as
$$
begin
    a := a * a;
end;
$$
    language plpgsql;


select square(5);



CREATE OR REPLACE FUNCTION sum_avg(VARIADIC list NUMERIC[],
                                   OUT total NUMERIC,
                                   OUT average NUMERIC) AS
$$
BEGIN
    SELECT INTO total SUM(list[i])
    FROM generate_subscripts(list, 1) g(i);
    SELECT INTO average AVG(list[i])
    FROM generate_subscripts(list, 1) g(i);
END;
$$
    LANGUAGE plpgsql;



select sum_avg(5, 6, 7, 1, 4, 10);



CREATE OR REPLACE FUNCTION get_rental_duration(p_customer_id INTEGER)
    RETURNS INTEGER AS
$$
DECLARE
    rental_duration INTEGER;
BEGIN
    -- get the rate based on film_id
    SELECT INTO rental_duration SUM(EXTRACT(DAY FROM return_date -
                                                     rental_date))
    FROM rental
    WHERE customer_id = p_customer_id;
    RETURN rental_duration;
END;
$$
    LANGUAGE plpgsql;



select *
from get_rental_duration(3);


CREATE OR REPLACE FUNCTION get_rental_duration(p_customer_id INTEGER, p_from_date DATE)
    RETURNS INTEGER AS
$$
DECLARE
    rental_duration integer;
BEGIN
    -- get the rental duration based on customer_id and rental date
    SELECT INTO rental_duration SUM(EXTRACT(DAY FROM return_date + '12:00:00' - rental_date))
    FROM rental
    WHERE customer_id = p_customer_id
      AND rental_date >= p_from_date;
    RETURN rental_duration;
END;
$$
    LANGUAGE plpgsql;


select *
from rental;

select *
from get_rental_duration(3, '2005-07-24 22:54:33.000000');



CREATE OR REPLACE FUNCTION get_rental_duration(p_customer_id INTEGER,
                                               p_from_date DATE DEFAULT '2005-01-01'
)
    RETURNS INTEGER AS
$$
DECLARE
    rental_duration integer;
BEGIN
    -- get the rental duration based on customer_id and rental date
    SELECT INTO rental_duration SUM(EXTRACT(DAY FROM return_date + '12:00:00' - rental_date))
    FROM rental
    WHERE customer_id = p_customer_id
      AND rental_date >= p_from_date;
    RETURN rental_duration;
END;
$$
    LANGUAGE plpgsql;



drop function get_rental_duration(integer);
select *
from get_rental_duration(3);



CREATE OR REPLACE FUNCTION get_film(p_pattern VARCHAR)
    RETURNS TABLE
            (
                film_title        VARCHAR,
                film_release_year INT
            )
AS
$$
BEGIN
    RETURN QUERY SELECT title,
                        cast(release_year as integer)
                 FROM film
                 WHERE title ILIKE p_pattern;
END;
$$
    LANGUAGE 'plpgsql';



select *
from get_film('a%');



do
$$
    <<outer_block>>
        declare
        counter integer := 0;
    begin
        counter := counter + 1;
        raise notice 'The value of the counter is %', counter;
        <<inner_block>>
            declare
            counter integer := 0;
        begin
            counter := counter + 10;
            raise notice 'The value of the inner counter is %', counter;
            outer_block.counter := 5;
            raise notice 'The value of the outer counter is %', outer_block.counter;
        end inner_block;

        <<inner_block2>>
            declare
            counter integer := 0;
        begin
            counter := counter + 7;
            raise notice 'The value of the inner2 counter is %', counter;
            outer_block.counter := 9;
            raise notice 'The value of the outer counter is %', outer_block.counter;
        end inner_block2;

        raise notice 'The value of the counter is %', counter;
    end outer_block;
$$



drop trigger actor_update_trigger on actor;
drop function actor_update();



create table actor_old
(
    like actor
);

create or replace function actor_update()
    returns trigger
    language plpgsql
as
$$
begin
    insert into actor_old (actor_id, first_name, last_name, last_update)
    VALUES (old.actor_id, old.first_name, old.last_name, old.last_update);

    return new;
end;
$$;



create trigger actor_update_trigger
    before update
    on actor
    for each row
execute procedure actor_update();



select *
from actor where actor_id = 5;


update actor
set first_name=first_name || ' new'
where actor_id = 5;

select * from actor_old;


alter table actor
disable trigger actor_update_trigger;

alter table actor
enable trigger actor_update_trigger;


select * from pg_trigger;



