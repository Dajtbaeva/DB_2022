584. Find Customer Referee
https://leetcode.com/problems/find-customer-referee/

# Write your MySQL query statement below
SELECT name FROM customer WHERE referee_id <> 2 OR referee_id IS NULL;
