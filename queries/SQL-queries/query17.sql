-- Delete from the database all the people who have never had a contract with any club or league.
/*
Categories:
B - Negative query on at least two joined tables
G1 - Nested query in WHERE clause
G4 - Correlated nested query (EXISTS|NOT EXISTS)
P - DELETE with nested SELECT statement
*/

begin;

select id_person from person;

delete from person pp where id_person in 
(
    select id_person 
    from person p
    where not exists ( select 1 from contract c where c.id_person = p.id_person )
);

select id_person from person;

rollback;
