596. Classes More Than 5 Students
https://leetcode.com/problems/classes-more-than-5-students/
Write an SQL query to report all the classes that have at least five students.
Return the result table in any order.
The query result format is in the following example.

--------------------------------------------------------------
# Write your MySQL query statement below
SELECT
    class
FROM
    courses
GROUP BY class
HAVING COUNT(DISTINCT student) >= 5
;
--------------------------------------------------------------
SELECT
    class
FROM
    (SELECT
        class, COUNT(DISTINCT student) AS num
    FROM
        courses
    GROUP BY class) AS temp_table
WHERE
    num >= 5
;
