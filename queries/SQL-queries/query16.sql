-- Create view of champions ( clubs, that took first place in some season ). 
-- Write out the most points per game that a player with a contract with these clubs had in any season. 
/*
Categories:
A - Positive query on at least two joined tables
F2 - NATURAL JOIN|JOIN USING
G1 - Nested query in WHERE clause
G4 - Correlated nested query (EXISTS|NOT EXISTS)
I1 - Aggregate functions (count|sum|min|max|avg)
I2 - Aggregate function over grouped rows - GROUP BY (HAVING)
L - View
M - Query over a view
*/

create or replace view champions as
(
    select * 
    from club cl
    where exists ( select 1 from season s where s.champion=cl.name )
) with check option;

select ch.name as club_name, max(points) as highest_pts_per_game
from person p
join contract c using ( id_person )
join champions ch using ( id_club )
join stats st using ( id_person, id_season )
group by id_club, ch.name;
