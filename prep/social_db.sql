create database social;

/* Create the schema for our tables */
create table Highschooler(ID int, name text, grade int);
create table Friend(ID1 int, ID2 int);
create table Likes(ID1 int, ID2 int);

/* Populate the tables with our data */
insert into Highschooler values (1510, 'Jordan', 9);
insert into Highschooler values (1689, 'Gabriel', 9);
insert into Highschooler values (1381, 'Tiffany', 9);
insert into Highschooler values (1709, 'Cassandra', 9);
insert into Highschooler values (1101, 'Haley', 10);
insert into Highschooler values (1782, 'Andrew', 10);
insert into Highschooler values (1468, 'Kris', 10);
insert into Highschooler values (1641, 'Brittany', 10);
insert into Highschooler values (1247, 'Alexis', 11);
insert into Highschooler values (1316, 'Austin', 11);
insert into Highschooler values (1911, 'Gabriel', 11);
insert into Highschooler values (1501, 'Jessica', 11);
insert into Highschooler values (1304, 'Jordan', 12);
insert into Highschooler values (1025, 'John', 12);
insert into Highschooler values (1934, 'Kyle', 12);
insert into Highschooler values (1661, 'Logan', 12);

insert into Friend values (1510, 1381);
insert into Friend values (1510, 1689);
insert into Friend values (1689, 1709);
insert into Friend values (1381, 1247);
insert into Friend values (1709, 1247);
insert into Friend values (1689, 1782);
insert into Friend values (1782, 1468);
insert into Friend values (1782, 1316);
insert into Friend values (1782, 1304);
insert into Friend values (1468, 1101);
insert into Friend values (1468, 1641);
insert into Friend values (1101, 1641);
insert into Friend values (1247, 1911);
insert into Friend values (1247, 1501);
insert into Friend values (1911, 1501);
insert into Friend values (1501, 1934);
insert into Friend values (1316, 1934);
insert into Friend values (1934, 1304);
insert into Friend values (1304, 1661);
insert into Friend values (1661, 1025);
insert into Friend SELECT ID2, ID1 FROM Friend;

insert into Likes values(1689, 1709);
insert into Likes values(1709, 1689);
insert into Likes values(1782, 1709);
insert into Likes values(1911, 1247);
insert into Likes values(1247, 1468);
insert into Likes values(1641, 1468);
insert into Likes values(1316, 1304);
insert into Likes values(1501, 1934);
insert into Likes values(1934, 1501);
insert into Likes values(1025, 1101);

select * from Highschooler;
select * from Friend;
select * from Likes;

-- 1. Find the names of all students who are friends with someone named Gabriel.
select name from Highschooler join Friend on Highschooler.ID = Friend.ID1 where ID2 in (select id from Highschooler where name = 'Gabriel');

-- 2. For every student who likes someone 2 or more grades younger than themselves, return that student's name and grade, and the name
-- and grade of the student they like.
select t1.name, t1.grade, t2.name, t2.grade from( (select * from Highschooler h, likes l where h.id = l.id1) t1
join (select * from Highschooler h, likes l where h.id = l.id2) t2 on t1.id2 = t2.id2) where t1.grade - t2.grade >= 2;

-- 3. Find the name and grade of all students who are liked by more than one other student.
select name, grade from (select id2 from Highschooler, Likes where id = id1 group by id2 having count(id2) > 1) t1, highschooler t2
where t1.id2 = t2.id;

SELECT name, grade
FROM
(SELECT id2 FROM highschooler, likes WHERE id = id1 GROUP BY id2 HAVING count(id2) > 1) t1, highschooler t2
WHERE t1.id2 = t2.id;



