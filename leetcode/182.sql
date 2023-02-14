182. Duplicate Emails
https://leetcode.com/problems/duplicate-emails/
# Write your MySQL query statement below
Write an SQL query to report all the duplicate emails.

Return the result table in any order.

The query result format is in the following example.

select Email
from Person
group by Email
having count(Email) > 1;

# select Email from
# (
#   select Email, count(Email) as num
#   from Person
#   group by Email
# ) as statistic
# where num > 1
# ;
