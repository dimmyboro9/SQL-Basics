-- Choose all players with more than 14 points per game in the 2023 season or more than 7 rebounds per game in the 2025 season.
/*
Categories:
A - Positive query on at least two joined tables
F2 - NATURAL JOIN|JOIN USING
H1 - Set unification - UNION
*/

select p.*
from person p
join stats st using ( id_person )
join season using ( id_season )
where year = 2023 and points > 14
union
select p.*
from person p
join stats st using ( id_person )
join season using ( id_season )
where year = 2025 and rebounds > 7
