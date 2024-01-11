-- Choose people, who had contracst as employees with league at the season, when the winner was team "Rome elephants".
/*
Categories:
A - Positive query on at least two joined tables
F2 - NATURAL JOIN|JOIN USING
*/

select p.*
from person p
join contract c using ( id_person )
join season s using ( id_season )
where id_type = 4 and year = 
(
    select year
    from season
    where champion = 'Rome elephants'
)
