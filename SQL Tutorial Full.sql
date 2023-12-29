CREATE TABLE Employee_demographic
(Employee_ID int,
First_name varchar(50),
Last_name varchar(50),
Age int, 
Gender varchar(50)
)

CREATE TABLE Employee_salary
(Employee_ID int,
Job_title varchar(50),
Salary int)

INSERT INTO Employee_demographic Values
(1001,'Jim','Halpert',30,'Male'),
(1002,'Pam','Beasley',30,'Female'),
(1003,'Dwight','Schrute',29,'Male'),
(1004,'Angele','Martin',33,'Female'),
(1005,'Toby','Flenderson',32,'Male'),
(1006,'Michael','Scott',35,'Male'),
(1007,'Meredith','Palmer',32,'Female'),
(1008,'Stanley','Hudson',38,'Male'),
(1009,'Kevin','Malone',31,'Male')

Insert into Employee_salary values
(1001,'Salesman',45000),
(1002,'Receptionist',36000),
(1003,'Salesman',63000),
(1004,'Accountant',47000),
(1005,'HR',50000),
(1006,'Regional Manager',65000),
(1007,'Supplier Relations',41000),
(1008,'Salesman',48000),
(1009,'Accountant',42000)

Select * 
from dbo.Employee_demographic

Select * 
from dbo.Employee_salary

-- Delete top row from table
DELETE TOP (1)
FROM  dbo.Employee_demographic

-- Select first name and last name only
Select First_name, Last_name
from dbo.Employee_demographic

-- SELECT statement: Top, Distinct, Count, As, Max, Min, Avg

-- Select top 5
Select top 5 *
from dbo.Employee_demographic

Select top 5 *
from dbo.Employee_salary

-- Select Distinct
SELECT DISTINCT(gender)
From Employee_demographic

SELECT DISTINCT(Last_name)
From Employee_demographic
-- Count
SELECT count(Last_name)
From Employee_demographic

SELECT count(Last_name) as last_name_count
From Employee_demographic

-- Max, Min, Avg salary
SELECT max(Salary) as Max_salary
From Employee_salary

SELECT min(Salary) as Min_salary
From Employee_salary

SELECT Avg(Salary) as Avg_salary
From Employee_salary

-- Select from the database
Select * 
From [SQL Tutorial].dbo.Employee_demographic

/* 
Where statement 
=, <>, <, >, And, Or, Like, Null, Not Null, In
*/


select *
from Employee_demographic
where Age = 30

select *
from Employee_demographic
where Age <= 30 and Gender='Male'

select *
from Employee_demographic
where Age >= 30 Or Gender='Female'

-- select employee with last name strat with S
select *
from Employee_demographic
where Last_name like 'S%'
-- select employee with a S in their last name
select *
from Employee_demographic
where Last_name like '%S%'
-- select employee start with a S and has a "o" in their last name
select *
from Employee_demographic
where Last_name like 'S%o%'

select *
from Employee_demographic
where Last_name like 'S%c%ott%'

-- select all first names are not null
select *
from Employee_demographic
where First_name is not null

-- select
select *
from Employee_demographic
where First_name ='Jim'

select *
from Employee_demographic
where First_name IN ('Jim','Michael')

-- Group By, Order By
Select distinct (gender)
from Employee_demographic

Select gender, count(gender)
from Employee_demographic
group by Gender

-- Select people who have neither the same gender nor age
Select Gender, Age, count(Gender) as Count_Gender
from Employee_demographic
group by Gender, Age

-- Select people 
Select Gender, count(Gender)  as Count_Gen
from Employee_demographic
where Age>31
group by Gender
order by Count_Gen DESC

--
select *
from Employee_demographic
order by Age ASC, Gender DESC

-- We can use the "Order By" with comlumn number ( Starting from 0 )
select *
from Employee_demographic
order by 4 ASC, 5 DESC

---------- Intermediate--------------------

-- Inner Joins, Full/Left/Right Outer Joins

select * 
from Employee_demographic

select * 
from Employee_salary

Insert into Employee_salary values
(1010,'IE',45000),
(1011,'Production Management',43000)

-- Inner Joins (take all intersection values of two tables )
Select *
From Employee_demographic
inner join Employee_salary
	on Employee_demographic.Employee_ID = Employee_salary.Employee_ID

-- Full Outer Join (take all values of two tables )
Select *
From Employee_demographic
Full Outer Join Employee_salary
	on Employee_demographic.Employee_ID = Employee_salary.Employee_ID

-- Left Outer Join ( take all values on the right table and the intersection of two tables )
Select *
From Employee_demographic
Left Outer Join Employee_salary
	on Employee_demographic.Employee_ID = Employee_salary.Employee_ID

-- Right Outer Join ( take the intersection of two tables and all values on the right table )
Select *
From Employee_demographic
Right Outer Join Employee_salary
	on Employee_demographic.Employee_ID = Employee_salary.Employee_ID

select * 
from Employee_demographic
Insert into Employee_demographic values
(1010,'Truong','Chi Tam',24,'Male')

-- Select from Joined table
Select Employee_demographic.Employee_ID, First_name, Last_name, Job_title, Salary
From Employee_demographic
Inner Join Employee_salary
	on Employee_demographic.Employee_ID = Employee_salary.Employee_ID
order by Salary

-- Select from Joined table
Select Employee_demographic.Employee_ID, First_name, Last_name, Job_title, Salary
From Employee_demographic
Inner Join Employee_salary
	on Employee_demographic.Employee_ID = Employee_salary.Employee_ID
order by Salary DESC

---//// Union, Union All
CREATE TABLE warehouse_employee_demographic
(Employee_ID int,
First_name varchar(50),
Last_name varchar(50),
Age int, 
Gender varchar(50)
)
INSERT INTO warehouse_employee_demographic Values
(1011,'Nguyen','Thi Nhat Le',24,'Female'),
(1012,'Martin','Beasley',22,'Female'),
(1013,'Nguyen','Van A',25,'Male'),
(1014,'Tran','Thi B',22,'Female')

--- Union 
select * from Employee_demographic
Union
select *  from warehouse_employee_demographic

--- Note: Cannot union if the type of data for each column is different
select * from Employee_demographic
Union
select * from Employee_salary

---- Case Statement
Select First_name,last_name, Age, 
Case 
 When age>30 then 'Old'
 When age between 27 and 30 then 'Mature'
 Else 'Teenager'
End 
 From Employee_demographic 
 Where age is not null 
 Order by age

select First_name,Last_name,Job_title,Salary,
Case 
	When Job_title='IE' then salary + (salary*0.2)
	When Job_title='Production Management' then salary + (Salary*0.25)
	Else Salary 
End as Salary_after_bonus
from Employee_demographic
join Employee_salary 
on Employee_demographic.Employee_ID = Employee_salary.Employee_ID
order by Salary_after_bonus desc

--- -------------------Having Clause 
--- Find out the job title that have more than 1 worker
Select Job_title, COUNT(job_title)
from Employee_demographic
join Employee_salary 
on Employee_demographic.Employee_ID=Employee_salary.Employee_ID
---Where count(Job_title)>1 (cannot use statement "Where" here)
Group by Job_title
Having COUNT(Job_title)>1

--- find job title that have Avg salary that > 45000
Select Job_title, Avg(Salary)
from Employee_demographic
join Employee_salary 
on Employee_demographic.Employee_ID=Employee_salary.Employee_ID
---Where count(Job_title)>1 (cannot use statement "Where" here)
Group by Job_title
Having Avg(Salary)>45000
Order by Avg(Salary)

--- find the people and their job title that have salary after bonuse > 42000
Select First_name, LAst_name, Job_title, Avg(Salary)
from Employee_demographic
join Employee_salary 
on Employee_demographic.Employee_ID=Employee_salary.Employee_ID
---Where count(Job_title)>1 (cannot use statement "Where" here)
Group by first_name, last_name, Job_title
Having Avg(Salary)>42000
Order by Avg(Salary) desc

Select * from Employee_demographic
join Employee_salary 
on Employee_demographic.Employee_ID=Employee_salary.Employee_ID 
order by Salary desc

----- Udapting/Deleting Data
Select * from Employee_salary

Update Employee_salary
Set Salary=46000
Where Job_title='IE'

Delete 
From Employee_demographic
Where Employee_ID=1005

Select * from Employee_demographic

--------- Aliasing

Select first_name + ' ' + last_name as Full_name
From Employee_demographic

Select a.Employee_ID, b.Salary
From Employee_demographic as a
left join Employee_salary as b
	on a.Employee_ID=b.Employee_ID

----------- Partition By

Select * from Employee_demographic
Select * from Employee_salary

Select First_name,Last_name,Gender,Salary,
Count(Gender) OVER (Partition By Gender) as Total_gender
From Employee_demographic as demo
join Employee_salary as sal
	on demo.Employee_ID=sal.Employee_ID
where Salary > '45000'

--Select First_name,Last_name,Gender,Salary,Count(Gender)
--From Employee_demographic as demo
--join Employee_salary as sal
	--on demo.Employee_ID=sal.Employee_ID
--Group by First_name,Last_name,Gender,Salary

---- Topic: CTEs

With CTE_Employee as 
(
SELECT First_name,Last_name,Gender,Salary
, Count(Gender) OVER (Partition By Gender) as Total_gender
, AVG(Salary) OVER (Partition by Gender) as Avg_salary

From Employee_demographic as demo
join Employee_salary as sal
	on demo.Employee_ID=sal.Employee_ID
where Salary > '45000')

Select First_name, Avg_salary from CTE_Employee
--- only work with the Select statement directly after the CTE statement
Select * from CTE_Employee

--- Topic: Temp Tables 
Create Table #temp_Employee( 
Employee_ID int, 
Job_title varchar(100),
Salary int
)
Select * from #temp_Employee

Insert into #temp_Employee Values (
'1001', 'HR', '45000' )

-- Insert all the data from Employee_salary into #temp_Employee
Insert into #temp_Employee
Select * from Employee_salary

Drop Table if exists #temp_Employee2 
-- if the table #temp_employee2 exists then delete that table then we can create the new table
Create table #Temp_Employee2 (
Job_title varchar(50), 
Employee_per_job int, 
Avg_age int, 
Avg_salary int )

Insert into #Temp_Employee2
Select Job_title, Count(Job_title), AVG(Age), AVG(salary)
From Employee_demographic emp
join Employee_salary sal 
	on emp.Employee_ID=sal.Employee_ID
Group by Job_title

Select * from #Temp_Employee2

--- Topic: String Function - TRIM, LTRIM, RTRIM, Replace, Substring, Upper, Lower

Drop Table Employee_Error;
Create Table Employee_Error (
Employee_ID varchar(50)
,First_name varchar(50)
,Last_name varchar(50)
)
Insert into Employee_Error Values
('1001 ','JiMbo','Halbert')
,(' 1002','Pam','Beasely')
,('1005','TRuong','Chi Tam - Fired')

Select * from Employee_Error

--Using Trim, LTRIM, RTRIM

Select Employee_ID, TRIM(Employee_ID) as ID_TRIM
from Employee_Error 

Select Employee_ID, LTRIM(Employee_ID) as ID_TRIM
from Employee_Error

Select Employee_ID, RTRIM(Employee_ID) as ID_TRIM
 from Employee_Error

 --- Using Replace

Select Last_name, REPLACE(Last_name, '- Fired','') as Last_name_fixed
from Employee_Error

--- Using Substring ( Match tables )

Select SUBSTRING(First_name,1,3) -- take from character 1 to character 3 
from Employee_Error

Select SUBSTRING(err.First_name,1,3),SUBSTRING(demo.First_name,1,3)
From Employee_Error err
Join Employee_demographic demo
	on SUBSTRING(err.First_name,1,3)=SUBSTRING(demo.First_name,1,3)

--- Gender 
--- Last_name
--- Age
select * from Employee_demographic
Select * from Employee_Error

--- Using UPPER and LOWER

Select First_name, LOWER(First_name)
from Employee_Error

Select First_name, UPPER(First_name)
from Employee_Error

-------- Topic: Stored Procedures

Create Procedure Test 
as
Select * From Employee_demographic

EXEC Test 


Drop Table #temp_employee;
Create Table #temp_employee (
Job_title varchar(100),
Employee_ID int, 
Avg_age int,
Avg_salary int 
)
Insert into #temp_employee
Select Job_title, Count(Job_title), AVG(Age), AVG(salary)
From Employee_demographic emp
join Employee_salary sal 
	on emp.Employee_ID=sal.Employee_ID
Group by Job_title

Select * from #temp_employee

CREATE PROCEDURE Temp_Employee AS
Select * from #temp_employee

EXEC Temp_Employee

------- Topic: Subqueries ( in the SELECT, FROM, and WHERE statement)

select * from Employee_salary

--- Subquery in SELECT
----- 1. Check the avg salary compare to each employee salary
Select Employee_ID, Salary, ( Select AVg(salary) From Employee_salary)  as Avg_salary
From Employee_salary

--- How to do it with Partition By

Select Employee_ID, Salary, AVg(salary) over ()  as Avg_salary
From Employee_salary

--- Why Group By doesn't work 

Select Employee_ID, Salary, ( Select AVg(salary) From Employee_salary)  as Avg_salary
From Employee_salary
Group by Employee_ID,Salary
Order by 1,2

--- Subquery in From 

Select a.Employee_ID, Avg_salary
From (Select Employee_ID, Salary, AVg(salary) over ()  as Avg_salary
		From Employee_salary) a

--- Subquery in Where 

Select Employee_ID, Job_title, salary
From Employee_salary
Where Employee_ID in (
				Select Employee_ID
				From Employee_demographic
				Where Age >30)