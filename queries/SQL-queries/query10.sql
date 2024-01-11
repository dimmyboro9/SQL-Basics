-- Write out the name of club, the name of the stadium where the club played home games and the year when club participated our league. 
-- If the club did not participate in the season, write NOT PLAYED in column stadium_name, 
-- if no teams played their matches in the stadium, write NO TEAM in column club_name and 0 in column year.
/*
Categories:
A - Positive query on at least two joined tables
F2 - NATURAL JOIN|JOIN USING
F4 - LEFT|RIGHT OUTER JOIN
F5	F5 - FULL (OUTER) JOIN
*/

select coalesce ( c.name, 'NO TEAM' ) as club_name, coalesce ( s.year, 0 ) as year, coalesce ( st.name, 'NOT PLAYED' ) as stadium_name
from club c
join season s using ( league_name )
left join team t using ( id_season, id_club )
full outer join stadium st using ( id_stadium )
