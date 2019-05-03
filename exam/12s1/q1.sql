drop view if exists q1;
create view q1(team, matches) as 
select t.Country, count(*) 
from Teams as t 
join Involves as i 
on i.team = t.id 
group by t.Country;
;