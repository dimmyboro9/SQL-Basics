-- Add two contracts, that are signed between players who have no contracts with anyone and one of the teams. 
-- (Attention, the maximum number of players on a team can not be more than 15). 
/*
Categories:
A - Positive query on at least two joined tables
F2 - NATURAL JOIN|JOIN USING
F3 - CROSS JOIN
G1 - Nested query in WHERE clause
G2 - Nested query in FROM clause
I1 - Aggregate functions (count|sum|min|max|avg)
I2 - Aggregate function over grouped rows - GROUP BY (HAVING)
K - All clauses in one query - SELECT FROM WHERE GROUP BY HAVING ORDER BY
N - INSERT, which insert a set of rows, which are the result of another subquery (an INSERT command which has VALUES clause replaced by a nested query.
*/

begin;

select count(*)
from contract;

insert into contract
(
    select id_person, id_season, id_club, league_name, id_type, salary 
    from
    (
        select *, null as league_name, 1 as id_type, floor( ( random () + 1 )*1500000 ) as salary
        from 
        ( 
            select id_person
            from person 
            where id_person not in ( select id_person from contract )
            order by random ()
            limit 2
        ) random_players
        cross join 
        (
            select id_season, id_club
            from team
            join contract using ( id_club, id_season )
            where id_type = 1
            group by id_club, id_season
            having count ( distinct id_person ) < 14
            order by random ()
            limit 1
        ) random_team
    ) as add
);

select count(*)
from contract;

rollback;
