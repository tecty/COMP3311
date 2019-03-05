-- COMP3311 Prac 03 Exercise
-- Schema for simple company database

create table Employees (
	tfn         char(11) primary key,
	givenName   varchar(30) not null,
	familyName  varchar(30) not null,
	hoursPweek  float check(hoursPweek > 0)
);

create table Departments (
	id          char(3) primary key,
	name        varchar(100),
	manager     char(11) not null
);

create table DeptMissions (
	department  char(3) not null,
	keyword     varchar(20)
);

create table WorksFor (
	employee    char(11) UNIQUE not null,
	department  char(3) not null,
	percentage  float
);

-- constrain for employee and department mission
alter table Employees ADD CONSTRAINT  manager_employee foreign key (manager) reference Employees (tfn);
alter table DeptMissions ADD CONSTRAINT mission_department foreign key (department) reference Departments (id);
-- many to many reference 
alter table WorksFor ADD CONSTRAINT works_employee foreign key (employee) reference Employees (tfn);
alter table WorksFor ADD CONSTRAINT works_department foreign key (department) reference Departments (id);

