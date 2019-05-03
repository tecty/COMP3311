DROP VIEW IF EXISTS player_goal_count;
CREATE VIEW player_goal_count( player_id, memberOf, goals) AS
SELECT p.id, p.memberOf, count(g.id) 
FROM players AS p 
LEFT JOIN Goals AS g 
ON p.id = g.scoredBy 
GROUP BY p.id, p.memberOf;

CREATE VIEW q3(team, players) AS
select t.country, count(*) 
from player_goal_count as p  
join Teams as t on t.id = p.memberOf 
where p.goals = 0 
GROUP BY t.country 
ORDER BY count(*)
DESC LIMIT 1
;