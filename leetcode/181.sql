181. Employees Earning More Than Their Managers
https://leetcode.com/problems/employees-earning-more-than-their-managers/
Actually, JOIN is a more common and efficient way to link tables together, and we can use ON to specify some conditions.

# Write your MySQL query statement below
SELECT
     a.NAME AS Employee
FROM Employee AS a JOIN Employee AS b
     ON a.ManagerId = b.Id
     AND a.Salary > b.Salary
;


# SELECT
#     a.Name AS 'Employee'
# FROM
#     Employee AS a,
#     Employee AS b
# WHERE
#     a.ManagerId = b.Id
#         AND a.Salary > b.Salary
# ;

