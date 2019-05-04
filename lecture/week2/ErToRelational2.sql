create table Department(
    'name' text primary key,
    phone integer, 
    'location' text
    e_ssn text unique,
    M_date date
);

create table Employee (
    SSN text primary key, 
    works_for text references Department('name') not null,
    birthdate date, 
    name text
);

alter table Department add constraint ssn_foreign foreign key e_ssn references Employee(SSN);


create table Project(
    Pname text,
    Pnumber text, 
    primary key (Pname, Pnumber)
);

create table Participation(
    'time' datetime not null,
    project_name text references Project(Pname),
    e_ssn text references Employee(SSN)
    
);

create table Dependent(
    e_ssn text references Employee(SSN) not null,
    'name' text primary key, 
    brithdate date not null,
    relation text not null
);
