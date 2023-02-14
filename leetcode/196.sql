196. Delete Duplicate Emails
https://leetcode.com/problems/delete-duplicate-emails/
Write an SQL query to delete all the duplicate emails, keeping only one unique email with the smallest id. 
Note that you are supposed to write a DELETE statement and not a SELECT one.


# Please write a DELETE statement and DO NOT write a SELECT statement.
# Write your MySQL query statement below
# SELECT p1.*
# FROM Person p1,
#     Person p2
# WHERE
#     p1.Email = p2.Email AND p1.Id > p2.Id
# ;

DELETE p1 FROM Person p1,
    Person p2
WHERE
    p1.Email = p2.Email AND p1.Id > p2.Id
