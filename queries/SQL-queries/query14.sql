-- Write out the name of the team ( same as name of the club ), the year of the season it participated and the number of players it had on contracts.
/*
Categories:
A - Positive query on at least two joined tables
F2 - NATURAL JOIN|JOIN USING
I1 - Aggregate functions (count|sum|min|max|avg)
I2 - Aggregate function over grouped rows - GROUP BY (HAVING)
*/

select cl.name, year, count( id_person) as number_of_players
from person p
join contract c using ( id_person )
join club cl using ( id_club )
join season s using ( id_season )
where id_type = 1
group by id_club, id_season, cl.name, year
order by id_club
