-- Choose all clubs ( name, year_of_foundation, year_of_discontinuance ) that that existed at the beginning of the certain season (year). 
-- ( We want to start a new season, so we'll add it too ).
/*
Categories:
F3 - CROSS JOIN
*/

begin;

insert into season ( id_season, league_name, year, champion, mvp ) values ( 5, 'EuroGo', 2026, '', '' );
insert into club ( id_club, league_name, name, year_of_foundation, year_of_discontinuance ) values ( 21, 'EuroGo', 'Unlucky team', 1990, 2024 );
insert into club ( id_club, league_name, name, year_of_foundation, year_of_discontinuance ) values ( 22, 'EuroGo', 'Progtest', 1998, 2026 );

select c.name, c.year_of_foundation, c.year_of_discontinuance, s.year 
from club c
cross join season s
where c.year_of_discontinuance is null or c.year_of_discontinuance > s.year
;

rollback;
