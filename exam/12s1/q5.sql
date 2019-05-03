DROP VIEW IF EXISTS country_card;
CREATE VIEW country_card(team, cardtype) AS
select t.id, c.cardtype
from cards as c 
join players as p on p.id = c.givenTo 
join teams as t on t.id = p.memberOf 
ORDER BY t.id, c.cardtype;

DROP VIEW IF EXISTS country_red_count;
CREATE VIEW country_red_count(team, amount) AS
select t.id, count(c.cardtype) 
from teams as t 
left join country_card as c 
on 
    c.cardtype = 'red' and 
    c.team = t.id 
GROUP BY t.id;

DROP VIEW IF EXISTS country_yellow_count;
CREATE VIEW country_yellow_count(team, amount) AS
select t.id, count(c.cardtype) 
from teams as t 
left join country_card as c 
on 
    c.cardtype = 'yellow' and 
    c.team = t.id 
GROUP BY t.id;


DROP VIEW IF EXISTS q5;
CREATE VIEW q5(team, reds, yellows) AS
SELECT t.country, cr.amount, cy.amount 
from teams as t 
join country_red_count as cr
on cr.team = t.id 
join country_yellow_count as cy 
on cy.team = t.id
;