create type course_type as (id integer, subject text, term text, homepage text, ns integer, ne integer, avgEval float);

create function fixCoursesOnAddCourseEnrolment() returns trigger as $$
DECLARE 
    _course course_type;
    _avgEval float;
BEGIN 
    _course := (select * from courses where id = new.course );
    -- increament the ns 
    update courses set ns = _course.ns + 1 where id = _course.id;
    if (new.stueval IS NOT NULL) then 
        if (_course.nE = 0) then 
            _avgEval := new.stueval;
        else 
            _avgEval := (new.stueval + _course.avgEval *_course.nE)/ (_course.nE + 1);
        end if;
        -- assign the update 
        update courses 
        set
            avgEval = _avgEval,
            nE = _course.nE + 1
        where id = _course.id;
    end if;
END
$$ language plpgsql;

create function fixCoursesOnDropCourseEnrolment() returns trigger as $$
DECLARE 
    _course course_type;
BEGIN 
    _course := (select * from courses where id = new.course);
    -- decrement the ns 
    update courses set ns = _course.ns + 1 where id = _course.id;

    if (_course.nE = 1 and old.stueval IS NOT NULL) then 
        update course 
        set nE = 0, avgEval = NULL
        where id = old.course;
    else 
        update course
        set 
            nE = _course.nE -1, 
            avgEval = (_course.avgEval * _course.nE - old) / _course.nE -1
        where id = old.course
    end if 
    
END
$$ language plpgsql;

create function fixCoursesOnDropCourseEnrolment() returns trigger as $$
DECLARE 
    _course course_type;
BEGIN 
    _course := (select * from courses where id = new.course);
    -- decrement the ns 
    update courses set ns = _course.ns + 1 where id = _course.id;

    if (new.stueval <> old.stueval) then 
        if (_course.nE = 0) then 
            _avgEval := new.stueval;
        else if (old.stueval IS NOT NULL )
            _avgEval := _course.avgEval - old.stueval/ _course.nE;
        else 
            _avgEval :=  (new.stueval + _course.avgEval *_course.nE)/ (_course.nE + 1); 
            -- and increament the record 
            update course 
            set nE = _course.nE + 1
            where id = _course.id;
        end if;
        -- assign the update 
        update courses 
        set
            avgEval = _avgEval,
        where id = _course.id;
    end if;
END
$$ language plpgsql;