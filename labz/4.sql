-- ASSIGNMENT 4:
-- Task 1:
-- a. Find the titles of courses in the Biology department that have more than 3
-- credits
select title from course where course.dept_name = 'Biology' and credits > 3;

-- b. Find all classrooms situated either in ‘Watson’ or ‘Painter’ buildings
select * from classroom where building = 'Watson' or building = 'Painter';

-- c. Find all courses offered by the Computer Science department
select * from course where dept_name = 'Comp. Sci.';

-- d. Find all courses offered during Spring
select * from course where course_id in (select course_id from section where semester = 'Spring');

-- e. Find all students who have more than 45 credits but less than 85
select * from student where tot_cred > 45 and tot_cred < 85;

-- f. Find all courses where names end with vowels
select * from course where title like '%a' or title like '%e' or title like '%i' or title like '%o' or title like '%u' or title like '%y';

-- g. Find all courses which have course ‘EE-181’ as their prerequisite
select course_id from prereq where prereq_id = 'EE-181';
-- select * from course, prereq where course.course_id = prereq.course_id and prereq_id = 'EE-181';

-- Task 2:
-- a. For each department, find the average salary of instructors in that
-- department and list them in ascending order. Assume that every
-- department has at least one instructor
select dept_name, avg(salary) as average_salary from instructor group by dept_name order by average_salary asc;

-- b. Find the building where the biggest number of courses takes place
select building, count(building) as maximum from section group by building order by count(building) desc limit 1;

-- c. Find the department with the lowest number of courses offered
select dept_name, count(course_id) as count from course group by dept_name
having count(course_id) in (select min(res) from (select count(course_id) as res from course group by dept_name) as foo);

-- d. Find the ID and name of each student who has taken more than 3 courses
-- from the Computer Science department
select student.id, name, count(name) from student join takes on student.ID = takes.ID
where takes.course_id in (select course_id from course where dept_name = 'Comp. Sci.')
group by student.id, name having count(name) > 3;

-- e. Find the ID and name of each instructor in a department located in the
-- building “Taylor”
select id, name from instructor join department on instructor.dept_name = department.dept_name and building = 'Taylor';

-- f. Find all instructors who work either in Biology, Philosophy, or Music
-- departments
select name from instructor where dept_name in ('Biology', 'Philosophy', 'Music');

-- g. Find all instructors who taught in the 2018 year but not in the 2017 year
select name from instructor join teaches on instructor.ID = teaches.ID where year = 2018;

-- Task 3:
-- a. Find all students who have taken Comp. Sci. course and got an excellent
-- grade (i.e., A, or A-) and sort them alphabetically
select distinct name from student join takes on student.ID = takes.ID
where dept_name = 'Comp. Sci.' and takes.grade in ('A', 'A-') order by name asc;

-- b. Find all advisors of students who got grades higher than B on any class
select distinct advisor.i_ID from advisor, takes where advisor.s_ID = takes.ID and grade in ('A','A-','B+','B');

-- c. Find all departments whose students have never gotten an F or C grade
select dept_name from department where dept_name not in
(select dept_name from course where course_id in
(select course_id from takes where takes.grade in ('F','C')));

-- d. Find all instructors who have never given an A and A- grade in any of the
-- courses they taught
select name from instructor where instructor.dept_name not in
(select distinct dept_name from student, takes where student.id = takes.id and grade in ('A', 'A-'));

-- e. Find all courses offered in the morning hours (i.e., courses ending before
-- 13:00)
select distinct title as name from course, section, time_slot
where course.course_id = section.course_id and section.time_slot_id = time_slot.time_slot_id
and (end_hr <= 12 and end_min <= 59) or (end_hr = 13 and end_min = 0);
