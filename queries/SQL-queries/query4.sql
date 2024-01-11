-- Checking a D1 query.
/*
Categories:
A - Positive query on at least two joined tables
D2 - Result check of D1 query
F2 - NATURAL JOIN|JOIN USING
G1 - Nested query in WHERE clause
G4 - Correlated nested query (EXISTS|NOT EXISTS)
I1 - Aggregate functions (count|sum|min|max|avg)
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
) and (select count(*) from season ) != ( select count(*) from season ss join contract cc using (id_season) where cc.id_person = p.id_person )
