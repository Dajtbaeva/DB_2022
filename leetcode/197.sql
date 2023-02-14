# Write your MySQL query statement below

Write an SQL query to find all dates Id with higher temperatures compared to its previous dates (yesterday).

Return the result table in any order.

The query result format is in the following example.

Approach: Using JOIN and DATEDIFF() clause [Accepted]
Algorithm

MySQL uses DATEDIFF to compare two date type values.

So, we can get the result by joining this table weather with itself and use this DATEDIFF() function.


SELECT
    weather.id AS 'Id'
FROM
    weather
        JOIN
    weather w ON DATEDIFF(weather.recordDate, w.recordDate) = 1
        AND weather.Temperature > w.Temperature
;
