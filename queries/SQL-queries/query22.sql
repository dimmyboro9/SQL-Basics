-- Write out all the years in which "London Alligators" participated and the places it took.
/*
Categories:
A - Positive query on at least two joined tables
F2 - NATURAL JOIN|JOIN USING
G1 - Nested query in WHERE clause
G4 - Correlated nested query (EXISTS|NOT EXISTS)
*/

select s.year, t.place
from team t
join season s using ( id_season )
where exists ( select 1 from club cl where cl.name = 'London Alligators' and cl.id_club = t.id_club )
