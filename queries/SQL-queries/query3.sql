-- Choose people, who had contracts during all seasons. ( Choose person, who doesn't have season, where this person doesn't have a contract ).
/*
Categories:
D1 - Select all related to - universal quantification query
G1 - Nested query in WHERE clause
G4 - Correlated nested query (EXISTS|NOT EXISTS)
*/

select p.*
from person p
where not exists 
(
    select 1 
    from season s
    where not exists 
    (
        select 1 
        from contract c
        where c.id_person = p.id_person AND s.id_season = c.id_season
    )
);
