175. Combine Two Tables
https://leetcode.com/problems/combine-two-tables/

# Write your MySQL query statement below
select firstname, lastname, city, state
from person
left join address on person.personid = address.personid;

