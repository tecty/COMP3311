drop view if exists goal_map;
create view goal_map(match, team) as 
select g.scoredIn, p.memberOf 
from goals as g 
join Players as p 
on p.id = g.scoredBy;


-- same solution from q4 
DROP VIEW IF EXISTS team_pair;
CREATE VIEW team_pair(team1, team2, match) AS
select i1.team, i2.team, m.id  
from Involves as i1 
join matches as m on i1.match = m.id 
join Involves as i2 on
    m.id = i2.match and
    i1.team <> i2.team 
;

drop view if exists team1_goal;
create view team1_goal(match, team1, goals1, team2) as 
select m.match, m.team1, count(g1.team), m.team2 
from team_pair as m 
left join goal_map as g1 
on
    g1.match = m.match and
    g1.team = m.team1 
GROUP BY m.team1, m.team2, m.match  ;



drop view if exists teams_goal;
create view teams_goal(match, team1, goals1, team2, goals2) as 
select m.match, m.team1, m.goals1, m.team2,  count(g.team)
from team1_goal as m 
left join goal_map as g 
on
    g.match = m.match and
    g.team = m.team2 
GROUP BY m.team1, m.team2, m.match, m.goals1;

drop view if exists q6;
create view q6 ( location, date, team1, goals1, team2, goals2) as
select
    m.city, m.playedOn, t1.country, 
    g.goals1, t2.country, g.goals2 
from teams_goal as g 
join matches as m 
    on m.id = g.match
join teams as t1 
    on t1.id = g.team1 
join teams as t2 
    on t2.id = g.team2 ;