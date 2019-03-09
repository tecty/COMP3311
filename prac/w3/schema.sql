-- COMP3311 Prac 03 Exercise
-- Schema for simple company database

create table Employees (
	tfn         char(11) primary key ,
	givenName   varchar(30) not null,
	familyName  varchar(30) not null,
	hoursPweek  float check(hoursPweek > 0 and hoursPweek < 168),
	CONSTRAINT tfn_style CHECK (tfn ~ '^[0-9]{3}-[0-9]{3}-[0-9]{3}$')
);

create table Departments (
	id          char(3) primary key check (id ~ '^[0-9]{3}$'),
	name        varchar(100) unique not null,
	manager     char(11) not null
);

create table DeptMissions (
	department  char(3) not null,
	keyword     varchar(20) not null
);

create table WorksFor (
	employee    char(11) not null,
	department  char(3) not null,
	percentage  float,
	constraint percentage_valid check (percentage > 0 and percentage <= 100)
);


-- constrain for employee and department mission
alter table Departments ADD CONSTRAINT  manager_employee foreign key (manager) references Employees (tfn);
alter table DeptMissions ADD CONSTRAINT mission_department foreign key (department) references Departments (id);
-- many to many reference 
alter table WorksFor ADD CONSTRAINT works_employee foreign key (employee) references Employees (tfn);
alter table WorksFor ADD CONSTRAINT works_department foreign key (department) references Departments (id);
