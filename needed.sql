use my_db;
select * from emp;
select *,salary*3 as "Quaterly Salary" from emp;
select *, salary *1.15 as "Hiked Salary" from emp;
select name, deptno, salary* 1.12 as "NEW SALARY" from emp where job="SALESMAN";
select * from emp;
select empno,job,hiredate,deptno, salary*12 as "Annual Salary", salary*1.178 as "Hiked Salary" from emp where job = "MANAGER";
select empno,name,job,hiredate,manager,salary as "Actual Salary",commission,deptno,salary-(salary*0.2) as "Revised Salary" 
from emp where job= "ANALYST";

select name,empno,salary as "Previous Salary", salary*12 as "Annual Salary" from emp;
select name,empno,salary,salary*1.3 as "Hiked Salary" from emp;
select name,salary *12 as "Annual Salary with a monthly commission of 200" from emp where commission=200;
select name,salary *12 as "Annual Salary with a yearly commission of 200" from emp where commission=1000;
select * from emp where salary>1500;
select name,hiredate,salary,salary*12 as "Annual Salary" from emp where salary*12>10000;
select * from emp where deptno=20;
select * from emp where job="MANAGER";
select * from emp where hiredate>"1995-12-31";
select * from emp where commission>salary;
select * from emp where job="CLERK";
select * from emp where deptno=10 and salary>2000;
select name,salary,salary*12 as "Annual Salary",salary*1.25 as "Hiked Salary" from emp where job="CLERK" and hiredate>"1982-06-16";
select * from emp where salary*12>15000 and commission>salary;
select * from departments where deptno=10 or name="RESEARCH";
select * from emp where deptno in (10,20) and salary>2000;
select * from emp where job in ("SALESMAN","ANALYST");
select * from emp where salary>2000 and job in ("SALESMAN","ANALYST") and deptno in (10,20);
select name,empno,hiredate,salary-salary*0.2 as "Revised salary" from emp where salary>2500 and deptno=10;
select * from emp where hiredate<1985-01-01 or salary>2000;



use my_db;
select *,
if(salary>1000,'Permanent','Contract') as 'Employment type' from emp;

select *,
if(salary>1000 and commission>600,'Level1 employee','Level2 employee') as 'Employee level' from emp;

select *, IFNULL(manager,empno) as 'Manager Id' from emp;

select *, IFNULL(commission,0) as 'Revised Commission' from emp;
select *,NULLIF(0,commission) from emp;
select *,ifnull(empno,manager) as 'managers' from emp;

select case 1
when 1 then 'one'
when 2 then 'two'
else 'none'
end as test;

select empno,name,
case job
when 'CLERK' then 'all dept'
when 'SALESMAN' then 'sales dept'
when 'ANALYST' then 'qc dept'
when 'MANAGER' then 'hr dept'
when 'PRESIDENT' then 'ceo'
end as 'Department' from emp;

select count(empno) from emp where manager is not null;
select count(commission) from emp where commission>0;

select count(empno) from emp where salary*12>15000 and manager is not null;

select sum(salary) from emp where deptno=10;
select concat(name,"<->",job) as 'Emp Info',concat(name," is woking as ",job) from emp;

select avg(salary), deptno from emp group by deptno order by deptno desc;
select sum(salary),deptno from emp group by deptno;
select count(empno),sum(salary),sum(commission*12),deptno from emp group by deptno having count(empno) in(5,6);


select * from emp where commission is null;
select name from emp where name like 'A%';
select name from emp where name like 'A%A';
select name from emp where name like '%A%A%';
select name from emp where name like 'M%';
select name from emp where name like 'S%';
select name from emp where name like '_L%';
select name from emp where name like '%L%L%';
select name from emp where name like '%E_';
select name from emp where name like '__R%';
select job from emp where job like '_____';
select * from emp where salary between 2000 and 3000;

select * from emp where job=(select job from emp where name = 'SCOTT');
select salary from emp where salary=(select max(salary) from emp);
select max(salary)        
from emp
where salary<(select MAX(salary)
           from emp);
select * from departments;

select departments.location from departments
inner join emp on emp.deptno= departments.deptno 
where emp.empno=(select manager from emp where name="MARTIN");

select emp.name,emp.job,departments.name,departments.location from emp
inner join departments on emp.deptno=departments.deptno;

describe emp;

create table Products(
ProductID integer,
Prod_name varchar(255),
Prod_category varchar(255),
Prod_Make varchar(255)
);

create table Candidates as 
(select * from emp where deptno=10);

create table Manager as
(select * from emp where job="MANAGER");

create table Persons(
Id int not null,
LastName varchar(255) not null,
FirstName varchar(255) not null,
age int);

describe Persons;

create table Inventory(
Id int not null,
Item_name varchar(255) not null,
Item_description varchar(255),
constraint UC_InvId unique(Id)
);

describe Inventory;

create table Electronics(
prod_id int not null primary key,
prod_name varchar(255) not null,
prod_make varchar(255)
);

describe Electronics;

create table Persons(
Id int not null primary key,
lastname varchar(255) not null,
firstname varchar(255),
age int,
city varchar(255)
);
describe Persons;

insert into Persons values(23,'rash','rashmi',33,'delhi');
select * from persons;

select * from emp where job=(select job from emp where name = 'SCOTT');

