DROP VIEW IF EXISTS q2_1;
CREATE VIEW q2_1( player, goals) as 
SELECT p.name, count(*) 
FROM Goals AS g 
JOIN players AS p 
ON p.id = g.scoredBy  
WHERE rating = 'amazing'  
GROUP BY scoredBy 
;

DROP VIEW IF EXISTS q2;
CREATE VIEW q2 as 
SELECT * FROM q2_1 WHERE goals > 1
;