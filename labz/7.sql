create database lab7;

create table dealer (
    id integer primary key ,
    name varchar(255),
    location varchar(255),
    commission float
);

INSERT INTO dealer (id, name, location, commission) VALUES (101, 'Oleg', 'Astana', 0.15);
INSERT INTO dealer (id, name, location, commission) VALUES (102, 'Amirzhan', 'Almaty', 0.13);
INSERT INTO dealer (id, name, location, commission) VALUES (105, 'Ademi', 'Taldykorgan', 0.11);
INSERT INTO dealer (id, name, location, commission) VALUES (106, 'Azamat', 'Kyzylorda', 0.14);
INSERT INTO dealer (id, name, location, commission) VALUES (107, 'Rahat', 'Satpayev', 0.13);
INSERT INTO dealer (id, name, location, commission) VALUES (103, 'Damir', 'Aktobe', 0.12);

create table client (
    id integer primary key ,
    name varchar(255),
    city varchar(255),
    priority integer,
    dealer_id integer references dealer(id)
);

INSERT INTO client (id, name, city, priority, dealer_id) VALUES (802, 'Bekzat', 'Satpayev', 100, 101);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (807, 'Aruzhan', 'Almaty', 200, 101);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (805, 'Али', 'Almaty', 200, 102);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (808, 'Yerkhan', 'Taraz', 300, 102);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (804, 'Aibek', 'Kyzylorda', 300, 106);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (809, 'Arsen', 'Taldykorgan', 100, 103);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (803, 'Alen', 'Shymkent', 200, 107);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (801, 'Zhandos', 'Astana', null, 105);

create table sell (
    id integer primary key,
    amount float,
    date timestamp,
    client_id integer references client(id),
    dealer_id integer references dealer(id)
);

INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (201, 150.5, '2021-10-05 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (209, 270.65, '2021-09-10 00:00:00.000000', 801, 105);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (202, 65.26, '2021-10-05 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (204, 110.5, '2021-08-17 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (207, 948.5, '2021-09-10 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (205, 2400.6, '2021-07-27 00:00:00.000000', 807, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (208, 5760, '2021-09-10 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (210, 1983.43, '2021-10-10 00:00:00.000000', 804, 106);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (203, 2480.4, '2021-10-10 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (212, 250.45, '2021-06-27 00:00:00.000000', 808, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (211, 75.29, '2021-08-17 00:00:00.000000', 803, 107);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (213, 3045.6, '2021-04-25 00:00:00.000000', 802, 101);


-- 1. Write a SQL query using Joins:

-- a. find those clients with a priority less than 300
select client.id, client.name, client.priority, dealer.name from client left outer join dealer on client.dealer_id = dealer.id
where client.priority < 300;

select * from client where priority < 300;

-- b. combine each row of dealer table with each row of client table
-- б. объедините каждую строку таблицы дилера с каждой строкой таблицы клиента.
select * from dealer cross join client;

-- c. find all dealers along with client name, city, priority, sell number, date, and amount
-- c. найдите всех дилеров вместе с именем клиента, городом, приоритетом, номером продажи, датой и суммой
select dealer.name, client.name, client.city, sell.id, sell.date, sell.amount
from dealer join client on client.dealer_id=dealer.id join sell on client.id = sell.client_id;

select dealer.name, client.name, client.city, sell.id, sell.date, sell.amount
from sell left join dealer on dealer.id = sell.dealer_id left join client on client.id = sell.client_id;

-- d. find the dealer and client who reside in the same city
-- d. найдите дилера и клиента, которые проживают в одном городе
select dealer.name, dealer.location, client.name from dealer join client on dealer.id = client.dealer_id
where dealer.location = client.city;

-- e. find sell id, amount, client name, city those sells where sell amount exists between 200 and 500
-- e. найдите идентификатор продажи, сумму, имя клиента, город в тех ячейках, где существует сумма продажи между 200 и 500
select sell.id, sell.amount, client.name, client.city from sell join client on sell.client_id = client.id
where sell.amount between 200 and 500;

-- f. find dealers who works either for one or more client or not yet join under any of the clients
-- f. найдите дилеров, которые работают либо на одного, либо на нескольких клиентов, либо еще не присоединились ни к одному из клиентов
select dealer.name, count(client.id) as client_num from client right join dealer
    on client.dealer_id = dealer.id group by dealer.id;

-- g. find the dealers and the clients he service, return client name, city, dealer name, commission.
-- g. найдите дилеров и клиентов, которых он обслуживает, верните имя клиента, город, название дилера, комиссию.
select client.name,client.city,dealer.name,dealer.commission from dealer join client on dealer.id = client.dealer_id;

SELECT client.name,client.city,dealer.name,dealer.commission from client left join dealer on client.dealer_id = dealer.id;

-- h. find client name, client city, dealer, commission those dealers who received a commission from the sell more than 13%
-- h. найдите имя клиента, город клиента, дилера, комиссию тех дилеров, которые получили комиссию от продажи более 13%
select client.name, client.city, dealer.name, dealer.commission from client join dealer on client.dealer_id = dealer.id
where dealer.commission > 0.13;

select client.name, client.city, dealer.name, dealer.commission from client left join dealer on client.dealer_id = dealer.id
where dealer.commission > 0.13;

-- i. make a report with client name, city, sell id, sell date, sell amount, dealer name
-- and commission to find that either any of the existing clients haven’t made a
-- purchase(sell) or made one or more purchase(sell) by their dealer or by own.
-- i. составьте отчет с именем клиента, городом, идентификатором продажи, датой продажи,
-- суммой продажи, именем дилера и комиссией, чтобы выяснить, что либо кто-либо из существующих
-- клиентов не совершил покупку (sell), либо совершил одну или несколько покупок (sell) у своего дилера или самостоятельно.
select client.name, client.city, sell.id, sell.date, sell.amount, dealer.name, dealer.commission
from client left join sell on client.id = sell.client_id left join dealer on client.dealer_id = dealer.id;

select client.name, client.city, sell.id, sell.date, sell.amount, dealer.name, dealer.commission
from client join sell on client.id = sell.client_id join dealer on client.dealer_id = dealer.id;

select client.name, client.city, sell.id, sell.date, sell.amount, dealer.name, dealer.commission
from client join dealer on client.dealer_id = dealer.id full outer join sell on client.id = sell.client_id;

-- j. find dealers who either work for one or more clients. The client may have made,
-- either one or more purchases, or purchase amount above 2000 and must have a
-- priority, or he may not have made any purchase to the associated dealer. Print
-- client name, client priority, dealer name, sell id, sell amount
-- j. найдите дилеров, которые работают на одного или нескольких клиентов. Клиент, возможно, совершил
-- одну или несколько покупок, или сумма покупки превышает 2000 и должна иметь
-- приоритет, или он, возможно, не совершал никаких покупок у соответствующего дилера. Вывести
-- имя клиента, приоритет клиента, имя дилера, идентификатор продажи, сумму продажи
select client.name, client.city, client.priority, dealer.name, sell.id, sell.date, sell.amount
from client left join dealer on client.dealer_id = dealer.id left join sell on client.id = sell.client_id
where sell.amount >= 2000 and client.priority is not null;

-- 2. Create following views:

-- a. count the number of unique clients, compute average and total purchase amount of client orders by each date.
-- a. подсчитайте количество уникальных клиентов, вычислите среднюю и общую сумму покупок клиентских заказов на каждую дату.

create view A as (select date, count(distinct client_id), avg(amount), sum(amount) from sell group by date);
select * from A;

-- b. find top 5 dates with the greatest total sell amount
-- б. найдите топ-5 дат с наибольшей общей суммой продаж.

create view B as (select date, sum(amount) from sell group by date order by sum(amount) desc limit 5);
select * from B;

-- c. count the number of sales, compute average and total amount of all sales of each dealer
-- c. подсчитайте количество продаж, вычислите среднюю и общую сумму всех продаж каждого дилера

create view C as(select dealer_id, avg(amount), sum(amount) from sell group by dealer_id);
select * from C;

-- d. compute how much all dealers earned from commission (total sell amount * commission) in each location
-- d. подсчитайте, сколько все дилеры заработали на комиссионных (общая сумма продажи * комиссия) в каждом месте
create view D as (select dealer.location, sum(sell.amount) * dealer.commission as earn from dealer join sell on dealer.id = sell.dealer_id
group by location, dealer.name, dealer.commission);
select * from D;


-- e. compute number of sales, average and total amount of all sales dealers made in each location
-- e. вычислите количество продаж, среднюю и общую сумму всех продаж дилеров, совершенных в каждом местоположении
create view E as (select dealer.location, count(sell.id), avg(amount), sum(amount) from sell join dealer on sell.dealer_id = dealer.id  group by dealer.location);
select * from E;

create view E2(location, sal_number_of_sales, sal_average_amount, sal_total_amount) as
    (select dealer.location, count(sell.id), avg(amount), sum(amount) from sell join dealer on sell.dealer_id = dealer.id  group by dealer.location);
select * from E2;

-- f. compute number of sales, average and total amount of expenses in each city clients made.
-- f. вычислите количество продаж, среднюю и общую сумму расходов в каждом городе, произведенных клиентами.
create view F as (select client.city, count(sell.id), avg(amount), sum(amount) from sell join client on sell.client_id = client.id  group by client.city);
select * from F;

create view F2(city, exp_number_of_sales, exp_average_amount, exp_total_amount)
    as (select client.city, count(sell.id), avg(amount), sum(amount) from sell join client on sell.client_id = client.id  group by client.city);
select * from F2;

-- g. find cities where total expenses more than total amount of sales in locations.
-- g. найдите города, где общие расходы превышают общий объем продаж в местоположениях.
create view G as (select * from E2 join F2 on E2.location = F2.city where F2.exp_total_amount > E2.sal_total_amount);
select * from G;