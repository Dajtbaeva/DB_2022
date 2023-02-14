183. Customers Who Never Order
https://leetcode.com/problems/customers-who-never-order/

Write an SQL query to report all customers who never order anything.

Return the result table in any order.

The query result format is in the following example.

# Write your MySQL query statement below
select customers.name as 'Customers'
from customers
where customers.id not in
(
    select customerid from orders
);
