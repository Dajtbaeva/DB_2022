create database final;

-- 1. The result which operation contains all pairs of tuples from the two relations, regardless of
-- whether their attribute values match.
-- Cartesian product
-- 2. Which one of the following provides the ability to query information from the database and
-- to insert tuples into, delete tuples from, and modify tuples in the database?
-- DML(Data Manipulation Language)
-- 3. An attribute A of datatype varchar(20) has the value "Avi". The attribute B of data type
-- char(20) has value "Reed". Here attribute A has spaces and attribute B has spaces.
-- 3, 20
-- 4. Which of the following statements contains an error?
-- Select empid where empid=1009 and lastname='GELLER';
-- 5. SELECT name __ instructor name, course_id FROM instructor, teaches WHERE
-- instructor.ID = teaches.ID;
-- Which keyword must be used here to rename the field name?
-- As
-- 6. SELECT * FROM instructor ORDER BY salary __, name __;
-- To display the salary from greater to smaller and name in ascending order which of the
-- following options should be used?
-- Desc, Asc
-- 7. __ operation is used for appending two strings.
-- ||
-- 8. A __ consists of a sequence of query and/or update statements.
-- Transaction
-- 9. A Boolean data type that can take values true, false and __.
-- Unknown
-- 10. What type of join is needed when you wish to include rows that do not have matching
-- values?
-- Outer join

--PROBLEMS:
-- #1
--
-- S1: update A = A - 3;
-- S2: update B = B * 2;
-- S3: sum(A);
-- S4: sum(B);
--
--                     Serializable     Read committed    Repeatable read    Read uncommitted
-- 1.S1, S2, S3, S4      13, 44            13, 44            13, 44                13, 44
-- 2.S1, S3, S2, S4      22, 22            22, 44            22, 44                13, 44
-- 3.S1, S3, S4, S2      22, 22            22, 22            22, 22                13, 22
-- 4.S3, S1, S2, S4      22, 22            22, 44            22, 44                22, 44
-- 5.S3, S1, S4, S2      22, 22            22, 22            22, 22                22, 22
-- 6.S3, S4, S1, S2      22, 22            22, 22            22, 22                22, 22
--
-- #2
--
-- Answer is 13. Because 6 + 4 + 3 = 13;
--
--
-- #3
--
-- 1) Updatable views cannot get include GROUP BY or aggregation
-- 2) Updatable view cannot get function COUNT
-- 3) NULL values are not permitted
-- 4) Updatable views get only one table

--Queries

create table pieces(
    code serial primary key,
    name varchar
);

create table providers(
    code varchar primary key,
    name varchar
);

create table provides(
    piece int,
    provider varchar,
    foreign key (piece) references pieces (code),
    foreign key (provider) references providers (code),
    price int
);
insert into providers
values ('HAL', 'Clarke Enterprices'),
       ('RBT', 'Susan Calvin Corp.'),
       ('TNBC', 'Skellington Supplies');

insert into pieces
values (default, 'Spocket'),
       (default, 'Screw'),
       (default, 'Nut'),
       (default, 'Bolt');

insert into provides
values (1, 'HAL', 10),
       (1, 'RBT', 15),
       (2, 'HAL', 20),
       (2, 'RBT', 15),
       (2, 'TNBC', 14),
       (3, 'RBT', 50),
       (3, 'TNBC', 45),
       (4, 'HAL', 5),
       (4, 'RBT', 7);
-- 5.1
-- Select the name of all the pieces.
select Name from Pieces;

-- 5.2
-- Select all the providers' data.
select * from providers;

-- 5.3
-- Obtain the average price of each piece (show only the piece code and the average price).
select piece, avg(price) from Provides group by piece;
select * from provides;

-- 5.4
-- Obtain the names of all providers who supply piece 1.
select Name
from Providers
where Code in (
select  Provider from provides where Piece = 1
);

select Providers.Name
from Providers join Provides
on Providers.Code = Provides.Provider
where Provides.Piece = 1;

/* Without subquery */
 SELECT Providers.Name
   FROM Providers INNER JOIN Provides
          ON Providers.Code = Provides.Provider
             AND Provides.Piece = 1;

/* With subquery */
 SELECT Name
   FROM Providers
  WHERE Code IN
   (SELECT Provider FROM Provides WHERE Piece = 1);



-- 5.5
-- Select the name of pieces provided by provider with code "HAL".
select Name from Pieces
where Code in (
select Piece from Provides where Provider = 'HAL'
);

select Pieces.Name
from Pieces join Provides
on (Pieces.code = Provides.Piece)
where Provides.Provider = 'HAL';

/* With EXISTS subquery */
-- Interesting clause
SELECT Name
  FROM Pieces
  WHERE EXISTS
  (
    SELECT * FROM Provides
      WHERE Provider = 'HAL'
        AND Piece = Pieces.Code
  );


-- 5.6
-- ---------------------------------------------
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- Interesting and important one.
-- For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price
-- (note that there could be two providers who supply the same piece at the most expensive price).

-- WRONG solution given by XD-DENG.
select a.name, a.code, b.price, c.Name
from Pieces a join Provides b
on a.Code = b.Piece
join Providers c
on b.provider = c.Code
group by a.code;
-- this is wrong since when I group by a.code, SQL will automatically select the first c.Name in each group to return,
-- which is not what we expected.

-- CORRECT SOLUTION
SELECT Pieces.Name, Providers.Name, Price
  FROM Pieces INNER JOIN Provides ON Pieces.Code = Piece
              INNER JOIN Providers ON Providers.Code = Provider
  WHERE Price =
  (
    SELECT MAX(Price) FROM Provides
    WHERE Piece = Pieces.Code
  );
-- This is worthwhile to look into again
-- --------------------------------------------------------------

-- 5.7
-- Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") will
-- provide sprockets (code "1") for 7 cents each.
INSERT INTO Provides(Piece, Provider, Price) VALUES (1, 'TNBC', 7);

-- 5.8
-- Increase all prices by one cent.
UPDATE Provides
SET Price = Price + 1;

-- 5.9
-- Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).
DELETE FROM Provides WHERE provider = 'RBT' AND Piece = 4;


-- 5.10
-- Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces
-- (the provider should still remain in the database).
DELETE FROM provides
WHERE Provider = 'RBT';

--1. Obtain the average price of each piece (show only the piece code and the average price).
select Piece, avg(Price) from Provides group by (Piece);

--2. Obtain the names of all providers who supply piece 1.
select Providers.Name from Providers join Provides
    on Providers.Code = Provides.Provider and Provides.Piece = 1;

select Name
from Providers
where Code in (
select  Provider from provides where Piece = 1
);

--3. Select the name of pieces provided by provider with code "HAL".
select Pieces.Name from Pieces join Provides
    on Pieces.Code = Provides.Piece and Provides.Provider = 'HAL';

--4. For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price
-- (note that there could be two providers who supply the same piece at the most expensive price).
select Pieces.Name, Providers.Name, Price from Pieces
    join Provides ON Pieces.Code = Piece join Providers on Providers.Code = Provider
        where Price = (select max(Price) from Provides where Piece = Pieces.Code);

--5
create index res on provides(price, asc);