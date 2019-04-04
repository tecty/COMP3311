create table enrolments (
    student text,
    course  text,
    mark    integer check (mark between 0 and 100),
    grade   char(1) check (grade between 'A' and 'E'),
    primary key (student,course)
);



insert into enrolments (student, course, mark, grade) values (
	'james', 'COMP1917 12s1' ,50 , 'D');
insert into enrolments (student, course, mark, grade) values (
	'peter', 'COMP1917 12s1' ,45 , 'E');
insert into enrolments (student, course, mark, grade) values (
	'john' , 'COMP1917 12s1' ,90 , 'A');
insert into enrolments (student, course, mark, grade) values (
	'peter', 'COMP1917 12s2' ,40 , 'E');
insert into enrolments (student, course, mark, grade) values (
	'john' , 'COMP1927 12s2' ,85 , 'A');
insert into enrolments (student, course, mark, grade) values (
	'james', 'COMP1927 12s2' ,55 , 'D');
insert into enrolments (student, course, mark, grade) values (
	'james', 'COMP2911 13s1' ,50 , 'D');
insert into enrolments (student, course, mark, grade) values (
	'john' , 'COMP2911 13s1' ,85 , 'A');
insert into enrolments (student, course, mark, grade) values (
	'john' , 'COMP3311 13s2' ,70 , 'B');

create type stu_res as
     (student text, score numeric(5,2));
create function results() returns setof stu_res
as $$
declare
    r record;  res stu_res;
    p text := '';  s integer := 0;  n integer := 0;
begin
    for r in
        select student,mark
        from   enrolments
        order  by student
    loop
        if (p <> r.student and n > 0) then
            res.student := p;
            res.score := (s::float/n)::numeric(5,2);
            return next res;
            s := 0;  n := 0;
        end if;
        n := n + 1;
        s := s + r.mark;
        p := r.student;
    end loop;
    if (n > 0) then
        res.student := r.student;
        res.score := (s::float/n)::numeric(5,2);
        return next res;
    end if;
end;
$$ language plpgsql;


create type IntPair as (x integer, y integer);

create function 
    next_state(p IntPair, n integer) returns IntPair
as $$
begin
    if (p.x is null) then
        p.x := n;
    elsif (p.y is null) then
        if (n < p.x) then
            p.y := n;
        elsif (n > p.x) then
            p.y := p.x; p.x := n;
        end if;
    elsif (n > p.x) then
        p.y := p.x; p.x := n;
    elsif (n < p.x and n > p.y) then
        p.y := n;
    end if;
    return p;
end;
$$ language plpgsql;

create function
    second(p IntPair) returns integer
as $$
begin
    return p.y;
end;
$$ language plpgsql;

create aggregate max2 (int) (
    sfunc = next_state,
    stype = IntPair,
    finalfunc = second
);
