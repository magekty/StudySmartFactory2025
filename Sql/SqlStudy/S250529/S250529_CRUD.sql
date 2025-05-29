insert into doit_Create_table(col1, col2, col3)values(1, 'DoitSQL','2025-05-29');
select * from doit_create_table;
insert into doit_Create_table(col1)values(2);
insert into doit_Create_table values(3, 'DoitSQL','2025-05-29');
insert into doit_Create_table values(4, 'doitsql');
insert into doit_Create_table(col1, col3, col2) values(4, '2025-05-29','DoitSQL');

insert into doit_Create_table (col1, col3, col2) values (5, 'DoitSQL','2025-05-29');
insert into doit_Create_table (col1, col3, col2) values (6, 'DoitSQL','2025-05-29');
insert into doit_Create_table (col1, col3, col2) values (7, 'DoitSQL','2025-05-29');

insert into doit_Create_table (col1, col2, col3) values 
(5, 'DoitSQL','2025-05-29'),
(6, 'DoitSQL','2025-05-29'),
(7, 'DoitSQL','2025-05-29');
select * from doit_create_table;

insert into doit_Create_table (col1, col2, col3) values 
(8,	'DoitSQL'	, '2025-05-29'),
(9,	'DoitSQL'	, '2025-05-29'),
(10,	'DoitSQL'	, '2025-05-29'),
(11,	'DoitSQL'	, '2025-05-29'),
(12,	'DoitSQL'	, '2025-05-29'),
(13,	'DoitSQL'	, '2025-05-29');

update doit_Create_table set col2 = 'DoitSQL', col3 = '2025-05-29' where col1 = 2; 
delete from doit_create_table where col1 = 2;
-- delete from doit_create_table

create table Employees(
emp_id int,
name varchar(7),
dept_id int
); 

create table Departments(
dept_id int,
dept_name varchar(10)
); 

insert into employees (emp_id, name, dept_id) values
(1,	'Alice'	, 10),
(2,	'Bob'	, 20),
(3,	'Charlie'	, null);

insert into Departments (dept_id, dept_name) values
(10,	'HR'),
(20,	'IT'	),
(30,	'Marketing');

select * from employees;
select * from Departments;

-- inner join 교집합 비어있는건 버림
SELECT *
FROM Employees e
INNER JOIN Departments d ON e.dept_id = d.dept_id;

-- left join 왼쪽테이블기준 교집합 오른쪽의 레코드가 비어있으면 null
SELECT *
FROM Employees e
LEFT JOIN Departments d ON e.dept_id = d.dept_id;

-- right join 오른쪽테이블기준 교집합 왼쪽의 레코드가 비어있으면 null
SELECT *
FROM Employees e
RIGHT JOIN Departments d ON e.dept_id = d.dept_id;

-- fullouter join 미지원 union 합집합 모든테이블의 레코드가 비어있으면 null
SELECT *
FROM Employees e
LEFT JOIN Departments d ON e.dept_id = d.dept_id
UNION
SELECT *
FROM Employees e
RIGHT JOIN Departments d ON e.dept_id = d.dept_id;

-- cross join 열기준 합집합 비어있는 레코드는 Null처리
SELECT e.name, d.dept_name
FROM Employees e
CROSS JOIN Departments d;
SELECT e.name, d.dept_name
FROM Departments d
CROSS JOIN Employees e;

-- self join 자기 자신을 교집합
SELECT *
FROM Employees a
JOIN Employees b ON a.dept_id = b.dept_id AND a.emp_id != b.emp_id;









