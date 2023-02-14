586. Customer Placing the Largest Number of Orders
https://leetcode.com/problems/customer-placing-the-largest-number-of-orders/
Write an SQL query to find the customer_number for the customer who has placed the largest number of orders.

The test cases are generated so that exactly one customer will have placed more orders than any other customer.

# Write your MySQL query statement below

SELECT
    customer_number
FROM
    orders
GROUP BY customer_number
ORDER BY COUNT(*) DESC
LIMIT 1
;
