-- 1
create database lab6;

-- 2
create table locations(
    location_id serial primary key,
    street_address varchar(25),
    postal_code varchar(12),
    city varchar(30),
    state_province varchar(12)
);

create table departments(
    department_id serial primary key,
    department_name varchar(50) unique,
    budget integer,
    location_id integer references locations
);

create table employee(
    employee_id serial primary key,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(50),
    phone_number varchar(20),
    salary integer,
    department_id integer references departments
);

-- 3
insert into locations(location_id, street_address, postal_code, city, state_province) values (5001, '201 Kulikov St', '992364', 'Moscow', 'Russia');
insert into locations(location_id, street_address, postal_code, city, state_province) values (1001, '6092 Boxwood St', '490231', 'Munich', 'Bavaria');
insert into locations(location_id, street_address, postal_code, city, state_province) values (2001, '147 Spadina Ave', '560131', 'Toronto', 'Ontario');
insert into locations(location_id, street_address, postal_code, city, state_province) values (3001, '2004 Charade Rd', '151515', 'Seattle','Washington');
insert into locations(location_id, street_address, postal_code, city, state_province) values (4001, '2007 Zagora St', '500900', 'South Brunswick', 'New Jersey');


insert into departments(department_id, department_name, budget, location_id) values (70, 'Benefits', 121, 4001);
insert into departments(department_id, department_name, budget, location_id) values (30, 'Purchasing', 115, 1001);
insert into departments(department_id, department_name, budget, location_id) values (50, 'Finance', 107, 2001);
insert into departments(department_id, department_name, budget, location_id) values (60, 'Accounting', 214, 3001);
insert into departments(department_id, department_name, budget, location_id) values (80, 'Control And Credit', 205, 5001);


insert into employee(employee_id, first_name, last_name, email, phone_number, salary, department_id) values (106,'Kate', 'Gilbert', 'kate@gmail.com', '87012334812', 6000, 80);
insert into employee(employee_id, first_name, last_name, email, phone_number, salary, department_id) values (102,'Bruce', 'Hunold', 'bruce@gmail.com', '87017294812', 6000, 30);
insert into employee(employee_id, first_name, last_name, email, phone_number, salary, department_id) values (103,'Bob', 'Coronel', 'bob@gmail.com', '87471527606', 7500, 30);
insert into employee(employee_id, first_name, last_name, email, phone_number, salary, department_id) values (104,'Diana', 'Lorentz', 'diana@gmail.com', '87752028767', 4800, 50);
insert into employee(employee_id, first_name, last_name, email, phone_number, salary, department_id) values (105,'Lili', 'Salvatore', 'lili@gmail.com', '87017223812', 5000, NULL);


-- 4. Select the first name, last name, department id, and department name for each employee.
select first_name, last_name, employee.department_id, departments.department_name from employee join departments on employee.department_id = departments.department_id;


-- 5. Select the first name, last name, department id and department name, for all employees for departments 80 or 30
select first_name, last_name, employee.department_id, departments.department_name from employee join departments on employee.department_id = departments.department_id where employee.department_id in (80, 30);


-- 6. Select the first and last name, department, city, and state province for each employee.
select first_name, last_name, departments.department_name, city, state_province from employee
join departments on employee.department_id = departments.department_id join locations on departments.location_id = locations.location_id;


-- 7. Select all departments including those where does not have any employee.
select employee.first_name, employee.last_name, departments.department_id, departments.department_name
from employee right outer join departments
on employee.department_id = departments.department_id;


-- 8. Select the first name, last name, department id and name, for all employees who have or have not any department.
select employee.first_name, employee.last_name, departments.department_id, departments.department_name
from employee left outer join departments
on employee.department_id = departments.department_id;


-- 9. Select the employee last name, first name, who works in Moscow.
select last_name, first_name from employee join departments on employee.department_id = departments.department_id
join locations on departments.location_id = locations.location_id where locations.city = 'Moscow';