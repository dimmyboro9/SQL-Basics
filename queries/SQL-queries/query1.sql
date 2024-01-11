-- Choose people who have never had a contract with any club or league.
/*
Categories:
B - Negative query on at least two joined tables
F2 - NATURAL JOIN|JOIN USING
G1 - Nested query in WHERE clause
G4 - Correlated nested query (EXISTS|NOT EXISTS)
H2 - Set difference - MINUS or EXCEPT
J - Same query in 3 different sql statements
*/

select *
from person p
where not exists 
(
    select 1
    from contract c
    where c.id_person = p.id_person
);

select * 
from person p1
except 
select p2.* 
from person p2
join contract c using ( id_person );

select * 
from person p1 
where id_person 
not in ( select id_person from contract c );
