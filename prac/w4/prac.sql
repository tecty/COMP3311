-- COMP3311 18s1 Prac 06 Exercise
-- Written by: YOUR NAME (April 2018)


-- AllRatings view 

create or replace view AllRatings(taster,beer,brewer,rating)
as
	select t.given, b.name, br.name, r.score
	from ratings as r 
	join taster as t on t.id=r.taster 
	join beer as b on b.id=r.beer 
	join brewer as br on br.id=b.brewer
;


-- John's favourite beer

create or replace view JohnsFavouriteBeer(brewer,beer)
as
	select brewer, beer  
	from AllRatings 
	where taster='John' 
	and rating=(
		select max(rating) 
		from AllRatings 
		where taster='John'
	)
;


-- X's favourite beer

create type BeerInfo as (brewer text, beer text);

create or replace function FavouriteBeer(taster text) returns setof BeerInfo
as $$
	select brewer, beer  
	from AllRatings 
	where taster=$1
	and rating=(
		select max(rating) 
		from AllRatings 
		where taster=$1
	)
$$ language sql
;


-- Beer style

create or replace function BeerStyle(brewer text, beer text) returns text
as $$
	select s.name 
	from beer as b 
	join brewer as br on br.id=b.brewer 
	join beerstyle as s on s.id=b.style 
	where upper(b.name)=upper($2) and upper(br.name)=upper($1);
$$ language sql
;

-- Taster address

create or replace function TasterAddress(taster text) returns text
as $$
	select loc.state||', '||loc.country
	from   Taster t, Location loc
	where  t.given = $1 and t.livesIn = loc.id
$$ language sql
;

create or replace function TasterAddress(taster text) returns text
as $$
declare 
	li  Location%rowtype;
begin
	select loc.* into li
	from   Taster t, Location loc
	where  t.given = $1 and t.livesIn = loc.id;
	return coalesce(li.state||', '||li.country,li.country,'(none)') ;
end;
$$ language plpgsql
;


-- BeerSummary function

create or replace function BeerSummary() returns text
as $$
declare
	... replace this by your definitions ...
begin
	... replace this by your code ...
end;
$$ language plpgsql;



-- Concat aggregate

create aggregate concat (... replace by base type ...)
(
	stype     = ... replace by state type ... ,
	initcond  = ... replace by initial state ... ,
	sfunc     = ... replace by name of state transition function ...,
	finalfunc = ... replace by name of finalisation function ...
);


-- BeerSummary view

create or replace view BeerSummary(beer,rating,tasters)
as
	... replace by SQL your query using concat() and AllRatings ...
;


-- TastersByCountry view

create or replace view TastersByCountry(country,tasters)
as
	... replace by SQL your query using concat() and Taster ...
;
