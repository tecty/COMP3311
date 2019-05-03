DROP VIEW IF EXISTS team_pair;
CREATE VIEW team_pair(team1, team2, match) AS
select i1.team, i2.team, m.id  
from Involves as i1 
join matches as m on i1.match = m.id 
join Involves as i2 on
    m.id = i2.match and
    i1.team <> i2.team 
;

DROP VIEW IF EXISTS q4;
CREATE VIEW q4(team1, team2, matchs) AS
select t1.country, t2.country,count(*) 
from team_pair as p 
join teams as t1 on t1.id = p.team1 
join teams as t2 on t2.id = p.team2 
where t1.country < t2.country 
GROUP BY t1.country, t2.country 
ORDER BY t1.country, t2.country 
;